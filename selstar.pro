pro selstar
close,/all
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.U_final.lst',utag, format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.B.lst',btag, format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.V.lst',vtag, format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.527combined.lst',ibtag, format='a'


openW,1,'Useeing.dat'
openW,2,'Bseeing.dat'
openW,3,'Vseeing.dat'
openW,4,'527seeing.dat'
urh=fltarr(n_elements(utag))
brh=fltarr(n_elements(btag))
vrh=fltarr(n_elements(vtag))
ibrh=fltarr(n_elements(ibtag))
ustd=urh
bstd=brh
vstd=vrh
ibstd=ibrh

for i=0,n_elements(utag)-1 do begin
   name=strcompress('/Volumes/MacintoshHD2/supcam/seeing/'+utag[i]+'.txt',/remove_all)
   readcol,name,mag,rh
   urh[i]=median(2*rh*0.15)
   ustd[i]=stddev(2*rh*0.15)
   printf,1,urh[i],ustd[i]
endfor
for i=0,n_elements(btag)-1 do begin
   name=strcompress('/Volumes/MacintoshHD2/supcam/seeing/'+btag[i]+'.txt',/remove_all)
   readcol,name,mag,rh
   brh[i]=median(2*rh*0.15)
   bstd[i]=stddev(2*rh*0.15)
   printf,2,brh[i],bstd[i]
endfor
for i=0,n_elements(vtag)-1 do begin
   name=strcompress('/Volumes/MacintoshHD2/supcam/seeing/'+vtag[i]+'.txt',/remove_all)
   readcol,name,mag,rh
   vrh[i]=median(2*rh*0.15)
   vstd[i]=stddev(2*rh*0.15)
   printf,3,vrh[i],vstd[i]
endfor
for i=0,n_elements(ibtag)-1 do begin
   name=strcompress('/Volumes/MacintoshHD2/supcam/seeing/'+ibtag[i]+'.txt',/remove_all)
   readcol,name,mag,rh
   ibrh[i]=median(2*rh*0.15)
   ibstd[i]=stddev(2*rh*0.15)
   printf,4,ibrh[i],ibstd[i]
endfor
set_plot,'ps'
device,file='Useeing.eps',/encap,/color
x=indgen(n_elements(utag))+1
xerr=x*0.
plot,x,urh,psym=sym(2),xtitle='Index',ytitle='Half Light Diameter  (ArcSec)',title='U band',thick=1.5,charsize=1.5
oploterror,x,urh,xerr,ustd
device,/close
device,file='Vseeing.eps',/encap,/color
x=indgen(n_elements(vtag))+1
xerr=x*0.
plot,x,vrh,psym=sym(2),xtitle='#Index',ytitle='Half Light Diameter (ArcSec)',title='V band',thick=1.5,charsize=1.5
oploterror,x,vrh,xerr,vstd
device,/close
device,file='Bseeing.eps',/encap,/color
x=indgen(n_elements(btag))+1
xerr=x*0.
plot,x,brh,psym=sym(2),xtitle='Index',ytitle='Half Light Diameter (ArcSec)',title='B band',thick=1.5,charsize=1.5
oploterror,x,brh,xerr,bstd
device,/close
device,file='IB527seeing.eps',/encap,/color
x=indgen(n_elements(ibtag))+1
xerr=x*0.
plot,x,ibrh,psym=sym(2),xtitle='Index',ytitle='Half Light Diameter (ArcSec)',title='IB527 band',thick=1.5,charsize=1.5
oploterror,x,ibrh,xerr,ibstd
device,/close
SPAWN,'open Useeing.eps'
SPAWN,'open Bseeing.eps'
SPAWN,'open Vseeing.eps'
SPAWN,'open IB527seeing.eps'

set_plot,'x'
close,/all
end
