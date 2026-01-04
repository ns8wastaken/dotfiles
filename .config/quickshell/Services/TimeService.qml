pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property date date: clock.date

    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
