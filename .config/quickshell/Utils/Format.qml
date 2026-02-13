pragma Singleton

import Quickshell

Singleton {
    function seconds(s: int): string {
        const day = Math.floor(s / 86400);
        const hr = Math.floor(s / 3600) % 60;
        const min = Math.floor(s / 60) % 60;

        let comps = [];
        if (day > 0) comps.push(day + 'd');
        if (hr  > 0) comps.push(hr  + 'h');
        if (min > 0) comps.push(min + 'm');

        return comps.join(' ');
    }
}
