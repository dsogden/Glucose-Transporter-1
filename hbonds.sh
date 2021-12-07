for i in `seq 0 2`
do

cat > do.tcl << EOF
mol new ../glut.psf
mol addfile ../$i.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
source macro.tcl

package require hbonds
set N [atomselect top "NTD"]
set C [atomselect top "CTD"]
hbonds -sel1 \$N -sel2 \$C -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-N-C.dat -polar yes -DA both -type all -detailout stdout-N-C

quit

EOF

vmd -dispdev text -e do.tcl

done
for i in `seq 0 2`
do

cat > do2.tcl << EOF
mol new ../glut.psf
mol addfile ../$i.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
source macro.tcl

package require hbonds
set C [atomselect top "CTD"]
set ICH [atomselect top "ICHD"]
hbonds -sel1 \$C -sel2 \$ICH -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-C-ICH.dat -polar yes -DA both -type all -detailout stdout-C-ICH

quit

EOF

vmd -dispdev text -e do2.tcl

done
for i in `seq 0 2`
do

cat > do3.tcl << EOF
mol new ../glut.psf
mol addfile ../$i.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
source macro.tcl

package require hbonds
set N [atomselect top "NTD"]
set ICH [atomselect top "ICHD"]
hbonds -sel1 \$N -sel2 \$ICH -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-N-ICH.dat -polar yes -DA both -type all -detailout stdout-N-ICH

quit

EOF

vmd -dispdev text -e do3.tcl

done
for i in `seq 0 2`
do

cat > do4.tcl << EOF
mol new ../glut.psf
mol addfile ../$i.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
source macro.tcl

package require hbonds
set prot [atomselect top "protein"]
set lipid [atomselect top "lipid"]
hbonds -sel1 \$prot -sel2 \$lipid -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-prot-lipid.dat -polar yes -DA both -type all -detailout stdout-prot-lipid

quit

EOF

vmd -dispdev text -e do4.tcl

done
