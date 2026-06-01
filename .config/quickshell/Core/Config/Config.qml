pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    function shellFont(name: string): string {
        return Quickshell.shellPath("Assets/Fonts/" + name);
    }

    property alias general:         adapter.general
    property alias bar:             adapter.bar
    property alias launcher:        adapter.launcher
    property alias notifs:          adapter.notifs
    property alias wallpaperPicker: adapter.wallpaperPicker
    property alias wlogout:         adapter.wlogout

    FileView {
        path: Quickshell.shellPath("config.json")
        watchChanges: true

        onFileChanged: reload();

        adapter: JsonAdapter {
            id: adapter

            property GeneralConfig         general:         GeneralConfig {}
            property BarConfig             bar:             BarConfig {}
            property LauncherConfig        launcher:        LauncherConfig {}
            property NotificationConfig    notifs:          NotificationConfig {}
            property WallpaperPickerConfig wallpaperPicker: WallpaperPickerConfig {}
            property WLogoutConfig         wlogout:         WLogoutConfig {}
        }
    }
}
