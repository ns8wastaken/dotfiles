import QtQuick
import qs.Components.Animations

Rectangle {
    id: root

    color: "transparent"

    Behavior on color { CAnim {} }
}
