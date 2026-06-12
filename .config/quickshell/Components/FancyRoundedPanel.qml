import QtQuick

Canvas {
    id: root

    // Panel geometry
    property int panelX: 0
    property int panelY: 0
    property int panelWidth: 0
    property int panelHeight: 0

    // Corner radii properties (Positive = Outward, Negative = Inward/Extended tabs)
    property int topLeftRadius:     0
    property int topRightRadius:    0
    property int bottomRightRadius: 0
    property int bottomLeftRadius:  0

    // Controls which axis the negative/inverse radius extension relies on.
    property bool isTopLeftVertical:     false
    property bool isTopRightVertical:    false
    property bool isBottomLeftVertical:  false
    property bool isBottomRightVertical: false

    // Styling
    property color color: "#ffffff"

    // How far the shape extends to the left
    property int leftExtension: Math.max(
        0,
        (topLeftRadius < 0 && !isTopLeftVertical) ? Math.abs(topLeftRadius) : 0,
        (bottomLeftRadius < 0 && !isBottomLeftVertical) ? Math.abs(bottomLeftRadius) : 0
    )

    // How far the shape extends to the right
    property int rightExtension: Math.max(
        0,
        (topRightRadius < 0 && !isTopRightVertical) ? Math.abs(topRightRadius) : 0,
        (bottomRightRadius < 0 && !isBottomRightVertical) ? Math.abs(bottomRightRadius) : 0
    )

    // How far the shape extends upwards
    property int topExtension: Math.max(
        0,
        (topLeftRadius < 0 && isTopLeftVertical) ? Math.abs(topLeftRadius) : 0,
        (topRightRadius < 0 && isTopRightVertical) ? Math.abs(topRightRadius) : 0
    )

    // How far the shape extends downwards
    property int bottomExtension: Math.max(
        0,
        (bottomLeftRadius < 0 && isBottomLeftVertical) ? Math.abs(bottomLeftRadius) : 0,
        (bottomRightRadius < 0 && isBottomRightVertical) ? Math.abs(bottomRightRadius) : 0
    )

    width: panelWidth + leftExtension + rightExtension
    height: panelHeight + topExtension + bottomExtension

    // Automatic redraw triggers when properties update
    onWidthChanged:                 requestPaint()
    onHeightChanged:                requestPaint()
    onPanelXChanged:                requestPaint()
    onPanelYChanged:                requestPaint()
    onPanelWidthChanged:            requestPaint()
    onPanelHeightChanged:           requestPaint()
    onTopLeftRadiusChanged:         requestPaint()
    onTopRightRadiusChanged:        requestPaint()
    onBottomRightRadiusChanged:     requestPaint()
    onBottomLeftRadiusChanged:      requestPaint()
    onIsTopLeftVerticalChanged:     requestPaint()
    onIsTopRightVerticalChanged:    requestPaint()
    onIsBottomRightVerticalChanged: requestPaint()
    onIsBottomLeftVerticalChanged:  requestPaint()
    onColorChanged:                 requestPaint()

    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();

        const x = root.panelX + root.leftExtension;
        const y = root.panelY + root.topExtension;
        const w = root.panelWidth;
        const h = root.panelHeight;

        const tl = root.topLeftRadius;
        const tr = root.topRightRadius;
        const br = root.bottomRightRadius;
        const bl = root.bottomLeftRadius;

        ctx.beginPath();
        ctx.fillStyle = root.color;

        // ==========================================
        // 1. TOP-LEFT CORNER
        // ==========================================
        if (tl > 0) {
            ctx.arc(x + tl, y + tl, tl, Math.PI, 1.5 * Math.PI);
        } else if (tl < 0) {
            const absTl = Math.abs(tl);
            if (root.isTopLeftVertical) {
                // Extends UPWARDS out of the main box
                ctx.arc(x + absTl, y - absTl, absTl, Math.PI, 0.5 * Math.PI, true);
            } else {
                // Extends HORIZONTALLY left (Your original layout)
                ctx.arc(x - absTl, y + absTl, absTl, 0, 1.5 * Math.PI, true);
            }
        } else {
            ctx.moveTo(x, y);
        }

        // ==========================================
        // 2. TOP-RIGHT CORNER
        // ==========================================
        if (tr > 0) {
            ctx.lineTo(x + w - tr, y);
            ctx.arc(x + w - tr, y + tr, tr, 1.5 * Math.PI, 0);
        } else if (tr < 0) {
            const absTr = Math.abs(tr);
            if (root.isTopRightVertical) {
                // Extends UPWARDS out of the main box
                ctx.lineTo(x + w - absTr, y);
                ctx.arc(x + w - absTr, y - absTr, absTr, 0.5 * Math.PI, 0, true);
            } else {
                // Extends HORIZONTALLY right
                ctx.lineTo(x + w, y);
                ctx.arc(x + w + absTr, y + absTr, absTr, 1.5 * Math.PI, Math.PI, true);
            }
        } else {
            ctx.lineTo(x + w, y);
        }

        // ==========================================
        // 3. BOTTOM-RIGHT CORNER
        // ==========================================
        if (br > 0) {
            ctx.lineTo(x + w, y + h - br);
            ctx.arc(x + w - br, y + h - br, br, 0, 0.5 * Math.PI);
        } else if (br < 0) {
            const absBr = Math.abs(br);
            if (root.isBottomRightVertical) {
                // Extends DOWNWARDS out of the main box
                ctx.lineTo(x + w, y + h);
                ctx.arc(x + w - absBr, y + h + absBr, absBr, 0, 1.5 * Math.PI, true);
            } else {
                // Extends HORIZONTALLY right
                ctx.lineTo(x + w, y + h);
                ctx.arc(x + w + absBr, y + h - absBr, absBr, Math.PI, 0.5 * Math.PI, true);
            }
        } else {
            ctx.lineTo(x + w, y + h);
        }

        // ==========================================
        // 4. BOTTOM-LEFT CORNER
        // ==========================================
        if (bl > 0) {
            ctx.lineTo(x + bl, y + h);
            ctx.arc(x + bl, y + h - bl, bl, 0.5 * Math.PI, Math.PI);
        } else if (bl < 0) {
            const absBl = Math.abs(bl);
            if (root.isBottomLeftVertical) {
                // Extends DOWNWARDS out of the main box
                ctx.lineTo(x + absBl, y + h);
                ctx.arc(x + absBl, y + h + absBl, absBl, 1.5 * Math.PI, Math.PI, true);
            } else {
                // Extends HORIZONTALLY left
                ctx.lineTo(x, y + h);
                ctx.arc(x - absBl, y + h - absBl, absBl, 0.5 * Math.PI, 0, true);
            }
        } else {
            ctx.lineTo(x, y + h);
        }

        ctx.closePath();
        ctx.fill();
    }
}
