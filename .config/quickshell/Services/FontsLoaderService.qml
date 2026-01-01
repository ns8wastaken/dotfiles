pragma Singleton

import Quickshell
import QtQuick
import Qt.labs.folderlistmodel

Singleton {
    FolderListModel {
        id: fontsModel
        folder: Qt.resolvedUrl("Assets/Fonts")
        nameFilters: ["*.ttf", "*.otf"]
        sortField: FolderListModel.Name
        showDirs: false
    }

    Repeater {
        model: fontsModel

        delegate: FontLoader {
            required property var fileUrl

            source: fileUrl

            onStatusChanged: {
                if (status === FontLoader.Ready) {
                    console.log(name);
                }
            }
        }
    }
}
