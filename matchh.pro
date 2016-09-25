pro scale


readcol, '/Volumes/MacintoshHD2/supcam/astroref2.cat',id,ra0,dec0,u, g, r, i, z
close,/all
nb=mrdfits('CAT_527.fits',1)
b=mrdfits('CAT_B.fits',1)
v=mrdfits('CAT_V.fits',1)
nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
vf=v.flux_auto
x=v.x_image
y=v.y_image
fxread,'OBJECT.V.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
matchcat,ra0,dec0,ra,dec,in0,in,DT=0.5
print, 'in0 ',n_elements(in0)
s1=fltarr(n_elements(in0))
s2=s1
ratio=s1
openw,101,'used.reg'
openw,102,'ref.reg'
printf,101,'# Region file format: DS9 version 4.1',format='(a)' 
printf,101,'# Filename: OBJECT.V.1.fits',format='(a)'
printf,101,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,101,'fk5',format='(a)'
printf,102,'# Region file format: DS9 version 4.1',format='(a)' 
printf,102,'# Filename: OBJECT.V.1.fits',format='(a)'
printf,102,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,102,'fk5',format='(a)'
zp=s1
zp_n=s1
for i=0,n_elements(in)-1 do begin
   printf,101,'circle(',ra[in[i]],",",dec[in[i]],',2")',format='(a,d15.6,a,d15.6,a)'
   printf,102,'circle(',ra0[in0[i]],",",dec0[in0[i]],',3") # color=red',format='(a,d15.6,a,d15.6,a)'
   ;s1[i]=g[in0[i]]-r[in0[i]]
   s1[i]=bm[in[i]]-vm[in[i]]
   s2[i]=vm[in[i]]-r[in0[i]]
   ;ratio[i]=vm[in[i]]/g[in0[i]]
   ;zp[i]=g[in0[i]]-vm[in[i]]
   ;zp_n[i]=g[in0[i]]-(-2.5*alog10(vf[in[i]]/900.))
endfor
res=linfit(s1,s2,yfit=yy)
sig=stddev(abs(s2-yy))
idd=-1
for i=0,n_elements(s1)-1 do begin
   if s2[i]-yy[i] gt 3*sig then begin
      idd=[idd,i]
   endif
endfor
remove,0,idd
remove,idd,s1
remove,idd,s2
res=linfit(s1,s2,yfit=yy)
close,/all
plot, s1,s2,psym=sym(0),color=get_colour_by_name("red"),xtitle='B-V',ytitle='v-r';,yrange=[-10,10]
;scale=median(ratio)
;print,'V/g= ',scale
;print, 'ZP= ', median(zp)
;print, 'ZP_n= ', median(zp_n)

;vm_new=-2.5*alog10(vf)+median(zp_n)

readcol,'five.cat',ra1,dec1
matchcat,ra1,dec1,ra,dec,in1,in,DT=0.7
openw,3,'five.cat2'
medBV=in*0.
vm_new=medBV
for k=0,n_elements(in)-1 do begin
   print, in[k], ra[in[k]], dec[in[k]],r[in0[k]],vm[in[k]],bm[in[k]]
   medBV[k]=bm[in[k]]-vm[in[k]]
endfor
bv=median(medBV)
print,' B-V median= ', bv
for k=0,n_elements(in)-1 do begin
   vm_new[k]=-res[1]*medBV[k]-res[0]+vm[in[k]]
  
  ; vm_new[k]=float(7.2+vm[in[k]])
   printf,3, in[k], ra[in[k]], dec[in[k]], vm_new[k]
   print,vm_new[k], r[in0[k]]
endfor
xx=dindgen(15)/10.
oplot,xx,res[1]*xx+res[0]


close,3
coord, 'five.cat2','five2.reg' 
stop
end


pro coord,input, output 
close,/all
openw,101,output
readcol,input,x,y
printf,101,'# Region file format: DS9 version 4.1',format='(a)' 
printf,101,'# Filename: OBJECT.527.1.fits',format='(a)'
printf,101,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,101,'fk5',format='(a)'
for i=0,n_elements(x)-1 do printf,101,'circle(',x[i],",",y[i],',3") #color=red',format='(a,d15.6,a,d15.6,a)'

close,101
end
