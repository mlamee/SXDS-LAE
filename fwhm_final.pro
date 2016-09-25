pro fwhmf_lyc
close,/all
namelyc='/Volumes/MacintoshHD2/supcam/quilt/sxds.383.txt'
openW,5,'fwhm_final_Lyc.txt'
printf,5, 'FWHM of the final image in arcsec and the standard deviation'
   fw=0.
   readcol,namelyc,x,y,rh
   x=x-1
   y=y-1
 
   fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',im,hd
   for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fw=[fw,mean(fwxy)]
      endfor
   remove,0,fw
   fwhm=median(fw*0.365)
   print,n_elements(fw)
   fwhmstd=stddev(fw*0.365)
   printf,5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',fwhm,fwhmstd,format='(a,3x,f,3x,f)'
close,/all
end


pro fwhmf
close,/all
name2=['/Volumes/MacintoshHD2/supcam/quilt/sxds.U.txt','/Volumes/MacintoshHD2/supcam/quilt/sxds.V.txt','/Volumes/MacintoshHD2/supcam/quilt/sxds.B.txt','/Volumes/MacintoshHD2/supcam/quilt/sxds.527.txt']

openW,1,'fwhm_final.txt'
printf,1, 'FWHM of the final images in arcsec and the standard deviation'
name=['/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits','/Volumes/MacintoshHD2/supcam/quilt/OBJECT.V.1.fits','/Volumes/MacintoshHD2/supcam/quilt/OBJECT.B.1.fits','/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits']
for i=0,3 do begin
   fw=0.
   readcol,name2[i],x,y,rh
   x=x-1
   y=y-1
   id=where( x le 30 or y le 30 or x ge 12970 or y ge 12970)
   if id[0] ne -1 then begin
      remove, id,x
      remove,id,y
   endif
   fxread,name[i],im,hd
   for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-25:x[k]+25,y[k]-25:y[k]+25]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.1 and ratio ge 0.9 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then fw=[fw,mean(fwxy)]
      endfor
   remove,0,fw
   fwhm=median(fw*0.15)
   print,n_elements(fw)
   fwhmstd=stddev(fw*0.15)
   printf,1,name[i],fwhm,fwhmstd,format='(a,3x,f,3x,f)'
endfor
close,/all
stop
end
