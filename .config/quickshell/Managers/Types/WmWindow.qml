import QtQuick
import qs.Managers

Rectangle {
    /* ---- WM-controlled state ---- */
    final property string _handle // set by the wm
    final property bool focused: false

    // Scale and opacity are set in order for the animation to properly work
    z: focused ? 1000 : 0

    /* ---- Signals ---- */
    signal wmOpened()
    signal wmFocused()
    signal wmUnfocused()

    /* ---- Functions ---- */
    function close() { WindowManager.close(_handle); }
}
