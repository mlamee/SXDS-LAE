pro chk
nb=mrdfits('CAT_527dual1.fits',1)
;b=mrdfits('CAT_Bdual1.fits',1)
;v=mrdfits('CAT_Vdual1.fits',1)
nbm=nb.mag_auto
;bm=b.mag_auto
;vm=v.mag_auto
x=nb.x_image-1
y=nb.y_image-1
fxread,'OBJECT.527.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
openw,lun,'chk.reg',/get_lun
printf,lun,'# Region file format: DS9 version 4.1',format='(a)' 
printf,lun,'# Filename:OBJECT.527.1.fits',format='(a)'
printf,lun,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,lun,'fk5',format='(a)'
for i=0,n_elements(ra)-1 do printf,lun,'circle(',ra[i],",",dec[i],',0.5") #width=2 ',format='(a,d15.6,a,d15.6,a)'

free_lun,lun

end
