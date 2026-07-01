import QtQuick
import QtQuick.Effects
import "../Animations"

MultiEffect {
    property color sourceColor: "#000000"

    colorization: 1
    brightness: 1 - sourceColor.hslLightness

    Behavior on colorizationColor {
        CAnim {}
    }
}
