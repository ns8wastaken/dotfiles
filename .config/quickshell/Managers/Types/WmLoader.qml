import QtQuick
import qs.Managers
import qs.Theme

Loader {
    id: root

    required property string handle
    property bool opened: false
    property bool focused: false

    property bool draggable: false
    property bool resetPosition: true // TODO:

    Component.onCompleted: {
        active = false;
        WindowManager.register(handle, root);
    }

    Component.onDestruction: {
        WindowManager.unregister(handle);
    }

    DragHandler { enabled: root.draggable }

    visible: active
    focus: active
    // TODO: fix the top window getting hidden behind others while closing anim plays
    z: focused ? 1000 : 0

    /* ---- Animation ---- */
    opacity: 0
    scale: 0.75

    states: State {
        name: "VISIBLE"
        when: root.opened && root.status === Loader.Ready

        PropertyChanges {
            root {
                opacity: 1
                scale: 1
            }
        }
    }

    transitions: Transition {
        to: "VISIBLE"
        reversible: true

        SequentialAnimation {
            PropertyAction {
                target: root
                property: "active"
                value: root.state === "VISIBLE"
            }

            PropertyAnimation {
                target: root
                properties: "opacity, scale"
                duration: Theme.anim.xsmall
                easing.type: Easing.InOutCubic
            }
        }
    }

    /* ---- Functions ---- */
    function open() { WindowManager.open(handle); }
    function close() { WindowManager.close(handle); }
    function toggle() { state === "" ? open() : close(); }

    /* ---- Delegated Updates ---- */
    onFocusedChanged: {
        if (status === Loader.Ready) {
            item.focused = focused;
            if (focused)
                item.wmFocused();
            else
                item.wmUnfocused();
        }
    }

    onStatusChanged: {
        if (status === Loader.Ready) {
            item._handle = handle;
            item.focused = focused;
        }
    }
}
