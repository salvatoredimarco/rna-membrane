#!/bin/bash
#executed in metadyn folder
#creates amber topology from given conf.pdb, in order to use MMPBSA.Py
#AmberTools required!
echo 1 | gmx editconf -f ../conf.pdb -o 3drism/conf.pdb -n ../indices.ndx
echo 1 | gmx trjconv -f prod_metadyn_sel_unbound_allatom.xtc -o 3drism/prod_metadyn.xtc -n ../indices -skip 3
pdb4amber -i 3drism/conf.pdb -o 3drism/conf_amb.pdb
#sed -i -e "s/${nucl} /${nucl}N/g" 3drism/conf_amb.pdb
cd 3drism
tleap -f leap.in
MMPBSA.py -O -i mmPBSA_3D-RISM.in -o MMPBSA_RESULTS.out -cp lig.prmtop -y prod_metadyn.xtc
