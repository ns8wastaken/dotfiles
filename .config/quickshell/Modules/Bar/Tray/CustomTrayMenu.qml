pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Settings

PopupWindow {
    id: trayMenu

    implicitWidth: 180
    implicitHeight: Math.max(40, listView.contentHeight + 12)
    visible: false
    color: "transparent"

    property QsMenuHandle menu: null
    property Item anchorItem: null
    property real anchorX: 0.0
    property real anchorY: 0.0

    anchor.item: anchorItem ? anchorItem : null
    anchor.rect.x: anchorX
    anchor.rect.y: anchorY - 4

    function showAt(item, x, y) {
        if (!item) {
            console.warn("CustomTrayMenu: anchorItem is undefined, not showing menu.");
            return;
        }
        anchorItem = item;
        anchorX = x;
        anchorY = y;
        visible = true;
        trayMenu.forceActiveFocus();
        Qt.callLater(() => trayMenu.anchor.updateAnchor());
    }

    function hideMenu() {
        visible = false
    }

    QsMenuOpener {
        id: opener
        menu: trayMenu.menu
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
        enabled: trayMenu.visible
        clip: true

        model: ScriptModel {
            values: opener.children ? [...opener.children.values] : []
        }

        delegate: Rectangle {
            id: trayEntry

            required property var modelData

            readonly property bool isSeparator: trayEntry.modelData?.isSeparator ?? false

            width: listView.width
            height: (modelData?.isSeparator) ? 8 : 32

            color: "transparent"

            radius: 12

            // Separator
            Rectangle {
                anchors.centerIn: parent

                visible: trayEntry.isSeparator

                width: parent.width - 20
                height: 1

                color: Theme.surfaceVariant
            }

            // Button
            Rectangle {
                id: bg

                anchors.fill: parent

                visible: !trayEntry.isSeparator

                color: mouseArea.containsMouse ? Theme.highlight : "transparent"

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                        easing.type: Easing.OutQuad
                    }
                }

                radius: 8

                property color hoverTextColor: mouseArea.containsMouse
                    ? Theme.textDark
                    : Theme.textPrimary;

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 8

                    Text {
                        Layout.fillWidth: true

                        color: (trayEntry.modelData?.enabled ?? true)
                            ? bg.hoverTextColor
                            : Theme.textDisabled;

                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                                easing.type: Easing.OutQuad
                            }
                        }

                        text: trayEntry.modelData?.text ?? ""

                        font.family: Settings.bar.fontFamily
                        font.pixelSize: Settings.fontSizeSmall

                        verticalAlignment: Text.AlignVCenter

                        elide: Text.ElideRight
                    }

                    Component {
                        id: icon
                        Image {
                            id: iconImage
                            width: 16
                            height: 16
                            source: trayEntry.modelData?.icon ?? ""
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Loader {
                        active: icon.iconImage.source !== ""
                        sourceComponent: icon
                    }
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent

                    hoverEnabled: true

                    enabled: (trayEntry.modelData?.enabled ?? true)
                        && !(trayEntry.modelData?.isSeparator ?? false)
                        && trayMenu.visible

                    onClicked: {
                        if (trayEntry.modelData && !trayEntry.modelData.isSeparator) {
                            trayEntry.modelData.triggered();
                            trayMenu.hideMenu();
                        }
                    }
                }
            }
        }
    }
}
