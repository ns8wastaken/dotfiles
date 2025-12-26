pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
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

    property alias bar:             adapter.bar
    property alias fonts:           adapter.fonts
    property alias launcher:        adapter.launcher
    property alias notifications:   adapter.notifications
    property alias wallpaperPicker: adapter.wallpaperPicker
    property alias wlogout:         adapter.wlogout

    // property QtObject fonts: QtObject {
    //     property FontLoader sansLoader: FontLoader {
    //         source: root.shellFont(adapter.fonts.sans)
    //     }
    //     property string sans: sansLoader.name
    //
    //     property FontLoader monoLoader: FontLoader {
    //         source: root.shellFont(adapter.fonts.mono)
    //     }
    //     property string mono: monoLoader.name
    //
    //     property FontLoader iconLoader: FontLoader {
    //         source: root.shellFont(adapter.fonts.icon)
    //     }
    //     property string icon: iconLoader.name
    //
    //     property FontLoader clockLoader: FontLoader {
    //         source: root.shellFont(adapter.fonts.clock)
    //     }
    //     property string clock: clockLoader.name
    //
    //     property FontLoader japaneseLoader: FontLoader {
    //         source: root.shellFont(adapter.fonts.japanese)
    //     }
    //     property string japanese: japaneseLoader.name
    //
    //     property FontLoader cuteLoader: FontLoader {
    //         source: root.shellFont(adapter.fonts.cute)
    //     }
    //     property string cute: cuteLoader.name
    // }

    FileView {
        path: Quickshell.shellPath("shell.json")
        watchChanges: true

        onFileChanged: reload();

        adapter: JsonAdapter {
            id: adapter

            property string placeholderFontFamily

            property string iconFontFamily

            property int fontSizeSmaller
            property int fontSizeSmall
            property int fontSizeNormal
            property int fontSizeLarge
            property int fontSizeLarger

            property BarConfig             bar:             BarConfig {}
            property FontsConfig           fonts:           FontsConfig {}
            property LauncherConfig        launcher:        LauncherConfig {}
            property NotificationConfig    notifications:   NotificationConfig {}
            property WallpaperPickerConfig wallpaperPicker: WallpaperPickerConfig {}
            property WLogoutConfig         wlogout:         WLogoutConfig {}
        }
    }
}
