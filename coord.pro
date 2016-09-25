pro coord
close,/all
openw,1,'radec2.reg'
readcol,'candidates.coords2',x,y
fxread,'OBJECT.527.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, a, d
printf,1,'# Region file format: DS9 version 4.1',format='(a)' 
printf,1,'# Filename: OBJECT.527.1.fits',format='(a)'
printf,1,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,1,'fk5',format='(a)'
for i=0,n_elements(x)-1 do printf,1,'circle(',a[i],",",d[i],',2")',format='(a,d15.6,a,d15.6,a)'

close,1

end
