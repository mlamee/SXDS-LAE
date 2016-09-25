pro fwhmf_lyc
close,/all
namelyc='/Volumes/MacintoshHD2/supcam/quilt/sxds.383.txt'
openW,5,'fwhm_surf_Lyc.txt'
printf,5, 'FWHM of the final image in arcsec and the standard deviation (Surf-Gauss)'
   fw=0.
   fw2=fw
   readcol,namelyc,x,y,rh
   x=x-1
   y=y-1
 
   fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',im,hd
   for k=0, n_elements(x)-1 do begin
         im2=im[x[k]-35:x[k]+35,y[k]-35:y[k]+35]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT,/inner_max )
         fwxy2 = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT, /aver,/inner_max )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.05 and ratio ge 0.95 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then begin
            fw=[fw,mean(fwxy)]
            fw2=[fw2,fwxy2]
            print,'x y ',x[k]+1, y[k]+1
            print,'FWHM', mean(fwxy),fwxy2
            ;print,'X-X0, Y-Y0', 35.-cxy[0],35.-cxy[1]
         endif
      endfor
   remove,0,fw
   fwhm=median(fw*0.365)
   print,n_elements(fw)
   fwhmstd=stddev(fw*0.365)
   printf,5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',fwhm,fwhmstd,format='(a,3x,f,3x,f)'
close,/all
stop
end


pro fwhmf
close,/all
name2=['/Volumes/MacintoshHD2/supcam/quilt/sxds.U.txt','/Volumes/MacintoshHD2/supcam/quilt/sxds.V.txt','/Volumes/MacintoshHD2/supcam/quilt/sxds.B.txt','/Volumes/MacintoshHD2/supcam/quilt/sxds.527.txt']

openW,1,'fwhm_surf.txt'
printf,1, 'FWHM of the final images in arcsec and the standard deviation (Surf Gauss)'
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
         im2=im[x[k]-35:x[k]+35,y[k]-35:y[k]+35]
         fwxy = FullWid_HalfMax( im2, centroid=cxy, /GAUSSIAN_FIT,/inner_max )
         ratio=fwxy[0]/fwxy[1]
         if ratio le 1.05 and ratio ge 0.95 and mean(fwxy) gt 0 and mean(fwxy) lt 10 then begin
            fw=[fw,mean(fwxy)]
             print,'x y ',x[k]+1, y[k]+1
            print,'FWHM', mean(fwxy)
         endif
      endfor
   remove,0,fw
   fwhm=median(fw*0.15)
   print,n_elements(fw)
   fwhmstd=stddev(fw*0.15)
   printf,1,name[i],fwhm,fwhmstd,format='(a,3x,f,3x,f)'
stop
endfor
close,/all

end
