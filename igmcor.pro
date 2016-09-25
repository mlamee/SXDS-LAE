pro igmcor
;Reading LFC NB383
readcol,'~/Downloads/smoka/MITCCDs/NB383.txt',l383, t383, skipline=1100, numline=172
l383=l383*10.
t383=t383/max(t383)
id383=sort(l383)
l383=l383[id383]
t383=t383[id383]
readcol,'~/Dropbox/Research/LFCQE.csv',lfc,qelfc
lfc=lfc*10.0
qelfc=qelfc/100.0
idlfc=sort(lfc)
lfc=lfc[idlfc]
qelfc=qelfc[idlfc]
; Multipltying all LFC QE
qe383=interpol(qelfc,lfc,l383,/nan)
tt383=qe383*t383

;Reading Subaru filters
readcol,'~/Downloads/smoka/MITCCDs/Usubaru.dat',lu,tu,skipline=1
idu=sort(lu)
lu=lu[idu]
tu=tu[idu]

readcol,'~/Downloads/smoka/MITCCDs/Rc.txt',lrs,trs
idrs=sort(lrs)
lrs=lrs[idrs]
trs=trs[idrs]


;reading Subaru telescope responses
readcol,'~/Downloads/smoka/MITCCDs/focus.txt',lfoc,foc
idfoc=sort(lfoc)
lfoc=lfoc[idfoc]
foc=foc[idfoc]
readcol,'~/Downloads/smoka/MITCCDs/primarymirror.txt',lprim,prim
prim=prim*10.0
idprim=sort(lprim)
lprim=lprim[idprim]
prim=prim[idprim]
readcol,'~/Downloads/smoka/MITCCDs/oldccd.dat',lccd,qe
idccd=sort(lccd)
lccd=lccd[idccd]
qe=qe[idccd]

; Multipltying all Subaru responses
qeu=interpol(qe,lccd,lu,/nan)
primu=interpol(prim,lprim,lu,/nan)
focu=interpol(foc,lfoc,lu,/nan)
tu=qeu*primu*focu*tu

qer=interpol(qe,lccd,lrs,/nan)
primr=interpol(prim,lprim,lrs,/nan)
focr=interpol(foc,lfoc,lrs,/nan)
trs=qer*primr*focr*trs

;Reading IGM attenuation at z=3.34
readcol,'~/Dropbox/IGMz3.35/IGM-z3.35.dat',ligm,tav,tam

;Calculating average IGM attenuation in IB383 band for z=3.34
igm383=interpol(tav,ligm*4.34,l383,/nan)
igmav383=int_tabulated(l383,igm383*tt383)/int_tabulated(l383,tt383)

;Calculating average IGM attenuation in U band for z=3.34
igmu=interpol(tav,ligm*4.34,lu,/nan)
igmavu=int_tabulated(lu,igmu*tu)/int_tabulated(lu,tu)

;Calculating average IGM attenuation in R band for z=3.34
igmr=interpol(tav,ligm*4.34,lrs,/nan)
igmavr=int_tabulated(lrs,igmr*trs)/int_tabulated(lrs,trs)

print,'Average IGM attenuation in SupCam R band for a source at z=3.34 is ',igmavr
print,'Average IGM attenuation in LFC IB383 band for a source at z=3.34 is ',igmav383
print,'Average IGM attenuation in SupCam U band for a source at z=3.34 is ',igmavu

stop
end
