pro compV
readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
signb=ap1[3]
;mosv=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Vdual_f.fits',1,hv)
mosv=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527dual_f.fits',1,hv)
im='/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits'
x=mosv.x_image-1
y=mosv.y_image-1
fxread,im,data,header
extast,header,astr
xy2ad, x, y, astr, ra, dec
;ra=mosv.x_world
;dec=mosv.y_world
im2='/Volumes/MacintoshHD2/supcam/quilt/OBJECT.V.1.fits'
fxread,im2,data2,header2
extast,header2,astr2



v=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Vsingle.fits',1,hv0)
x2=v.x_image-1
y2=v.y_image-1

xy2ad, x2, y2, astr2, ra0, dec0
magv=mosv.mag_auto
ind=where(magv le 32)
newra=ra[ind]
newdec=dec[ind]
newmagv=magv[ind]
magv0=v.mag_auto
ind2=where(magv0 le 32)
newra0=ra0[ind2]
newdec0=dec0[ind2]
newmagv0=magv0[ind2]
matchcat,newra0,newdec0,newra,newdec,in0,in,DT=0.15
magv_2=newmagv[in]
magv0_2=newmagv0[in0]
print, 'in0 ',n_elements(in0)
v0new=newmagv0[in0]
vnew=newmagv[in]
idd=where(vnew le 26.482)
set_plot, 'ps'
device,file='IB527(dual)V.eps',/encap,/color
plot,v0new[idd],vnew[idd],psym=sym(18),xtitle='V(single) Mag',ytitle='527(dual) Mag',charsize=1.5,thick=1.5,yr=[15,32]
oplot,indgen(40),indgen(40),color=get_colour_by_name('red')
device,/close
device,file='IB527(dual)-V.eps',/encap,/color
plot,vnew[idd],vnew[idd]-v0new[idd],psym=sym(18),xtitle='IB527(dual)',ytitle='IB527(dual)-V(single)',charsize=1.5,thick=1.5,yr=[-2,2],xr=[15,30],xstyle=1
oplot,indgen(40),indgen(40)*0,color=get_colour_by_name('red')
device,/close
newra2=newra[in]
newdec2=newdec[in]
newra02=newra0[in0]
newdec02=newdec0[in0]
;openw,lun,'shared_dualV.reg',/get_lun
;printf,lun,'# Region file format: DS9 version 4.1',format='(a)' 
;printf,lun,'# Filename: mosaic_V.fits',format='(a)'
;printf,lun,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
;printf,lun,'fk5',format='(a)'
;for i=0,n_elements(newra2)-1 do printf,lun,'circle(',newra2[i],",",newdec2[i],',0.3") #width=2 ',format='(a,d15.6,a,d15.6,a)'
;free_lun,lun

;openw,lun,'shared_V.reg',/get_lun
;printf,lun,'# Region file format: DS9 version 4.1',format='(a)' 
;printf,lun,'# Filename: OBJECT.V.1.fits',format='(a)'
;printf,lun,'global color=red dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
;printf,lun,'fk5',format='(a)'
;for i=0,n_elements(newra02)-1 do printf,lun,'circle(',newra02[i],",",newdec02[i],',0.5") #width=2 ',format='(a,d15.6,a,d15.6,a)'
;free_lun,lun

;openw,lun,'Dual-Subaru_V.cor',/get_lun
;printf,lun,'RA_Subaru   DEC_Subaru   RA_dual     DEC_dual    V_Subaru     V_dual' 
;for i=0,n_elements(newra02)-1 do printf,lun, newra02[i],newdec02[i], newra2[i], newdec2[i], magv0_2[i], magv_2[i], format='(f8.5,4x,f8.5,4x,f8.5,4x,f8.5,4x,f7.4,4x,f7.4)'
;free_lun,lun
set_plot,'x'
stop
end

pro compV2
readcol,'Dual-Subaru_V.cor',ra0,dec0,ra,dec,v0,v, skipline=1
set_plot, 'ps'
device,file='V(dual)-V.eps',/encap,/color
plot,v0,v,psym=sym(18),xtitle='V Mag',ytitle='V(dual) Mag',charsize=1.5,thick=1.5,yr=[15,32]
oplot,indgen(40),indgen(40),color=get_colour_by_name('red')
device,/close
pct=fltarr(30,2)
medv=fltarr(30)-15
for i=0.,29. do begin
   id=where(v0 lt i/2.+15.5 and v0 ge i/2.+15)
   if id[0] ne -1 then begin
      medv[i]=median(v0[id]-v[id])
      pct[i,*]=percentiles(reform(v0[id]-v[id]),value=[0.16,0.84])
   endif
endfor
vx=indgen(30)/2.+15.25
device,file='V-dual.eps',/encap,/color
plot,v0,v0-v,psym=sym(18),xtitle='V Mag',ytitle='V-V(dual)',charsize=1.5,thick=1.5,yr=[-2,2]
oplot,indgen(40),indgen(40)*0,color=get_colour_by_name('red')
oplot,vx,medv,color=get_colour_by_name('blue'),psym=sym(1)
for i=0,29 do oplot,[vx[i],vx[i]],[pct[i,0],pct[i,1]],color=get_colour_by_name('blue')
device,/close

set_plot,'x'
stop
end
