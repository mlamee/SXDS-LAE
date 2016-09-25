pro select
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
close,/all
nb=mrdfits('CAT_527dual_f.fits',1)
b=mrdfits('CAT_Bdual_f.fits',1)
v=mrdfits('CAT_Vdual_f.fits',1)
readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/NB527-V.comp', ff,ib_v_syn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/NB527-B.comp', ff,ib_b_syn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/NB527-V0.5.comp', ff,ib_v05_syn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/NB527-B0.5.comp', ff,ib_b05_syn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/NB527-V0.25.comp', ff,ib_v25_syn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/NB527-B0.25.comp', ff,ib_b25_syn
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/synmag_z3.42.lst',ew,nbbsyn,nbvsyn,bband,nbband,vband, skipline=1
readcol,'/Users/mehdi/Downloads/smoka/MITCCDs/synmag_z3.3.lst',ew1,nbbsyn1,nbvsyn1,bband1,nbband1,vband1, skipline=1
zpv=35.4005
zpb=35.2590
zp527=33.6880
zpu=32.7402
zp383=31.5187
sigv=ap1[0]
sigb=ap1[2]
signb=ap1[3]
sig383=ap1[4]
sigu=ap1[1]
xxx1=indgen(120)/(-100.)-0.47
xxx2=indgen(47)/(-100.)
yyy=-1.2*(xxx1+2.1)^(-1.7)+0.05
zzz=-30*(xxx2-0.04)-15.5
xxx=[xxx2,xxx1]
ggg=[zzz,yyy]
plot,nb.mag_auto-v.mag_auto,b.mag_auto-nb.mag_auto,psym=3,xr=[-5,3],yr=[-5,5],xtitle='NB-V',ytitle='B-NB'


xx=dindgen(31)/10.-0.6
yy=0.32*xx-0.5
ss=xx
a1=dindgen(50)/10.0+18
b1=0.05*a1-1.3
a2=dindgen(80)/10.0+23
b3=-0.65*a1+12
b4=a2*0-5
b2=-0.1*a2+2.5
c1=[a1,a2]
c2=[b1,b2]
c3=[b3,b4]

nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
nbf=nb.flux_auto
bf=b.flux_auto
vf=v.flux_auto
ra=nb.x_image-1
dec=nb.y_image-1
maj_v=v.A_image
min_v=v.B_image
maj_b=b.A_image
min_b=b.B_image
maj_nb=nb.A_image
min_nb=nb.B_image
;area of the elliptical aperture 
area_v=0.15^2*!pi*maj_v*min_v
area_b=0.15^2*!pi*maj_b*min_b
area_nb=0.15^2*!pi*maj_nb*min_nb
;getting flux per aquare arcsec.
bf_n=bf/area_b
vf_n=vf/area_v
nbf_n=nbf/area_nb

openw,1,'cand.coords'
openw,2,'cand.coords2'

for j=0,n_elements(xx)-1,1 do begin
indbin=where(bm-vm gt xx[j]-0.05 and bm-vm le xx[j]+0.05 and nbm-vm gt -4 and nbm -vm lt 3)
index_candidates=where(bm-vm gt xx[j]-0.05 and bm-vm le xx[j]+0.05 and nbm-vm gt -4 and nbm -vm lt 0 and nbm-vm lt yy[j])

if j eq 0 then in=index_candidates
ra_cand=ra[index_candidates]
dec_cand=dec[index_candidates]

if j ne 0 then in=[in,index_candidates]

for i=0,n_elements(ra_cand)-1,1 do printf,1,ra_cand[i],dec_cand[i],format='((d15.6)," ",(d15.6))'
endfor
count=0
for j=0,n_elements(xxx)-1 do begin
index_candidates2=where(nbm-vm gt xxx[j]-0.005 and nbm-vm le xxx[j]+0.005 and nbm-vm gt -1.5 and nbm-vm lt 0. and  nbm-bm le ggg[j]  and vm gt 24 and vm lt 27 )
if total(index_candidates2) ne -1 then begin
   if (count eq 0)  then in2=index_candidates2 else in2=[in2,index_candidates2]
   count=1
   ra_cand2=ra[index_candidates2]
   dec_cand2=dec[index_candidates2]
   ;for i=0,n_elements(ra_cand2)-1,1 do printf,2,ra_cand2[i],dec_cand2[i],format='((d15.6)," ",(d15.6))'
endif
endfor


;close,/all

set_plot,'ps'
device,filename='sel2.ps',/encap,/color
plotsym,0,0.2,/fill
plot,b.mag_auto-v.mag_auto,nb.mag_auto-v.mag_auto,psym=3,xr=[-0.5,2.5],yr=[-4,2],ytitle='NB-V',xtitle='B-V',xstyle=1
;plot,v.mag_auto,nb.mag_auto-v.mag_auto,psym=8,xr=[10,25],yr=[-2,3],ytitle='V',xtitle='B-V',xstyle=1

for i=0,n_elements(in)-2 do begin
h=in[i]
;print,h
plotsym,0,0.5,color=230
oplot,[bm[h]-vm[h]],[nbm[h]-vm[h]],psym=8, color=230
;oplot,[vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('blue')

endfor
oplot,xx,yy,color=230
device,/close
device,filename='sel3.ps',/encap,/color
plotsym,0,0.2,/fill

plot,b.mag_auto,nb.mag_auto-b.mag_auto,psym=8,xr=[14,31],yr=[-4,2],ytitle='NB-B',xtitle='B',xstyle=1

for i=0,n_elements(in)-2 do begin
h=in[i]

oplot,[bm[h]],[nbm[h]-bm[h]],psym=8, color=get_colour_by_name('red')


endfor
device,/close
device,filename='sel4.ps',/encap,/color
plotsym,0,0.2,/fill
gg=where(nb.flags ge 0)    
plot,v[gg].mag_auto,nb[gg].mag_auto-v[gg].mag_auto,psym=sym(0),xr=[14,31],yr=[-4,2],ytitle='NB-V',xtitle='V',xstyle=1
nblimit=-2.5*alog10(signb*5.)+zp527
vlimit=-2.5*alog10(sigv*3.)+zpv
blimit=-2.5*alog10(sigb)+zpb
oplot,v[gg].mag_auto,nblimit-v[gg].mag_auto,color=get_colour_by_name('red')
oplot,[vlimit,vlimit],[-4,2],linestyle=2,color=get_colour_by_name('red')

for i=0,n_elements(in2)-1 do begin
h=in2[i]
if nbf[h] ge 5*signb then begin
oplot,[vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('blue')
endif else begin
oplot,[vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('red')
endelse

;oplot,a1,b3
;oplot,c1,c2
endfor
loadct,13
device,/close
device,filename='sel.ps',/encap,/color
plotsym,0,0.2,/fill
;gg=where(nb.flags ge 0)    
cgplot,nb.mag_auto-v.mag_auto,-(nb.mag_auto-b.mag_auto),psym=sym(18),xr=[-2,1],yr=[-1,4],ytitle='B-IB527',xtitle='IB527-V',xstyle=1,thick=4,charsize=1.5

for i=0,n_elements(in2)-1 do begin
h=in2[i]
if nbf[h] ge 5*signb then begin
;oplot,[nbm[h]-vm[h]],-[nbm[h]-bm[h]],psym=sym(1), color=get_colour_by_name('blue')
oplot,nbvsyn,-nbbsyn,psym=sym(11),color=get_colour_by_name('brown')
oplot,nbvsyn1,-nbbsyn1,psym=sym(11),color=get_colour_by_name('brown')
printf,2,ra[h],dec[h],format='((d15.6)," ",(d15.6))'
endif else begin
;oplot,[nbm[h]-vm[h]],-[nbm[h]-bm[h]],psym=sym(1), color=get_colour_by_name('red')

endelse


endfor
cgplot,xxx1,-yyy,thick=4,/overplot,charsize=1.5
cgplot,xxx2,-zzz,thick=4,/overplot,charsize=1.5
;oplot,ib_v_syn,ib_b_syn,psym=sym(1),color=get_colour_by_name('green')
;oplot,ib_v25_syn,ib_b25_syn,psym=sym(1),color=get_colour_by_name('orange')
;oplot,ib_v05_syn,ib_b05_syn,psym=sym(1),color=get_colour_by_name('pink')
close,/all
loadct,13
device,/close
set_plot,'x'
makepdf, 'sel4','sel4'
makepdf, 'sel3','sel3'
makepdf,'sel2','sel2'
makepdf,'sel','sel'
plot, nbf_n/signb, nbm,psym=sym(1),xtitle='sigma',ytitle='NB527 mag'
spawn,'open sel.pdf '
spawn,'open sel4.pdf '
coord, 'cand.coords2', 'NB-V_gt0.1andlt1andNB-Blt-0.5.new.reg'
print, '5 sigma mag IB527 ',-2.5*alog10(5*signb)+zp527
print, '5 sigma mag B ',-2.5*alog10(5*sigb)+zpb
print, '5 sigma mag V ',-2.5*alog10(5*sigv)+zpv
print,'5 sigma mag IB383 ',-2.5*alog10(5*sig383)+zp383
print, '5 sigma mag U ',-2.5*alog10(5*sigu)+zpu
stop
end

pro coord,input, output 
close,/all
openw,101,output
openw,102,'radec.lst'
readcol,input,x,y
fxread,'OBJECT.527.1.fits',data,header
extast,header,astr
xy2ad, x, y, astr, a, d
printf,101,'# Region file format: DS9 version 4.1',format='(a)' 
printf,101,'# Filename: OBJECT.527.1.fits',format='(a)'
printf,101,'global color=green dashlist=8 3 width=1 font="helvetica 10 normal roman" select=1 highlite=1 dash=0 fixed=0 edit=1 move=1 delete=1 include=1 source=1',format='(a)'
printf,101,'fk5',format='(a)'
for i=0,n_elements(x)-1 do begin
   printf,101,'circle(',a[i],",",d[i],',2")',format='(a,d15.6,a,d15.6,a)'
   printf,102,a[i],d[i]
endfor
close,/all

end
