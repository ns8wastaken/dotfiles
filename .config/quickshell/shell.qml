import QtQuick
import Quickshell
import "Modules/Bar"

Scope {
    readonly property bool disableHotReload:
        Quickshell.env("QS_DISABLE_HOT_RELOAD") === "1"
        || Quickshell.env("QS_DISABLE_HOT_RELOAD") === "true"

    Component.onCompleted: {
        Quickshell.watchFiles = !disableHotReload;
    }

    Loader {
        active: true
        sourceComponent: Bar {}
    }
}
