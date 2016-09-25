pro findsat, image, sat, output

fxread,image,im,h
fxread,'l527new.exp',w,h1
openw,lun,output,/get_lun
printf,lun,'# Region file format: DS9 version 4.1',format='(a)' 
printf,lun,'# Filename: OBJECT.527.1.fits',format='(a)'
printf,lun,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,lun,'image',format='(a)'

in=where(im le sat and w ne 0)


for i=0, n_elements(in)-1 do begin
   
   y=fix(in[i]/n_elements(im[*,0]))
   x=in[i] mod n_elements(im[*,0])
   print,x
   sy1=0
   sy2=0
   sx1=0
   sx2=0
   
   while im[x+sx1,y]le 0 or im[x+sx1,y] ge 30 and x+sx1 lt n_elements(im[*,0])-1 do sx1++
   while im[x-sx2,y]le 0 or im[x-sx2,y] ge 30and x-sx2 ge 0 do sx2++ 
   dx=(sx1+sx2)/2
   x=x-sx2+dx
   while im[x,y+sy1]le 0 or im[x,y+sy1] ge 30 and y+sy1 lt n_elements(im[0,*])-1 do sy1++
   while im[x,y-sy2]le 0 or im[x,y-sy2] ge 30 and y-sy2 ge 0  do sy2++
   dy=(sy1+sy2)/2
   y=y-sy2+dy
   rad=1.2*dx
   xx=x
   yy[i]=y
  endfor
   printf,lun,'circle(',x,",",y,',',rad,')',format='(a,d15.6,a,d15.6,a,d16.6,a)'
endfor
free_lun,lun

end
