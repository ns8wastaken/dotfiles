import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Settings

Rectangle {
    id: root

    required property var modelData
    required property bool isSelected

    readonly property int margins: 4

    radius: 10

    color: isSelected ? Theme.highlight.darker(1.1) : Theme.backgroundSecondary

    RowLayout {
        id: entryRow

        anchors.fill: parent
        anchors.centerIn: parent

        anchors {
            leftMargin: root.margins
            rightMargin: root.margins
        }

        spacing: 8

        // Icon
        Rectangle {
            // Layout.alignment: Qt.AlignVCenter

            implicitWidth: parent.height - 2 * root.margins
            implicitHeight: parent.height - 2 * root.margins

            radius: 8

            color: Theme.backgroundSecondary

            visible: itemIcon.isLoaded

            Image {
                id: itemIcon

                readonly property bool isLoaded: status == Image.Ready

                anchors.centerIn: parent

                width: parent.height - 8
                height: parent.height - 8

                source: Quickshell.iconPath(root.modelData.icon, true)
            }
        }

        // App name
        Text {
            // Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            text: root.modelData.name

            font.family: Settings.appLauncher.fontFamily
            font.pixelSize: Settings.fontSizeSmall

            color: root.isSelected
                ? Theme.textPrimaryInverted
                : Theme.textPrimary;

            elide: Text.ElideRight
        }
    }
}
