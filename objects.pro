pro ob
readcol,'~/Dropbox/Research/SupCam/BVge0.4_err/BVge0.4_err.cat',skipline=17,ra,dec,u,uer,b,ber,nb,nber,v,ver,r,rer,ew,ewer,nb2,nb2er,f

id=sort(nb)
nb=nb[id]
nber=nber[id]
ra=ra[id]
dec=dec[id]
f=f[id]
ew=ew[id]
ewer=ewer[id]
hh=fix(ra/15)
mm=fix((ra-(hh*15.))*60./15.)
ss=(ra-(hh*15.+mm*15./60.))*3600./15.
print,hh,mm,ss
dd=fix(dec)
mmd=fix((dec-dd)*60)
ssd=(dec-(dd+mmd/60.0))*3600.0
openw,lun,'targets.hydra',/get_lun
for i=0,n_elements(ra)-1 do printf,lun,hh[i],mm[i],ss[i],dd[i],mmd[i],ssd[i],'O', format='(I02,1x,I02,1x,f6.3,1x,I02,1x,I03,1x,f7.3,1x,a)'
free_lun,lun
stop
end
