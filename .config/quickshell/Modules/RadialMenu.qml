pragma ComponentBehavior: Bound

import QtQuick

Item {
    id: root

    property list<Item> items
    property int radius: 120
    property Item center

    implicitWidth: 300
    implicitHeight: 300

    Item {
        id: centerContainer

        anchors.centerIn: parent

        width: 0
        height: 0

        Component.onCompleted: {
            if (root.center) {
                root.center.parent = this;
                root.center.anchors.centerIn = this;
                root.center.visible = true;
            }
        }
    }

    Repeater {
        id: repeater

        model: root.items

        delegate: Item {
            required property Item modelData
            required property int index

            width: 0
            height: 0

            readonly property real angle: (index / root.items.length) * 2 * Math.PI

            x: (root.width / 2) + (Math.cos(angle) * root.radius)
            y: (root.height / 2) + (Math.sin(angle) * root.radius)

            // This line attaches the actual Item from the list to this position
            Component.onCompleted: {
                modelData.parent = this;
                modelData.anchors.centerIn = this;
            }
        }
    }
}
