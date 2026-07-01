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
import "Services/Config"

ShellRoot {
    id: root
    readonly property int barHeight: 30

    readonly property bool disableHotReload:
        Quickshell.env("QS_DISABLE_HOT_RELOAD") === "1"
        || Quickshell.env("QS_DISABLE_HOT_RELOAD") === "true";

    Component.onCompleted: {
        Quickshell.watchFiles = !disableHotReload;
    }

    // --- Background layer (behind everything) ---
    Loader {
        active: true
        sourceComponent: BackgroundText {}
    }

    // Shared hover state for calendar popup
    QtObject {
        id: calendarState
        property bool clockHovered: false
        property bool popupHovered: false
    }

    // --- Bar (always visible, creates top strut) ---
    PanelWindow {
        anchors { top: true; left: true; right: true }
        exclusionMode: ExclusionMode.Normal
        exclusiveZone: root.barHeight
        color: "transparent"
        implicitHeight: root.barHeight + 20 // TODO: instead of +20 use the bottom rounding of the bar

        Bar {
            id: bar
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: root.barHeight
            calendarState: calendarState
        }
    }

    // --- Calendar popup (shown on clock hover) ---
    Loader {
        id: calendarLoader
        active: calendarState.clockHovered || calendarState.popupHovered

        sourceComponent: CalendarPopup {
            calendarState: calendarState
        }
    }

    // --- Notification popups (top-right corner) ---
    PanelWindow {
        anchors { right: true; top: true }
        margins {
            top: root.barHeight + HyprlandConfigService.gapsOutTop
            right: HyprlandConfigService.gapsOutRight
        }
        exclusionMode: ExclusionMode.Ignore
        color: "transparent"
        implicitWidth: notifs.width
        implicitHeight: notifs.height

        NotificationPopups { id: notifs }
    }

    // Shared mutex for togglable overlays (launcher, wallpaper picker: only one at a time)
    QtObject {
        id: overlayGroup
        property string active: ""
        function toggle(name: string) {
            active = active === name ? "" : name
        }
    }

    // --- Togglable windows (loaded on demand) ---
    Loader {
        id: launcherLoader
        active: overlayGroup.active === "launcher"
        sourceComponent: Launcher {
            onCloseRequested: overlayGroup.active = ""
        }
    }

    Loader {
        id: wallpaperPickerLoader
        active: overlayGroup.active === "wallpaper"
        sourceComponent: WallpaperPicker {
            onCloseRequested: overlayGroup.active = ""
        }
    }

    Loader {
        id: wlogoutLoader
        active: false
        sourceComponent: WLogout {
            onCloseRequested: wlogoutLoader.active = false
        }
    }

    // --- Keyboard shortcuts ---
    CustomShortcut {
        name: "launcher"
        onPressed: overlayGroup.toggle("launcher")
    }

    CustomShortcut {
        name: "wallpaperPicker"
        onPressed: overlayGroup.toggle("wallpaper")
    }

    CustomShortcut {
        name: "wlogout"
        onPressed: wlogoutLoader.active = !wlogoutLoader.active
    }

    // "Activate Linux" watermark
    Loader {
        active: false
        sourceComponent: Watermark {}
    }
}
