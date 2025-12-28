#!/bin/bash

# Read /proc/stat once (instant)
cpu_usage_snapshot() {
    read -r line < /proc/stat
    read -ra s <<< "$line"
    idle=${s[4]}
    total=0
    for v in "${s[@]:1}"; do ((total+=v)); done
    # store to temp file for next run
    echo "$idle $total"
}

# Compute CPU usage from previous snapshot if available
cpu_usage() {
    local idle2 total2 idle1 total1 di dt
    read -r line < /proc/stat
    read -ra s <<< "$line"
    idle2=${s[4]}
    total2=0; for v in "${s[@]:1}"; do ((total2+=v)); done

    if [[ -f /tmp/.cpu_prev ]]; then
        read -r idle1 total1 < /tmp/.cpu_prev
        di=$((idle2 - idle1))
        dt=$((total2 - total1))
        ((dt > 0)) && echo $((100 * (dt - di) / dt)) || echo 0
    else
        echo 0
    fi

    echo "$idle2 $total2" > /tmp/.cpu_prev
}

cpu_temp() {
    # Use the following command to find which zone is of type x86_pkg_temp and use that zone
    # cat /sys/class/thermal/thermal_zone*/type
    local f="/sys/class/thermal/thermal_zone1/temp"
    [[ -f $f ]] && echo $(( $(<"$f") / 1000 )) || echo 0
}

memory_usage() {
    local t a u p
    while read -r k v _; do
        case "$k" in
            MemTotal:) t=$v ;;
            MemAvailable:) a=$v ;;
        esac
    done < /proc/meminfo
    u=$((t - a))
    p=$((100 * u / t))
    echo "$u $p"
}

disk_usage() {
    df --output=pcent / | tail -n1 | tr -dc '0-9'
}

cpu=$(cpu_usage)
cputemp=$(cpu_temp)
read -r used mperc <<< "$(memory_usage)"
diskper=$(disk_usage)

printf '{"cpu":%d,"cputemp":%d,"mem":%d,"memper":%d,"diskper":%d}\n' \
        "$cpu" "$cputemp" "$((used/1024))" "$mperc" "$diskper"
