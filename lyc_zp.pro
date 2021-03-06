pro lyc

close,/all
;readcol, '/Volumes/MacintoshHD2/supcam/astroref3.cat',id,ra0,dec0,u, g, r, i, z  ;31.1841 It is more scattered
readcol, '/Volumes/MacintoshHD2/supcam/astroref-u.txt',ra0,dec0,u, g,
;r, i, z ; 31.5187 Nice and linear so I use this one.
close,/all
ly=mrdfits('CAT_383.fits',1)
lym=ly.mag_auto
f=ly.flags

;ra=ly.x_world
;dec=ly.y_world
x=ly.x_image-1
y=ly.y_image-1
fxread,'SXDS.NB383.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
rm=where(ra0 ge 34.8 or ra0 le 34.25 or dec0 le -5.6 or dec0 gt -5.08 )
remove,rm,ra0
remove,rm,dec0
remove,rm,g
remove,rm,r
remove,rm,u
matchcat,ra0,dec0,ra,dec,in0,in,DT=0.5

print, 'in0 ',n_elements(in0)
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(in)-1 do begin
   s1[i]=u[in0[i]]-g[in0[i]]
   s2[i]=lym[in[i]]-g[in0[i]]
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
openw,1,'Lyccoord.txt'
for i=0,n_elements(ra2)-1 do printf,1,ra2[i],dec2[i]
close,1
coordfk5,'SXDS.NB383.fits','Lyccoord.txt','lyc.reg'
res=linfit(s1,s2,yfit=yy)
zp=res[0]
set_plot, 'ps'
device,filename='zp_lyc.ps',/encap,/color
plot, s1,s2,psym=sym(1),color=get_colour_by_name("black"),xtitle='u-g',ytitle='NB383-g';,yrange=[-10,10]
xx=dindgen(40)/10.-1
oplot,xx,res[1]*xx+res[0],color=get_colour_by_name("red")
device, /close
print, 'ZP_NB383= ', zp
ly_c=lym-zp
s1=fltarr(n_elements(in0))
s2=s1
for i=0,n_elements(s1)-1 do begin
   s1[i]=u[in0[i]]-g[in0[i]]
   s2[i]=ly_c[in[i]]-g[in0[i]]
endfor
makepdf,'zp_lyc','zp_lyc'
spawn,'open zp_lyc.pdf '
set_plot,'x'
stop
end
