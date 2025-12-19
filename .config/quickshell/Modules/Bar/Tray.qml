pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.Modules.Bar.Tray
import qs.Config

Row {
    id: root

    readonly property var trayMenu: TrayMenu {}

    spacing: Config.bar.tray.spacing

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
                root.trayMenu
            );

            width: Config.bar.tray.iconSize
            height: Config.bar.tray.iconSize

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

            IconImage {
                id: trayEntryIcon

                anchors.centerIn: parent

                width: trayEntry.width
                height: trayEntry.width

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
                        trayEntryTooltip.tooltipVisible = false

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
                                parent.height + 18
                            )
                        }
                    }
                }

                onEntered: trayEntryTooltip.tooltipVisible = !root.trayMenu.visible
                onExited: trayEntryTooltip.tooltipVisible = false
            }

            Tooltip {
                id: trayEntryTooltip
                targetItem: trayEntryIcon
                text: trayEntry.modelData.tooltipTitle
                    || trayEntry.modelData.name
                    || trayEntry.modelData.id
                    || "Tray Item";
                delay: 200
                visible: trayEntryMouseArea.containsMouse
            }
        }
    }
}
