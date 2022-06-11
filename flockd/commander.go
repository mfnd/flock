package main

import (
	"fmt"
	"os/exec"
)

type Commander interface {
	Suspend() error
	Shutdown() error
}

// Linux Commands

type LinuxCommander struct{}

func (LinuxCommander) Suspend() error {
	return exec.Command("systemctl", "suspend").Run()
}

func (LinuxCommander) Shutdown() error {
	return exec.Command("systemctl", "shutdown", "now").Run()
}

// Windows Commands

type WindowsCommander struct{}

func (WindowsCommander) Suspend() error {
	return exec.Command("rundll32.exe", "powrprof.dll", "SetSuspendState", "Sleep").Run()
}

func (WindowsCommander) Shutdown() error {
	return fmt.Errorf("not implemented")
}
