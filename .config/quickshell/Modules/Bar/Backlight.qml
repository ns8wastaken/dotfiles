import QtQuick
import Quickshell.Io
import qs.Components
import qs.Widgets
import qs.Theme

Pill {
    id: root

    width: textRow.width + 12
    height: 18

    color: Theme.colors.surface

    // visible: UPower.displayDevice.isLaptopBattery

    FileView {
        id: backlightBrightness
        watchChanges: true
        onFileChanged: reload()
        // WARNING: uses intel_backlight
        path: "/sys/class/backlight/intel_backlight/brightness"
        readonly property real value: +data()
    }

    FileView {
        id: backlightMaxBrightness
        watchChanges: true
        onFileChanged: reload()
        // WARNING: uses intel_backlight
        path: "/sys/class/backlight/intel_backlight/max_brightness"
        onLoaded: console.log("FILE VIEW:", data())
        readonly property real value: +data()
    }

    readonly property real brightness: backlightBrightness.value / backlightMaxBrightness.value
    readonly property real brightnessPercentage: brightness * 100

    Row {
        id: textRow

        anchors.centerIn: parent
        spacing: Theme.spacing.small

        LevelLucideIcon {
            icons: ["circle-small", "sun-dim", "sun-medium", "sun"]
            value: root.brightness
            min: 0.10
            max: 0.80

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.colors.textPrimary
            size: Theme.fontSize.normal
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(root.brightnessPercentage) + '%'

            font.pixelSize: Theme.fontSize.small
            font.family: Theme.fonts.sans

            color: Theme.colors.textPrimary
        }
    }
}
