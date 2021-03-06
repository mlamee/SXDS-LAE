pro stack
d=80
dv=195
close,/all
zp383=31.5187
sig383=53.5755
sig15=41.95
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',n383,h383
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.V.1.fits',v,hv
fxread,'/Volumes/MacintoshHD2/supcam/quilt/seg-V.fits',sv,s
fxread,'~/Dropbox/Research/Supcam/seg383.fits',s383,s
readcol,'~/Dropbox/Research/Supcam/new/BVge0.4_err/BVge0.4_errold.cat',ra,dec,u,uer,b,ber,ib,iber,vm,ver,r,rer,ew,ewer,ibf,ibfer,line,skipline=17
readcol,'~/Dropbox/Research/Supcam/new/BVge0.4_noerronly/BVge0.4_noerronly.cat',ra2,dec2,u2,uer,b2,ber,ib2,iber,vm2,ver2,r2,rer,ew2,ewer,ibf2,ibfer,line2  ,skipline=17
ra=[ra,ra2]
dec=[dec,dec2]
vm=[vm,vm2]
r=[r,r2]
;spawn,'mkdir ~/Dropbox/Research/Supcam/stack383'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/*.fits'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/*.exp'
spawn,'mkdir ~/Dropbox/Research/Supcam/stack383/noerronly'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/noerronly/*.fits'
;spawn, 'rm -f  ~/Dropbox/Research/Supcam/stack383/noerronly/*.exp'
dd=where(s383 ne 0)

n383[dd]=-12000
extast,h383,astr
ad2xy, ra, dec, astr, x, y
extast,hv,astr
ad2xy, ra, dec, astr, xv, yv
med=fltarr(n_elements(ra))-11000.
s={img:fltarr(2*d+1,2*d+1)-11000.}
s=replicate(s,n_elements(ra))
im=fltarr(2*d+1,2*d+1,n_elements(ra))-11000
apr=[4.36,3.27] ; 2FWHM
aprv=[10.6,7.95]


;aper, im, d, d, flux, eflux,sky,skyerr, 1, apr,-1,[-10000,10000], /flux, /exact,setsky=0.0
for i=0, n_elements(ra)-1 do begin
  idd=where(n383[x[i]-d:x[i]+d,y[i]-d:y[i]+d] lt -13000) 
   if x[i]+d lt 5095 and y[i]+d lt 5095 and x[i]-d gt 0 and y[i]-d gt 0 and idd[0] eq -1   then begin
    
      im[*,*,i]=n383[x[i]-d:x[i]+d,y[i]-d:y[i]+d]
      img=im[*,*,i]
      med[i]=median(img[where(img gt -11000)])
      img[where(img gt -11000)]=img[where(img gt -11000)]-med[i]
      im[*,*,i]=img
   endif
endfor

f=fltarr(n_elements(ra),2)-2000.
f15=f
for i=0, n_elements(ra)-1 do begin
   aper, im[*,*,i], d, d, flux, eflux,sky,skyerr, 1, apr,[20,30],[-10000,10000], /flux, /exact;,setsky=0.0
   f[i,0]=flux[0]
   f[i,1]=eflux[0]
   f15[i,0]=flux[1]
   f15[i,1]=eflux[1]
;hextract,n383,h383,newim,newhr,x[i]-d,x[i]+d,y[i]-d,y[i]+d
;writefits,strcompress('~/Dropbox/Research/Supcam/stack383/'+string(i)+'-'+string(ra[i])+string(dec[i])+'dt383.fits',/remove_all),newim,newhr
endfor

id=where(f[*,0]-f[*,0] ne 0 or f[*,0]/sig383 gt 1.)
id15=where(f15[*,0]-f15[*,0] ne 0 or f15[*,0] gt 1.)
flux=f[*,0]
eflux=f[*,1]
flux15=f15[*,0]
eflux15=f15[*,1]
if id[0] ne -1 then begin 
   remove,id,flux
   remove,id,eflux
   remove,id,flux15
   remove,id,eflux15
   remove,id,x
   remove,id,y
   remove,id,ra
   remove,id,dec
   remove,id,vm
   remove,id,r
   ;remove,id,ver
   im[*,*,id]=0
endif
openw,1,'/Volumes/MacintoshHD2/supcam/quilt/new/BVge0.4_noerronly/flag0/listUu'
openw,2,'/Volumes/MacintoshHD2/supcam/quilt/new/BVge0.4_noerronly/flag0/listBb'
openw,3,'/Volumes/MacintoshHD2/supcam/quilt/new/BVge0.4_noerronly/flag0/listVv'
openw,4,'/Volumes/MacintoshHD2/supcam/quilt/new/BVge0.4_noerronly/flag0/listNBv'
openw,5,'/Volumes/MacintoshHD2/supcam/quilt/new/BVge0.4_noerronly/flag0/listLCc'
for i=0, n_elements(ra)-1 do begin
 printf,1,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'ntU.fits',/remove_all)

 printf,2,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'ntB.fits',/remove_all)
 printf,3,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'ntV.fits',/remove_all)
 printf,4,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'nt527.fits',/remove_all)
 printf,5,strcompress(string(ra[i],format='(f7.4)')+string(dec[i],format='(f7.4)')+'nt383.fits',/remove_all)
endfor
close,/all
badA=[1,7,8,11,19,44,48,54,62,70,72,73]
remove,badA,vm
remove,badA,r
stop
;extast,hv,astr
;ad2xy, ra, dec, astr, xv, yv

;set_plot,'ps'
for i=0,n_elements(ra)-1 do begin
   hextract,n383,h383,newim,newhr,x[i]-d,x[i]+d,y[i]-d,y[i]+d
   writefits,strcompress('~/Dropbox/Research/Supcam/stack383/noerronly/'+string(i)+'-'+string(ra[i])+string(dec[i])+'dt383.fits',/remove_all),newim,newhr
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
sum=total(flux)/n_elements(flux)
sumerr=sqrt(total(eflux^2))/n_elements(flux)
sum15=total(flux15)/n_elements(flux15)
sumerr15=sqrt(total(eflux15^2))/n_elements(flux15)
print,'Sum= ',sum , '   sumerr= ',sumerr, '  Sum15= ',sum15 , '   sumerr15= ',sumerr15
print,' sumratio= ',sum/(sig383/sqrt(n_elements(flux))),' sumratio15= ',sum15/(sig15/sqrt(n_elements(flux15)))
stackim=fltarr(2*d+1,2*d+1)-12000
weight=fltarr(2*d+1,2*d+1)+nuse
for i=0, 2*d do for j=0, 2*d do begin
   id=where(im[i,j,*] lt -10000)
   if id[0] ne -1 then begin
   im[i,j,id]=0
   weight[i,j]=weight[i,j]-n_elements(id)
   endif
   stackim[i,j]=total(im[i,j,*])/nuse
   
endfor
writefits,'~/Dropbox/Research/Supcam/stack383/stackim383.fits',stackim,newhr
writefits,'~/Dropbox/Research/Supcam/stack383/stackim383.exp',weight,newhr
aper, stackim, d, d, fs, efs,sky,skyerr, 1, apr,[20,30],[-10000,10000], /flux, /exact;,setsky=0.0
print,'stackim 2FWHM=  ',fs[0], '   error=  ',efs[0]
print,'stackratio 2FWHM= ',fs[0]/(sig383/sqrt(nuse))
print,'stackim 1.5FWHM=  ',fs[1], '   error=  ',efs[1]
print,'stackratio 1.5FWHM= ',fs[1]/(sig15/sqrt(nuse))
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
