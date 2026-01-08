pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    readonly property alias brightness: backlightBrightness.value
    readonly property alias maxBrightness: backlightMaxBrightness.value
    readonly property real brightnessNormalized: brightness / maxBrightness
    readonly property real brightnessPercentage: brightnessNormalized * 100

    FileView {
        id: backlightBrightness
        watchChanges: true
        onFileChanged: reload()
        // WARNING: uses intel_backlight
        path: "/sys/class/backlight/intel_backlight/brightness"
        readonly property real value: parseFloat(data())
    }

    FileView {
        id: backlightMaxBrightness
        watchChanges: true
        onFileChanged: reload()
        // WARNING: uses intel_backlight
        path: "/sys/class/backlight/intel_backlight/max_brightness"
        readonly property real value: parseFloat(data())
    }
}
