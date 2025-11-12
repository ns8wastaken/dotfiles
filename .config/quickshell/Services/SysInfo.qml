pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.Settings

Singleton {
    id: manager

    // property int updateInterval: 200

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

        // command: [Quickshell.shellDir + "/Programs/stats.sh", updateInterval]
        command: [Quickshell.shellDir + "/Programs/stats.sh"]

        stdout: SplitParser {
            onRead: function (line) {
                try {
                    const data = JSON.parse(line);
                    cpuUsage          = +data.cpu;
                    cpuTemp           = +data.cputemp;
                    memoryUsage       = +data.mem;
                    memoryUsagePer    = +data.memper;
                    diskUsage         = +data.diskper;
                    cpuUsageStr       = data.cpu + '%';
                    cpuTempStr        = data.cputemp + "°C";
                    memoryUsageStr    = data.mem + 'M';
                    memoryUsagePerStr = data.memper + '%';
                    diskUsageStr      = data.diskper + '%';
                } catch (e) {
                    console.error("Failed to parse stats output:", e);
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}
