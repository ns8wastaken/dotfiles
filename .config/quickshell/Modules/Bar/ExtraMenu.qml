import Quickshell
import QtQuick
import qs.Services
import qs.Components
import qs.Theme

Pill {
    width: text.width + 2 * 6
    height: 18

    color: Theme.color.secondary_container

    LucideIcon {
        id: text

        anchors.centerIn: parent

        source: "ellipsis"

        color: Theme.color.on_secondary_container
        size: Theme.fontSize.normal
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    PanelWindow {
        visible: mouseArea.containsMouse

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: SysInfoService.cpuUsageStr
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -20
            text: SysInfoService.cpuTempStr
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            text: SysInfoService.memoryUsageStr
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 20
            text: SysInfoService.memoryUsagePerStr
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 40
            text: SysInfoService.diskUsageStr
            color: "#000000"
        }
    }
}
