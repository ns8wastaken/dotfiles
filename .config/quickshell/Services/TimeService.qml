pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm")
    readonly property date date: clock.date

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
