import QtQuick
import QtQuick.Effects
import "../Theme"

MultiEffect {
    required property var target

    anchors.fill: target

    source: target

    shadowEnabled: true
    shadowColor: Theme.color.shadow
    shadowOpacity: 1
    shadowVerticalOffset: 0
    shadowHorizontalOffset: 0
    shadowBlur: 0.5
}
