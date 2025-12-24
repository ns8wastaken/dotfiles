pragma Singleton

import Quickshell
import QtQuick

Singleton {
    component WmOpenAnimation: ParallelAnimation {
        id: wmOpenAnimationRoot

        required property WmWindow target
        default property list<Animation> animations
        readonly property bool hasCustomAnimations: animations.length > 0

        NumberAnimation {
            target: wmOpenAnimationRoot.target; property: "scale"
            to: 1; duration: 150
            easing.type: Easing.InOutCubic
        }
        NumberAnimation {
            target: wmOpenAnimationRoot.target; property: "opacity"
            to: 1; duration: 150
            easing.type: Easing.InOutCubic
        }

        onStarted: target.wmOpenAnimStarted()
        onFinished: target.wmOpenAnimFinished()
    }

    component WmCloseAnimation: ParallelAnimation {
        id: wmCloseAnimationRoot

        required property WmWindow target
        default property list<Animation> animations
        readonly property bool hasCustomAnimations: animations.length > 0

        NumberAnimation {
            target: wmCloseAnimationRoot.target; property: "scale"
            to: 0.9; duration: 150
            easing.type: Easing.InOutCubic
        }
        NumberAnimation {
            target: wmCloseAnimationRoot.target; property: "opacity"
            to: 0; duration: 150
            easing.type: Easing.InOutCubic
        }

        onStarted: target.wmCloseAnimStarted()
        onFinished: target.wmCloseAnimFinished()
    }

    component WmWindow: Rectangle {
        id: wmWindowRoot

        final property string handle

        /* ---- WM-controlled state ---- */
        final property bool shortcutsEnabled: false
        final property bool opened: false
        final property bool focused: false

        // Scale and opacity are set in order for the animation to properly work
        scale: 0.9
        opacity: 0
        visible: opened
        z: focused ? 1000 : 0

        /* ---- Basic Functions ---- */
        function open() { wmOpenAnim.start() }
        function close() { wmCloseAnim.start() }
        function toggle() { opened ? close() : open(); }

        /* ---- Signals ---- */
        signal wmFocused()
        signal wmUnfocused()
        signal wmOpened()
        signal wmClosed()

        signal wmOpenAnimStarted()
        signal wmOpenAnimFinished()
        signal wmCloseAnimStarted()
        signal wmCloseAnimFinished()

        /* ---- Open / Close Animations ---- */
        // TODO: allow the user to change these
        WmOpenAnimation {
            id: wmOpenAnim
            target: wmWindowRoot
        }

        WmCloseAnimation {
            id: wmCloseAnim
            target: wmWindowRoot
        }

        onWmOpenAnimStarted: WindowManager.open(handle)
        onWmCloseAnimFinished: WindowManager.close(handle)
    }

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
