set all [atomselect 1 "all"]
set sel [atomselect 1 "protein and alpha"]
set ref [atomselect 0 "protein and alpha"]

set N [atomselect 1 "NTD and alpha"]
set rN [atomselect 0 "NTD and alpha"]
set C [atomselect 1 "CTD and alpha"]
set rC [atomselect 0 "CTD and alpha"]

set ICH [atomselect 1 "ICHD and alpha"]
set rICH [atomselect 0 "ICHD and alpha"]

set n_frames [molinfo 1 get numframes]

for {set frame_num 0} {$frame_num < $n_frames} {incr frame_num} {

    $all frame $frame_num
    $sel frame $frame_num
    $N frame $frame_num
    $C frame $frame_num
    $ICH frame $frame_num

    $all move [measure fit $sel $ref]

    set Nrmsd [measure rmsd $N $rN]
    set Crmsd [measure rmsd $C $rC]
    set Prmsd [measure rmsd $sel $ref]
    set ICHrmsd [measure rmsd $ICH $rICH]

   puts stderr "$frame_num $Prmsd $Nrmsd $Crmsd $ICHrmsd"

}

quit

