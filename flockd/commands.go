package main

import (
	"fmt"
	"os/exec"
	"runtime"

	log "github.com/sirupsen/logrus"
)

type Commander interface {
	Suspend() error
	Shutdown() error
	EnableWakeOnLan(intf string) error
}

func GetCommander() Commander {
	var commands Commander
	switch runtime.GOOS {
	case "windows":
		commands = WindowsCommander{}
	case "linux":
		commands = LinuxCommander{}
	}
	return commands
}

// Linux Commands

type LinuxCommander struct{}

func (LinuxCommander) Suspend() error {
	return exec.Command("systemctl", "suspend").Run()
}

func (LinuxCommander) Shutdown() error {
	return exec.Command("systemctl", "shutdown", "now").Run()
}

func (LinuxCommander) EnableWakeOnLan(intf string) error {
	log.Info("Enabling Wake-on-LAN for ", intf)
	return exec.Command("ethtool", "-s", intf, "wol", "g").Run()
}

// Windows Commands

type WindowsCommander struct{}

func (WindowsCommander) Suspend() error {
	return exec.Command("rundll32.exe", "powrprof.dll", "SetSuspendState", "Sleep").Run()
}

func (WindowsCommander) Shutdown() error {
	return fmt.Errorf("not implemented")
}

func (WindowsCommander) EnableWakeOnLan(intf string) error {
	log.Warn("Enabling Wake-On-LAN in Windows is currently not supported")
	return nil
}
