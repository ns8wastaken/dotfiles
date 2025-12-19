pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Controls
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.Modules.Bar.Tray
import qs.Config
import qs.Theme

Row {
    id: root

    readonly property var trayMenu: TrayMenu {}

    spacing: Config.bar.tray.spacing

    // Tray entry repeater
    Repeater {
        model: SystemTray.items

        // Tray entry (app icon)
        delegate: Item {
            id: trayEntry

            required property var modelData
            readonly property bool isHovered: trayEntryMouseArea.containsMouse
            readonly property bool menuAvailable: (
                trayEntry.modelData.hasMenu &&
                trayEntry.modelData.menu &&
                root.trayMenu
            );

            width: Config.bar.tray.iconSize
            height: Config.bar.tray.iconSize

            IconImage {
                id: trayEntryIcon

                anchors.centerIn: parent

                width: trayEntry.width
                height: trayEntry.width

                antialiasing: true
                asynchronous: true
                backer.fillMode: Image.PreserveAspectFit

                source: trayEntry.modelData.icon

                opacity: status === Image.Ready ? 1 : 0

                Behavior on opacity {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                // Hover scale animation
                scale: trayEntry.isHovered ? 1.15 : 1.0
                Behavior on scale {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }

                // Subtle rotation on hover
                rotation: trayEntry.isHovered ? 5 : 0
                Behavior on rotation {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
            }

            MouseArea {
                id: trayEntryMouseArea

                anchors.fill: parent
                hoverEnabled: true

                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton

                onClicked: function(mouse) {
                    if (!trayEntry.modelData) return;

                    if (mouse.button === Qt.LeftButton) {
                        // If menu is visible, close it
                        if (root.trayMenu && root.trayMenu.visible) {
                            root.trayMenu.hideMenu();
                        }

                        // Open application
                        if (!trayEntry.modelData.onlyMenu) {
                            trayEntry.modelData.activate();
                        }
                    }

                    // else if (mouse.button === Qt.MiddleButton) {
                    //     // If menu is already visible, close it
                    //     if (root.trayMenu && root.trayMenu.visible) {
                    //         root.trayMenu.hideMenu();
                    //     }
                    //
                    //     trayEntry.modelData.secondaryActivate
                    //         && trayEntry.modelData.secondaryActivate()
                    // }

                    else if (mouse.button === Qt.RightButton) {
                        if (!trayEntry.menuAvailable) {
                            console.log("No menu available for", trayEntry.modelData.id, "or root.trayMenu not set")
                        }

                        // Anchor the menu to the root icon item (parent) and position it below the icon
                        if (root.trayMenu.menu == trayEntry.modelData.menu && root.trayMenu.visible) {
                            // The same root entry is right clicked (just hide the menu)
                            root.trayMenu.hideMenu();
                        } else {
                            // A different entry is right clicked (hide the menu then show it again to remove artifacts)
                            root.trayMenu.hideMenu();
                            root.trayMenu.menu = trayEntry.modelData.menu;
                            root.trayMenu.showAt(
                                parent,
                                (parent.width - root.trayMenu.implicitWidth) / 2,
                                parent.height + 12
                            )
                        }
                    }
                }
            }

            ToolTip {
                id: trayEntryTooltip

                visible: trayEntry.isHovered && !root.trayMenu.visible

                delay: 200

                text: trayEntry.modelData.tooltipTitle
                    || trayEntry.modelData.name
                    || trayEntry.modelData.id
                    || "Tray Item";

                font.family: Config.fonts.sans
                font.pixelSize: Config.fontSizeSmall

                contentItem: Text {
                    anchors.centerIn: tooltipRect
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: trayEntryTooltip.text
                    font: trayEntryTooltip.font
                    color: Theme.textPrimary
                }

                background: Rectangle {
                    id: tooltipRect

                    width: trayEntryTooltip.width + 24
                    height: trayEntryTooltip.height + 16

                    color: Theme.backgroundPrimary

                    radius: 6

                    border.color: Theme.outline
                    border.width: 1
                }

                x: (trayEntry.width - tooltipRect.width) / 2
                y: trayEntry.height + 12
            }
        }
    }
}
