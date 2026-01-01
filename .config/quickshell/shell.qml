//@ pragma Env QML_IMPORT_PATH=/usr/local/lib/qt-6/qml
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QSG_USE_SIMPLE_ANIMATION_DRIVER=1

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
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

        PanelWindow {
            id: barExclusiveZone
            anchors.top: true
            implicitWidth: 0
            implicitHeight: 0
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

        NotificationPopups {
            anchors {
                right: parent.right
                top: parent.top
                // +4 because its hyprland's outer gap
                topMargin: barExclusiveZone.exclusiveZone + Config.notifications.marginTop + 4
                rightMargin: Config.notifications.marginRight
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

        GlobalShortcut {
            name: "launcher"
            onPressed: launcher.toggle()
        }

        GlobalShortcut {
            name: "wallpaperPicker"
            onPressed: wallpaperPicker.toggle()
        }

        GlobalShortcut {
            name: "wlogout"
            onPressed: wlogout.toggle()
        }
    }

    // "Activate Linux" watermark
    Loader {
        active: false
        sourceComponent: Watermark {}
    }

    Loader {
        active: true
        sourceComponent: BackgroundText {}
    }
}
