pro testconv
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
close,/all
nb=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527dual_fake.fits',1)
nb2=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527dual_f_conv.fits',1)
nbm=nb.mag_auto
nbm2=nb2.mag_auto


id= where(nbm-nbm2 ge 3)
x=nb.x_image-1
y=nb.y_image-1
x0=x[id]
y0=y[id]
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x0],[y0]],'check.reg','green'
set_plot,'ps'
device,filename='conv.eps',/encap,/color ;Original IB527 vs Convolved IB527
plotsym,0,0.2,/fill
cgplot,nbm,nbm-nbm2,psym=sym(0),xr=[25.5,28.5],yr=[-2,2],xtitle='Original 527 Auto mag',ytitle='Original - convolved 527 mag',xstyle=1,ystyle=1,thick=4,charsize=1.5
device,/close
set_plot,'x'
stop
end
