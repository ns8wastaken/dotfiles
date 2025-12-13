pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.Modules.Bar.Tray
import qs.Settings

Row {
    id: tray

    readonly property var trayMenu: CustomTrayMenu {}

    spacing: Settings.bar.traySpacing

    // App icon repeater
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
                tray.trayMenu
            )

            width: 24
            height: 24

            // Hover scale animation
            scale: isHovered ? 1.15 : 1.0
            Behavior on scale {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            // Subtle rotation on hover
            rotation: isHovered ? 5 : 0
            Behavior on rotation {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }

            Rectangle {
                anchors.centerIn: parent
                color: "transparent"

                width: 22
                height: 22
                // radius: 7

                IconImage {
                    id: trayIcon

                    anchors.centerIn: parent

                    width: 16
                    height: 16

                    smooth: false
                    asynchronous: true
                    backer.fillMode: Image.PreserveAspectFit

                    source: {
                        let icon = trayEntry.modelData?.icon;
                        if (!icon) return "";
                        // Process icon path
                        if (icon.includes("?path=")) {
                            const [name, path] = icon.split("?path=");
                            const fileName = name.substring(name.lastIndexOf("/") + 1);
                            return `file://${path}/${fileName}`;
                        }
                        return icon;
                    }

                    opacity: status === Image.Ready ? 1 : 0

                    NumberAnimation on opacity {
                        duration: 300
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
                        if (tray.trayMenu && tray.trayMenu.visible) {
                            tray.trayMenu.hideMenu();
                        }

                        // Open application
                        if (!trayEntry.modelData.onlyMenu) {
                            trayEntry.modelData.activate();
                        }
                    }

                    // else if (mouse.button === Qt.MiddleButton) {
                    //     // If menu is already visible, close it
                    //     if (tray.trayMenu && tray.trayMenu.visible) {
                    //         tray.trayMenu.hideMenu();
                    //     }
                    //
                    //     trayEntry.modelData.secondaryActivate
                    //         && trayEntry.modelData.secondaryActivate()
                    // }

                    else if (mouse.button === Qt.RightButton) {
                        trayEntryTooltip.tooltipVisible = false

                        if (!trayEntry.menuAvailable) {
                            console.log("No menu available for", trayEntry.modelData.id, "or tray.trayMenu not set")
                        }

                        // Anchor the menu to the tray icon item (parent) and position it below the icon
                        if (tray.trayMenu.menu == trayEntry.modelData.menu && tray.trayMenu.visible) {
                            // The same tray entry is right clicked (just hide the menu)
                            tray.trayMenu.hideMenu();
                        } else {
                            // A different entry is right clicked (hide the menu then show it again to remove artifacts)
                            tray.trayMenu.hideMenu();
                            tray.trayMenu.menu = trayEntry.modelData.menu;
                            tray.trayMenu.showAt(
                                parent,
                                (width - tray.trayMenu.width) / 2,
                                height + 20
                            );
                        }
                    }
                }

                onEntered: trayEntryTooltip.tooltipVisible = (tray.trayMenu.visible ? false : true)
                onExited: trayEntryTooltip.tooltipVisible = false
            }

            StyledTooltip {
                id: trayEntryTooltip
                text: trayEntry.modelData.tooltipTitle
                    || trayEntry.modelData.name
                    || trayEntry.modelData.id
                    || "Tray Item";
                targetItem: trayIcon
                delay: 200
            }
        }
    }
}
