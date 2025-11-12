pragma Singleton

import QtQuick
import Quickshell

Singleton {
    property string shellName: "IDK BUT ITS A NAME"

    // ==================================
    // =========== Workspaces ===========
    // ==================================
    property QtObject workspaces: QtObject {
        property var labels: {
            1: "一",
            2: "二",
            3: "三",
            4: "四",
            5: "五",
            6: "六",
            7: "七",
            8: "八",
            9: "九",
            10: "十"
        }

        property string labelFont: "KAWAIITEGAKIMOJI"

        function getLabel(id) {
            return labels[id] || id;
        }

        function getButtonColor(modelData) {
            if (modelData.active) { return Theme.accentPrimary; }
            if (modelData.urgent) { return Theme.error; }
            if (modelData.focused) { return Theme.error; }
            return Theme.surfaceVariant.lighter(1.6);
        }

        function getButtonTextColor(modelData) {
            return modelData.active
                ? Theme.textDark
                : Theme.textPrimary;
        }
    }

    // ==================================
    // ============ General =============
    // ==================================
    property string fontFamily: "CQ Mono"
    property int fontSizeSmall: 14
    property int fontSizeNormal: 16
    property int fontSizeLarge: 18

    property int notificationPadding: 4
}
