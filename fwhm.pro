pro fwhm383
close,/all
readcol,'/Volumes/MacintoshHD2/starsLyc-only/OBJECT.NB383.lst',lyctag,format='a'
openW,5,'Lycfwhm.dat'
lycrh=fltarr(n_elements(lyctag))
lycstd=lycrh
for i=0,n_elements(lyctag)-1 do begin
   fwlyc=0.
   j=[0,1,2,5]
   for m=0,3 do begin
      
      name=strcompress('/Volumes/MacintoshHD2/starsLyc-only/fwhm/'+lyctag[i]+'.'+string(j[m])+'.txt',/remove_all)
      readcol,name,x,y,rh
      x=x-1
      y=y-1
      id=where( x le 60 or y le 60 or x ge 990 or y ge 2000)
      if id[0] ne -1 then begin
         remove, id,x
         remove,id,y
      endif
      name2='/Volumes/Mehdi2TB/Backups.backupdb/MehdiMacBookPro/Latest/Macintosh\ HD/Users/Mehdi/sxdslfc/srcimages/'+strcompress(lyctag[i]+'.'+string(j[m])+'.ncr',/remove_all)
      fxread,name2,im,hd
      for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fwlyc=[fwlyc,mean(fwxy)]
      endfor
   endfor
   remove,0,fwlyc
   lycrh[i]=median(fwlyc*0.365)
   print,n_elements(fwlyc)
   lycstd[i]=stddev(fwlyc*0.365)
   printf,5,lyctag[i],lycrh[i],lycstd[i],format='(a,3x,f,3x,f)'
   
endfor
set_plot,'ps'

device,file='LyC383-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(lyctag))+1
xerr=xx*0.
plot,xx,lycrh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='LyC383 band',thick=1.5,charsize=1.5,yr=[1,3],xr=[0,70],xstyle=1
oploterror,xx,lycrh,xerr,lycstd
device,/close
set_plot,'x'
close,/all
stop
end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
pro fwhm
close,/all
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.U_final.lst',utag, format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.B.lst',btag, format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.V.lst',vtag, format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.527combined.lst',ibtag, format='a'


openW,1,'Ufwhm.dat'
openW,2,'Bfwhm.dat'
openW,3,'Vfwhm.dat'
openW,4,'527fwhm.dat'
urh=fltarr(n_elements(utag))
brh=fltarr(n_elements(btag))
vrh=fltarr(n_elements(vtag))
ibrh=fltarr(n_elements(ibtag))
ustd=urh
bstd=brh
vstd=vrh
ibstd=ibrh





for i=0,n_elements(utag)-1 do begin
   fwu=0.
   for j=0, 9 do begin
      name=strcompress('/Volumes/MacintoshHD2/supcam/fwhm/'+utag[i]+'.'+string(j)+'.txt',/remove_all)
      readcol,name,x,y,rh
      x=x-1
      y=y-1
      id=where( x le 30 or y le 30 or x ge 2022 or y ge 4070)
      if id[0] ne -1 then begin
         remove, id,x
         remove,id,y
      endif
      name2=strcompress('/Volumes/MacintoshHD2/supcam/srcimages/'+utag[i]+'.'+string(j)+'.ncr2',/remove_all)
      fxread,name2,im,hd
      for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fwu=[fwu,mean(fwxy)]
      endfor
   endfor
   remove,0,fwu
   urh[i]=median(fwu*0.15)
   print,n_elements(fwu)
   ustd[i]=stddev(fwu*0.15)
   printf,1,utag[i],urh[i],ustd[i],format='(a,3x,f,3x,f)'
   
endfor
;;;;;;;;;;;;;;;;;;;;;;;;
for i=0,n_elements(btag)-1 do begin
   fwb=0.
   for j=0, 9 do begin
      name=strcompress('/Volumes/MacintoshHD2/supcam/fwhm/'+btag[i]+'.'+string(j)+'.txt',/remove_all)
      readcol,name,x,y,rh
      x=x-1
      y=y-1
      id=where( x le 30 or y le 30 or x ge 2022 or y ge 4070)
      if id[0] ne -1 then begin
         remove, id,x
         remove,id,y
      endif
      name2=strcompress('/Volumes/Mehdi2TB/smokafits/B/'+btag[i]+'.'+string(j)+'.ncr',/remove_all)
      fxread,name2,im,hd
      for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fwb=[fwb,mean(fwxy)]
      endfor
   endfor
   remove,0,fwb
   brh[i]=median(fwb*0.15)
   print,n_elements(fwb)
   bstd[i]=stddev(fwb*0.15)
   printf,2,btag[i],brh[i],bstd[i],format='(a,3x,f,3x,f)'
   
endfor
;;;;;;;;;;;;;;;;;;;;;;;;
for i=0,n_elements(vtag)-1 do begin
   fwv=0.
   for j=0, 9 do begin
      name=strcompress('/Volumes/MacintoshHD2/supcam/fwhm/'+vtag[i]+'.'+string(j)+'.txt',/remove_all)
      readcol,name,x,y,rh
      x=x-1
      y=y-1
      id=where( x le 30 or y le 30 or x ge 2022 or y ge 4070)
      if id[0] ne -1 then begin
         remove, id,x
         remove,id,y
      endif
      name2=strcompress('/Volumes/Mehdi2TB/smokafits/V/'+vtag[i]+'.'+string(j)+'.ncr',/remove_all)
      fxread,name2,im,hd
      for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fwv=[fwv,mean(fwxy)]
      endfor
   endfor
   remove,0,fwv
   vrh[i]=median(fwv*0.15)
   print,n_elements(fwv)
   vstd[i]=stddev(fwv*0.15)
   printf,3,vtag[i],vrh[i],vstd[i],format='(a,3x,f,3x,f)'
   
endfor
;;;;;;;;;;;;;;;;;;;;;;;;
for i=0,n_elements(ibtag)-1 do begin
   fwib=0.
   for j=0, 9 do begin
      name=strcompress('/Volumes/MacintoshHD2/supcam/fwhm/'+ibtag[i]+'.'+string(j)+'.txt',/remove_all)
      readcol,name,x,y,rh
      x=x-1
      y=y-1
      id=where( x le 30 or y le 30 or x ge 2022 or y ge 4070)
      if id[0] ne -1 then begin
         remove, id,x
         remove,id,y
      endif
      name2=strcompress('/Volumes/MacintoshHD2/supcam/srcimages/'+ibtag[i]+'.'+string(j)+'.ncr',/remove_all)
      fxread,name2,im,hd
      for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fwib=[fwib,mean(fwxy)]
      endfor
   endfor
   remove,0,fwib
   ibrh[i]=median(fwib*0.15)
   print,n_elements(fwib)
   ibstd[i]=stddev(fwib*0.15)
   printf,4,ibtag[i],ibrh[i],ibstd[i],format='(a,3x,f,3x,f)'
   
endfor
;;;;;;;;;;;;;;;;;;;;;;;;
set_plot,'ps'

device,file='U-FWHM.eps',/encap,/color
xx=indgen(n_elements(utag))+1
xerr=xx*0.
plot,xx,urh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='U band',thick=1.5,charsize=1.5
oploterror,xx,urh,xerr,ustd
device,/close
device,file='B-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(btag))+1
xerr=xx*0.
plot,xx,brh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='B band',thick=1.5,charsize=1.5
oploterror,xx,brh,xerr,bstd
device,/close
device,file='V-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(vtag))+1
xerr=xx*0.
plot,xx,vrh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='V band',thick=1.5,charsize=1.5
oploterror,xx,vrh,xerr,vstd
device,/close
device,file='IB527-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(ibtag))+1
xerr=xx*0.
plot,xx,ibrh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='IB527 band',thick=1.5,charsize=1.5
oploterror,xx,ibrh,xerr,ibstd
device,/close
set_plot,'x'
close,/all
stop
end
