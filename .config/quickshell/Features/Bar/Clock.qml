pragma ComponentBehavior: Bound

import QtQuick
import "../../Shared/Components"
import "../../Services"
import "../../Shared/Theme"

Item {
    id: root

    width: clockText.width
    height: clockText.height

    StyledText {
        id: clockText

        anchors.centerIn: parent

        text: TimeService.format("hh:mm")
        color: Theme.color.on_surface
    }
}
