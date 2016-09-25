pro zp


readcol, '/Volumes/MacintoshHD2/supcam/astroref3.cat',id,ra0,dec0,u, g, r, i, z
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/ub.txt',q,ubsyn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/bv.txt',q,bvsyn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/g.txt',q,gsyn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/u.txt',q,usyn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/rp.txt',q,rsyn
close,/all
nb=mrdfits('CAT_527.fits',1)
b=mrdfits('CAT_B.fits',1)
v=mrdfits('CAT_V.fits',1)
;uu=mrdfits('CAT_U.fits',1)
nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
vf=v.flux_auto
um=uu.mag_auto
;uf=uu.flux_auto
x=nb.x_image-1
y=nb.y_image-1

;ra=v.x_world
;dec=v.y_world
fxread,'OBJECT.527.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
matchcat,ra0,dec0,ra,dec,in0,in,DT=0.5
print, 'in0 ',n_elements(in0)
s1=fltarr(n_elements(in0))
s2=s1
ss1=s1

ss2=s1
sss1=s1
sss2=s1
;su1=s1
;su2=s1
openw,lun,'radec.txt',/get_lun
openw,lun1,'ra0dec0.txt',/get_lun
for i=0,n_elements(in)-1 do begin
if u[in0[i]] lt 26. then begin
   s1[i]=g[in0[i]]-r[in0[i]]
   s2[i]=vm[in[i]]-r[in0[i]]
   ss1[i]=u[in0[i]]-g[in0[i]]
  
   ss2[i]=bm[in[i]]-g[in0[i]]
   sss1[i]=g[in0[i]]-r[in0[i]]
   sss2[i]=nbm[in[i]]-r[in0[i]]
   
   ;su1=u[in0[i]]-g[in0[i]]
  ; su2=um[in[i]]-g[in0[i]]
;;;;;;;;;;;
   ;sss2[i]=nbm[in[i]]-vm[in[i]]
;;;;;;;;;
   printf,lun,ra[in[i]],dec[in[i]]
   printf,lun1,ra0[in0[i]],dec0[in0[i]]
endif
endfor
free_lun,lun
free_lun,lun1
coord, 'radec.txt','radec.reg'
coord,'ra0dec0.txt','ra0dec0.reg'
bv0=ss2-s2+s1
ub0=ss1-ss2
resv=linfit(s1,s2,yfit=yy)
sigv=stddev(s2-yy)
idd=-1

resb=linfit(ss1,ss2,yfit=yyb)

sigb=stddev(ss2-yyb)

idb=-1
resnb=linfit(sss1,sss2,yfit=yynb)
;;;;;;;;;;
;resnb=linfit(bv0,sss2,yfit=yynb)
;;;;;;;;;;
signb=stddev(sss2-yynb)
idnb=-1
for i=0,n_elements(s1)-1 do begin
   if abs(s2[i]-yy[i]) gt 2*sigv then begin
      idd=[idd,i]
   endif
   if abs(ss2[i]-yyb[i]) gt 2*sigb then begin
      idb=[idb,i]
   endif
   if abs(sss2[i]-yynb[i]) gt 2*signb then begin
      idnb=[idnb,i]
   endif
endfor
print,'s1 ',n_elements(s1)
remove,0,idd
remove,idd,s1
remove,idd,s2
print,'s1 ',n_elements(s1)

resv=linfit(s1,s2,yfit=yy)
zpv=resv[0]
remove,0,idb
remove,idb,ss1
remove,idb,ss2

resb=linfit(ss1,ss2,yfit=yyb)

zpb=resb[0]
remove,0,idnb
remove,idnb,sss1
;remove,idnb,bv0
remove,idnb,sss2
resnb=linfit(sss1,sss2,yfit=yynb)
;resnb=linfit(bv0,sss2,yfit=yynb)
zpnb=resnb[0]
set_plot, 'ps'
device,filename='zpv.ps',/encap,/color
plot, s1,s2,psym=sym(0),color=get_colour_by_name("black"),xtitle='g-r',ytitle='V-r';,yrange=[-10,10]
xx=dindgen(40)/10.-1
oplot,xx,resv[1]*xx+resv[0],color=get_colour_by_name("red")
device, /close
device,filename='zpb.ps',/encap,/color
plot, ss1,ss2,psym=sym(0),color=get_colour_by_name("black"),xtitle='u-g',ytitle='B-g',xrange=[-2,2];,yrange=[-10,10],xrange=[-2,2]
oplot,xx,resb[1]*xx+resb[0],color=get_colour_by_name("red")
device, /close
device,filename='zpnb.ps',/encap,/color
plot, sss1,sss2,psym=sym(0),color=get_colour_by_name("black"),xtitle='g-r',ytitle='NB527-r';,yrange=[-10,10]
;plot, bv0,sss2,psym=sym(0),color=get_colour_by_name("black"),xtitle='B-V',ytitle='NB527-V';,yrange=[-10,10]
oplot,xx,resnb[1]*xx+resnb[0],color=get_colour_by_name("red")
device, /close

print, 'ZP_V= ', zpv
print, 'ZP_B= ', zpb
print, 'ZP_NB= ', zpnb
vm_c=vm-zpv
bm_c=bm-zpb
nb_c=nbm-zpnb
s1=fltarr(n_elements(in0))
s2=s1
ss1=s1
ss2=s1
sss1=s1
sss2=s1
for i=0,n_elements(s1)-1 do begin
   s1[i]=g[in0[i]]-r[in0[i]]
   s2[i]=vm_c[in[i]]-r[in0[i]]
   ss1[i]=u[in0[i]]-g[in0[i]]
   ss2[i]=bm_c[in[i]]-g[in0[i]]
   sss1[i]=g[in0[i]]-r[in0[i]]
   sss2[i]=nb_c[in[i]]-r[in0[i]]
endfor
bv=ss2-s2+s1
ub=ss1-ss2
makepdf,'zpv','zpv'
makepdf,'zpb','zpb'
makepdf,'zpnb','zpnb'
;spawn,'open zpv.pdf '
device,filename='colorBV.ps',/encap,/color
 plot,bv,ub,psym=sym(1),xr=[-1,2],yr=[-1,3],xtitle='B-V(syn_red),B-V',ytitle='u-B(syn), u-B' 
oplot,bvsyn,ubsyn,psym=sym(1), color=get_colour_by_name('red')
device, /close
device,filename='colorug.ps',/encap,/color
plot, s1,ss1 ,psym=sym(1),xr=[-1,2],yr=[-1,3],xtitle=' g-r, g-r(syn_red)',ytitle=' u-g, u-g(syn)'
oplot,gsyn-rsyn,usyn-gsyn,psym=sym(1), color=get_colour_by_name('red')
device, /close
makepdf,'colorBV','colorBV'
spawn,'open colorBV.pdf '
makepdf,'colorug','colorug'
spawn,'open colorug.pdf '
set_plot,'x'
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
