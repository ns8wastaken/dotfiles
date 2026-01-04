pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.Theme

Popup {
    id: root

    property QsMenuHandle menu: null

    function update(_trayEntry: Item) {
        if (!_trayEntry) {
            console.warn("CustomTrayMenu: trayEntry is undefined, not showing menu.");
            return;
        }
        menu = _trayEntry.modelData.menu;
        parent = _trayEntry;
        x = (parent.width - implicitWidth) / 2;
        y = parent.height + 12;
        visible = true;
    }

    function hideMenu() {
        visible = false;
    }

    popupType: Popup.Window

    background: Rectangle {
        color: Theme.colors.backgroundPrimary
        radius: 12
        border.color: Theme.colors.outline
        border.width: 1
    }

    padding: 6

    implicitWidth: 200
    implicitHeight: listView.contentHeight > 0
        ? listView.contentHeight + padding * 2
        : 1;

    QsMenuOpener {
        id: opener
        menu: root.menu
    }

    ListView {
        id: listView

        anchors.fill: parent
        spacing: 2

        interactive: false

        enabled: root.visible

        clip: true

        model: ScriptModel {
            values: opener.children.values ?? []
        }

        delegate: Rectangle {
            id: trayEntry

            required property QsMenuEntry modelData
            readonly property bool isSeparator: trayEntry?.modelData?.isSeparator ?? false

            width: listView.width
            height: modelData?.isSeparator ? 8 : 32

            color: "transparent"

            radius: 12

            // Separator
            Rectangle {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 1

                visible: trayEntry?.isSeparator

                width: parent.width - 20
                height: 1

                color: Theme.colors.surfaceVariant
            }

            // Button
            Rectangle {
                id: button

                anchors.fill: parent

                visible: !trayEntry.isSeparator

                color: mouseArea.containsMouse ? Theme.colors.highlight : "transparent"

                radius: 8

                property color hoverTextColor: mouseArea.containsMouse
                    ? Theme.colors.textDark
                    : Theme.colors.textPrimary;

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: Theme.spacing.normal

                    // Button text
                    Text {
                        Layout.fillWidth: true

                        text: trayEntry?.modelData?.text ?? ""

                        color: trayEntry?.modelData?.enabled
                            ? button.hoverTextColor
                            : Theme.colors.textDisabled;

                        font.family: Theme.fonts.sans
                        font.pixelSize: Theme.fontSize.small

                        elide: Text.ElideRight
                    }

                    // Icon
                    Image {
                        id: iconImage

                        visible: !!trayEntry.modelData?.icon

                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16

                        source: trayEntry?.modelData?.icon ?? ""

                        fillMode: Image.PreserveAspectFit
                    }
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent

                    hoverEnabled: true

                    enabled: (trayEntry?.modelData?.enabled ?? false)
                        && !(trayEntry?.modelData?.isSeparator ?? true)
                        && root.visible;

                    onClicked: {
                        if (!trayEntry.modelData.isSeparator) {
                            trayEntry.modelData.triggered();
                            root.hideMenu();
                        }
                    }
                }
            }
        }
    }
}
