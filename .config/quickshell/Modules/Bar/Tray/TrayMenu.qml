pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Config
import qs.Theme

PopupWindow {
    id: root

    implicitWidth: 200
    implicitHeight: listView.contentHeight + 12

    visible: false
    color: "transparent"

    property QsMenuHandle menu: null
    property Item anchorItem: null
    property real anchorX: 0.0
    property real anchorY: 0.0

    anchor.item: anchorItem ? anchorItem : null
    anchor.rect.x: anchorX
    anchor.rect.y: anchorY

    function showAt(item: Item, x: int, y: int) {
        if (!item) {
            console.warn("CustomTrayMenu: anchorItem is undefined, not showing menu.");
            return;
        }
        anchorItem = item;
        anchorX = x;
        anchorY = y;
        visible = true;
    }

    function hideMenu() {
        visible = false
    }

    QsMenuOpener {
        id: opener
        menu: root.menu
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.backgroundPrimary
        border.color: Theme.outline
        border.width: 1
        radius: 12
        z: 0
    }

    ListView {
        id: listView

        anchors.fill: parent
        anchors.margins: 6
        spacing: 2

        interactive: false

        enabled: root.visible

        clip: true

        model: ScriptModel {
            values: opener.children ? opener.children.values : []
        }

        delegate: Rectangle {
            id: trayEntry

            required property var modelData
            readonly property bool isSeparator: trayEntry.modelData.isSeparator ?? false

            width: listView.width
            height: modelData.isSeparator ? 8 : 32

            color: "transparent"

            radius: 12

            // Separator
            Rectangle {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 1

                visible: trayEntry.isSeparator

                width: parent.width - 20
                height: 1

                color: Theme.surfaceVariant
            }

            // Button
            Rectangle {
                id: button

                anchors.fill: parent

                visible: !trayEntry.isSeparator

                color: mouseArea.containsMouse ? Theme.highlight : "transparent"

                radius: 8

                property color hoverTextColor: mouseArea.containsMouse
                    ? Theme.textDark
                    : Theme.textPrimary;

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 8

                    // Button text
                    Text {
                        Layout.fillWidth: true

                        text: trayEntry.modelData.text ?? ""

                        color: trayEntry.modelData.enabled
                            ? button.hoverTextColor
                            : Theme.textDisabled;

                        font.family: Config.fonts.sans
                        font.pixelSize: Config.fontSizeSmall

                        elide: Text.ElideRight
                    }

                    // Icon
                    Image {
                        id: iconImage

                        visible: !!trayEntry.modelData.icon

                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16

                        source: trayEntry.modelData.icon ?? ""

                        fillMode: Image.PreserveAspectFit
                    }
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent

                    hoverEnabled: true

                    enabled: (trayEntry.modelData.enabled ?? true)
                        && !(trayEntry.modelData.isSeparator ?? false)
                        && root.visible;

                    onClicked: {
                        if (trayEntry.modelData && !trayEntry.modelData.isSeparator) {
                            trayEntry.modelData.triggered();
                            root.hideMenu();
                        }
                    }
                }
            }
        }
    }
}
