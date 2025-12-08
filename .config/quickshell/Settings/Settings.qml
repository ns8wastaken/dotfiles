pragma Singleton

import QtQuick
import Quickshell

Singleton {
    readonly property string placeholderFontFamily: ""

    // ==================================
    // =========== Workspaces ===========
    // ==================================
    readonly property var workspaces: QtObject {
        readonly property string fontFamily: "KAWAIITEGAKIMOJI"
    }

    // ==================================
    // ============== Bar ===============
    // ==================================
    readonly property var bar: QtObject {
        readonly property string fontFamily: "CQ Mono"

        readonly property var margins: QtObject {
            readonly property int top: 4
            readonly property int left: 4
            readonly property int right: 4
            readonly property int bottom: 0
        }
    }

    // ==================================
    // ========= Notifications ==========
    // ==================================
    readonly property var notifications: QtObject {
        readonly property string fontFamily: "CQ Mono"

        readonly property int width: 350
        readonly property int height: 60

        readonly property int popupMargins: 4
        readonly property int spacing: 4

        readonly property int marginTop: 4
        readonly property int marginRight: 4

        readonly property int maxVisible: 5
    }

    // ==================================
    // ============ General =============
    // ==================================
    readonly property string iconFontFamily: "Material Icons Round"

    readonly property int fontSizeSmaller: 12
    readonly property int fontSizeSmall: 14
    readonly property int fontSizeNormal: 16
    readonly property int fontSizeLarge: 18
    readonly property int fontSizeLarger: 20
}
