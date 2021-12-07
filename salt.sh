echo "mol new ../glut.psf
mol addfile ../min.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile ../trajectory.dcd type dcd first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
" > s.tcl

cat salt.tcl >> s.tcl
vmd -dispdev text -e s.tcl 2> s.txt


