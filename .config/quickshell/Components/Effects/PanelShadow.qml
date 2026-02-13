import QtQuick
import QtQuick.Effects
import qs.Theme

MultiEffect {
    required property var target

    anchors.fill: target

    source: target

    shadowEnabled: true
    shadowColor: Theme.color.shadow
    shadowOpacity: 0.75
    shadowVerticalOffset: 0
    shadowHorizontalOffset: 0
    shadowBlur: 0.75
}
