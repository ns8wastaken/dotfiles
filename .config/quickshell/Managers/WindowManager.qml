pragma Singleton

import Quickshell
import QtQuick
import qs.Managers.Types

Singleton {
    /* -----------------------------
     * State
     * --------------------------- */
    property var handles: ({}) // handle -> WmWindow
    property string focusedHandle: ""
    property list<string> focusHistory: [] // array of handles, most recent = last
    readonly property bool wantsKeyboardFocus: focusedHandle !== ""

    /* -----------------------------
     * Registration
     * --------------------------- */
    function register(handle: string, loader: WmLoader) {
        if (handles[handle]) {
            console.warn("WindowManager: handle already registered:", handle);
            return;
        }

        handles[handle] = loader;
    }

    function unregister(handle: string, loader: WmLoader) {
        close(handle);
        delete handles[handle];
    }

    /* -----------------------------
     * Open / Close
     * --------------------------- */
    function open(handle: string) {
        const loader = handles[handle];
        if (!loader) return;

        loader.active = true;
        loader.opened = true;

        focus(handle);
    }

    function close(handle: string) {
        const loader = handles[handle];
        if (!loader) return;

        loader.opened = false;

        // Remove from history
        const idx = focusHistory.indexOf(handle);
        if (idx !== -1)
            focusHistory.splice(idx, 1);

        // Nothing more to do if the closed window was not focused
        if (focusedHandle !== handle)
            return;

        focusedHandle = "";

        // Focus the most recent still-open window
        _focusLastOpen();
    }

    /* -----------------------------
     * Focus
     * --------------------------- */
    function focus(handle: string) {
        const loader = handles[handle];
        if (!loader|| !loader.active) return;

        if (focusedHandle && handles[focusedHandle]) {
            const old = handles[focusedHandle];
            old.item.focused = false;
            old.item.wmUnfocused();
        }

        focusedHandle = handle;
        loader.focus = true;
        // TODO: make sure status === Loader.ready or something
        loader.item.focused = true;
        loader.item.wmFocused();

        // Update history (move handle to the end)
        const idx = focusHistory.indexOf(handle);
        if (idx !== -1)
            focusHistory.splice(idx, 1);
        focusHistory.push(handle);
    }

    function _focusLastOpen() {
        for (let i = focusHistory.length - 1; i >= 0; i--) {
            const h = focusHistory[i];
            if (handles[h]?.active) {
                focus(h);
                return;
            }
        }
    }

    /* -----------------------------
     * Helpers
     * --------------------------- */
    function isFocused(handle: string): bool {
        return focusedHandle === handle;
    }

    function isOpen(handle: string): bool {
        return !!handles[handle]?.active;
    }
}
