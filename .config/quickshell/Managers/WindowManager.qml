pragma Singleton

import Quickshell
import QtQuick

Singleton {
    component WmWindow: Rectangle {
        property string handle

        /* ---- WM-controlled state ---- */
        property bool shortcutsEnabled: false
        property bool opened: false
        property bool focused: false

        visible: opened
        z: focused ? 1000 : 0

        /* ---- Basic Functions ---- */
        function open() { WindowManager.open(handle); }
        function close() { WindowManager.close(handle); }
        function toggle() { opened ? close() : open(); }

        /* ---- Signals ---- */
        signal wmFocused()
        signal wmUnfocused()
        signal wmOpened()
        signal wmClosed()
    }

    /* -----------------------------
     * State
     * --------------------------- */
    property var handles: ({}) // handle -> WmWindow
    property string focusedHandle: ""
    property list<string> focusHistory: [] // array of handles, most recent = last

    /* -----------------------------
     * Registration
     * --------------------------- */
    function register(handle: string, window: WmWindow) {
        if (handles[handle]) {
            console.warn("WindowManager: handle already registered:", handle);
            return;
        }

        window.handle = handle;
        handles[handle] = window;
    }

    /* -----------------------------
     * Open / Close
     * --------------------------- */
    function open(handle: string) {
        const win = handles[handle];
        if (!win) return;

        if (!win.opened) {
            win.opened = true;
            win.wmOpened();
        }

        focus(handle);
    }

    function close(handle: string) {
        const win = handles[handle];
        if (!win) return;

        if (win.opened) {
            win.opened = false;
            win.focused = false;
            win.shortcutsEnabled = false;
            win.wmClosed();
        }

        // Remove from history
        const idx = focusHistory.indexOf(handle);
        if (idx !== -1)
            focusHistory.splice(idx, 1);

        // Nothing more to do if the closed window was not focused
        if (!(focusedHandle === handle))
            return;

        focusedHandle = "";

        // Focus the most recent still-open window
        for (let i = focusHistory.length - 1; i >= 0; i--) {
            const h = focusHistory[i];
            if (handles[h]?.opened) {
                focus(h);
                return;
            }
        }
    }

    /* -----------------------------
     * Focus
     * --------------------------- */
    function focus(handle: string) {
        const win = handles[handle];
        if (!win || !win.opened) return;

        // Clear previous focus
        if (focusedHandle && handles[focusedHandle]) {
            const old = handles[focusedHandle];
            old.focused = false;
            old.shortcutsEnabled = false;
            old.wmUnfocused();
        }

        focusedHandle = handle;
        win.focused = true;
        win.shortcutsEnabled = true;
        win.wmFocused();

        // Update history (move handle to the end)
        const idx = focusHistory.indexOf(handle);
        if (idx !== -1)
            focusHistory.splice(idx, 1);

        focusHistory.push(handle);
    }

    /* -----------------------------
     * Helpers
     * --------------------------- */
    function isFocused(handle: string): bool {
        return focusedHandle === handle;
    }

    function isOpen(handle: string): bool {
        return !!handles[handle]?.opened;
    }
}
