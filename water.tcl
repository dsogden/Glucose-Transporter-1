set num_steps [molinfo 1 get numframes]
set sel [atomselect 1 "water and same residue as (within 5 of protein) and not (within 5 of lipids) and noh"]
set pro [atomselect 1 "protein and noh"]
set ref [atomselect 0 "protein and noh"]
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $pro frame $frame
    $sel frame $frame
    $sel update
    $sel move [measure fit $pro $ref]
    for {set k -40} {$k<41} {incr k} {
	set h($k) 0
    }
    set zcoor [$sel get z]
    foreach Z $zcoor {
	set k [expr "round($Z)"]
	if {$k>=-40 && $k<41} {
	    incr h($k)
	}
    }
    for {set k -40} {$k<41} {incr k} {
	puts -nonewline stderr " $h($k)"
    }
    puts stderr ""
}
quit

