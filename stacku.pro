pro stacku
sigu=59.1858
sigu15=44.3061 
; Stamp sizes are designed to have the same size as the IB383 stamps
d=194.0
dv=474.0
close,/all
zpu=32.5556 
zp383=31.3949
;sig383=53.5755
;sig15=41.95
badpix=[-260,48000]
;fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',n383,h383
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/OBJECT.Unew2.1.fits',imu,hu
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/OBJECT.V.1.fits',v,hv
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/seg-V.fits',sv,s
;fxread,'~/Dropbox/Research/Supcam/seg383.fits',s383,s
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/segu.fits',segu,su
readcol,'~/Dropbox/Research/Supcam/new2/BVge0.4_err/BVge0.4_err.cat',ra,dec,u,uer,b,ber,ib,iber,vm,ver,r,rer,ew,ewer,ibf,ibfer,line,skipline=17
readcol,'~/Dropbox/Research/Supcam/new2/BVge0.4_noerronly/BVge0.4_noerronly.cat',ra2,dec2,u2,uer,b2,ber,ib2,iber,vm2,ver2,r2,rer,ew2,ewer,ibf2,ibfer,line2  ,skipline=17
ra=[ra,ra2]
dec=[dec,dec2]
vm=[vm,vm2]
r=[r,r2]
ew=[ew,ew2]
spawn,'mkdir ~/Dropbox/Research/Supcam/stack383/new2/all/U'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/new2/*.fits'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/new2/*.exp'
;spawn,'mkdir ~/Dropbox/Research/Supcam/stack383/new2/BVge0.4_err'
spawn,'mkdir /Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/all/u'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/new2/noerronly/*.fits'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/new2/noerronly/*.exp'
dd=where(segu ne 0)

imu[dd]=-12000

extast,hu,astr
ad2xy, ra, dec, astr, x, y
extast,hv,astrv
ad2xy, ra, dec, astrv, xv, yv
med=fltarr(n_elements(ra))-11000.
s={img:fltarr(2*d+1,2*d+1)-11000.}
s=replicate(s,n_elements(ra))
im=fltarr(2*d+1,2*d+1,n_elements(ra))-11000
apr=[5.05, 6.72] ; 1.5 and 2FWHM for U
aprv=[10.6,7.95]


;aper, im, d, d, flux, eflux,sky,skyerr, 1, apr,-1,[-10000,10000], /flux, /exact,setsky=0.0
for i=0, n_elements(ra)-1 do begin &$
  idd=where(imu[x[i]-d:x[i]+d,y[i]-d:y[i]+d] lt -12001) &$
   if x[i]+d lt 12901 and y[i]+d lt 12901 and x[i]-d gt 0 and y[i]-d gt 0 and idd[0] eq -1   then begin &$  
     im[*,*,i]=imu[x[i]-d:x[i]+d,y[i]-d:y[i]+d] &$
      img=im[*,*,i] &$
      med[i]=median(img[where(img gt -11000)]) &$
      img[where(img gt -11000)]=img[where(img gt -11000)]-med[i] &$
      im[*,*,i]=img &$
   endif &$
endfor

f=fltarr(n_elements(ra),2)-2000.
f15=f
for i=0, n_elements(ra)-1 do begin &$
   aper, im[*,*,i], d, d, flux, eflux,sky,skyerr, 1, apr,[48,73],[-260,48000], /flux, /exact,/silent,setsky=0.0 &$
   f[i,0]=flux[1] &$
   f[i,1]=eflux[1] &$
   f15[i,0]=flux[0] &$
   f15[i,1]=eflux[0] &$
;hextract,n383,h383,newim,newhr,x[i]-d,x[i]+d,y[i]-d,y[i]+d
;writefits,strcompress('~/Dropbox/Research/Supcam/stack383/'+string(i)+'-'+string(ra[i])+string(dec[i])+'dt383.fits',/remove_all),newim,newhr
endfor

id=where(f[*,0]-f[*,0] ne 0); or f[*,0]/sigu gt 1.)
;coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.U.1.fits',[[ra[id]],[dec[id]]],'stackexcludeU.reg','green','2'
id15=where(f15[*,0]-f15[*,0] ne 0); or f15[*,0]/sig383 gt 1.)
stop
flux=f[*,0]
eflux=f[*,1]
flux15=f15[*,0]
eflux15=f15[*,1]

if id15[0] ne -1 then begin &$
   remove,id,flux &$
   remove,id,eflux &$
   remove,id,x &$
   remove,id,y &$
   remove,id,ra &$
   remove,id,dec &$
   remove,id,vm &$
   remove,id,r &$
   ;remove,id,ver &$
   im[*,*,id]=0 &$
    remove,id15,flux15 &$
   remove,id15,eflux15 &$
   endif 
openw,1,'/Volumes/MacintoshHD2/supcam/quilt/new2/all/U/listUu'
openw,2,'/Volumes/MacintoshHD2/supcam/quilt/new2/all/U/listBb'
openw,3,'/Volumes/MacintoshHD2/supcam/quilt/new2/all/U/listVv'
openw,4,'/Volumes/MacintoshHD2/supcam/quilt/new2/all/U/listNBv'
openw,5,'/Volumes/MacintoshHD2/supcam/quilt/new2/all/U/listLCc'
for i=0, n_elements(ra)-1 do begin
 printf,1,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'ntU.fits',/remove_all)

 printf,2,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'ntB.fits',/remove_all)
 printf,3,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'ntV.fits',/remove_all)
 printf,4,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'nt527.fits',/remove_all)
 printf,5,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'nt383.fits',/remove_all)
endfor
close,/all
;badA=[1,7,8,11,19,44,48,54,62,70,72,73]
;remove,badA,vm
;remove,badA,r
;extast,hv,astr
;ad2xy, ra, dec, astr, xv, yv

;set_plot,'ps'
for i=0,n_elements(ra)-1 do begin
   hextract,imu,hu,newim,newhr,x[i]-d,x[i]+d,y[i]-d,y[i]+d
   writefits,strcompress('~/Dropbox/Research/Supcam/stack383/new2/all/U/'+string(i)+'-'+string(ra[i])+string(dec[i])+'dtU.fits',/remove_all),newim,newhr
   ;hextract,v,hv,newim,newhr,xv[i]-dv,xv[i]+dv,yv[i]-dv,yv[i]+dv
   ;writefits,strcompress('~/Dropbox/Research/Supcam/stack383/'+string(i)+'-'+string(ra[i])+string(dec[i])+'dtV.fits',/remove_all),newim,newhr
 ;  device,filenames=strcompress('~/Dropbox/Research/Supcam/stack383/'+string(i)+'-'+string(ra[i])+string(dec[i])+'dt383.eps',/remove_all),/color,/encap;, xsize=12., ysize=12.
;TVIMAGE,-image,bytscl(-image,median(-image)+stddev(-image), median(-image)-stddev(-image)), /scale, position=position
;plot,dindgen(dims[0]+1),dindgen(dims[0]+1)*dims[1]/dims[0],xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, xrange=[0.,dims[0]], yrange=[0.,dims[1]], /xstyle, /ystyle, ticklen=0,color=0, position=position
;dv=where(sv[xv[i]-dv:xv[i]+dv,yv[i]-dv:yv[i]+dv] ne 0)
;ddv=where(abs(xv[i]-xv[dv]) lt 11 or abs(yv[i]-yv[dv]) lt 11 )
;remove,ddv,dv
endfor
nuse=n_elements(flux)
sum=total(flux)/float(n_elements(flux))
sumerr=sqrt(total(eflux^2))/float(n_elements(flux))
sum15=total(flux15)/float(n_elements(flux15))
sumerr15=sqrt(total(eflux15^2))/float(n_elements(flux15))
print,'mean= ',sum , '   meanerr= ',sumerr, '  mean15= ',sum15 , '   meanerr15= ',sumerr15
print,' meanratio= ',sum/(sigu/sqrt(n_elements(flux))),' meanratio15= ',sum15/(sigu15/sqrt(n_elements(flux15)))
stackim=fltarr(2*d+1,2*d+1)-12000
weight=fltarr(2*d+1,2*d+1)+nuse
for i=0, 2*d do for j=0, 2*d do begin
   id=where(im[i,j,*] lt -260)
   if id[0] ne -1 then begin
   im[i,j,id]=0
   weight[i,j]=weight[i,j]-n_elements(id)
   endif
   stackim[i,j]=total(im[i,j,*])/float(nuse)
;   im2=im[i,j,*]
 ;   stackim[i,j]=median(im2[where(im2 ne 0)])
endfor
writefits,'~/Dropbox/Research/Supcam/stack383/new2/all/U/stackUerr.fits',stackim,newhr
writefits,'~/Dropbox/Research/Supcam/stack383/new2/all/U/stackUerr.exp',weight,newhr

aper, stackim, d, d, fs, efs,sky,skyerr, 1, apr,[48,73],[-260,48000], /flux, /exact,setsky=0.0
print,'stackim 2FWHM=  ',fs[0], '   error=  ',efs[0]
print,'stackratio 2FWHM= ',fs[0]/(sigu/sqrt(nuse))
print,'stackim 1.5FWHM=  ',fs[1], '   error=  ',efs[1]
print,'stackratio 1.5FWHM= ',fs[1]/(sigu15/sqrt(nuse))
;Ploting the absolute R mag hist with the assumption that all sources
;at at z=3.34 and therefore Dl=2.89118d6 pc
dl=2.89118d10
mr=r-5.0*(alog10(dl)-1)+2.5*alog10(1+3.34)
set_plot,'ps'
device,filename='~/Dropbox/Research/Supcam/stack383/new2/all/U/Mr_correct.eps',/color,/encap
plothist,mr,bin=0.2,xtitle=textoidl('M_R'),ytitle='Number',thick=4.5,xthick=3,ythick=3,charsize=1.5,xr=[-22, -17.5],xstyle=1;,yr=[0,50],ystyle=1
oplot,[-21.9,-21.9],[0,100],thick=4,color=get_colour_by_name('red'),linestyle=2
oplot,[-18.9,-18.9],[0,100],thick=4,color=get_colour_by_name('red'),linestyle=2
device,/close
;idd=where(med eq -4700.)
;if idd[0] ne -1 then remove,idd,med
;id=-1
;for i=0,n_elements(ra)-1 do if median(s[i].img) eq -4700. then id=[id,i]
;if n_elements(id) gt 1 then begin
;   remove,where(id eq -1),id
;   remove,id,s
;endif
;stackmed=median(med)
;d2=(2*d+1)^2
;pix=fltarr(d2)
;newim=fltarr(2*d+1,2*d+1)
;for i=0,d2-1 do pix[i]=median(s.img[i])
;for i=0, 2*d do for j=0,2*d do newim[i,j]=median(s.img[i,j])
;pixstack=median(pix)
;print,'stackemed= ',stackmed
;print, 'pixmed= ',pixstack
;hextract,n383,h383,newim_r,newhr,4000-d,4000+d,4000-d,4000+d
;writefits,'med383.fits',newim,newhr



stop
end

pro stacku2
sigu=59.1858
sigu15=44.3061 
; Stamp sizes are designed to have the same size as the IB383 stamps
d=194.0
dv=474.0
zpu=32.5556 
zp383=31.3949
;sig383=53.5755
;sig15=41.95
apr=[5.05, 6.72] ; 1.5 and 2FWHM for U
fxread,'~/Dropbox/Research/Supcam/stack383/new2/all/U/stackUerr.fits',imu,hu
fxread,'~/Dropbox/Research/Supcam/stack383/new2/all/U/stackUerr.exp',imexp,hu
aper, imu, d, d, fs0, efs0,sky,skyerr, 1, apr,[48,73],[-260,48000], /flux, /exact;,setsky=0.0
print,'stackim 2FWHM=  ',fs[0], '   error=  ',efs[0]
print,'stackratio 2FWHM= ',fs[0]/(sigu/sqrt(nuse))
print,'stackim 1.5FWHM=  ',fs[1], '   error=  ',efs[1]
print,'stackratio 1.5FWHM= ',fs[1]/(sigu15/sqrt(nuse))
a=randomu(seed,1000)*360.0+6
noise=[]
for i=0, n_elements(a)-1 do begin &$
   aper, imu, a[i], a[i], fs, efs,sky,skyerr, 1, apr[0],[48,73],[-260,48000], /flux, /exact,setsky=0.0 &$
   noise=[noise,fs] &$
endfor
   print, median(noise)
   print,stddev(noise)
stop  
end
