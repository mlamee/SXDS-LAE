pro astmet
close,/all
readcol,'~/Dropbox/Research/Supcam/astroref-u.txt',raref,decref
u1=mrdfits('CAT_Unew2.fits',1)
;u=mrdfits('CAT_U.fits',1)
fxread,'OBJECT.Unew2.1.fits',data,header
x=u1.x_image-1
y=u1.y_image-1
a=u1.A_image
b=u1.B_image
r=b/a
;ra=u1.x_world
;dec=u1.y_world
;raref=u1.x_world
;decref=u1.y_world
extast,header,astr
xy2ad, x, y, astr, ra, dec

openw,1,'sexcoord.txt'
for i=0, n_elements(ra)-1 do printf,1,ra[i], dec[i]
close,1
coordfk5,'OBJECT.Unew2.1.fits','sexcoord.txt','sexfound.reg'
matchcat,ra,dec,raref,decref,indim,indref,dt=1.0,plot=0
ra2=ra[indim]
dec2=dec[indim]
ra3=raref[indref]
dec3=decref[indref]
r2=r[indim]
bad=where((abs((ra2-ra3))*3600. gt 0.2) and (abs((dec2-dec3))*3600. gt 0.2) )
openw,3,'badcoord.txt'
for i=0, n_elements(bad)-1 do printf,3,ra3[bad[i]], dec3[bad[i]]
close,3
coordfk5,'OBJECT.Unew2.1.fits','badcoord.txt','badcorelref.reg'
openw,2,'corel_coord.txt'
for i=0, n_elements(ra2)-1 do printf,2,ra2[i], dec2[i]
close,2
coordfk5,'OBJECT.Unew2.1.fits','corel_coord.txt','corelfound.reg'
result=linfit(raref[indref],(ra[indim]-raref[indref])*3600.,yfit=yy)
result2=linfit(decref[indref],(dec[indim]-decref[indref])*3600.,yfit=yy2)
set_plot,'ps'

sml=where(r2 lt 0.6)
bt=where(r2 ge 0.6 and r2 lt 0.8)
bg=where(r2 ge 0.8)
device,file='elp.eps',/color,/encap
plot, ra2[sml],dec2[sml],psym=sym(1),xtitle='RA', ytitle='Dec',title='Ellipticity'
oplot,ra2[bt],dec2[bt],psym=sym(1),color=get_colour_by_name('red')
oplot,ra2[bg],dec2[bg],psym=sym(1),color=get_colour_by_name('blue')

device,/close
device,file='ra.eps',/color,/encap
plot,raref[indref],(ra[indim]-raref[indref])*3600.,psym=sym(1),xtitle='RA_ref',ytitle='Delta RA'
oplot,raref[indref],yy,color=get_colour_by_name('red')
device,/close
device,file='dec.eps',/color,/encap
plot,decref[indref],(dec[indim]-decref[indref])*3600.,psym=sym(2), xtitle='DEC_ref',ytitle='Delta Dec'
oplot,decref[indref],yy2,color=get_colour_by_name('red')
device,/close
set_plot,'x'
spawn,'open ra.eps'
spawn,'open dec.eps'
spawn,'open elp.eps'


stop
end


pro astmet2
close,/all
readcol,'~/Dropbox/Research/Supcam/astroref-u.txt',raref,decref
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
sigu=ap3[1]
zpu=32.7402
ulim=-2.5*alog10(5.*sigu)+zpu

u1=mrdfits('/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/CAT_Unew2.fits',1)
id= where(u1.mag_auto le 23.5 and u1.flags eq 0)
;u=mrdfits('CAT_U.fits',1)
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/OBJECT.Unew2.1.fits',data,header
x=u1.x_image-1
y=u1.y_image-1
a=u1.A_image
b=u1.B_image
x=x[id]
y=y[id]
a=a[id]
b=b[id]
r=b/a
;ra=u1.x_world
;dec=u1.y_world
;raref=u1.x_world
;decref=u1.y_world
extast,header,astr
xy2ad, x, y, astr, ra, dec

openw,1,'sexcoord2.txt'
for i=0, n_elements(ra)-1 do printf,1,ra[i], dec[i]
close,1
coordfk5,'OBJECT.Unew2.1.fits','sexcoord2.txt','sexfound2.reg','green','3'
matchcat,ra,dec,raref,decref,indim,indref,dt=1.0,plot=0
ra2=ra[indim]
dec2=dec[indim]
ra3=raref[indref]
dec3=decref[indref]
r2=r[indim]
bad=where((abs((ra2-ra3))*3600. gt 0.2) and (abs((dec2-dec3))*3600. gt 0.2) )
openw,3,'badcoord2.txt'
for i=0, n_elements(bad)-1 do printf,3,ra3[bad[i]], dec3[bad[i]]
close,3
coordfk5,'OBJECT.Unew2.1.fits','badcoord2.txt','badcorelref2.reg','red','3'
openw,2,'corel_coord2.txt'
for i=0, n_elements(ra2)-1 do printf,2,ra2[i], dec2[i]
close,2
coordfk5,'OBJECT.Unew2.1.fits','corel_coord2.txt','corelfound2.reg','blue','3'
result=linfit(raref[indref],(ra[indim]-raref[indref])*3600.,yfit=yy)
result2=linfit(decref[indref],(dec[indim]-decref[indref])*3600.,yfit=yy2)
set_plot,'ps'

sml=where(r2 lt 0.6)
bt=where(r2 ge 0.6 and r2 lt 0.8)
bg=where(r2 ge 0.8)
device,file='elp2.eps',/color,/encap
plot, ra2[sml],dec2[sml],psym=sym(1),xtitle='RA', ytitle='Dec',title='Ellipticity', xr=[34.25,34.8],xstyle=1,ystyle=1,yr=[-5.65,-5.15]
oplot,ra2[bt],dec2[bt],psym=sym(1),color=get_colour_by_name('red')
oplot,ra2[bg],dec2[bg],psym=sym(1),color=get_colour_by_name('blue')

device,/close
j=indgen(22)/40.+34.25+0.0125
md=j*0.0
st=md
dra=(ra[indim]-raref[indref])*3600
raf=raref[indref]
for i=0,n_elements(j)-1 do begin 
   st[i]=stdev(dra[where(raf gt j[i]-0.0125 and raf lt j[i]+0.0125)] )
   md[i]=median(dra[where(raf gt j[i]-0.0125 and raf lt j[i]+0.0125)])
endfor
stop
device,file='ra2.eps',/color,/encap
plot,raref[indref],(ra[indim]-raref[indref])*3600.,psym=sym(1),xtitle='RA_ref',ytitle='Delta RA [arcsec]',charsize=1.5,xr=[34.25,34.8],xstyle=1
oplot,raref[indref],yy,color=get_colour_by_name('red')
cgplot,j,md,psym=sym(4),color=get_colour_by_name('blue'),/overplot
cgerrplot,j,st,md+(md-st),color=get_colour_by_name('blue')
device,/close
j=-indgen(18)/40.-5.175-0.0125
md=j*0.0
st=md
ddec=(dec[indim]-decref[indref])*3600
decf=decref[indref]
for i=0,n_elements(j)-1 do begin 
   st[i]=stdev(ddec[where(decf gt j[i]-0.0125 and decf lt j[i]+0.0125)] )
   md[i]=median(ddec[where(decf gt j[i]-0.0125 and decf lt j[i]+0.0125)])
endfor
device,file='dec2.eps',/color,/encap
plot,decref[indref],(dec[indim]-decref[indref])*3600.,psym=sym(1), xtitle='DEC_ref',ytitle='Delta Dec [arcsec]',charsize=1.5,xstyle=1,xr=[-5.65,-5.15]
oplot,decref[indref],yy2,color=get_colour_by_name('red')
cgplot,j,md,psym=sym(4),color=get_colour_by_name('blue'),/overplot
cgerrplot,j,st,md+(md-st),color=get_colour_by_name('blue')
device,/close
set_plot,'x'
;spawn,'cp ra2.eps ~/Dropbox/Research/Supcam/'

;spawn,'open ra2.eps'
;spawn,'open dec2.eps'
;spawn,'open elp2.eps'


stop
end
