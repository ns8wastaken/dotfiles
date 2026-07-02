import Quickshell
import QtQuick
import QtQuick.Effects
import "../../Services"
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Shared/Theme"
import "../../Services/Config"

Pill {
    id: root

    width: text.width + Config.bar.spacing * 2
    height: 20

    color: Theme.color.surface

    layer.enabled: true
    layer.effect: MultiEffect {
        source: root
        shadowEnabled: true
        shadowColor: Theme.color.shadow
        shadowOpacity: 1
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 0
        shadowBlur: 0.5
    }

    MaterialIcon {
        id: text

        anchors.centerIn: parent

        text: "more_horiz"

        color: Theme.color.on_surface
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
