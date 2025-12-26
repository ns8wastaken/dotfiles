pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    // TODO: make a setting for this
    readonly property string wallpaperDir: Quickshell.env("HOME") + "/wallpapers"
    property list<string> wallpaperList

    Process {
        id: wallpaperListLoader

        workingDirectory: root.wallpaperDir
        command: ["fd", ".", "-a", "-t", "file", "-c", "never"]

        stdout: StdioCollector {
            onStreamFinished: root.wallpaperList = text.trim().split('\n')
        }
    }

    function setWallpaper(path: string) {
        // TODO: move the script into qs config
        Quickshell.execDetached(["sh", "-c", `~/setwp.sh ${path}`]);
    }

    function reload() {
        wallpaperListLoader.running = true;
    }
}
