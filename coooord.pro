pro coord,im,input,output
close,/all
openw,lun,output,/get_lun
readcol,input,x,y
fxread,im,data,header
extast,header,astr
xy2ad, x, y, astr, a, d
printf,lun,'# Region file format: DS9 version 4.1',format='(a)' 
printf,lun,'# Filename: OBJECT.527.1.fits',format='(a)'
printf,lun,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,lun,'fk5',format='(a)'
for i=0,n_elements(x)-1 do printf,lun,'circle(',a[i],",",d[i],',2")',format='(a,d15.6,a,d15.6,a)'

close,lun

end
