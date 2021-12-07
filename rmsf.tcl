set all [atomselect 1 "all"]
set compare [atomselect 1 "protein and alpha"]
set ref [atomselect 0 "protein and alpha"]

set num_steps [molinfo 1 get numframes]
for {set frame 0} {$frame < $num_steps} {incr frame} {
    $all frame $frame
    $compare frame $frame

    set trans [measure fit $compare $ref]
    $all move $trans
}

for {set i 0} {$i < [$compare num]} {incr i} {
     set rmsf [measure rmsf $compare first 0 last -1 step 1]
     puts stderr "[expr {$i+1}] \t [lindex $rmsf $i]"
}

quit
