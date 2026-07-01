import QtQuick
import "../Animations"

Rectangle {
    id: root

    color: "transparent"

    Behavior on color { CAnim {} }
}
