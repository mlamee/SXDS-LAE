pro clplots
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
nbf2=reform(nbfa[1,*])
bf2=reform(bfa[1,*])
vf2=reform(vfa[1,*])
uf2=reform(ufa[1,*])

;rf=r.flux_auto

x=nb.x_image-1
y=nb.y_image-1

set_plot,'ps'
;id5=where(nbf ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm
;gt 0)
id5=where(nbf1 ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0)
id6=where(nbf1 ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0 and nb.flags eq 0 and nbm-vm le -0.3 and bm-nbm ge 1.5)
id7=where(nbf1 ge 5.*signb and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0 and nb.flags ne 0 and nbm-vm le -0.3 and bm-nbm ge 1.5)
id1=where(nbf1 ge 5.*signb and u1 gt 0 and v1 gt 0 and nb1 gt 0 and b1 gt 0 and nb.flags eq 0 and nb1-v1 le -0.3 and b1-nb1 ge 1.5)
id2=where(nbf1 ge 5.*signb and u1 gt 0 and v1 gt 0 and nb1 gt 0 and b1 gt 0 and nb.flags ne 0 and nb1-v1 le -0.3 and b1-nb1 ge 1.5)

;just to check
;id5=where(nbf ge 5.*signb and bf ge 5.*sigb and vf ge 5.*sigv and uf ge 5.*sigu and um lt 0)
x0=x[id6]
y0=y[id6]
x00=x[id7]
y00=y[id7]
xx0=x[id1]
yy0=y[id1]
xx00=x[id2]
yy00=y[id2]

coord,'OBJECT.527.1.fits',[[x0],[y0]],'LAE_auto_noflag.reg','red'
coord,'OBJECT.527.1.fits',[[x00],[y00]],'LAE_auto_flag.reg','blue'
coord,'OBJECT.527.1.fits',[[xx0],[yy0]],'LAE_aper_noflag.reg','green'
coord,'OBJECT.527.1.fits',[[xx00],[yy00]],'LAE_aper_flag.reg','yellow'
;finish checking
device,filename='pt1.eps',/encap,/color ; IB527-V vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nbm[id5]-vm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[-3,1],yr=[-1,4],xtitle='IB527-V',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id6]-vm[id6],bm[id6]-nbm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,nbm[id7]-vm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
device,filename='pt2.eps',/encap,/color ;IB527-V vs U-V
plotsym,0,0.2,/fill

cgplot,bm[id5]-nbm[id5],um[id5]-bm[id5],psym=sym(18),xr=[-1,4],yr=[-2,5],xtitle='B-IB527',ytitle='U-B',xstyle=1,thick=4,charsize=1.5
cgplot,bm[id6]-nbm[id6],um[id6]-bm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,bm[id7]-nbm[id7],um[id7]-bm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
device,filename='pt3.eps',/encap,/color ;U vs U-V
plotsym,0,0.2,/fill
    
cgplot,um[id5],um[id5]-bm[id5],psym=sym(18),xr=[15,30],yr=[-2,5],xtitle='U',ytitle='U-B',xstyle=1,thick=4,charsize=1.5
cgplot,um[id6],um[id6]-bm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,um[id7],um[id7]-bm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
device,/close
device,filename='pt4.eps',/encap,/color ;V vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,vm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='V',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
cgplot,vm[id6],nbm[id6]-vm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,vm[id7],nbm[id7]-vm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='pt5.eps',/encap,/color ;IB527 vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id6],nbm[id6]-vm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,nbm[id7],nbm[id7]-vm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='pt6.eps',/encap,/color ;B vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,bm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='B',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,bm[id6],bm[id6]-nbm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,bm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='pt7.eps',/encap,/color ;IB527 vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='IB527',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id6],bm[id6]-nbm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,nbm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='pt8.eps',/encap,/color ;IB527 vs IB527-V Aperture mag
plotsym,0,0.2,/fill
gg=where(nb.flags ge 0)    
cgplot,nb2[id5],nb2[id5]-v2[id5],psym=sym(18),xr=[15,30],yr=[-4,2],title='Aperture 8 pixels',xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
device,/close
device,filename='pt9.eps',/encap,/color ;IB527 vs IB527-V Aperture mag
plotsym,0,0.2,/fill
   
cgplot,nb3[id5],nb3[id5]-v3[id5],psym=sym(18),xr=[15,30],yr=[-4,2],title='Aperture 20 pixels',xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
device,/close



device,filename='ptt1.eps',/encap,/color ; IB527-V vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nb1[id5]-v1[id5],b1[id5]-nb1[id5],psym=sym(18),xr=[-3,1],yr=[-1,4],xtitle='IB527-V',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,nb1[id1]-v1[id1],b1[id1]-nb1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,nb1[id2]-v1[id2],b1[id2]-nb1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot

device,/close
device,filename='ptt2.eps',/encap,/color ;IB527-V vs U-V
plotsym,0,0.2,/fill

cgplot,b1[id5]-nb1[id5],u1[id5]-b1[id5],psym=sym(18),xr=[-1,4],yr=[-2,5],xtitle='B-IB527',ytitle='U-B',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,b1[id1]-nb1[id1],u1[id1]-b1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,b1[id2]-nb1[id2],u1[id2]-b1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot

device,/close
device,filename='ptt3.eps',/encap,/color ;U vs U-V
plotsym,0,0.2,/fill
    
cgplot,u1[id5],u1[id5]-b1[id5],psym=sym(18),xr=[15,30],yr=[-2,5],xtitle='U',ytitle='U-B',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,u1[id1],u1[id1]-b1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,u1[id2],u1[id2]-b1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot
device,/close
device,filename='ptt4.eps',/encap,/color ;V vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,v1[id5],nb1[id5]-v1[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='V',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,v1[id1],nb1[id1]-v1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,v1[id2],nb1[id2]-v1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot

device,/close

device,filename='ptt5.eps',/encap,/color ;IB527 vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,nb1[id5],nb1[id5]-v1[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,nb1[id1],nb1[id1]-v1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,nb1[id2],nb1[id2]-v1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot

device,/close

device,filename='ptt6.eps',/encap,/color ;B vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,b1[id5],b1[id5]-nb1[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='B',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,b1[id1],b1[id1]-nb1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,b1[id2],b1[id2]-nb1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot

device,/close

device,filename='ptt7.eps',/encap,/color ;IB527 vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nb1[id5],b1[id5]-nb1[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='IB527',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5,title='Aper diameter 5.3 pixels'
cgplot,nb1[id1],b1[id1]-nb1[id1],psym=sym(1),color=get_colour_by_name('green'),/overplot
cgplot,nb1[id2],b1[id2]-nb1[id2],psym=sym(1),color=get_colour_by_name('yellow'),/overplot

device,/close


set_plot,'x'
stop
end
