import Quickshell.Io

JsonObject {
    property int spacing

    property TrayConfig tray: TrayConfig {}

    component MarginsConfig: JsonObject {
        property int top
        property int left
        property int right
        property int bottom
    }

    component TrayConfig: JsonObject {
        property int iconSize
        property int spacing
    }
}
