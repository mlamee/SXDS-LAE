pro ev
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
close,/all
nb=mrdfits('CAT_527dual_f.fits',1)
b=mrdfits('CAT_Bdual_f.fits',1)
v=mrdfits('CAT_Vdual_f.fits',1)
u=mrdfits('CAT_Unew2_dual_f.fits',1)
us=mrdfits('CAT_Unew2.fits',1)
r=mrdfits('~/UKIDSS/subaru/ukidss_subR.fits',1)
readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
readcol, '~/Downloads/smoka/MITCCDs/NB527.txt',lam527, p527,skipline=22
readcol,'~/Downloads/smoka/MITCCDs/B.txt',lamb,pb
readcol,'~/Downloads/smoka/MITCCDs/V.txt',lamv,pv
zpv=35.4005
zpb=35.2590
zp527=33.75
zpu=32.7402
zp383=31.5187
sigv=ap1[0]
sigb=ap1[2]
signb=ap1[3]
sig383=ap1[4]
sigu=ap1[1]
nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
um=u.mag_auto
usm=us.mag_auto
rm=r.mag_auto

nbma=nb.mag_aper
bma=b.mag_aper
vma=v.mag_aper
uma=u.mag_aper
usma=us.mag_aper
nb1=reform(nbma[0,*])
b1=reform(bma[0,*])
v1=reform(vma[0,*])
u1=reform(uma[0,*])
nb2=reform(nbma[1,*])
b2=reform(bma[1,*])
v2=reform(vma[1,*])
u2=reform(uma[1,*])
nb3=reform(nbma[2,*])
b3=reform(bma[2,*])
v3=reform(vma[2,*])
u3=reform(uma[2,*])
; To use auto mag and flux
nbf=nb.flux_auto
bf=b.flux_auto
vf=v.flux_auto
uf=u.flux_auto
usf=us.flux_auto
; to use aper flux
nbfa=nb.flux_aper
bfa=b.flux_aper
vfa=v.flux_aper
ufa=u.flux_aper
usfa=us.flux_aper
nbf1=reform(nbfa[0,*])
bf1=reform(bfa[0,*])
vf1=reform(vfa[0,*])
uf1=reform(ufa[0,*])

;calculating the EW of the lines

lf527=int_tabulated(lam527,lam527*p527)/int_tabulated(lam527,p527)
lfb=int_tabulated(lamb,lamb*pb)/int_tabulated(lamb,pb)
lfv=int_tabulated(lamv,lamv*pv)/int_tabulated(lamv,pv)
cont=bf*0.
ev=cont
fb=10.^((bm)/(-2.5))
fv=10.^((vm)/(-2.5))
f527=10.^((nbm)/(-2.5))

for i=0, n_elements(bf)-1 do begin
   ct=linfit([lfb,lfv],[fb[i],fv[i]])
   cont[i]=ct[1]*lf527+ct[0]
   ev[i]=(f527[i]-cont[i])/cont[i]
endfor
;rf=r.flux_auto
plot,bm,fb-fv,psym=sym(1),charsize=2.5,thick=2.5,xr=[15,28],yr=[-0.10,0.10]
stop
plot,nbm,ev,psym=sym(1),charsize=2.5,thick=2.5,xr=[22,28]
x=nb.x_image-1
y=nb.y_image-1

set_plot,'ps'
;id5=where(nbf ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm
;gt 0)
id5=where(nbf1 ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0)
id6=where(nbf1 ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0 and nb.flags eq 0  and nbm-vm lt -0.3 and bm-nbm gt 1.5)

;just to check
;id5=where(nbf ge 5.*signb and bf ge 5.*sigb and vf ge 5.*sigv and uf ge 5.*sigu and um lt 0)
x0=x[id6]
y0=y[id6]
coord,'OBJECT.527.1.fits',[[x0],[y0]],'LAE_1.reg','blue'

;finish checking
device,filename='ptt1.eps',/encap,/color ; IB527-V vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nbm[id5]-vm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[-2,1],yr=[-1,3],xtitle='IB527-V',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id6]-vm[id6],bm[id6]-nbm[id6],psym=sym(18),color=get_colour_by_name('red'),/overplot
device,/close
device,filename='ptt2.eps',/encap,/color ;IB527-V vs U-V
plotsym,0,0.2,/fill

cgplot,nbm[id5]-vm[id5],um[id5]-vm[id5],psym=sym(18),xr=[-1,1],yr=[-1,2],xtitle='IB527-V',ytitle='U-V',xstyle=1,thick=4,charsize=1.5
device,/close
device,filename='ptt3.eps',/encap,/color ;U vs U-V
plotsym,0,0.2,/fill
    
cgplot,um[id5],um[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-1,2],xtitle='U',ytitle='U-V',xstyle=1,thick=4,charsize=1.5
device,/close
device,filename='ptt4.eps',/encap,/color ;V vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,vm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-1,2],xtitle='V',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
device,/close

device,filename='ptt5.eps',/encap,/color ;IB527 vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-1,2],xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
device,/close

device,filename='ptt6.eps',/encap,/color ;B vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,bm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,2],xtitle='B',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
device,/close

device,filename='ptt7.eps',/encap,/color ;IB527 vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,2],xtitle='IB527',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
device,/close

device,filename='ptt8.eps',/encap,/color ;IB527 vs IB527-V Aperture mag
plotsym,0,0.2,/fill
gg=where(nb.flags ge 0)    
cgplot,nb2[id5],nb2[id5]-v2[id5],psym=sym(18),xr=[15,30],yr=[-1,2],title='Aperture 8 pixels',xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
device,/close
device,filename='ptt9.eps',/encap,/color ;IB527 vs IB527-V Aperture mag
plotsym,0,0.2,/fill
   
cgplot,nb3[id5],nb3[id5]-v3[id5],psym=sym(18),xr=[15,30],yr=[-1,2],title='Aperture 20 pixels',xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
device,/close
set_plot,'x'
stop
end
