pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    function shellFont(name: string): string {
        return Quickshell.shellPath("Assets/Fonts/" + name);
    }

    property alias wallpaperDir: adapter.wallpaperDir

    property alias bar:             adapter.bar
    property alias launcher:        adapter.launcher
    property alias notifications:   adapter.notifications
    property alias wallpaperPicker: adapter.wallpaperPicker
    property alias wlogout:         adapter.wlogout

    FileView {
        path: Quickshell.shellPath("config.json")
        watchChanges: true

        onFileChanged: reload();

        adapter: JsonAdapter {
            id: adapter

            property string wallpaperDir

            property BarConfig             bar:             BarConfig {}
            property LauncherConfig        launcher:        LauncherConfig {}
            property NotificationConfig    notifications:   NotificationConfig {}
            property WallpaperPickerConfig wallpaperPicker: WallpaperPickerConfig {}
            property WLogoutConfig         wlogout:         WLogoutConfig {}
        }
    }
}
