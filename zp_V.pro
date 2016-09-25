pro zpv

readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
sigv=ap1[0]
sigb=ap1[2]
signb=ap1[3]
sig383=ap1[4]
sigu=ap1[1]
readcol, '/Volumes/MacintoshHD2/supcam/astroref3.cat',id,ra0,dec0,u, g, r, i, z ;35.4005
;readcol, '/Volumes/MacintoshHD2/supcam/astroref5.txt',ra0,dec0,u, g, r, i, z
close,/all
v=mrdfits('CAT_Vsingle.fits',1)
vm=v.mag_auto
vf=v.flux_auto
f=v.flags

;ra=uu.x_world
;dec=uu.y_world
x=v.x_image-1
y=v.y_image-1
fxread,'OBJECT.V.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
rm=where(ra0 ge 34.8 or ra0 le 34.25 or dec0 le -5.6 or dec0 gt -5.08 )
remove,rm,ra0
remove,rm,dec0
remove,rm,g
remove,rm,r
remove,rm,u
rm2=where(f ne 0)
remove,rm2,ra
remove,rm2,dec
remove,rm2,vm
remove,rm2,vf
mn=median(vm)
sigma=stddev(vm)
rm3=where(vf lt 50*sigv)
if n_elements(rm3) gt 1 then begin
remove,rm3,ra
remove,rm3,dec
remove,rm3,vm
remove,rm3,vf
endif
matchcat,ra0,dec0,ra,dec,in0,in,DT=0.3
print, 'in0 ',n_elements(in0)
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(in)-1 do begin
   s1[i]=g[in0[i]]-r[in0[i]]
   s2[i]=vm[in[i]]-r[in0[i]]
endfor
res=linfit(s1,s2,yfit=yy)
sig=stddev(s2-yy)
idd=-1
for i=0,n_elements(s1)-1 do begin
   if abs(s2[i]-yy[i]) gt 2.*sig then idd=[idd,i]
   
endfor
ra2=ra[in]
dec2=dec[in]
if n_elements(idd) ge 2 then begin
   remove,0,idd
   remove,idd,s1
   remove,idd,s2
 remove,idd,ra2
   remove,idd,dec2
endif
openw,1,'vcoord.txt'
for i=0,n_elements(ra2)-1 do printf,1,ra2[i],dec2[i]
close,1
coordfk5,'OBJECT.V.1.fits','vcoord.txt','V.reg'
res=linfit(s1,s2,yfit=yy)
zp=res[0]
set_plot, 'ps'
device,filename='zp_Vsingle.ps',/encap,/color
plot, s1,s2,psym=3,color=get_colour_by_name("black"),xtitle='g-r',ytitle='V_sub-r';,yrange=[-10,10]
xx=dindgen(40)/10.-1
oplot,xx,res[1]*xx+res[0],color=get_colour_by_name("red")
device, /close
print, 'ZP_Vsingle= ', zp
Vcor=vm-zp
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(s1)-1 do begin
   s1[i]=g[in0[i]]-r[in0[i]]
   s2[i]=Vcor[in[i]]-r[in0[i]]
endfor
makepdf,'zp_Vsingle','zp_Vsingle'
spawn,'open zp_Vsingle.pdf '
set_plot,'x'
stop
end
