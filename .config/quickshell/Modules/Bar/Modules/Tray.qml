import QtQuick
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import qs.Components
import qs.Settings

Row {
    property var trayMenu: CustomTrayMenu {}

    spacing: 8

    property bool containsMouse: false

    // App icon repeater
    Repeater {
        model: SystemTray.items

        // App icon
        delegate: Item {
            width: 24
            height: 24

            property bool isHovered: trayMouseArea.containsMouse

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
                radius: 7

                IconImage {
                    id: trayIcon

                    anchors.centerIn: parent

                    width: 16
                    height: 16

                    smooth: false
                    asynchronous: true
                    backer.fillMode: Image.PreserveAspectFit

                    source: {
                        let icon = modelData?.icon;
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

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 300
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }

            MouseArea {
                id: trayMouseArea

                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: function(mouse) {
                    if (!modelData) return;

                    if (mouse.button === Qt.LeftButton) {
                        // If menu is already visible, close it
                        if (trayMenu && trayMenu.visible) {
                            trayMenu.hideMenu()
                        }

                        if (!modelData.onlyMenu) {
                            modelData.activate()
                        }
                    }

                    else if (mouse.button === Qt.MiddleButton) {
                        // If menu is already visible, close it
                        if (trayMenu && trayMenu.visible) {
                            trayMenu.hideMenu()
                        }

                        modelData.secondaryActivate && modelData.secondaryActivate()
                    }

                    else if (mouse.button === Qt.RightButton) {
                        trayTooltip.tooltipVisible = false

                        if (modelData.hasMenu && modelData.menu && trayMenu) {
                            // Anchor the menu to the tray icon item (parent) and position it below the icon
                            const menuX = (width / 2) - (trayMenu.width / 2);
                            const menuY = height + 20;
                            if (trayMenu.menu == modelData.menu && trayMenu.visible) {
                                trayMenu.hideMenu();
                            } else {
                                trayMenu.menu = modelData.menu;
                                trayMenu.showAt(parent, menuX, menuY);
                            }
                        } else {
                            console.log("No menu available for", modelData.id, "or trayMenu not set")
                        }
                    }
                }

                onEntered: trayTooltip.tooltipVisible = (trayMenu.visible ? false : true)
                onExited: trayTooltip.tooltipVisible = false
            }

            StyledTooltip {
                id: trayTooltip
                text: modelData.tooltipTitle || modelData.name || modelData.id || "Tray Item"
                targetItem: trayIcon
                delay: 200
            }
        }
    }
}
