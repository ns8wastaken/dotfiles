.pragma library

function score(query, str) {
    let score = 0;
    let lastIndex = -1;

    for (const char of query) {
        const index = str.indexOf(char, lastIndex + 1);
        if (index === -1) {
            return { isValid: false, score: 0 };
        }

        if (lastIndex === -1) {
            score += Math.max(0, 100 - index);
        } else {
            let distance = index - lastIndex;
            if (distance === 1) {
                score += 200;
            } else {
                score += Math.max(0, 100 - distance);
            }
        }

        lastIndex = index;
    }

    return { isValid: true, score: score };
}

function fuzzySort(query, src, keyFn = x => x) {
    if (!query) return src;

    const q = query.toLowerCase();
    const result = [];

    for (const item of src) {
        const match = score(q, keyFn(item).toLowerCase());

        if (match.isValid) {
            result.push({ item, score: match.score });
        }
    }

    result.sort((a, b) => b.score - a.score);

    for (let i = 0; i < result.length; i++) {
        result[i] = result[i].item;
    }

    return result;
}
