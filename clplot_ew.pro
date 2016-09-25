pro e_w
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
close,/all
nb=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527dual_f.fits',1)
b=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Bdual_f.fits',1)
v=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Vdual_f.fits',1)
u=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Unew2_dual_f.fits',1)
;us=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Unew2.fits',1)
r=mrdfits('~/UKIDSS/subaru/ukidss_subR.fits',1)
readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
readcol, '~/Downloads/smoka/MITCCDs/NB527.txt',lam527, p527,skipline=22
readcol,'~/Downloads/smoka/MITCCDs/B.txt',lamb,pb
readcol,'~/Downloads/smoka/MITCCDs/V.txt',lamv,pv
width_v=984.
zpv=35.4005
zpb=35.2590
zp527=33.75
zpu=32.7402
zp383=31.5187
sigv=ap3[0]
sigb=ap3[2]
signb=ap3[3]
signb1=ap1[3]
sig383=ap3[4]
sigu=ap3[1]
rlim=27.7 ;3sigma mag 

mag527=-2.5*alog10(5.*signb)+zp527
vlim=-2.5*alog10(3.*sigv)+zpv
nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
um=u.mag_auto
rm=r.mag_auto
nbmer=nb.magerr_auto
bmer=b.magerr_auto
vmer=v.magerr_auto
umer=u.magerr_auto
;usm=us.mag_auto
;rm=r.mag_auto

nbma=nb.mag_aper
bma=b.mag_aper
vma=v.mag_aper
uma=u.mag_aper

nbmaer=nb.magerr_aper
bmaer=b.magerr_aper
vmaer=v.magerr_aper
umaer=u.magerr_aper
;usma=us.mag_aper
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

nb3er=reform(nbmaer[2,*])
b3er=reform(bmaer[2,*])
v3er=reform(vmaer[2,*])
u3er=reform(umaer[2,*])
; To use auto mag and flux
nbf=nb.flux_auto
bf=b.flux_auto
vf=v.flux_auto
uf=u.flux_auto
;usf=us.flux_auto
; to use aper flux
nbfa=nb.flux_aper
nbfaer=nb.fluxerr_aper
bfa=b.flux_aper
vfa=v.flux_aper
ufa=u.flux_aper
;usfa=us.flux_aper
nbf1=reform(nbfa[0,*])
bf1=reform(bfa[0,*])
vf1=reform(vfa[0,*])
uf1=reform(ufa[0,*])
nbf2=reform(nbfa[1,*])
bf2=reform(bfa[1,*])
vf2=reform(vfa[1,*])
uf2=reform(ufa[1,*])
nbf3=reform(nbfa[2,*])
bf3=reform(bfa[2,*])
vf3=reform(vfa[2,*])
uf3=reform(ufa[2,*])

nbfa3er=reform(nbfaer[2,*])
;rf=r.flux_auto
;calculating the EW of the lines

lf527=int_tabulated(lam527,lam527*p527)/int_tabulated(lam527,p527) ;the average wavelength
lfb=int_tabulated(lamb,lamb*pb)/int_tabulated(lamb,pb)
lfv=int_tabulated(lamv,lamv*pv)/int_tabulated(lamv,pv)
cont=bm*0.
ew=cont
ff=ew
ffer=ff
ewer=ew
openw,1,'Claudia.cat'
printf,1, 'EW     V_auto    V_auto_err    V_aper3    V_aper3_err    IB527_auto     IB527_auto_err     IB527_aper3      IB527_aper3_err'
for i=0, n_elements(bm)-1 do begin
  ; ct=linfit([lfb,lfv],[bm[i],vm[i]])
   ;cont[i]=ct[1]*lf527+ct[0]
   ;ev[i]=(10.0^((cont[i]-nbm[i])/2.5)-1)*245.7

ff[i]=10.d^(-(nbm[i]-vm[i])/2.5-2*alog10(lf527/lfv))
ffer[i]=ff[i]*alog(10)*(nbmer[i]+vmer[i])/2.5
ew[i]=245.7*(ff[i]-1)/(1-ff[i]*245.7/width_v)
ewer[i]=245.7*(1-245.7/width_v)*ffer[i]/(1-ff[i]*245.7/width_v)^2
printf,1, ew[i],vm[i],vmer[i], v3[i],v3er[i], nbm[i],nbmer[i], nb3[i],nb3er[i],format='(F10.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4)'
endfor

x=nb.x_image-1
y=nb.y_image-1

nt=where(nbf3 ge 5.*signb and vf3 lt 3.*sigv and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 )

ff[nt]=10^( -(nbm[nt]-vlim) /2.5 - 2.*alog10(lf527/lfv))
ew[nt]=245.7*(ff[nt]-1) / (1-ff[nt]*245.7/width_v)
nt2=where(nbf3 lt 5.*signb and vf3 lt 3.*sigv and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115)
ff[nt2]=10^(-(mag527-vlim)/2.5-2*alog10(lf527/lfv))
ew[nt2]=245.7*(ff[nt2]-1)/(1-ff[nt2]*245.7/width_v)
set_plot,'ps'
id5=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv  and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0  and nb.flags le 3 and ew gt -200)
id6=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and bm gt 0 and nb.flags le 3 and ew ge 108 and ew le 5000  )
id7=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and bm gt 0 and nb.flags gt 0  and ew ge 108 and ew le 5000 )
xx=indgen(30)/10.-2.
yy=-1.7*xx+1.13
id8=where(nbf3 ge 5.*signb   and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and bm gt 0  and bm-nbm gt -1.7*(nbm-vm)+1.13 )
id9=where(nbf3 ge 5.*signb   and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and bm gt 0  and nbm lt 23 and nbm-nb1 gt -1)
id10=where(nbf3 ge 5.*signb and vf3 lt 3.*sigv  and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and nbm gt 0 and bm gt 0)

;idv1=where(nbf1 ge 5.*signb and uf1 lt 3.*sigu and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and bm gt 0); and nb.flags eq 0 and ew ge 108 and ew le 5000  )
;stop
;just to check
;id5=where(nbf ge 5.*signb and bf ge 5.*sigb and vf ge 5.*sigv and uf ge 5.*sigu and um lt 0)
x0=x[id6]
y0=y[id6]
x00=x[id7]
y00=y[id7]
xx0=x[id9]
yy0=y[id9]
xxx0=x[nt]
yyy0=y[nt]
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x0],[y0]],'LAE_auto_noflag_EWw.reg','green'
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x00],[y00]],'LAE_auto_flag_EWw.reg','yellow'
;coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[xx0],[yy0]],'popII.reg','green'
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[xx0],[yy0]],'auto-aper.reg','green'
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[xxx0],[yyy0]],'notdet.reg','green'

fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',im527,h527
extast,h527,astr_527
xy2ad, x, y, astr_527, ra, dec
ra5=ra[id5]
dec5=dec[id5]


nbm5=nbm[id5]
ew5=ew[id5]
md=fltarr(19)
lp=md
j=indgen(19)/2.+18.
jj=indgen(37)/4.+18.
jj[36]=mag527
t=-700./(27.75-jj+2.5)-20   
;nnn=dindgen(10) + 18.
ff_limit=10.d^(-(nbm-vlim)/2.5-2*alog10(lf527/lfv))
ew_limit=245.7*(ff_limit-1)
                            
j[18]=mag527
for i=0, 18 do begin
   dd=where(nbm5 lt j[i]+0.5 and nbm5 ge j[i])
   if dd[0] eq -1 then md[i]=0 else md[i]=median(ew5[dd])
   ew55=ew5[dd]
   ;dd1=where(ew55 le md[i])
   lp[i]=percentiles(reform(ew55),value=0.0005)
;if j[i] gt 25.2 then stop   
endfor
id66=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and x gt 1410 and x lt 11260 and y gt 1675 and y lt 11115 and um gt 0 and vm gt 0 and bm gt 0 and nb.flags le 3 and ew-ewer ge 700./(27.75-nbm+2.5)+20   and ew le ew_limit  )
x66=x[id66]
y66=y[id66]
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x66],[y66]],'LAE66.reg','green'

ra66=ra[id66]
dec66=dec[id66]
flag=nb.flags
flg66=flag[id66]
nbf66=nbf[id66]
nbf3_66=nbf3[id66]
nbfa3er_66=nbfa3er[id66]
vm66=vm[id66]

;finish checking
device,filename='eww1.eps',/encap,/color ; IB527-V vs B-IB527
plotsym,0,0.2,/fill
;id8=fltarr(2309)
;j=0
;for i=0,23089,10 do begin
 ;  id8[j]=id5[j]
  ; j++
;endfor

cgplot,nbm[id5]-vm[id5],bm[id5]-nbm[id5],psym=sym(0),xr=[-3,1],yr=[-1,4],xtitle='IB527-V',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,xx,yy ,color=get_colour_by_name('red'),/overplot
cgplot,nbm[id66]-vm[id66],bm[id66]-nbm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7]-vm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
device,filename='eww2.eps',/encap,/color ;IB527-V vs U-V
plotsym,0,0.2,/fill

cgplot,bm[id5]-nbm[id5],um[id5]-bm[id5],psym=sym(18),xr=[-1,4],yr=[-2,5],xtitle='B-IB527',ytitle='U-B',xstyle=1,thick=4,charsize=1.5
cgplot,bm[id66]-nbm[id66],um[id66]-bm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,bm[id7]-nbm[id7],um[id7]-bm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
device,filename='eww3.eps',/encap,/color ;U vs U-V
plotsym,0,0.2,/fill
    
cgplot,um[id5],um[id5]-bm[id5],psym=sym(18),xr=[15,30],yr=[-2,5],xtitle='U',ytitle='U-B',xstyle=1,thick=4,charsize=1.5
cgplot,um[id66],um[id66]-bm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,um[id7],um[id7]-bm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
device,/close
device,filename='eww4.eps',/encap,/color ;V vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,vm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='V',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
cgplot,vm[id6],nbm[id6]-vm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,vm[id7],nbm[id7]-vm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='eww5.eps',/encap,/color ;IB527 vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id66],nbm[id66]-vm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7],nbm[id7]-vm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='eww6.eps',/encap,/color ;B vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,bm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='B',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,bm[id66],bm[id66]-nbm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,bm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
t=-700./(27.75-jj+2.5)-20                               
device,filename='eww7.eps',/encap,/color ;IB527 vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='IB527',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id66],bm[id66]-nbm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename='eww.eps',/encap,/color ;IB527 vs Equivalent width
plotsym,2,1.5,/fill
cgplot,nbm[id5],ew[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,28],yr=[-250,1000],xstyle=1,ystyle=1,xtitle='IB527',ytitle='EW (Angstrom)',title='Observed equivalent width'
cgplot,nbm[id66],ew[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7],ew[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot
cgplot,j,md,psym=sym(4),color=get_colour_by_name('green'),/overplot
cgplot,jj,t,color=get_colour_by_name('blue'),/overplot
cgplot,jj,-t,color=get_colour_by_name('blue'),/overplot
;cgplot,jj,ew_limit,color=get_colour_by_name('red'),/overplot

for i=0,18 do cgplot, j,lp,color=get_colour_by_name('green'),/overplot
for i=0,18 do cgplot, j,md+(md-lp),color=get_colour_by_name('green'),/overplot

device,/close

device,filename='ewwmag.eps',/encap,/color ;IB527-V vs Equivalent width
plotsym,0,0.2,/fill
cgplot,nbm[id5]-vm[id5],ew[id5],psym=sym(1),charsize=1.5,thick=4,xr=[-2,2],yr=[-200,2000],xstyle=1,xtitle='IB527- V ',ytitle='EW (Angstrom)',title='Observed equivalent width 5sigma'
;cgplot,nbm[id6]-vm[id6],ew[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7]-vm[id7],ew[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
;cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot

device,/close
device,filename='ewwmag2.eps',/encap,/color ;IB527 vs Equivalent width
plotsym,0,0.2,/fill
cgplot,nbm[id5],ew[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,28],yr=[-200,2000],xstyle=1,xtitle='IB527 ',ytitle='EW (Angstrom)',title='Observed equivalent width 5sigma'
cgerrplot,nbm[id66],ew[id66]-ewer[id66],ew[id66]+ewer[id66],color=get_colour_by_name('red')
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot
cgplot,j,md,psym=sym(4),color=get_colour_by_name('green'),/overplot
cgplot,jj,t,color=get_colour_by_name('blue'),/overplot
cgplot,jj,-t,color=get_colour_by_name('blue'),/overplot
;cgplot,jj,ew_limit,color=get_colour_by_name('red'),/overplot

for i=0,18 do cgplot, j,lp,color=get_colour_by_name('green'),/overplot
for i=0,18 do cgplot, j,md+(md-lp),color=get_colour_by_name('green'),/overplot
device,/close
device,filename='nbm_err.eps',/encap,/color ; Equivalent width vs error
plotsym,0,0.2,/fill
cgplot,nbm[id5],ewer[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,30],xstyle=1,xtitle='nbm ',ytitle='Error ',title='Observed equivalent width 5sigma'
device,/close
device,filename='eww_aper.eps',/encap,/color ;IB527 vs Equivalent width
plotsym,0,0.2,/fill
cgplot,nb1[id5],ew[id5],psym=sym(18),charsize=1.5,thick=4,xr=[15,28],yr=[-200,600],xstyle=1,xtitle='IB527',ytitle='EW (Angstrom)',title='Observed equivalent width'
cgplot,nb1[id66],ew[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nb1[id7],ew[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot

device,/close


device,filename='auto_aper.eps',/encap,/color ;IB527 vs IB527_aper
plotsym,0,0.2,/fill
cgplot,nbm,nbm-nb3,psym=sym(18),charsize=1.5,thick=4,xr=[22,28],yr=[-1,1],ystyle=1,xstyle=1,xtitle='IB527',ytitle='Auto - Aper(9.6 pix Diameter)',title='Auto mag vs Aperture mag'
;cgplot,nbm[id6],nbm[id6]-nb1[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,nbm[id9],nbm[id9]-nb3[id9],psym=sym(1),color=get_colour_by_name('blue'),/overplot
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot

device,/close
device,filename='err.eps',/encap,/color ;IB527 vs Error
plotsym,0,0.2,/fill
cgplot,nbm[id5],nbmer[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,30],yr=[0,0.2],xstyle=1,xtitle='IB527_auto ',ytitle='Error'
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot
device,/close
device,filename='errv.eps',/encap,/color ;V vs Error
plotsym,0,0.2,/fill
cgplot,vm[id5],vmer[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,30],yr=[0,0.2],xstyle=1,xtitle='V_auto ',ytitle='Error'
cgplot,[vlim,vlim],[-2000,2000],color=get_colour_by_name('brown'),/overplot
device,/close

;Working with r band image
idr=where(rm le rlim )
ra_r=r.x_world
dec_r=r.y_world
;matchcat,ra5,dec5,ra_r,dec_r,in5,inr,DT=0.5

matchcat,ra66,dec66,ra_r,dec_r,in66,inr_66,DT=0.5
ntdet=indgen(343)
remove,in66,ntdet
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra66[in66]],[dec66[in66]]],'LAE_R.reg','red'
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra66[ntdet]],[dec66[ntdet]]],'LAE_R_ntdet.reg','blue'
coordfk5,'~/UKIDSS/subaru/ukidss_subR.fits',[[ra_r],[dec_r]],'All_R.reg','blue'
;Making stamps

fxread,'~/UKIDSS/subaru/mosaic_R.fits',im_r,hr
extast,hr,astr_r
rant=ra66[ntdet]
decnt=dec66[ntdet]
ad2xy, rant,decnt, astr_r, x_r, y_r
spawn,'rm -f /Volumes/MacintoshHD2/supcam/quilt/stampsR/*.fits'
for i=0, n_elements(x_r)-1 do begin
hextract,im_r,hr,newim_r,newhr,x_r[i]-50,x_r[i]+50,y_r[i]-50,y_r[i]+50
name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/stampsR/'+string(i)+'R_nt.fits',/remove_all)
writefits,name,newim_r,newhr
endfor

xnt=x66[ntdet]
ynt=y66[ntdet]
flg_nt=flg66[ntdet]
nbf_nt=nbf66[ntdet]
nbf3_nt=nbf3_66[ntdet]
nbfa3er_nt=nbfa3er_66[ntdet]
vm66_nt=vm66[ntdet]
device,filename='fl.eps',/encap,/color 
plotsym,0,0.2,/fill
cgplot,nbf_nt,nbf_nt-nbf3_nt,psym=sym(1),xr=[600,5000],charsize=1.5,thick=4,xtitle='Auto flux ',ytitle='Auto-Aper flux'
;cgplot,[-300,5000],[5.*signb,5.*signb],color=get_colour_by_name('brown'),/overplot
device,/close
for i=0, n_elements(xnt)-1 do begin
im=im527
h2=h527
hextract,im,h2,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/stamps527/'+string(i)+'nt527.fits',/remove_all)
writefits,name,im,h2
endfor

fxread,'/Volumes/MacintoshHD2/supcam/quilt/Apt527.fits',imapt,hapt
extast,hapt,astr_apt
for i=0, n_elements(xnt)-1 do begin
im=imapt
h2=hapt
hextract,im,h2,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/stampsApt527/'+string(i)+'apt527.fits',/remove_all)
writefits,name,im,h2
endfor

fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.V.1.fits',imv,hv
for i=0, n_elements(xnt)-1 do begin
hextract,imv,hv,newim,newh,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/stampsV/'+string(i)+'V.fits',/remove_all)
writefits,name,newim,newh
endfor

set_plot,'x'
stop

end
