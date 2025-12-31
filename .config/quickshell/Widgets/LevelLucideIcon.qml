import qs.Components

LucideIcon {
    required property list<string> icons
    required property real value
    property real min: 0.0
    property real max: 1.0

    function indexFor(v: real): int {
        if (v <= min) return 0;
        if (v >= max) return icons.length - 1;

        const clamped = Math.max(min, Math.min(max, v));
        const range = max - min;
        const buckets = icons.length - 2;

        return 1 + Math.floor(((clamped - min) / range) * buckets);
    }

    source: icons[indexFor(value)]
}
