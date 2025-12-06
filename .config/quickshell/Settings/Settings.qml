pragma Singleton

import QtQuick
import Quickshell

Singleton {
    // ==================================
    // =========== Workspaces ===========
    // ==================================
    property QtObject workspaces: QtObject {
        property string fontFamily: "KAWAIITEGAKIMOJI"
    }

    // ==================================
    // ============ General =============
    // ==================================
    property string fontFamily: "CQ Mono"
    property string iconFontFamily: "Material Icons Round"

    property int fontSizeSmaller: 12
    property int fontSizeSmall: 14
    property int fontSizeNormal: 16
    property int fontSizeLarge: 18
    property int fontSizeLarger: 20

    property int notificationPadding: 4
}
