pro ext
  readcol, '~/Downloads/smoka/MITCCDs/NB527.txt',lam527, p527,skipline=22
readcol,'~/Downloads/smoka/MITCCDs/B.txt',lamb,pb
readcol,'~/Downloads/smoka/MITCCDs/V.txt',lamv,pv
readcol,'~/Downloads/smoka/MITCCDs/NB383.txt',l383, t383, skipline=1100, numline=172
l383=l383*10.
t383=t383/max(t383)
id=sort(l383)
t383=t383[id]
l383=l383[id]
readcol,'~/Downloads/smoka/MITCCDs/Usubaru2.dat',lu2,tu2,skipline=1
remove,101,lu2
remove, 101,tu2
readcol,'~/Downloads/smoka/MITCCDs/r.txt',lamr,pr

lf527=int_tabulated(lam527,lam527*p527,/sort)/int_tabulated(lam527,p527,/sort) ;the average wavelength
lfb=int_tabulated(lamb,lamb*pb,/sort)/int_tabulated(lamb,pb,/sort)
lfv=int_tabulated(lamv,lamv*pv,/sort)/int_tabulated(lamv,pv,/sort)
lf383=int_tabulated(l383,l383*t383,/sort)/int_tabulated(l383,t383,/sort) ;the average wavelength
lfr=int_tabulated(lamr,lamr*pr,/sort)/int_tabulated(lamr,pr,/sort)
lfu=int_tabulated(lu2,lu2*tu2,/sort)/int_tabulated(lu2,tu2,/sort)
upiv=sqrt(int_tabulated(lu2,lu2*tu2,/sort)/int_tabulated(lu2,tu2/lu2,/sort))
l383piv=sqrt(int_tabulated(l383,l383*t383,/sort)/int_tabulated(l383,t383/l383,/sort))
rpiv=sqrt(int_tabulated(lamr,lamr*pr,/sort)/int_tabulated(lamr,pr/lamr,/sort))
l527piv=sqrt(int_tabulated(lam527,lam527*p527,/sort)/int_tabulated(lam527,p527/lam527,/sort)) ;the average wavelength



  stop
  end
