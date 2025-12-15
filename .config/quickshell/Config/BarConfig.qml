import Quickshell.Io
import QtQuick

JsonObject {
    property int spacing

    property JsonObject margins: JsonObject {
        property int top
        property int left
        property int right
        property int bottom
    }

    property JsonObject tray: JsonObject {
        property int iconSize
        property int spacing
    }
}
