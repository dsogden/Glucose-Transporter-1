for i in `seq 0 2`
do

# shell script that writes a tcl file to run analysis through VMD

cat > do.tcl << EOF
mol new ../glut.psf # structure file
mol addfile ../$i.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all # trajectory
source macro.tcl # contains atomselections

package require hbonds # load package
# make atomselections
set N [atomselect top "NTD"]
set C [atomselect top "CTD"]
set prot [atomselect top "protein"]
set lipid [atomselect top "lipid"]

# Will report residues invovled and number of bonds at each timestep - looks at polar atoms and returns both donor and acceptor atoms
# Use a modest search 4 Å and 35 degrees 

# Hbonds between N and C
hbonds -sel1 \$N -sel2 \$C -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-N-C.dat -polar yes -DA both -type unique -detailout stdout-N-C

# Hbonds between C and ICH
hbonds -sel1 \$C -sel2 \$ICH -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-C-ICH.dat -polar yes -DA both -type unique -detailout stdout-C-ICH

# Hbonds between N and ICH
hbonds -sel1 \$N -sel2 \$ICH -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-N-ICH.dat -polar yes -DA both -type unique -detailout stdout-N-ICH

# Hbonds betweeen Protein and Lipids
hbonds -sel1 \$prot -sel2 \$lipid -writefile yes -upsel yes -frames all -dist 4.0 -ang 35 \
-plot no -outdir $i -outfile hbonds-prot-lipid.dat -polar yes -DA both -type unique -detailout stdout-prot-lipid

quit

EOF

vmd -dispdev text -e do.tcl

done
