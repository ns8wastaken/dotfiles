import QtQuick

Canvas {
    id: squircle

    required property real roundness
    required property color fillColor

    onPaint: {
        const ctx = getContext("2d");
        ctx.clearRect(0, 0, width, height);

        let a = width / 2;
        let b = height / 2;
        let step = 0.01;

        ctx.beginPath();

        // Parametric form of squircle
        // x = r * cos(t)^2
        // y = r * sin(t)^2
        for (let t = 0; t < 2 * Math.PI; t += step) {
            let x = a * Math.sign(Math.cos(t)) * Math.pow(Math.abs(Math.cos(t)), 2 / roundness);
            let y = b * Math.sign(Math.sin(t)) * Math.pow(Math.abs(Math.sin(t)), 2 / roundness);
            ctx.lineTo(x + a, y + b);
        }

        ctx.closePath();
        ctx.fillStyle = fillColor;
        ctx.fill();
    }
}
