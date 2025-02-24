#!/bin/bash
nucls="hairpin"
st="100"
Ts="323"
bf=10
ssh-keygen -R "login.leonardo.cineca.it"
#ssh-keyscan -H "login.leonardo.cineca.it" >> ~/.ssh/known_hosts
control_path="/tmp/ssh_mux_login.leonardo.cineca.it_sdimarco"
ssh -fN -o ControlMaster=yes -o ControlPath=${control_path} -o ControlPersist=10m "sdimarco@login.leonardo.cineca.it"
for T in $Ts
do
for nucl in $nucls
do
mkdir $nucl
cd $nucl
scp -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/conf.pdb .
scp -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/conf.gro .
scp -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/topol.top .
scp -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/indices.ndx .
scp -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/*mdp .
scp -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/*itp .
rm mdout.mdp
mkdir metadyn
cd metadyn
scp  -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/metadyn-bf${bf}-zdist/prod_metad.mdp .
scp  -o ControlPath=${control_path} leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/metadyn-bf${bf}-zdist/plumed_metad.dat .
rm mdout.mdp
cd ../../
#scp leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/metadyn-bf${bf}-zdist/METADYN_WALL METADYN_WALL_${nucl}
#scp leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/metadyn-bf${bf}-zdist/fes.dat fes_${nucl}_${T}K_bf${bf}_ST${st}.dat
#scp leonardo:/leonardo_scratch/large/userexternal/sdimarco/Membrane/DPPC/output/ST${st}/${T}K/${nucl}/metadyn-bf${bf}-zdist/METADYN_VMAX METADYN_VMAX_${nucl}_${T}K_bf${bf}_ST${st}
done
done
ssh -O exit -o ControlPath=${control_path} "sdimarco@login.leonardo.cineca.it"
