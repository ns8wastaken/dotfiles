import QtQuick
import qs.Settings

Rectangle {
    id: circularProgressBar

    color: "transparent"

    required property real progress // 0.0 to 1.0
    required property int size
    required property color backgroundColor
    required property color progressColor
    required property int strokeWidth
    required property bool showText
    required property string units
    required property int textSize

    property string text: Math.round(progress * 100) + units

    width: size
    height: size

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            var centerX = width / 2
            var centerY = height / 2
            var radius = Math.min(width, height) / 2 - circularProgressBar.strokeWidth / 2
            var startAngle = -Math.PI / 2 // Start from top

            // Clear canvas
            ctx.reset()

            // Background circle
            ctx.strokeStyle = circularProgressBar.backgroundColor
            ctx.lineWidth = circularProgressBar.strokeWidth
            ctx.lineCap = "round"
            ctx.beginPath()

            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI)
            ctx.stroke()

            // Progress arc
            if (circularProgressBar.progress > 0) {
                ctx.strokeStyle = circularProgressBar.progressColor
                ctx.lineWidth = circularProgressBar.strokeWidth
                ctx.lineCap = "round"
                ctx.beginPath()

                ctx.arc(
                    centerX,
                    centerY,
                    radius,
                    startAngle,
                    startAngle + (2 * Math.PI * circularProgressBar.progress)
                )
                ctx.stroke()
            }
        }
    }

    // Center text - always show the percentage
    Text {
        id: centerText
        anchors.centerIn: parent
        text: circularProgressBar.text
        font.pixelSize: circularProgressBar.textSize
        font.family: Settings.fontFamily
        font.bold: true
        color: Theme.textPrimary
        visible: circularProgressBar.showText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // Animate progress changes
    Behavior on progress {
        NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
    }

    // Redraw canvas when properties change
    onProgressChanged: canvas.requestPaint()
    onSizeChanged: canvas.requestPaint()
    onBackgroundColorChanged: canvas.requestPaint()
    onProgressColorChanged: canvas.requestPaint()
    onStrokeWidthChanged: canvas.requestPaint()
}
