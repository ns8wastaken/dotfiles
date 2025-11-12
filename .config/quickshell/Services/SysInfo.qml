pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import qs.Settings

Singleton {
    id: manager

    // property int updateInterval: 200

    property string cpuTempStr: ""
    property real cpuUsage: 0
    property string cpuUsageStr: ""
    property real memoryUsage: 0
    property string memoryUsagePerStr: ""
    property real cpuTemp: 0
    property real memoryUsagePer: 0
    property string memoryUsageStr: ""
    property real diskUsage: 0
    property string diskUsageStr: ""

    Process {
        running: true

        // command: [Quickshell.shellDir + "/Programs/stats", updateInterval]
        command: [Quickshell.shellDir + "/Programs/stats"]

        stdout: SplitParser {
            onRead: function (line) {
                try {
                    const data = JSON.parse(line);
                    cpuUsage          = +data.cpu;
                    cpuTemp           = +data.cputemp;
                    memoryUsage       = +data.mem;
                    memoryUsagePer    = +data.memper;
                    cpuUsageStr       = data.cpu + '%';
                    cpuTempStr        = data.cputemp + "°C";
                    memoryUsageStr    = data.mem + 'G';
                    memoryUsagePerStr = data.memper + '%';
                    diskUsage         = +data.diskper;
                    diskUsageStr      = data.diskper + '%';
                } catch (e) {
                    console.error("Failed to parse zigstat output:", e);
                }
            }
        }
    }
}
