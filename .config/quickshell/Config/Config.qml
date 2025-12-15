pragma Singleton

import Quickshell
import Quickshell.Io
import qs.Config

Singleton {
    id: root

    function shellFont(name: string): string {
        return Quickshell.shellDir + "/Assets/Fonts/" + name;
    }

    property alias fontSizeSmaller: adapter.fontSizeSmaller
    property alias fontSizeSmall:   adapter.fontSizeSmall
    property alias fontSizeNormal:  adapter.fontSizeNormal
    property alias fontSizeLarge:   adapter.fontSizeLarge
    property alias fontSizeLarger:  adapter.fontSizeLarger

    property alias iconFontFamily:  adapter.iconFontFamily

    property alias appLauncher:     adapter.appLauncher
    property alias bar:             adapter.bar
    property alias fonts:           adapter.fonts
    property alias notifications:   adapter.notifications
    property alias wallpaperPicker: adapter.wallpaperPicker
    property alias wlogout:         adapter.wlogout

    // ElapsedTimer {
    //     id: timer
    // }

    FileView {
        path: Quickshell.shellPath("shell.json")
        watchChanges: true

        onFileChanged: {
            // timer.restart();
            reload();
        }

        adapter: JsonAdapter {
            id: adapter

            property string placeholderFontFamily

            property string iconFontFamily

            property int fontSizeSmaller
            property int fontSizeSmall
            property int fontSizeNormal
            property int fontSizeLarge
            property int fontSizeLarger

            property AppLauncherConfig     appLauncher:     AppLauncherConfig {}
            property BarConfig             bar:             BarConfig {}
            property FontsConfig           fonts:           FontsConfig {}
            property NotificationConfig    notifications:   NotificationConfig {}
            property WallpaperPickerConfig wallpaperPicker: WallpaperPickerConfig {}
            property WLogoutConfig         wlogout:         WLogoutConfig {}
        }
    }
}
