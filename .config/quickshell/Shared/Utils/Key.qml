pragma Singleton

import Quickshell
import QtQuick

Singleton {
    function match(event, key, modifiers = Qt.NoModifier) {
        if (event.key !== key)
            return false;

        if (modifiers === Qt.NoModifier)
            return event.modifiers === Qt.NoModifier;

        return (event.modifiers & modifiers) === modifiers;
    }

    function ctrl(event)  { return event.modifiers & Qt.ControlModifier; }
    function shift(event) { return event.modifiers & Qt.ShiftModifier; }
    function alt(event)   { return event.modifiers & Qt.AltModifier; }
    function meta(event)  { return event.modifiers & Qt.MetaModifier; }
}
