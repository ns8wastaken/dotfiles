pragma Singleton

import Quickshell
import QtQuick

Singleton {
    /*
     * This entire singleton is meant to operate entirely on filesystem paths,
     * not qml url starting with file:// or anything else
     */

    readonly property string home: Quickshell.env("HOME")

    function toLocalFile(path: string, returnEmptyOnFail = false): string {
        if (path.startsWith("file://"))
            return path.slice(7);

        // Already a filesystem path
        if (path.startsWith("/"))
            return path;

        return returnEmptyOnFail ? "" : null;
    }

    function resolved(path: string, cwd = "/"): string {
        const hadTrailingSlash = path.length > 1 && path.endsWith("/");

        /* ---- Expand ~ ---- */
        if (path === "~") {
            path = home;
        } else if (path.startsWith("~/")) {
            path = home + path.slice(1);
        } else if (path.startsWith("./")) {
            path = cwd + path.slice(2);
        }

        /* ---- Stackificationalization ---- */
        const stack = [];

        if (!path.startsWith("/")) {
            if (!cwd || !cwd.startsWith("/")) {
                console.warn("cwd must be an absolute path");
            }

            for (const part of cwd.split("/")) {
                if (part) stack.push(part);
            }
        }

        /* ---- Normalize ---- */
        for (const part of path.split("/")) {
            switch (part) {
                case "":
                case ".":
                    break;

                case "..":
                    if (stack.length > 0) {
                        stack.pop();
                    }
                    break;

                default:
                    stack.push(part);
            }
        }

        let result = stack.length === 0 ? "/" : "/" + stack.join("/");

        if (hadTrailingSlash && result !== "/") {
            result += "/";
        }

        return result;
    }

    function relative(path: string, cwd = "/"): string {
        // Strip trailing slash (except root)
        if (path.length > 1 && path.endsWith("/"))
            path = path.slice(0, -1);

        if (cwd.length > 1 && cwd.endsWith("/"))
            cwd = cwd.slice(0, -1);

        const targetParts = path.split("/").filter(Boolean);
        const baseParts = cwd.split("/").filter(Boolean);

        // Find common prefix
        let i = 0;
        while (
            i < targetParts.length &&
            i < baseParts.length &&
            targetParts[i] === baseParts[i]
        ) {
            i++;
        }

        // How many times to go up
        const up = baseParts.length - i;
        const result = [];

        for (let j = 0; j < up; j++)
            result.push("..");

        // Then descend into path
        result.push(...targetParts.slice(i));

        return result.length === 0 ? "." : result.join("/");
    }
}
