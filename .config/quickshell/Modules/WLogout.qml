import QtQuick
import qs.Modules.WLogout

LogoutMenu {
    LogoutButton {
        cardColor1: "#cca5c6d5"
        cardColor2: "#cc688998"
        gradientAngle: 45

        rotationAngle: -5
        labelText: "Lock"
        iconSource: "lock-cat.png"

        command: "loginctl lock-session"
        keybind: Qt.Key_L
    }

    LogoutButton {
        cardColor1: "#cc51808a"
        cardColor2: "#cc8a8b86"
        gradientAngle: -45

        rotationAngle: -5
        labelText: "Logout"
        iconSource: "cat-stack.png"

        command: "loginctl terminate-user $USER"
        keybind: Qt.Key_Q
    }

    LogoutButton {
        cardColor1: "#cca1cbc9"
        cardColor2: "#ccf1ceb7"

        rotationAngle: 5
        labelText: "Suspend"
        iconSource: "suspend-cat.png"

        command: "systemctl suspend"
        keybind: Qt.Key_S
    }

    LogoutButton {
        cardColor1: "#ccaed6d6"
        cardColor2: "#cccfc8be"
        gradientAngle: -20

        rotationAngle: 5
        labelText: "Hibernate"
        iconSource: "hibernate-cat.png"

        command: "systemctl hibernate"
        keybind: Qt.Key_H
    }

    LogoutButton {
        cardColor1: "#ccf6cca4"
        cardColor2: "#ccdc9c81"
        gradientAngle: 45

        rotationAngle: 0
        labelText: "Shutdown"
        iconSource: "cat-in-box.png"

        command: "systemctl poweroff"
        keybind: Qt.Key_P
    }

    LogoutButton {
        cardColor1: "#cc5a6970"
        cardColor2: "#cc67989c"
        gradientAngle: 45

        rotationAngle: 5
        labelText: "Reboot"
        iconSource: "reboot-cat.png"

        command: "systemctl reboot"
        keybind: Qt.Key_R
    }
}
