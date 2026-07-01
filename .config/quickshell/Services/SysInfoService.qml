pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property int updateInterval: 1000

    property var cpu:     ({ percent: 0.0, temp: 0.0 })
    property var gpu:     ({ percent: 0, temp: 0, vram_used: 0, vram_total: 0 })
    property var ram:     ({ used_mb: 0, total_mb: 0, swap_used_mb: 0, swap_total_mb: 0 })
    property var disk:    ({ used_gb: 0, total_gb: 0 })
    property var network: ({ rx_kbps: 0, tx_kbps: 0 })

    Process {
        id: proc
        running: true

        workingDirectory: Quickshell.shellPath("Native/Programs/bin")
        command: ["./sys-monitor", root.updateInterval]

        stdout: SplitParser {
            onRead: data => {
                const d = JSON.parse(data);

                root.cpu = d.cpu;
                root.gpu = d.gpu;
                root.ram = d.ram;
                root.disk = d.disk;
                root.network = d.network;
            }
        }
    }
}
