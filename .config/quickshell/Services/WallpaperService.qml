pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import qs.Utils
import qs.Config

Singleton {
    id: root

    readonly property string wallpaperDir: FsPaths.resolved(Config.wallpaperDir)
    readonly property alias wallpapers: wallpapersModel

    FolderListModel {
        id: wallpapersModel
        folder: Qt.resolvedUrl(root.wallpaperDir)
        nameFilters: ["*.png", "*.jpg", "*.jpeg"]
        sortField: FolderListModel.Name
        showDirs: false
    }

    Process {
        id: proc
        workingDirectory: Quickshell.shellPath("Programs/bin")
        stdout: null
    }

    function setWallpaper(path: string) {
        const wallPath = FsPaths.toLocalFile(path);
        proc.command = ["./wallpaperctl", "-w", wallPath];
        proc.running = true;
    }
}
