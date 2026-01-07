import QtQuick
import qs.Managers

Rectangle {
    /* ---- WM-controlled state ---- */
    final property string _handle // set by the wm
    final property bool focused // set by the loader

    /* ---- Signals ---- */
    signal wmFocused()
    signal wmUnfocused()

    /* ---- Functions ---- */
    function close() { WindowManager.close(_handle); }
}
