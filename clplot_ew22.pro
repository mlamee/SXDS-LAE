;This file is editted in Dec 2014 with the new ZP for all bands

pro ew22
angs = '!6!sA!r!u!9 %!6!n' 
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
name2='new2/BVge0.4_err/'
name3='BVge0.4_err'
;spawn,'rm -r /Volumes/MacintoshHD2/supcam/quilt/new2'
;spawn,'rm -r new2'
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/new2'
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/new2/All_err'
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt//new2/All_noerr'
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/new2/BVge0.4_err'  
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/new2/BVge0.4_noerr'
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/new2/BVge0.4_noerronly'
spawn, 'mkdir new2'
spawn, 'mkdir new2/All_err'
spawn, 'mkdir new2/All_noerr'
spawn, 'mkdir new2/BVge0.4_err'
spawn, 'mkdir new2/BVge0.4_noerr'
spawn, 'mkdir new2/BVge0.4_noerronly'
spawn, 'mkdir plot2'
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/new2/BVge0.4_err'
close,/all
nb=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527dual_f2.fits',1)
b=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Bdual_f2.fits',1)
v=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Vdual_f2.fits',1)
u=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Unew2_dual_f2.fits',1)
;us=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Unew2.fits',1)
r=mrdfits('~/UKIDSS/subaru/ukidss_subR.fits',1)
readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
readcol, '~/Downloads/smoka/MITCCDs/NB527.txt',lam527, p527,skipline=22
readcol,'~/Downloads/smoka/MITCCDs/B.txt',lamb,pb
readcol,'~/Downloads/smoka/MITCCDs/V.txt',lamv,pv
width_v=984.
zpv=35.378
zpb=35.231
zp527=33.817
zpu=32.5556 
zp383=31.3949
sigv=ap3[0]
sigb=ap3[2]
signb=ap3[3]
signb1=ap1[3]
sig383=ap3[4]
sigu=ap3[1]
rlim=27.7 ;3sigma mag 
blim=-2.5*alog10(3.*sigb)+zpb
mag527=-2.5*alog10(5.*signb)+zp527
vlim=-2.5*alog10(3.*sigv)+zpv
ulim=-2.5*alog10(3.*sigu)+zpu

n383=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_383new.fits',1)
nm383=n383.mag_auto
f383=n383.flux_auto
xs3=n383.x_image-1
ys3=n383.y_image-1
;fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',ims383,hs383
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.exp',exp383,h383
extast,h383,astr_383
;extast,hs383,astr_s383
xy2ad, xs3, ys3, astr_383, ras3, decs3
idus=where(ras3 gt 34.3950 and ras3 lt 34.3952 and decs3 gt -5.4489 and decs3 lt -5.4486 )
print,nm383[idus]
print,f383[idus]/sig383


nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
um=u.mag_auto
rm=r.mag_auto
rmer=r.magerr_auto
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
rf=r.flux_auto
rfer=r.fluxerr_auto
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
;; I'm disabling this catalog making process 11/09/2015
;openw,1,'Claudia.cat'
;printf,1, 'EW     V_auto    V_auto_err    V_aper3    V_aper3_err    IB527_auto     IB527_auto_err     IB527_aper3      IB527_aper3_err'
ewer2=ewer*0.
ffer2=ffer*0.
for i=0, n_elements(bm)-1 do begin
  ;;;;; ct=linfit([lfb,lfv],[bm[i],vm[i]])
   ;;;;;cont[i]=ct[1]*lf527+ct[0]
   ;;;;;ev[i]=(10.0^((cont[i]-nbm[i])/2.5)-1)*245.7

ff[i]=10.d^(-(nbm[i]-vm[i])/2.5-2*alog10(lf527/lfv))
ffer2[i]=ff[i]*alog(10)*(nbmer[i]+vmer[i])/2.5
ffer[i]=ff[i]*alog(10)*sqrt(nbmer[i]^2.+vmer[i]^2.)/2.5

ew[i]=245.7*(ff[i]-1)/(1-ff[i]*245.7/width_v)
ewer[i]=245.7*(1-245.7/width_v)*ffer[i]/(1-ff[i]*245.7/width_v)^2
ewer2[i]=245.7*(1-245.7/width_v)*ffer2[i]/(1-ff[i]*245.7/width_v)^2

;printf,1, ew[i],vm[i],vmer[i], v3[i],v3er[i], nbm[i],nbmer[i], nb3[i],nb3er[i],format='(F10.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4, 4x,F7.4)'
endfor

x=nb.x_image-1
y=nb.y_image-1
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',im527,h527
extast,h527,astr_527
xy2ad, x, y, astr_527, ra, dec
ad2xy, ra,dec, astr_383, x383, y383
nt=where(nbf3 ge 5.*signb and vf3 lt 3.*sigv  and exp383[x383,y383] ne 0 )

ff[nt]=10^( -(nbm[nt]-vlim) /2.5 - 2.*alog10(lf527/lfv))
ew[nt]=245.7*(ff[nt]-1) / (1-ff[nt]*245.7/width_v)
nt2=where(nbf3 lt 5.*signb and vf3 lt 3.*sigv  and exp383[x383,y383] ne 0)
ff[nt2]=10^(-(mag527-vlim)/2.5-2*alog10(lf527/lfv))
ew[nt2]=245.7*(ff[nt2]-1)/(1-ff[nt2]*245.7/width_v)
set_plot,'ps'
id5=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv   and exp383[x383,y383] ne 0 and bm gt 0  and nb.flags eq 0 and ew gt -200 and abs(uf3) lt 100000)

id6=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 ge 3.*sigu and bf3 ge 3.*sigb and exp383[x383,y383] ne 0 and bm gt 0  and nb.flags eq 0 and ew gt -200 and abs(uf3) lt 100000) ;Detection in both u and B
id7=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and bf3 ge 3.*sigb and exp383[x383,y383] ne 0 and bm gt 0  and nb.flags eq 0 and ew gt -200 and abs(uf3) lt 100000) ; Detection only B and not u
xx=indgen(30)/10.-2.
yy=-1.7*xx+1.13
id8=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 ge 3.*sigu and bf3 lt 3.*sigb and exp383[x383,y383] ne 0 and bm gt 0  and nb.flags eq 0 and ew gt -200 and abs(uf3) lt 100000) ; detection in u and not B
id9=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and bf3 lt 3.*sigb and exp383[x383,y383] ne 0 and bm gt 0  and nb.flags eq 0 and ew gt -200 and abs(uf3) lt 100000) ; Detection not in u nor B
id10=where(nbf3 ge 5.*signb and vf3 lt 3.*sigv   and exp383[x383,y383] ne 0 and abs(uf3) lt 100000)

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
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x0],[y0]],'LAE_auto_noflag_EWw2.reg','green'
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x00],[y00]],'LAE_auto_flag_EWw2.reg','yellow'
;coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[xx0],[yy0]],'popII.reg','green'
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[xx0],[yy0]],'auto-aper2.reg','green'
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[xxx0],[yyy0]],'notdet2.reg','green'


ra5=ra[id5]
dec5=dec[id5]


nbm5=nbm[id5]
vm5=vm[id5]
um5=um[id5]
u3_5=u3[id5]
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
   dd=where(nbm5 lt j[i]+0.5 and nbm5 ge j[i] and ew5 ge -200.)
   if dd[0] eq -1 then md[i]=0 else md[i]=median(ew5[dd])
   ew55=ew5[dd]
   ;dd1=where(ew55 le md[i])
   lp[i]=percentiles(reform(ew55),value=0.0005)
;if j[i] gt 25.2 then stop   
endfor
;checking with 383 image

id66=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and uf3 gt -100000 and nb.flags eq 0 and ew le ew_limit and exp383[x383,y383] ne 0 and ew-ewer ge 108 and  bm-vm ge 0.48); and ew-ewer ge 700./(27.75-nbm+2.5)+5)
idu=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 gt 3.*sigu and abs(uf3 lt 100000) and nb.flags eq 0 and ew le ew_limit and exp383[x383,y383] ne 0 and ew-ewer ge 108 and  bm-vm ge 0.48); and ew-ewer ge 700./(27.75-nbm+2.5)+5)

id662=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and uf3 gt -100000 and nb.flags eq 0 and ew le ew_limit and exp383[x383,y383] ne 0 and ew ge 108 and  bm-vm ge 0.48 and ew-ewer2 ge 700./(27.75-nbm+2.5)+5)

id77=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and uf3 gt -100000 and nb.flags eq 0 and ew le ew_limit and exp383[x383,y383] ne 0  and bm-vm ge 0.48 and ew ge 108 and ew-ewer lt 108 );and ew ge 700./(27.75-nbm+2.5)+5 and ew-ewer lt 700./(27.75-nbm+2.5)+5)
id772=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and uf3 gt -100000 and nb.flags eq 0 and ew le ew_limit and exp383[x383,y383] ne 0 and ew ge 108 and ew ge 700./(27.75-nbm+2.5)+5 and bm-vm ge 0.48 )

;;;;;;;; Just a test plot

device,filename='errors.eps',/encap,/color ;EW vs error
   cgplot,ewer2[id66],ewer[id66],psym=sym(1),charsize=1.5,thick=4,xstyle=1,ystyle=1,xtitle='olderror ',ytitle='NewError'
   cgplot,ewer2[id77],ewer[id77],psym=sym(1),color=get_colour_by_name('black'),/overplot
  cgplot,[0,3000],[0,3000],/overplot
   
device,/close
;;;;;;;;;
stop


id88=where(nbf3 ge 5.*signb and vf3 ge 3.*sigv and uf3 lt 3.*sigu and nb.flags eq 0 and ew le ew_limit and exp383[x383,y383] ne 0 and bm-vm lt 0.48 and ew ge 108); and ew ge 700./(27.75-nbm+2.5)+5 )
x66=x[id66]
y66=y[id66]
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x66],[y66]],name2+'LAE66_2.reg','green'
ra66=ra[id66]
dec66=dec[id66]
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra66],[dec66]],name2+'radec66.reg','green','2'

flag=nb.flags
flg66=flag[id66]
nbf66=nbf[id66]
nbf3_66=nbf3[id66]
nbfa3er_66=nbfa3er[id66]
vm66=vm[id66]
bm66=bm[id66]
um66=um[id66]
nbm66=nbm[id66]
u366=u3[id66]
b366=b3[id66]
ew66=ew[id66]

nbfa3er66=nbfa3er[id66]
vmer66=vmer[id66]
nbmer66=nbmer[id66]
bmer66=bmer[id66]
umer66=umer[id66]
ewer66=ewer[id66]
ntb=where(bm66 gt blim)
bm66[ntb]=blim
x77=x[id77]
y77=y[id77]
coord,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[x77],[y77]],name2+'LAE77_2.reg','green'
ra77=ra[id77]
dec77=dec[id77]
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra77],[dec77]],name2+'radec77.reg','red','2'

flag=nb.flags
flg77=flag[id77]
nbf77=nbf[id77]
nbf3_77=nbf3[id77]
nbfa3er_77=nbfa3er[id77]
vm77=vm[id77]
bm77=bm[id77]
um77=um[id77]
nbm77=nbm[id77]
u377=u3[id77]
b377=b3[id77]
ew77=ew[id77]

nbfa3er77=nbfa3er[id77]
vmer77=vmer[id77]
nbmer77=nbmer[id77]
bmer77=bmer[id77]
umer77=umer[id77]
ewer77=ewer[id77]
ntb2=where(bm77 gt blim)
bm77[ntb2]=blim
openw,66,'radec66.dat'
for i=0, n_elements(id66)-1 do printf,66, ra66[i],dec66[i]
close,66
openw,77,'radec77.dat'
for i=0, n_elements(id77)-1 do printf,77, ra77[i],dec77[i]
close,77



device,filename=name2+'bv_ub.eps',/encap,/color ;B-V vs U-B
   cgplot,bm[id6]-vm[id6],um[id6]-bm[id6],psym=sym(0),charsize=1.5,thick=4,xr=[-0.5,2.5],yr=[-2,3],xstyle=1,ystyle=1,xtitle='B[auto]-V[auto] ',ytitle='U[auto]-B[auto]'
   plotsym,2,0.8,/fill
   cgplot,bm[id7]-vm[id7],ulim-bm[id7],psym=sym(0),color=get_colour_by_name('black'),/overplot
   cgplot,[-2,3],[ulim-blim,ulim-blim],linestyle=5,color=get_colour_by_name('black'),/overplot
  plotsym,7,0.8,/fill
   cgplot,blim-vm[id9],(ulim-blim)+vm[id9]*0,psym=8,color=get_colour_by_name('black'),/overplot 
   cgplot,blim-vm[id9],(ulim-blim)+vm[id9]*0,psym=8,color=get_colour_by_name('black'),/overplot 
   plotsym,2,0.8,/fill
   cgplot,bm66-vm66,ulim-bm66,psym=sym(1),color=get_colour_by_name('red'),/overplot
   plotsym,2,0.8,/fill
   cgplot,bm66-vm66,ulim-bm66,psym=8,color=get_colour_by_name('red'),/overplot
   plotsym,2,0.8,/fill
    cgplot,bm66[ntb]-vm66[ntb],ulim-bm66[ntb],psym=8,color=get_colour_by_name('red'),/overplot
    plotsym,7,0.8,/fill
    cgplot,bm66[ntb]-vm66[ntb],ulim-bm66[ntb],psym=8,color=get_colour_by_name('red'),/overplot

    plotsym,2,0.8,/fill
   cgplot,bm77-vm77,ulim-bm77,psym=sym(1),color=get_colour_by_name('blue'),/overplot
   plotsym,2,0.8,/fill
   cgplot,bm77-vm77,ulim-bm77,psym=8,color=get_colour_by_name('blue'),/overplot
   plotsym,2,0.8,/fill
    cgplot,bm77[ntb2]-vm77[ntb2],ulim-bm77[ntb2],psym=8,color=get_colour_by_name('blue'),/overplot
    plotsym,7,0.8,/fill
    cgplot,bm77[ntb2]-vm77[ntb2],ulim-bm77[ntb2],psym=8,color=get_colour_by_name('blue'),/overplot
    
device,/close
;;;;;;;;;;; I should plot these at the end since some of them are
;;;;;;;;;;; excluded when matching with R.
device,filename=name2+'vhist.eps',/encap,/color; Vhist
plothist,[vm66,vm77],bin=0.2,xtitle='V[auto]',ytitle='Number',xr=[23, 29],yr=[0,50],xstyle=1,ystyle=1,color=get_colour_by_name('blue'),thick=4.5,xthick=3,ythick=3
plothist,vm66,bin=0.2,color=get_colour_by_name('red'),linesyle=4,/overplot,thick=3
device,/close
device,filename=name2+'bhist.eps',/encap,/color; Bhist
plothist,[bm66,bm77],bin=0.2,xtitle='B[auto]',ytitle='Number',xr=[23.5, 29],yr=[0,40],xstyle=1,ystyle=1,color=get_colour_by_name('blue'),thick=4.5,xthick=3,ythick=3
plothist,bm66,bin=0.2,color=get_colour_by_name('red'),linesyle=4,/overplot,thick=3
device,/close
device,filename=name2+'ewhist.eps',/encap,/color; ewhist
plothist,[ew[id66],ew[id77]],bin=100,xtitle='EW [Angstrom]',ytitle='Number',color=get_colour_by_name('blue'),thick=4.5,xthick=3,ythick=3
plothist,ew66,bin=100,color=get_colour_by_name('red'),linesyle=4,/overplot,thick=3
device,/close
device,filename=name2+'ibhist.eps',/encap,/color; ibhist
plothist,[nbm66,nbm77],bin=0.2,xtitle='IB527[auto]',ytitle='Number',xr=[23, 29],yr=[0,50],xstyle=1,ystyle=1,color=get_colour_by_name('blue'),thick=4.5,xthick=3,ythick=3
plothist,nbm66,bin=0.2,color=get_colour_by_name('red'),linesyle=4,/overplot,thick=3
device,/close

stop
;finish checking
device,filename=name2+'eww1_2.eps',/encap,/color ; IB527-V vs B-IB527
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
device,filename=name2+'eww2_2.eps',/encap,/color ;IB527-V vs U-V
plotsym,0,0.2,/fill

cgplot,bm[id5]-nbm[id5],um[id5]-bm[id5],psym=sym(18),xr=[-1,4],yr=[-2,5],xtitle='B-IB527',ytitle='U-B',xstyle=1,thick=4,charsize=1.5
cgplot,bm[id66]-nbm[id66],um[id66]-bm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,bm[id7]-nbm[id7],um[id7]-bm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
device,filename=name2+'eww3_2.eps',/encap,/color ;U vs U-V
plotsym,0,0.2,/fill
    
cgplot,um[id5],um[id5]-bm[id5],psym=sym(18),xr=[15,30],yr=[-2,5],xtitle='U',ytitle='U-B',xstyle=1,thick=4,charsize=1.5
cgplot,um[id66],um[id66]-bm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,um[id7],um[id7]-bm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
device,/close
device,filename=name2+'eww4_2.eps',/encap,/color ;V vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,vm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='V',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
cgplot,vm[id6],nbm[id6]-vm[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,vm[id7],nbm[id7]-vm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename=name2+'eww5_2.eps',/encap,/color ;IB527 vs IB527-V
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],nbm[id5]-vm[id5],psym=sym(18),xr=[15,30],yr=[-4,2],xtitle='IB527',ytitle='IB527-V',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id66],nbm[id66]-vm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7],nbm[id7]-vm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename=name2+'eww6_2.eps',/encap,/color ;B vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,bm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='B',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,bm[id66],bm[id66]-nbm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,bm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close
t=-700./(27.75-jj+2.5)-5                               
device,filename=name2+'eww7_2.eps',/encap,/color ;IB527 vs B-IB527
plotsym,0,0.2,/fill
    
cgplot,nbm[id5],bm[id5]-nbm[id5],psym=sym(18),xr=[15,30],yr=[-1,4],xtitle='IB527',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
cgplot,nbm[id66],bm[id66]-nbm[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

device,/close

device,filename=name2+'eww_2.eps',/encap,/color ;IB527 vs Equivalent width
plotsym,2,1.5,/fill
cgplot,nbm[id5],ew[id5],psym=sym(0),charsize=1.5,xthick=3,ythick=3,thick=4,xr=[18,27],yr=[-250,1500],xstyle=1,ystyle=1,xtitle='IB527 [auto]',ytitle='Observed EW [Angstrom]';,title='Observed equivalent width'
cgplot,nbm[id66],ew[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,nbm[id77],ew[id77],psym=sym(1),color=get_colour_by_name('blue'),/overplot
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot,thick=4
;cgplot,j,md,psym=sym(4),color=get_colour_by_name('green'),/overplot
;cgplot,jj,t,color=get_colour_by_name('blue'),/overplot
;cgplot,jj,-t,color=get_colour_by_name('blue'),/overplot
;;;;;;;;
num=n_elements(id5)
n=500
s1=num/n
dloc=[]
med=[]
p05=[]
mdstd=[]
nbmd5=nbm[id5]
ewd5=ew[id5]
iddsort=sort(nbmd5)
nbmd5=nbmd5[iddsort]
ewd5=ewd5[iddsort]
for i=0, num-n-1 do begin &$
   dloc=[dloc,median(nbmd5[i : i+n-1])] &$
   med=[med,median(ewd5[i : i+n-1])] &$
   p05=[p05,percentiles(ewd5[i : i+n-1],value=0.0005)] &$
endfor
cgplot,dloc,med,thick=4,color=get_colour_by_name('orange'),/overplot
cgplot,dloc,p05,thick=4,color=get_colour_by_name('orange'),/overplot
res=linfit(dloc[where(dloc gt 23)],p05[where(dloc gt 23)])
dum1=[0,dloc[where(dloc gt 23)]]
dum2=[res[1]*23.0+res[0],res[1]*dloc[where(dloc gt 23)]+res[0]]
dum3=[-1*res[1]*23.0+(2*median(med)-res[0]),-1*res[1]*dloc[where(dloc gt 23)]+(2*median(med)-res[0])]
cgplot,dum1,dum2,thick=4,color=get_colour_by_name('gray'),/overplot 
cgplot,dum1,dum3,thick=4,color=get_colour_by_name('gray'),/overplot 

;;;;;;;;
;cgplot,jj,ew_limit,color=get_colour_by_name('red'),/overplot

;cgerrplot,j,lp,md+(md-lp),color=get_colour_by_name('green')

;for i=0,18 do cgplot, j,lp,color=get_colour_by_name('green'),/overplot
;for i=0,18 do cgplot, j,md+(md-lp),color=get_colour_by_name('green'),/overplot
cgplot,[18,mag527],[108,108],thick=4,linestyle=2,color=get_colour_by_name('green4'),/overplot
device,/close

device,filename=name2+'BV.eps',/encap,/color; B-V vs Equivalent width
plotsym,0,0.2,/fill
cgplot,bm[id5]-vm[id5],ew[id5],psym=sym(0),charsize=1.5,thick=4,xr=[-0.5,2.5],xthick=3,ythick=3,yr=[-200,1500],xstyle=1,ystyle=1,xtitle='B - V ',ytitle='Observed EW [Angstrom]' ;,title='Observed equivalent width 5sigma'
cgplot,bm[id66]-vm[id66],ew[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,bm[id77]-vm[id77],ew[id77],psym=sym(1),color=get_colour_by_name('blue'),/overplot
;cgplot,bm[id88]-vm[id88],ew[id88],psym=sym(1),color=get_colour_by_name('green4'),/overplot
cgplot,[0.48,0.48],[-200, 2000],color=get_colour_by_name('green4'),thick=4,/overplot
;cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot
cgplot,[0.48,5],[108, 108],color=get_colour_by_name('green4'),thick=4,linestyle=2,/overplot

device,/close

device,filename=name2+'ewwmag2_2.eps',/encap,/color ;IB527 vs Equivalent width
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
device,filename=name2+'nbm_err_2.eps',/encap,/color ; Equivalent width vs error
plotsym,0,0.2,/fill
cgplot,nbm[id5],ewer[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,30],xstyle=1,xtitle='nbm ',ytitle='Error ',title='Observed equivalent width 5sigma'
device,/close
device,filename=name2+'eww_aper_2.eps',/encap,/color ;IB527 vs Equivalent width
plotsym,0,0.2,/fill
cgplot,nb1[id5],ew[id5],psym=sym(18),charsize=1.5,thick=4,xr=[15,28],yr=[-200,600],xstyle=1,xtitle='IB527',ytitle='EW (Angstrom)',title='Observed equivalent width'
cgplot,nb1[id66],ew[id66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nb1[id7],ew[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot

device,/close


device,filename=name2+'auto_aper_2.eps',/encap,/color ;IB527 vs IB527_aper
plotsym,0,0.2,/fill
cgplot,nbm,nbm-nb3,psym=sym(18),charsize=1.5,thick=4,xr=[22,28],yr=[-1,1],ystyle=1,xstyle=1,xtitle='IB527',ytitle='Auto - Aper(9.6 pix Diameter)',title='Auto mag vs Aperture mag'
;cgplot,nbm[id6],nbm[id6]-nb1[id6],psym=sym(1),color=get_colour_by_name('red'),/overplot
cgplot,nbm[id9],nbm[id9]-nb3[id9],psym=sym(1),color=get_colour_by_name('blue'),/overplot
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot

device,/close
device,filename=name2+'err.eps_2',/encap,/color ;IB527 vs Error
plotsym,0,0.2,/fill
cgplot,nbm[id5],nbmer[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,30],yr=[0,0.2],xstyle=1,xtitle='IB527_auto ',ytitle='Error'
cgplot,[mag527,mag527],[-2000,2000],color=get_colour_by_name('brown'),/overplot
device,/close
device,filename=name2+'errv_2.eps',/encap,/color ;V vs Error
plotsym,0,0.2,/fill
cgplot,vm[id5],vmer[id5],psym=sym(0),charsize=1.5,thick=4,xr=[18,30],yr=[0,0.2],xstyle=1,xtitle='V_auto ',ytitle='Error'
cgplot,[vlim,vlim],[-2000,2000],color=get_colour_by_name('brown'),/overplot
device,/close

;Working with r band image
idr=where(rm le rlim )
ra_r=r.x_world
dec_r=r.y_world
matchcat,ra66,dec66,ra_r,dec_r,in66,inr_66,DT=0.5
ntdet=indgen(n_elements(id66))
remove,in66,ntdet
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra66[in66]],[dec66[in66]]],'LAE_R.reg_2','red','2.0'
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',[[ra66[ntdet]],[dec66[ntdet]]],'LAE_R_ntdet.reg_2','blue','2.0'
coordfk5,'~/UKIDSS/subaru/ukidss_subR.fits',[[ra_r],[dec_r]],'All_R_2.reg','blue','2.0'


ra66_nt=ra66[ntdet]
dec66_nt=dec66[ntdet]
vm66_nt=vm66[ntdet]
bm66_nt=bm66[ntdet]
ew66_nt=ew66[ntdet]
nbm66_nt=nbm66[ntdet]
nbf3_66_nt=nbf3_66[ntdet]

nbfa3er_66_nt=nbfa3er_66[ntdet]
vmer66_nt=vmer66[ntdet]
nbmer66_nt=nbmer66[ntdet]
bmer66_nt=bmer66[ntdet]
umer66_nt=umer66[ntdet]
ewer66_nt=ewer66[ntdet]





openw,lun1,name2+name3+'.nt.cat',/get_lun
printf,lun1, 'RA'
printf,lun1, 'DEC'
printf,lun1, 'U[auto]'
printf,lun1, 'Uerr'
printf,lun1, 'B[auto]'
printf,lun1, 'Berr'
printf,lun1, '527[auto]'
printf,lun1, '527err'
printf,lun1, 'V[auto]'
printf,lun1, 'Verr'
printf,lun1, 'R[auto]'
printf,lun1, 'Rerr'
printf,lun1, 'EW'
printf,lun1, 'EW_err'
printf,lun1, '527AperFlux'
printf,lun1, '527fluxerr' 
printf,lun1,'LineFlux/TotalFlux_in527'
for i=0, n_elements(ntdet)-1 do printf,lun1, ra66_nt[i],dec66_nt[i],ulim, -1, bm66_nt[i],bmer66_nt[i], nbm66_nt[i],nbmer66_nt[i], vm66_nt[i], vmer66_nt[i], -1,-1,ew66_nt[i],ewer66_nt[i],nbf3_66_nt[i],nbfa3er_66_nt[i],ew66_nt[i]/(ew66_nt[i]+245.7), format='(17f20.6)' 
free_lun,lun1


;Making stamps

fxread,'~/UKIDSS/subaru/mosaic_R.fits',im_r,hr
extast,hr,astr_r
rant=ra66[ntdet]
decnt=dec66[ntdet]
ad2xy, rant,decnt, astr_r, x_r, y_r
spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0'
spawn,'rm -f /Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/*.fits'
;spawn,'rm -r -f /Volumes/MacintoshHD2/supcam/quilt/stampsR/*'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsR/flag0'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsR/flag_lt3'
for i=0, n_elements(x_r)-1 do begin
hextract,im_r,hr,new2im_r,new2hr,x_r[i]-39,x_r[i]+39,y_r[i]-39,y_r[i]+39
name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant[i],format='(f7.4)')+string(decnt[i],format='(f7.4)')+'ntR.fits',/remove_all)
writefits,name,new2im_r,new2hr
endfor
rar=ra66[in66]
decr=dec66[in66]
ad2xy, rar,decr, astr_r, x_r, y_r
for i=0, n_elements(x_r)-1 do begin
hextract,im_r,hr,new2im_r,new2hr,x_r[i]-39,x_r[i]+39,y_r[i]-39,y_r[i]+39
name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rar[i],format='(f7.4)')+string(decr[i],format='(f7.4)')+'dtR.fits',/remove_all)
writefits,name,new2im_r,new2hr
endfor
xnt=x66[ntdet]
ynt=y66[ntdet]
rant2=ra66[ntdet]
decnt2=dec66[ntdet]
;flg_nt=flg66[ntdet]
;nbf_nt=nbf66[ntdet]
;nbf3_nt=nbf3_66[ntdet]
;nbfa3er_nt=nbfa3er_66[ntdet]
;vm66_nt=vm66[ntdet]
;device,filename='fl_2.eps',/encap,/color 
;plotsym,0,0.2,/fill
;cgplot,nbf_nt,nbf_nt-nbf3_nt,psym=sym(1),xr=[600,5000],charsize=1.5,thick=4,xtitle='Auto flux ',ytitle='Auto-Aper flux'
;cgplot,[-300,5000],[5.*signb,5.*signb],color=get_colour_by_name('brown'),/overplot
;device,/close
;spawn,'rm -r -f /Volumes/MacintoshHD2/supcam/quilt/stamps527/*'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stamps527/flag0'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stamps527/flag_lt3'
for i=0, n_elements(xnt)-1 do begin
   hextract,im527,h527,new2im527,new2h527,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant2[i],format='(f7.4)')+string(decnt2[i],format='(f7.4)')+'nt527.fits',/remove_all)
   writefits,name,new2im527,new2h527
endfor
xdt=x66[in66]
ydt=y66[in66]
radt=ra66[in66]
decdt=dec66[in66]
for i=0, n_elements(xdt)-1 do begin
   hextract,im527,h527,new2im527,new2h527,xdt[i]-70,xdt[i]+70,ydt[i]-70,ydt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(radt[i],format='(f7.4)')+string(decdt[i],format='(f7.4)')+'dt527.fits',/remove_all)
   writefits,name,new2im527,new2h527
endfor
;spawn,'rm -r -f /Volumes/MacintoshHD2/supcam/quilt/stampsApt527/*'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsApt527/flag0'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsApt527/flag_lt3'
fxread,'/Volumes/MacintoshHD2/supcam/quilt/Apt527_2.fits',imapt,hapt
extast,hapt,astr_apt
for i=0, n_elements(xnt)-1 do begin
   hextract,imapt,hapt,new2imapt,new2hapt,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant2[i],format='(f7.4)')+string(decnt2[i],format='(f7.4)')+'nt527Apt.fits',/remove_all)
   writefits,name,new2imapt,new2hapt
endfor
for i=0, n_elements(xdt)-1 do begin
   hextract,imapt,hapt,new2imapt,new2hapt,xdt[i]-70,xdt[i]+70,ydt[i]-70,ydt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(radt[i],format='(f7.4)')+string(decdt[i],format='(f7.4)')+'dt527Apt.fits',/remove_all)
   writefits,name,new2imapt,new2hapt
endfor
;spawn,'rm -r -f /Volumes/MacintoshHD2/supcam/quilt/stampsV/*'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsV/flag0'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsV/flag_lt3'
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.V.1.fits',imv,hv
for i=0, n_elements(xnt)-1 do begin
   hextract,imv,hv,new2im,new2h,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant2[i],format='(f7.4)')+string(decnt2[i],format='(f7.4)')+'ntV.fits',/remove_all)
   writefits,name,new2im,new2h
endfor
for i=0, n_elements(xdt)-1 do begin
   hextract,imv,hv,new2im,new2h,xdt[i]-70,xdt[i]+70,ydt[i]-70,ydt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(radt[i],format='(f7.4)')+string(decdt[i],format='(f7.4)')+'dtV.fits',/remove_all)
   writefits,name,new2im,new2h
endfor
;spawn,'rm -r -f /Volumes/MacintoshHD2/supcam/quilt/stampsB/*'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsB/flag0'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsB/flag_lt3'
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.B.1.fits',imb,hb
for i=0, n_elements(xnt)-1 do begin
   hextract,imb,hb,new2im,new2h,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant2[i],format='(f7.4)')+string(decnt2[i],format='(f7.4)')+'ntB.fits',/remove_all)
   writefits,name,new2im,new2h
endfor
for i=0, n_elements(xdt)-1 do begin
   hextract,imb,hb,new2im,new2h,xdt[i]-70,xdt[i]+70,ydt[i]-70,ydt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(radt[i],format='(f7.4)')+string(decdt[i],format='(f7.4)')+'dtB.fits',/remove_all)
   writefits,name,new2im,new2h
endfor
;spawn,'rm -r -f /Volumes/MacintoshHD2/supcam/quilt/stampsU/*'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsU/flag0'
;spawn,'mkdir /Volumes/MacintoshHD2/supcam/quilt/stampsU/flag_lt3'
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',imu,hu
for i=0, n_elements(xnt)-1 do begin
   hextract,imu,hu,new2im,new2h,xnt[i]-70,xnt[i]+70,ynt[i]-70,ynt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant2[i],format='(f7.4)')+string(decnt2[i],format='(f7.4)')+'ntU.fits',/remove_all)
   writefits,name,new2im,new2h
endfor
for i=0, n_elements(xdt)-1 do begin
   hextract,imu,hu,new2im,new2h,xdt[i]-70,xdt[i]+70,ydt[i]-70,ydt[i]+70
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(radt[i],format='(f7.4)')+string(decdt[i],format='(f7.4)')+'dtU.fits',/remove_all)
   writefits,name,new2im,new2h
endfor

fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',im383,h383
extast,h383,astr
ad2xy, rant2, decnt2, astr, xnt3, ynt3
for i=0, n_elements(xnt3)-1 do begin
   hextract,im383,h383,new2im,new2h,xnt3[i]-29,xnt3[i]+29,ynt3[i]-29,ynt3[i]+29
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(rant2[i],format='(f7.4)')+string(decnt2[i],format='(f7.4)')+'nt383.fits',/remove_all)
   writefits,name,new2im,new2h
endfor
ad2xy, radt, decdt, astr, xdt3, ydt3
for i=0, n_elements(xdt3)-1 do begin
   hextract,im383,h383,new2im,new2h,xdt3[i]-29,xdt3[i]+29,ydt3[i]-29,ydt3[i]+29
   name=strcompress('/Volumes/MacintoshHD2/supcam/quilt/'+name2+'flag0/'+string(radt[i],format='(f7.4)')+string(decdt[i],format='(f7.4)')+'dt383.fits',/remove_all)
   writefits,name,new2im,new2h
endfor

;Plotting 
matchcat,ra5,dec5,ra_r,dec_r,in5,inr5,DT=0.5
ra66_2=ra66[in66]
dec66_2=dec66[in66]
um5_2=um5[in5]
vm5_2=vm5[in5]
vm66_2=vm66[in66]
bm66_2=bm66[in66]
rm66_2=rm[inr_66]
rm_2=rm[inr5]
ew66_2=ew66[in66]
nbm66_2=nbm66[in66]
u3_2=u3_5[in5]
nbf3_66_2=nbf3_66[in66]

ra66_nt=ra66[ntdet]
dec66_nt=dec66[ntdet]
vm66_nt=vm66[ntdet]
bm66_nt=bm66[ntdet]
ew66_nt=ew66[ntdet]
nbm66_nt=nbm66[ntdet]
nbf3_66_nt=nbf3_66[ntdet]

nbfa3er_66_nt=nbfa3er_66[ntdet]
vmer66_nt=vmer66[ntdet]
nbmer66_nt=nbmer66[ntdet]
bmer66_nt=bmer66[ntdet]
umer66_nt=umer66[ntdet]
ewer66_nt=ewer66[ntdet]

idu0=where(u3_2 le ulim and rm_2 le rlim)
idu1=where(u3_2 gt ulim )
um66_2=um66[in66]
u366_2=u366[in66]
b366_2=b366[in66]

nbfa3er_66_2=nbfa3er_66[in66]
vmer66_2=vmer66[in66]
nbmer66_2=nbmer66[in66]
bmer66_2=bmer66[in66]
umer66_2=umer66[in66]
ewer66_2=ewer66[in66]
rmer66_2=rmer[inr_66]
idu2=where(u366_2 gt ulim and rm66_2 gt rlim )
rm66_2[idu2]=rlim
rmer66_2[idu2]=-1
idb1= where(b366_2 gt blim)
bm66_2[idb1]=blim
bmer66_2[idb1]=-1
;idu3=where(u366_2 le ulim and rm66_2 le rlim)
idu4=where(u366_2 gt ulim and rm66_2 le rlim )
;idu5=where(u366_2 le ulim and rm66_2 gt rlim)
; idbv0=where(bm66_2-vm66_2 lt 0.4)
;idbv1=where(bm66_2-vm66_2 ge 0.4)

;vm66_3=vm66_2[idbv0]
;bm66_3=bm66_2[idbv0]
;rm66_3=rm66_2[idbv0]
;ew66_3=ew66_2[idbv0]
;nbm66_3=nbm66_2[idbv0]
;um66_3=um66_2[idbv0]
openw,lun0,name2+name3+'.cat',/get_lun
printf,lun0, 'RA'
printf,lun0, 'DEC'
printf,lun0, 'U[auto]'
printf,lun0, 'Uerr'
printf,lun0, 'B[auto]'
printf,lun0, 'Berr'
printf,lun0, '527[auto]'
printf,lun0, '527err'
printf,lun0, 'V[auto]'
printf,lun0, 'Verr'
printf,lun0, 'R[auto]'
printf,lun0, 'Rerr'
printf,lun0, 'EW'
printf,lun0, 'EW_err'
printf,lun0, '527AperFlux'
printf,lun0, '527fluxerr' 
printf,lun0,'LineFlux/TotalFlux_in527'
for i=0, n_elements(in66)-1 do printf,lun0, ra66_2[i],dec66_2[i],ulim, -1, bm66_2[i],bmer66_2[i], nbm66_2[i],nbmer66_2[i], vm66_2[i], vmer66_2[i], rm66_2[i],rmer66_2[i],ew66_2[i],ewer66_2[i],nbf3_66_2[i],nbfa3er_66_2[i],ew66_2[i]/(ew66_2[i]+245.7), format='(17f20.6)' 
free_lun,lun0
openw,lun1,name2+name3+'.nt.cat',/get_lun
printf,lun1, 'RA'
printf,lun1, 'DEC'
printf,lun1, 'U[auto]'
printf,lun1, 'Uerr'
printf,lun1, 'B[auto]'
printf,lun1, 'Berr'
printf,lun1, '527[auto]'
printf,lun1, '527err'
printf,lun1, 'V[auto]'
printf,lun1, 'Verr'
printf,lun1, 'R[auto]'
printf,lun1, 'Rerr'
printf,lun1, 'EW'
printf,lun1, 'EW_err'
printf,lun1, '527AperFlux'
printf,lun1, '527fluxerr' 
printf,lun1,'LineFlux/TotalFlux_in527'
for i=0, n_elements(ntdet)-1 do printf,lun1, ra66_nt[i],dec66_nt[i],ulim, -1, bm66_nt[i],bmer66_nt[i], nbm66_nt[i],nbmer66_nt[i], vm66_nt[i], vmer66_nt[i], -1,-1,ew66_nt[i],ewer66_nt[i],nbf3_66_nt[i],nbfa3er_66_nt[i],ew66_nt[i]/(ew66_nt[i]+245.7), format='(17f20.6)' 
free_lun,lun1
;device,filename=name2+'eww_ur.eps',/encap,/color ;V-R vs U-V
 ;  cgplot,vm5_2[idu0]-rm_2[idu0],um5_2[idu0]-vm5_2[idu0],psym=sym(0),charsize=1.5,thick=4,xr=[-1.5,2],yr=[-1,5],xstyle=1,ystyle=1,xtitle='V[auto]-R[auto] ',ytitle='U[auto]-V[auto]'
 ;  cgplot,vm66_2[idu3]-rm66_2[idu3],um66_2[idu3]-vm66_2[idu3],psym=sym(1),color=get_colour_by_name('red'),/overplot
  ; plotsym,2,0.8,/fill
   ;cgplot,vm66_2[idu4]-rm66_2[idu4],ulim-vm66_2[idu4],psym=8,color=get_colour_by_name('blue'),/overplot
   ;plotsym,6,0.8,/fill
   ;cgplot,vm66_2[idu2]-rlim,ulim-vm66_2[idu2],psym=8,color=get_colour_by_name('brown'),/overplot
   ;plotsym,2,0.8,/fill
   ;cgplot,vm66_2[idu2]-rlim,ulim-vm66_2[idu2],psym=8,color=get_colour_by_name('blue'),/overplot
   ;plotsym,6,0.8,/fill
   ;cgplot,vm66_2[idu5]-rlim,um66_2[idu5]-vm66_2[idu5],psym=8,color=get_colour_by_name('brown'),/overplot

   ;cgplot,vm5_2[idu1]-rm_2[idu1],ulim-vm5_2[idu1],psym=8,color=get_colour_by_name('blue'),/overplot

;device,/close
;device,filename=name2+'eww1_22.eps',/encap,/color ; IB527-V vs B-IB527 for dt objects
;plotsym,0,0.2,/fill
;cgplot,nbm[id5]-vm[id5],bm[id5]-nbm[id5],psym=sym(0),xr=[-3,1],yr=[-1,4],xtitle='IB527-V',ytitle='B-IB527',xstyle=1,thick=4,charsize=1.5
;cgplot,xx,yy ,color=get_colour_by_name('red'),/overplot
;cgplot,nbm66[in66]-vm66[in66],bm66[in66]-nbm66[in66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7]-vm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

;device,/close

;device,filename=name2+'eww1_222.eps',/encap,/color ; B-V vs V-IB527 for dt objects
;plotsym,0,0.2,/fill
;cgplot,bm[id5]-vm[id5],vm[id5]-nbm[id5],psym=sym(0),xr=[-1,3],yr=[-1,1.5],xtitle='B-V',ytitle='V-IB527',xstyle=1,thick=4,charsize=1.5
;cgplot,xx,yy ,color=get_colour_by_name('red'),/overplot
;cgplot,bm66[in66]-vm66[in66],vm66[in66]-nbm66[in66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;cgplot,nbm[id7]-vm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

;device,/close
;device,filename=name2+'eww1_2222.eps',/encap,/color ; IB527 vs V-IB527 for dt objects
;plotsym,0,0.2,/fill
;cgplot,nbm[id5],vm[id5]-nbm[id5],psym=sym(0),xr=[20,28],yr=[-1,1.5],xtitle='IB527',ytitle='V-IB527',xstyle=1,thick=4,charsize=1.5
;cgplot,xx,yy ,color=get_colour_by_name('red'),/overplot
;cgplot,nbm66[in66],vm66[in66]-nbm66[in66],psym=sym(1),color=get_colour_by_name('red'),/overplot
;xall=nbm66[in66]
;yall=vm66[in66]-nbm66[in66]
;bmvall=bm66[in66]-vm66[in66]
;load_ct,13
;oplot,xall[where(bmvall lt 0.4)],yall[where(bmvall lt 0.4)],color=70,psym=4
;cgplot,nbm[id7]-vm[id7],bm[id7]-nbm[id7],psym=sym(1),color=get_colour_by_name('blue'),/overplot

;device,/close

set_plot,'x'
stop

end
