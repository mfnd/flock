package main

import (
	"flag"
	"flockd/messages"
	"fmt"
	"net"
	"os"
	"time"

	"google.golang.org/protobuf/proto"

	log "github.com/sirupsen/logrus"
)

var AnnounceInterval int
var CommandListenerPort int
var BroadcastListenerPort int

func main() {
	flag.IntVar(&AnnounceInterval, "announce-interval", 60, "Announce Packet Broadcast Interval")
	flag.IntVar(&CommandListenerPort, "command-port", 7777, "Port To Listen For Commands")
	flag.IntVar(&BroadcastListenerPort, "broadcast-port", 6666, "Port to Listen For Broadcasts")

	log.Infof("Announce Interval: %d - Broadcast Port: %d - Command Port: %d", AnnounceInterval, CommandListenerPort, BroadcastListenerPort)

	broadcastChannel := make(chan bool)

	go commandListener()
	go broadcastListener(broadcastChannel)

	announcer(broadcastChannel)
}

func announcer(broadcastChannel <-chan bool) error {
	commands := GetCommander()

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

	addr, err := net.ResolveUDPAddr("udp", fmt.Sprintf("255.255.255.255:%d", BroadcastListenerPort))
	if err != nil {
		return err
	}

	conn, err := net.DialUDP("udp", nil, addr)
	if err != nil {
		return err
	}

	localIP := conn.LocalAddr().(*net.UDPAddr).IP
	log.Infof("Local IP: %s Netmask: %s", localIP, localIP.DefaultMask())

	usedIntf := interfacesMapping[localIP.String()]

	commands.EnableWakeOnLan(usedIntf.Name)

	for {
		hostname, err := os.Hostname()
		if err != nil {
			log.Error(err)
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
		case <-time.After(time.Duration(AnnounceInterval) * time.Second):
		}
	}
}

func broadcastListener(announceSignal chan<- bool) {
	addr, err := net.ResolveUDPAddr("udp", fmt.Sprintf(":%d", BroadcastListenerPort))
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	conn, err := net.ListenUDP("udp", addr)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}
	defer conn.Close()

	for {
		var buf [1024]byte
		var broadcast messages.Broadcast

		n, rAddr, _ := conn.ReadFromUDP(buf[:])
		if err := proto.Unmarshal(buf[:n], &broadcast); err != nil {
			log.Error(err)
		}

		switch broadcast.Type {
		case messages.Broadcast_ANNOUNCE_REQUEST:
			log.Info("Announce request received from ", rAddr)
			announceSignal <- true
		}

	}
}

func commandListener() {
	commands := GetCommander()

	listen, err := net.Listen("tcp", fmt.Sprintf(":%d", CommandListenerPort))
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	defer listen.Close()

	for {
		conn, err := listen.Accept()
		if err != nil {
			log.Error(err)
		}
		go handleCommand(conn, commands)
	}
}

func handleCommand(conn net.Conn, commander Commander) {
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
			log.Info("Suspend request from ", conn.RemoteAddr().String())
			err = commander.Suspend()
			if err != nil {
				log.Error(err)
			}
		}
	}

}
