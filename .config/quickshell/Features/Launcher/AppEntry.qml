import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../Shared/Components"
import "../../Shared/Theme"

Rectangle {
    id: root

    required property DesktopEntry modelData
    required property bool isSelected

    readonly property int margins: 4

    radius: height / 2

    color: isSelected ? Theme.color.primary : Theme.color.surface
    Behavior on color { ColorAnimation { duration: Theme.anim.fast } }

    RowLayout {
        id: entryRow

        anchors.fill: parent
        anchors.centerIn: parent

        anchors {
            leftMargin: root.margins
            rightMargin: root.margins
        }

        spacing: root.margins

        // Icon
        Rectangle {
            implicitWidth: parent.height - 2 * root.margins
            implicitHeight: parent.height - 2 * root.margins

            radius: 8

            color: Theme.color.surface

            visible: itemIcon.isLoaded

            Image {
                id: itemIcon

                readonly property bool isLoaded: status === Image.Ready

                anchors.centerIn: parent

                source: Quickshell.iconPath(root.modelData.icon, true)
                sourceSize: Qt.size(parent.height - 8, parent.height - 8)

                cache: false
                asynchronous: true
            }
        }

        // App name
        StyledText {
            Layout.fillWidth: true

            text: root.modelData.name

            font.pixelSize: Theme.fontSize.small

            color: root.isSelected
                ? Theme.color.on_primary
                : Theme.color.on_surface;

            elide: Text.ElideRight
        }
    }
}
