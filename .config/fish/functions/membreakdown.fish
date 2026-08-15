function membreakdown --description 'Show detailed memory breakdown of a process and its libraries'
    if test -z "$argv[1]"
        echo "Usage: membreakdown <PID or Process Name>"
        return 1
    end

    set -l PID

    # Check if the argument is a PID (number) or a name (string)
    if string match -qr '^[0-9]+$' "$argv[1]"
        set PID $argv[1]
    else
        # Only spawn pgrep if we absolutely have to
        set PID (pgrep -f "$argv[1]" | head -n 1)
        if test -z "$PID"
            echo "Error: No process found matching '$argv[1]'"
            return 1
        end
    end

    # Fast path: Read process name directly from /proc instead of spawning 'ps'
    if not test -f /proc/$PID/comm
        echo "Error: Process with PID $PID does not exist."
        return 1
    end
    set -l pid_name (cat /proc/$PID/comm)

    # Fast path: Check read permissions using shell builtin instead of spawning 'pmap'
    set -l pmap_cmd pmap -x $PID
    if not test -r /proc/$PID/maps
        echo "Warning: Permission denied. Elevating with sudo..."
        set pmap_cmd sudo pmap -x $PID
    end

    # Run pmap and pipe the output to Python
    $pmap_cmd 2>/dev/null | python3 -c '
import sys

pid = "'$PID'"
pid_name = "'$pid_name'"

# Bulk read stdin lines
lines = sys.stdin.read().splitlines()
if len(lines) < 3:
    print("Error: Could not parse pmap output. (Process may have exited or requires sudo)")
    sys.exit(1)

categories = {
    "binary": 0,
    "heap": 0,
    "stack": 0,
    "anon": 0,
    "total_libs": 0,
    "other": 0
}
libs = {}

# Keep common strings in local scope for micro-optimization
heap_str, stack_str, anon_str, so_str = "[heap]", "[stack]", "[anon]", ".so"

for line in lines[2:]:
    parts = line.split()
    if not parts or parts[0] == "total" or "-" in parts[0]:
        continue
    if len(parts) < 3:
        continue

    try:
        rss = int(parts[2])
    except ValueError:
        continue

    mapping = parts[-1]

    if heap_str in mapping:
        categories["heap"] += rss
    elif stack_str in mapping:
        categories["stack"] += rss
    elif anon_str in mapping:
        categories["anon"] += rss
    elif so_str in mapping:
        lib_name = mapping.split("/")[-1]
        libs[lib_name] = libs.get(lib_name, 0) + rss
        categories["total_libs"] += rss
    elif pid_name in mapping:
        categories["binary"] += rss
    else:
        categories["other"] += rss

def fmt(kb):
    if kb >= 1024:
        return f"{kb:d} KB ({kb/1024.0:.1f} MB)"
    return f"{kb:d} KB"

lbl_header_cat = "Category / Shared Library"
lbl_header_rss = "RSS"
lbl_binary = "[Program Binary]"
lbl_heap = "[Heap]"
lbl_stack = "[Stack]"
lbl_anon = "[Anonymous (Dynamic Mem)]"
lbl_libs = "[Total Shared Libraries]"
lbl_other = "[Other/Unclassified]"
lbl_total = "TOTAL RSS"

val_binary = fmt(categories["binary"])
val_heap = fmt(categories["heap"])
val_stack = fmt(categories["stack"])
val_anon = fmt(categories["anon"])
val_libs = fmt(categories["total_libs"])
val_other = fmt(categories["other"])
val_total = fmt(sum(categories.values()))

print(f"=============================================================")
print(f"  DETAILED MEMORY BREAKDOWN (PID: {pid} - {pid_name})")
print(f"=============================================================")
print(f"{lbl_header_cat:<34} {lbl_header_rss:>25}")
print("-------------------------------------------------------------")
print(f"{lbl_binary:<34} {val_binary:>25}")
print(f"{lbl_heap:<34} {val_heap:>25}")
print(f"{lbl_stack:<34} {val_stack:>25}")
print(f"{lbl_anon:<34} {val_anon:>25}")
print(f"{lbl_libs:<34} {val_libs:>25}")
print(f"{lbl_other:<34} {val_other:>25}")
print("-------------------------------------------------------------")
print("INDIVIDUAL SHARED LIBRARIES (.so):")

sorted_libs = sorted(libs.items(), key=lambda x: x[1], reverse=True)
for lib, size in sorted_libs:
    if size > 0:
        val_size = fmt(size)
        print(f"  {lib:<32} {val_size:>25}")

print("-------------------------------------------------------------")
print(f"{lbl_total:<34} {val_total:>25}")
print("=============================================================")
'
end
