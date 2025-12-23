.pragma library

function key(event, key) {
    return event.key === key;
}

function ctrl(event) {
    return (event.modifiers & Qt.ControlModifier) !== 0;
}

function shift(event) {
    return (event.modifiers & Qt.ShiftModifier) !== 0;
}

function alt(event) {
    return (event.modifiers & Qt.AltModifier) !== 0;
}

function meta(event) {
    return (event.modifiers & Qt.MetaModifier) !== 0;
}
