.pragma library

function sort(query, src, keyFn = x => x) {
    if (!query) return src;

    const q = query.toLowerCase();

    function score(str) {
        const s = str.toLowerCase();
        let score = 0;
        let lastIndex = -1;

        for (const char of q) {
            const index = s.indexOf(char, lastIndex + 1);
            if (index === -1) return -1; // no match
            score += 100 - (index - lastIndex); // closer = higher score
            lastIndex = index;
        }

        return score;
    }

    const result = [];
    for (const item of src) {
        const s = score(keyFn(item));
        if (s > 0) result.push({ item, score: s });
    }

    // sort in place
    result.sort((a, b) => b.score - a.score);

    // extract items
    for (let i = 0; i < result.length; i++) {
        result[i] = result[i].item;
    }

    return result;
}
