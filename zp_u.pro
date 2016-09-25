pro zpu


readcol, '/Volumes/MacintoshHD2/supcam/astroref-u.txt',ra0,dec0,u, g, r, i, z ;32.7402
close,/all
uu=mrdfits('CAT_Unew2.fits',1)
um=uu.mag_auto
f=uu.flags

;ra=uu.x_world
;dec=uu.y_world
x=uu.x_image-1
y=uu.y_image-1

fxread,'OBJECT.Unew2.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
matchcat,ra0,dec0,ra,dec,in0,in,DT=0.3
print, 'in0 ',n_elements(in0)
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(in)-1 do begin
   s1[i]=u[in0[i]]-g[in0[i]]
   s2[i]=um[in[i]]-g[in0[i]]
endfor
res=linfit(s1,s2,yfit=yy)
sig=stddev(s2-yy)
idd=-1
for i=0,n_elements(s1)-1 do begin
   if abs(s2[i]-yy[i]) gt 2.*sig or f[in[i]] ne 0 then idd=[idd,i]
   
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
openw,1,'ucoord.txt'
for i=0,n_elements(ra2)-1 do printf,1,ra2[i],dec2[i]
close,1
coordfk5,'OBJECT.Unew2.1.fits','ucoord.txt','U.reg'
res=linfit(s1,s2,yfit=yy)
zp=res[0] 
set_plot, 'ps'
device,filename='zp_u.ps',/encap,/color
plot, s1,s2,psym=sym(1),color=get_colour_by_name("black"),xtitle='u-g',ytitle='U_sub-g';,yrange=[-10,10]
xx=dindgen(40)/10.-1
oplot,xx,res[1]*xx+res[0],color=get_colour_by_name("red")
device, /close
print, 'ZP_u= ', zp
Ucor=um-zp
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(s1)-1 do begin
   s1[i]=u[in0[i]]-g[in0[i]]
   s2[i]=Ucor[in[i]]-g[in0[i]]
endfor
makepdf,'zp_u','zp_u'
spawn,'open zp_u.pdf '
set_plot,'x'
stop
end
