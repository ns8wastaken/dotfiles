//@ pragma Env QML_IMPORT_PATH=/usr/local/lib/qt-6/qml
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QSG_USE_SIMPLE_ANIMATION_DRIVER=1

import Quickshell
import Quickshell.Wayland
import QtQuick
import "Features/Bar"
import "Features/Launcher"
import "Features/Notifications"
import "Features/WallpaperPicker"
import "Features/WLogout"
import "Features/BackgroundText"
import "Shared/Components"
import "Shared/Shortcuts"
import "Shared/Theme"
import "Services"
import "Services/WindowManager"
import "Services/Config"

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
            exclusiveZone: bar.height
        }
        Bar {
            id: bar

            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }
        }

        NotificationPopups {
            anchors {
                right: parent.right
                top: parent.top
                topMargin: barExclusiveZone.exclusiveZone + HyprlandConfigService.gapsOutTop
                rightMargin: HyprlandConfigService.gapsOutRight
            }
        }

        // Toggleable menus
        WlrLayershell.keyboardFocus: WindowManager.wantsKeyboardFocus
            ? WlrKeyboardFocus.Exclusive
            : WlrKeyboardFocus.None;

        WmLoader {
            id: launcher
            handle: "launcher"
            animate: false
            x: (fsPanelWindow.width - width) / 2
            sourceComponent: Launcher {}

            readonly property real margin: 20
            readonly property real closedY: fsPanelWindow.height + margin
            readonly property real openY: height > 0
                ? fsPanelWindow.height - height
                : closedY

            y: opened ? openY : closedY

            Behavior on y {
                NumberAnimation {
                    duration: Theme.anim.fast
                    easing.type: Easing.OutCubic
                }
            }
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
