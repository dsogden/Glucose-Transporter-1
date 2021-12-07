for i in `seq 0 2`
do

cat > do.tcl << EOF
mol new ../glut.psf
mol addfile ../$i.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all

package require saltbr
set pro [atomselect top "protein"]
saltbr -sel \$pro -ondist 4.0 -log saltbr-$i.log -outdir $i/

quit

EOF

vmd -dispdev text -e do.tcl

done
