pro zpb


readcol, '/Volumes/MacintoshHD2/supcam/astroref3.cat',id,ra0,dec0,u, g, r, i, z ; 35.2590
close,/all
b=mrdfits('CAT_Bsingle.fits',1)
bm=b.mag_auto
f=b.flags
;ra=uu.x_world
;dec=uu.y_world
x=b.x_image-1
y=b.y_image-1
fxread,'OBJECT.B.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
rm=where(ra0 ge 34.8 or ra0 le 34.25 or dec0 le -5.6 or dec0 gt -5.08 or u-g gt 60 )
remove,rm,ra0
remove,rm,dec0
remove,rm,g
remove,rm,r
remove,rm,u
rm2=where(f ne 0)
remove,rm2,ra
remove,rm2,dec
remove,rm2,bm
mn=median(bm)
sigma=stddev(bm)
rm3=where(bm-mn gt 2*sigma)
if n_elements(rm3) gt 1 then begin
remove,rm3,ra
remove,rm3,dec
remove,rm3,bm
endif
matchcat,ra0,dec0,ra,dec,in0,in,DT=0.3
print, 'in0 ',n_elements(in0)
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(in)-1 do begin
   s1[i]=u[in0[i]]-g[in0[i]]
   s2[i]=bm[in[i]]-g[in0[i]]
endfor
res=linfit(s1,s2,yfit=yy)
sig=stddev(s2-yy)
idd=-1
for i=0,n_elements(s1)-1 do begin
   if abs(s2[i]-yy[i]) gt 2.*sig  then idd=[idd,i]
   
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
openw,1,'bcoord.txt'
for i=0,n_elements(ra2)-1 do printf,1,ra2[i],dec2[i]
close,1
coordfk5,'OBJECT.B.1.fits','bcoord.txt','B.reg'
res=linfit(s1,s2,yfit=yy)
zp=res[0]
set_plot, 'ps'
device,filename='zp_Bsingle.ps',/encap,/color
plot, s1,s2,psym=sym(1),color=get_colour_by_name("black"),xtitle='u-g',ytitle='B-g';,yrange=[-10,10]
xx=dindgen(40)/10.-1
oplot,xx,res[1]*xx+res[0],color=get_colour_by_name("red")
device, /close
print, 'ZP_Bsingle= ', zp
Bcor=bm-zp
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(s1)-1 do begin
   s1[i]=u[in0[i]]-g[in0[i]]
   s2[i]=Bcor[in[i]]-g[in0[i]]
endfor
makepdf,'zp_Bsingle','zp_Bsingle'
spawn,'open zp_Bsingle.pdf '
set_plot,'x'
stop
end
