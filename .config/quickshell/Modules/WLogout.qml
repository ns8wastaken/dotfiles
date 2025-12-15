import QtQuick
import qs.Modules.WLogout

LogoutMenu {
    LogoutButton {
        command: "loginctl lock-session"
        keybind: Qt.Key_L
        text: "Lock"
        icon: "lock-cat.png"
    }

    LogoutButton {
        command: "loginctl terminate-user $USER"
        keybind: Qt.Key_E
        text: "Logout"
        icon: "cat-stack.png"
    }

    LogoutButton {
        command: "systemctl suspend"
        keybind: Qt.Key_U
        text: "Suspend"
        icon: "suspend-cat.png"
    }

    LogoutButton {
        command: "systemctl hibernate"
        keybind: Qt.Key_H
        text: "Hibernate"
        icon: "hibernate-cat.png"
    }

    LogoutButton {
        command: "systemctl poweroff"
        keybind: Qt.Key_K
        text: "Shutdown"
        icon: "cat-in-box.png"
    }

    LogoutButton {
        command: "systemctl reboot"
        keybind: Qt.Key_R
        text: "Reboot"
        icon: "reboot-cat.png"
    }
}
