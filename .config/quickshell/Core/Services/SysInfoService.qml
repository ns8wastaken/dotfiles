pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // TODO: make this a setting
    property int updateInterval: 5000 // ms

    property real cpuUsage: 0
    property real cpuTemp: 0
    property real memoryUsage: 0
    property real memoryUsagePer: 0
    property real diskUsage: 0
    property string cpuUsageStr: ""
    property string cpuTempStr: ""
    property string memoryUsageStr: ""
    property string memoryUsagePerStr: ""
    property string diskUsageStr: ""

    Process {
        id: proc

        running: true

        workingDirectory: Quickshell.shellPath("Programs")
        command: ["./stats.sh"]

        stdout: StdioCollector {
            onStreamFinished: function () {
                const data = JSON.parse(text);
                root.cpuUsage          = +data.cpu;
                root.cpuTemp           = +data.cputemp;
                root.memoryUsage       = +data.mem;
                root.memoryUsagePer    = +data.memper;
                root.diskUsage         = +data.diskper;
                root.cpuUsageStr       = data.cpu + '%';
                root.cpuTempStr        = data.cputemp + "°C";
                root.memoryUsageStr    = data.mem + 'M';
                root.memoryUsagePerStr = data.memper + '%';
                root.diskUsageStr      = data.diskper + '%';
            }
        }
    }

    Timer {
        interval: root.updateInterval
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
