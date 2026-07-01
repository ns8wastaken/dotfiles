pragma Singleton

import Quickshell

Singleton {
    id: root

    readonly property list<DesktopEntry> unfiltered_applications: DesktopEntries.applications.values
    readonly property list<DesktopEntry> applications: unfiltered_applications.filter(e => !e.noDisplay)
}
