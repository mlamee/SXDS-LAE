pro sky
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.exp',exp383,h383
fxread,'/Volumes/MacintoshHD2/supcam/quilt/l527new3.exp',exp527,h527
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',im,h
fxread,'/Volumes/MacintoshHD2/supcam/quilt/seg-V.fits',seg,hv

;nb=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527single.fits',1,h2)
;x2=nb.x_image-1
;y2=nb.y_image-1
extast,hv,astr
extast,h383,astr383

x=n_elements(im[*,0])-2800
y=n_elements(im[0,*])-3200
x=fix(x*randomu(f,1000))+1400
y=fix(y*randomu(f,1000))+1600
xy2ad,x,y,astr,ra,dec
ad2xy,ra,dec,astr383,x383,y383
idx=-1
idy=-1
for i=0,n_elements(x)-1 do begin
   for j=0, n_elements(y)-1 do begin
      if (exp383[x383[i],y383[j]] ne 0 and exp527[x[i],y[j]] ne 0 and total(seg[x[i]-14:x[i]+14,y[j]-14:y[j]+14]) eq 0) then begin
      idx=[idx,i]
      idy=[idy,j]
      endif
   endfor
endfor
;id=where(exp383[x383,y383] ne 0 and exp527[x,y] ne 0 and seg[x,y] eq
;0)
remove,0,idx
remove,0,idy
x=x[idx]
y=y[idy]
nx=n_elements(x)-1
idxy=fix(nx*randomu(f,1000))
x=x[idxy]
y=y[idxy]
xy2ad,x,y,astr,ra,dec
;xy2ad,x2,y2,astr,ra2,dec2
;matchcat,ra,dec,ra2,dec2,in,in2,DT=4.0
;remove,in,ra
;remove,in,dec
hh=fix(ra/15)
mm=fix((ra-(hh*15.))*60./15.)
ss=(ra-(hh*15.+mm*15./60.))*3600./15.
print,hh,mm,ss
dd=fix(dec)
mmd=fix(-(dec-dd)*60)
ssd=-(dec-(dd-mmd/60.0))*3600.0
print,dd,mmd,ssd
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra],[dec]],'Hydra_sky.reg','red','2.0'
openw,lun,'sky.hydra',/get_lun
;for i=0,n_elements(ra)-1 do printf,lun,ra[i],dec[i],
;format='(f10.5,3x,f10.5)'
for i=0,n_elements(ra)-1 do printf,lun,hh[i],mm[i],ss[i],dd[i],mmd[i],ssd[i],'S', format='(I02,1x,I02,1x,f6.3,1x,I02,1x,I02,1x,f6.3,1x,a)'

free_lun,lun
stop
end


pro fib
  readcol,'sky.hydra',hhs,mms,sss,dds,mmds,ssds,format='(I,I,f,I,I,f)'
;sky=strcompress(string(hhs,format='(I02)')+string(mms,format='(I02)')+string(sss,format='(f6.3)')+string(dds,format='(I02)')+string(mmds,format='(I02)')+string(ssds,format='(f6.2)'),/remove_all)
sky=strarr(1000)
for j=0,n_elements(hhs)-1 do sky[j]='sky'+string(j,format='(I003)')
readcol,'FOP.hydra',hhf,mmf,ssf,ddf,mmdf,ssdf,r,format='(I,I,f,I,I,f,x,f)'
;fop=strcompress(string(hhf,format='(I02)')+string(mmf,format='(I02)')+string(ssf,format='(f6.3)')+string(ddf,format='(I02)')+string(mmdf,format='(I02)')+string(ssdf,format='(f6.2)'),/remove_all)
fop='r='+strcompress(string(r,format='(f5.2)'),/remove_all)
readcol,'BVge0.4_err/BVge0.4_err_final.cat',ra,dec,nb,v,ew,format='(f,f,x,x,x,x,f,x,f,x,x,x,f)',skipline=18 ;one Object with U det is excluded
id=sort(nb)
ra=ra[id]
dec=dec[id]
nb=nb[id]
ew=ew[id]
v=v[id]
hh=fix(ra/15)
mm=fix((ra-(hh*15.))*60./15.)
ss=(ra-(hh*15.+mm*15./60.))*3600./15.

dd=fix(dec)
mmd=fix(-(dec-dd)*60)
ssd=-(dec-(dd-mmd/60.0))*3600.0

readcol,'BVge0.4_noerronly/BVge0.4_noerronly_final.cat',ra9,dec9,nb9,v9,ew9,format='(f,f,x,x,x,x,f,x,f,x,x,x,f)',skipline=17 ;Eight Object are excluded
id9=sort(nb9)
ra9=ra9[id9]
dec9=dec9[id9]
nb9=nb9[id9]
ew9=ew9[id9]
v9=v9[id9]
hh9=fix(ra9/15)
mm9=fix((ra9-(hh9*15.))*60./15.)
ss9=(ra9-(hh9*15.+mm9*15./60.))*3600./15.
dd9=fix(dec9)
mmd9=fix(-(dec9-dd9)*60)
ssd9=-(dec9-(dd9-mmd9/60.0))*3600.0

;targets2=strcompress(string(hh,format='(I02)')+string(mm,format='(I02)')+string(ss,format='(f6.3)')+string(dd,format='(I02)')+string(mmd,format='(I02)')+string(ssd,format='(f6.2)'),/remove_all)
targets='NB='+strcompress(string(nb,format='(f5.2)'),/remove_all)+' EW='+strcompress(string(EW,format='(f6.1)'))
extra='NB='+strcompress(string(nb9,format='(f5.2)'),/remove_all)+' EW='+strcompress(string(EW9,format='(f6.1)'))

close,/all
openw,lun,'SXDS1.ast',/get_lun
printf,lun,'FIELD NAME: SXDS Palomar'
printf,lun,'INPUT EPOCH: 2000.00'
printf,lun,'CURRENT EPOCH: 2013.68'
printf,lun,'SIDEREAL TIME: 7.0'
printf,lun,'EXPOSURE LENGTH: 0.5'
printf,lun,'WAVELENGTH: 5700.'
printf,lun,'CABLE: RED
printf,lun,'GUIDEWAVE: 6000.0'
printf,lun,'WEIGHTING: STRONG'
printf,lun,'#0000000011111111112222222222333333333344444444445555'
printf,lun,'#2345678901234567890123456789012345678901234567890123'
printf,lun,0,'Center', 02,18,07.285,-05,21,26.43,'C',format='(I04,1x,a20,1x,I02,1x,I02,1x,f6.3,1x,I003,1x,I02,1x,f5.2,1x,a)';compelete this
names=[fop,targets,sky,extra]
h=[hhf,hh,hhs,hh9]
m=[mmf,mm,mms,mm9]
s=[ssf,ss,sss,ss9]
d=[ddf,dd,dds,dd9]
m2=[mmdf,mmd,mmds,mmd9]
s2=[ssdf,ssd,ssds,ssd9]
class=strarr(n_elements(h))
class[0:n_elements(hhf)-1]='F'
class[n_elements(hhf):n_elements(hh)+n_elements(hhf)-1]='O'
class[n_elements(hh)+n_elements(hhf):n_elements(hh)+n_elements(hhf)+n_elements(hhs)-1]='S'
class[n_elements(hh)+n_elements(hhf)+n_elements(hhs):n_elements(hh)+n_elements(hhf)+n_elements(hhs)+n_elements(hh9)-1]='E'
for i=0,n_elements(h)-1 do printf,lun,i+1,names[i],h[i],m[i],s[i],d[i],m2[i],s2[i],class[i], format='(I04,1x,a20,1x,I02,1x,I02,1x,f6.3,1x,I003,1x,I02,1x,f5.2,1x,a)'

free_lun,lun
stop
end
