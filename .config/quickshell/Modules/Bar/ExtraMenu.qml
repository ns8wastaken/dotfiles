import Quickshell
import QtQuick
import qs.Services
import qs.Components
import qs.Config
import qs.Theme

Pill {
    width: text.width + 2 * 6
    height: 18

    color: Theme.surface

    MaterialIcon {
        id: text

        anchors.centerIn: parent

        text: "menu"

        color: Theme.textPrimary
        font.pixelSize: Config.fontSizeNormal
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    PanelWindow {
        visible: mouseArea.containsMouse

        Text {
            color: "#000000"
            text: SysInfoService.cpuUsageStr
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
        }

        Text {
            color: "#000000"
            text: SysInfoService.cpuTempStr
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -20
        }

        Text {
            color: "#000000"
            text: SysInfoService.memoryUsageStr
            anchors.centerIn: parent
        }

        Text {
            color: "#000000"
            text: SysInfoService.memoryUsagePerStr
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 20
        }

        Text {
            color: "#000000"
            text: SysInfoService.diskUsageStr
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 40
        }
    }
}
