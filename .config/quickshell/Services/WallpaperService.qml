pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import qs.Utils
import qs.Config

Singleton {
    id: root

    readonly property string wallpaperDir: Paths.resolved(Config.wallpaperDir)
    property alias wallpapers: wallpapersModel

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
        stdout: null
    }

    function setWallpaper(path: string) {
        const wall = Paths.toLocalFile(path);

        proc.command = [
            "./set_wallpaper.sh",
            "-w", wall,
            "-t", 'matugen image $WALLPAPER'
        ];
        proc.running = true;
    }
}
