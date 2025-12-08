import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Settings

Rectangle {
    id: appEntry

    required property var modelData
    required property bool isSelected

    readonly property int margins: 4

    radius: 10

    color: isSelected ? Theme.highlight.darker(1.2) : Theme.backgroundSecondary

    RowLayout {
        id: entryRow

        anchors.fill: parent
        anchors.centerIn: parent

        anchors {
            leftMargin: appEntry.margins
            rightMargin: appEntry.margins
        }

        spacing: 8

        // Icon
        Rectangle {
            // Layout.alignment: Qt.AlignVCenter

            implicitWidth: parent.height - 2 * appEntry.margins
            implicitHeight: parent.height - 2 * appEntry.margins

            radius: 8

            color: Theme.backgroundSecondary

            visible: itemIcon.isLoaded

            Image {
                id: itemIcon

                readonly property bool isLoaded: status == Image.Ready

                anchors.centerIn: parent

                width: parent.height - 8
                height: parent.height - 8

                source: Quickshell.iconPath(appEntry.modelData.icon, true)
            }
        }

        // App name
        Text {
            // Layout.alignment: Qt.AlignVCenter
            Layout.fillWidth: true

            text: appEntry.modelData.name

            font.family: Settings.appLauncher.fontFamily
            font.pixelSize: Settings.fontSizeSmall

            color: appEntry.isSelected
                ? Theme.textPrimaryInverted
                : Theme.textPrimary;

            elide: Text.ElideRight
        }
    }
}
