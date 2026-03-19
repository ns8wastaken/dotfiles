//@ pragma Env QML_IMPORT_PATH=/usr/local/lib/qt-6/qml
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QSG_USE_SIMPLE_ANIMATION_DRIVER=1

import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.Components
import qs.Components.Effects
import qs.Managers
import qs.Managers.Types
import qs.Modules
import qs.Config

ShellRoot {
    readonly property bool disableHotReload:
        Quickshell.env("QS_DISABLE_HOT_RELOAD") === "1"
        || Quickshell.env("QS_DISABLE_HOT_RELOAD") === "true";

    Component.onCompleted: {
        Quickshell.watchFiles = !disableHotReload;
    }

    PanelWindow {
        id: fsPanelWindow

        // We love inclusion
        exclusionMode: ExclusionMode.Ignore

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }

        // Where clicky is allowed to happen
        Variants {
            id: clickyRegions
            model: fsPanelWindow.contentItem.children

            delegate: Region {
                required property Item modelData
                item: modelData.visible ? modelData : null
            }
        }

        // No clicky outside of the clicky places
        mask: Region { regions: clickyRegions.instances }

        color: "transparent"

        ExclusiveZone {
            id: barExclusiveZone
            anchors.top: true
            // -4 because its hyprland's outer gap
            exclusiveZone: bar.height + bar.anchors.topMargin + bar.anchors.bottomMargin - 4
        }
        Bar {
            id: bar

            height: 32

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: Config.bar.margins.top
                bottomMargin: Config.bar.margins.bottom
                leftMargin: Config.bar.margins.left
                rightMargin: Config.bar.margins.right
            }
        }
        PanelShadow { target: bar }

        NotificationPopups {
            anchors {
                right: parent.right
                top: parent.top
                // +4 because its hyprland's outer gap
                topMargin: barExclusiveZone.exclusiveZone + Config.notifs.marginTop + 4
                rightMargin: Config.notifs.marginRight
            }
        }

        // Toggleable menus
        WlrLayershell.keyboardFocus: WindowManager.wantsKeyboardFocus
            ? WlrKeyboardFocus.Exclusive
            : WlrKeyboardFocus.None;

        WmLoader {
            id: launcher
            handle: "launcher"
            draggable: true
            x: (fsPanelWindow.width - width) / 2
            y: (fsPanelWindow.height - height) / 2
            sourceComponent: Launcher {}
        }

        WmLoader {
            id: wallpaperPicker
            handle: "wallpaperPicker"
            draggable: true
            resetPosition: false
            x: (fsPanelWindow.width - width) / 2
            y: (fsPanelWindow.height - height) / 2
            sourceComponent: WallpaperPicker {}
        }

        WmLoader {
            id: wlogout
            handle: "wlogout"
            anchors.fill: parent
            sourceComponent: WLogout {}
        }

        CustomShortcut {
            name: "launcher"
            onPressed: launcher.toggle()
        }

        CustomShortcut {
            name: "wallpaperPicker"
            onPressed: wallpaperPicker.toggle()
        }

        CustomShortcut {
            name: "wlogout"
            onPressed: wlogout.toggle()
        }

        // RadialMenu {
        //     anchors.fill: parent
        //     radius: 140
        //
        //     center: Rectangle {
        //         anchors.centerIn: parent
        //         width: 20
        //         height: 20
        //         radius: 10
        //         color: "white"
        //     }
        //
        //     items: [
        //         Rectangle {
        //             width: 40;
        //             height: 40;
        //             radius: 20;
        //             color: "red";
        //             Text {
        //                 text: "1";
        //                 anchors.centerIn: parent
        //             }
        //         },
        //         Rectangle {
        //             width: 40;
        //             height: 40;
        //             radius: 20;
        //             color: "blue";
        //             Text {
        //                 text: "2";
        //                 anchors.centerIn: parent
        //             }
        //         },
        //         Rectangle {
        //             width: 40;
        //             height: 40;
        //             radius: 20;
        //             color: "green";
        //             Text {
        //                 text: "3";
        //                 anchors.centerIn: parent
        //             }
        //         },
        //         Rectangle {
        //             width: 40;
        //             height: 40;
        //             radius: 20;
        //             color: "orange";
        //             Text {
        //                 text: "4";
        //                 anchors.centerIn: parent
        //             }
        //         }
        //     ]
        // }
    }

    // "Activate Linux" watermark
    Loader {
        active: false
        sourceComponent: Watermark {}
    }

    Loader {
        active: true
        sourceComponent: BackgroundText {
            col: "#ffffff"
        }
    }
}
