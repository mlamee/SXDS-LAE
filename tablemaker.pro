pro tb
close,/all
fmt='(f7.4," & ", f7.4," & ", i, "$\pm$",i, " & ",f5.2,"$\pm$", f4.2," & ",f5.2,"$\pm$", f4.2," & ",f5.2,"$\pm$", f4.2," & ",f5.2,"$\pm$", f4.2," & ",f5.1," & ",f4.1," & ",f6.3," &  \\")'
readcol,'~/Dropbox/Research/SupCam/new/BVge0.4_err/BVge0.4_err.cat',ra,dec,u,uer,b,ber,ib,iber,v,ver,r,rer,ew,ewer,ibf,ibfer,line  ,skipline=17
readcol,'~/Dropbox/Research/SupCam/new/BVge0.4_err/BVge0.4_err.nt.cat',rant,decnt,unt,uernt,bnt,bernt,ibnt,ibernt,vnt,vernt,rnt,rernt,ewnt,ewernt,ibfnt,ibfernt,linent  ,skipline=17

readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
sig527=ap3[3]
dv=3.e18*(1./5139.-1./5383.) ;fv.dv=fl.dl
fNB=10.^(-(ib+2.406+5.*alog10(5261.))/2.5)
fl=fNB/(1+245.7/ew);erg/[cm^2.s.A]
fl0=fl

fv=1.e23*1e6*fl*245.7/dv; micro Jansky
fNBnt=10.^(-(ibnt+2.406+5.*alog10(5261.))/2.5) 
flnt=fNBnt/(1+245.7/ewnt)
fvnt=1.e23*1e6*flnt*245.7/dv ; micro Jansky
openw,lun,'bverr0_new.txt',/get_lun
for i=0, n_elements(ra)-1 do printf,lun,ra[i], dec[i],ew[i],ewer[i],b[i],ber[i],ib[i],iber[i],v[i],ver[i],r[i],rer[i],ibf[i]/sig527,line[i], fl[i]*1.e17*245.7,format=fmt
for i=0, n_elements(rant)-1 do printf,lun,rant[i], decnt[i],ewnt[i],ewernt[i],bnt[i],bernt[i],ibnt[i],ibernt[i],vnt[i],vernt[i],rnt[i],rernt[i],ibfnt[i]/sig527,linent[i], flnt[i]*1.e17*245.7,format=fmt
ib0=ib
free_lun,lun
readcol,'~/Dropbox/Research/SupCam/new/BVge0.4_noerronly/BVge0.4_noerronly.cat',ra,dec,u,uer,b,ber,ib,iber,v,ver,r,rer,ew,ewer,ibf,ibfer,line  ,skipline=17
readcol,'~/Dropbox/Research/SupCam/new/BVge0.4_noerronly/BVge0.4_noerronly.nt.cat',rant,decnt,unt,uernt,bnt,bernt,ibnt,ibernt,vnt,vernt,rnt,rernt,ewnt,ewernt,ibfnt,ibfernt,linent  ,skipline=17

fNB=10.^(-(ib+2.406+5.*alog10(5261.))/2.5)
fl=fNB/(1+245.7/ew)
fv=1.e23*1e6*fl*245.7/dv
fNBnt=10.^(-(ibnt+2.406+5.*alog10(5261.))/2.5)
flnt=fNBnt/(1+245.7/ewnt)
fvnt=1.e23*1e6*flnt*245.7/dv

openw,lun,'bvnoerronly0_new.txt',/get_lun
for i=0, n_elements(ra)-1 do printf,lun,ra[i], dec[i],ew[i],ewer[i],b[i],ber[i],ib[i],iber[i],v[i],ver[i],r[i],rer[i],ibf[i]/sig527,line[i], fl[i]*1.e17*245.7,format=fmt
for i=0, n_elements(rant)-1 do printf,lun,rant[i], decnt[i],ewnt[i],ewernt[i],bnt[i],bernt[i],ibnt[i],ibernt[i],vnt[i],vernt[i],rnt[i],rernt[i],ibfnt[i]/sig527,linent[i], flnt[i]*1.e17*245.7,format=fmt

free_lun,lun
angstrom = '!6!sA!r!u!9 %!6!n' 
set_plot,'ps'
device,filename='BVerrhist_new.eps',/encap,/color
plothist,fl0*1.e17*245.7,bin=0.3,xtitle=Textoidl('F_{line} [10^{-17}erg/cm^2.s]'),ytitle='Number',xr=[0, 20],yr=[0,34],xstyle=1,ystyle=1,color=get_colour_by_name('red')
plothist,[fl0,fl]*1.e17*245.7,bin=0.3,color=get_colour_by_name('blue'),linesyle=4,/overplot
device,/close
;device,filename='ibhist.eps',/encap,/color; IBhist
;plothist,ib0,bin=0.2,xtitle='IB527[auto]',ytitle='Number',xr=[22, 27],yr=[0,25],xstyle=1,ystyle=1,color=get_colour_by_name('red')
;plothist,ib,bin=0.2,color=get_colour_by_name('blue'),linesyle=4,/overplot
;device,/close
set_plot,'x'
stop  
end
