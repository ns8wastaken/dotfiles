pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import qs.Utils

Singleton {
    id: root

    // TODO: make a setting for this
    readonly property string wallpaperDir: Paths.resolved("~/wallpapers")
    property alias wallpapers: wallpapersModel
    property string _path: ""

    FolderListModel {
        id: wallpapersModel
        folder: Qt.resolvedUrl(root.wallpaperDir)
        nameFilters: ["*.png", "*.jpg", "*.jpeg"]
        sortField: FolderListModel.Name
        showDirs: false
    }

    Process {
        id: proc
        workingDirectory: Quickshell.shellPath("Programs")
        command: ["./set_wallpaper.sh", root._path]
        stdout: StdioCollector {}
    }

    function setWallpaper(path: string) {
        // TODO: perhaps find a better way to do this without using _path
        _path = Paths.toLocalFile(path);
        proc.running = true;
    }
}
