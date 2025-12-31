import QtQuick
import qs.Managers

Rectangle {
    /* ---- WM-controlled state ---- */
    final property string _handle // set by the wm
    final property bool focused: false

    // TODO: move to WmLoader since it doesnt work here
    z: focused ? 1000 : 0

    /* ---- Signals ---- */
    signal wmFocused()
    signal wmUnfocused()

    /* ---- Functions ---- */
    function close() { WindowManager.close(_handle); }
}
