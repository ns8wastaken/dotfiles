import Quickshell
import QtQuick
import qs.Core.Services
import qs.Components
import qs.Components.Icons
import qs.Theme

Pill {
    width: text.width + 2 * 6
    height: 18

    color: Theme.color.secondary_container

    MaterialIcon {
        id: text

        anchors.centerIn: parent

        text: "more_horiz"

        color: Theme.color.on_secondary_container
        font.pixelSize: Theme.fontSize.normal
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }

    PanelWindow {
        visible: mouseArea.containsMouse
        implicitWidth: 300

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -40
            text: SysInfoService.cpu.percent
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -20
            text: SysInfoService.cpu.temp
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            text: SysInfoService.ram.used_mb
            color: "#000000"
        }

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 20
            text: Math.round(SysInfoService.ram.used_mb / SysInfoService.ram.total_mb * 1000) / 10
            color: "#000000"
        }
    }
}
