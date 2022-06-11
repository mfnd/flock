package main

import (
	"flock/messages"
	"net"
	"os"
	"runtime"
	"time"

	"google.golang.org/protobuf/proto"

	log "github.com/sirupsen/logrus"
)

const (
	AnnounceInterval = 3 * time.Second
)

func main() {
	broadcastChannel := make(chan bool)

	go commandListener(":7777")
	go discoveryListener(":6666", broadcastChannel)

	interfaces, err := net.Interfaces()
	if err != nil {
		log.Error(err)
	}

	var interfacesMapping map[string]net.Interface = make(map[string]net.Interface)

	for _, intf := range interfaces {
		addresses, _ := intf.Addrs()
		for _, addr := range addresses {
			ip := addr.(*net.IPNet).IP
			interfacesMapping[ip.String()] = intf
		}
	}

	addr, err := net.ResolveUDPAddr("udp", "255.255.255.255:6666")
	if err != nil {
		panic(err)
	}

	conn, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		panic(err)
	}

	localIP := conn.LocalAddr().(*net.UDPAddr).IP
	log.Infof("Local IP: %s Netmask: %s", localIP, localIP.DefaultMask())

	usedIntf := interfacesMapping[localIP.String()]

	for {
		hostname, err := os.Hostname()
		if err != nil {
			panic(err)
		}

		announce := messages.Broadcast{
			Type: messages.Broadcast_ANNOUNCE,
			Message: &messages.Broadcast_Announce{
				Announce: &messages.Announce{
					Name:      hostname,
					Interface: usedIntf.Name,
					HwAddr:    usedIntf.HardwareAddr.String(),
					IpAddr:    localIP.String(),
					Netmask:   localIP.DefaultMask().String(),
				},
			},
		}

		out, err := proto.Marshal(&announce)
		if err != nil {
			log.Error(err)
		}

		_, err = conn.Write(out)
		if err != nil {
			log.Error(err)
		}

		select {
		case <-broadcastChannel:
		case <-time.After(AnnounceInterval):
		}
	}
}

func discoveryListener(port string, announceSignal chan<- bool) {
	addr, err := net.ResolveUDPAddr("udp", port)
	if err != nil {
		panic(err)
	}

	conn, err := net.ListenUDP("udp", addr)
	if err != nil {
		panic(err)
	}
	defer conn.Close()

	for {
		var buf [1024]byte
		var broadcast messages.Broadcast

		n, rAddr, _ := conn.ReadFromUDP(buf[:])
		if err := proto.Unmarshal(buf[:n], &broadcast); err != nil {
			panic(err)
		}

		switch broadcast.Type {
		case messages.Broadcast_ANNOUNCE_REQUEST:
			log.Info("Announce request received from ", rAddr)
			announceSignal <- true
		}

	}
}

func commandListener(port string) {
	var commands Commander
	switch runtime.GOOS {
	case "windows":
		commands = WindowsCommander{}
	case "linux":
		commands = LinuxCommander{}
	}

	listen, err := net.Listen("tcp", port)
	if err != nil {
		panic(err)
	}

	defer listen.Close()

	for {
		conn, err := listen.Accept()
		if err != nil {
			panic(err)
		}
		go serveCommand(conn, commands)
	}
}

func serveCommand(conn net.Conn, commander Commander) {
	buf := make([]byte, 4096)
	len, err := conn.Read(buf)
	if err != nil {
		log.Error(err)
	}

	var message messages.Command
	if err := proto.Unmarshal(buf[:len], &message); err != nil {
		log.Error(err)
	}

	switch message.Command.(type) {
	case *messages.Command_Shutdown:
		if message.GetShutdown().Mode == messages.ShutdownCommand_SLEEP {
			log.Println("Suspend request from ", conn.RemoteAddr().String())
			err = commander.Suspend()
			if err != nil {
				log.Error(err)
			}
		}
	}

}
