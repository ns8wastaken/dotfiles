pragma Singleton

import Quickshell

Singleton {
    readonly property var workspaces: {
        1: "一",
        2: "二",
        3: "三",
        4: "四",
        5: "五",
        6: "六",
        7: "七",
        8: "八",
        9: "九",
        10: "十",
        // -98 is special:magic workspace but ill normalize it
        98: "特別"
    }

    function getWorkspaceLabel(id: int): string {
        id = Math.abs(id);
        return workspaces[id] || id;
    }

    function getNetworkIcon(strength: int): string {
        if (strength >= 80) return "signal_wifi_4_bar";
        if (strength >= 60) return "network_wifi_3_bar";
        if (strength >= 40) return "network_wifi_2_bar";
        if (strength >= 20) return "network_wifi_1_bar";
        return "signal_wifi_0_bar";
    }
}
