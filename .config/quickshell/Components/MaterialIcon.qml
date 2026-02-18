pragma ComponentBehavior: Bound

import QtQuick
import qs.Theme

StyledText {
    property real fill: 1.0
    // TODO: add light mode!!!!!!!!!!!!!!
    property int grade: Theme.light ? 0 : -25

    font.family: Theme.fonts.icon
    font.variableAxes: ({
        FILL: fill.toFixed(1),
        GRAD: 0,
        opsz: fontInfo.pixelSize,
        wght: fontInfo.weight
    })
}
