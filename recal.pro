function findcolor,c,x,color 
color=c[0]+c[1]*x+c[2]*x^2+c[3]*x^3+c[4]*x^4
return,color
end

function fit
readcol,'synthethic.mags',sdss_u,sdss_g,sdss_r,sdss_i,sup_u,sup_b,sup_527,sup_v,sup_r,nb383
id=where(sdss_g-sdss_r lt 0.7 and sdss_g-sdss_r gt -0.4)
gr=sdss_g[id]-sdss_r[id]
gb=sdss_g[id]-sup_b[id]
gb_model=-0.037-0.16*gr+0.009*gr^2-0.307*gr^3+0.246*gr^4
;print,gb-gb_model
Dgb=gb-gb_model
;plot,gr,Dgb,psym=sym(1),charsize=2,xtitle='g-r',ytitle='Delta (g-B)'
c=[-0.037,-0.16,0.009,-0.307,0.246]
;r = MPFITFUN('findcolor',gr, gb,error, c, cer, covar) ; reporoduce the best fit
cfitb=poly_fit(gr, gb,4,chisq=chisq,yfit=gb_fit, covar=covar,/double)
;oplot,gr,gb-gb_fit,psym=(1),color=240

; Calibrating V
id=where(sdss_g-sdss_r lt 0.8 and sdss_g-sdss_r gt -0.4)
gr=sdss_g[id]-sdss_r[id]
gv=sdss_g[id]-sup_v[id]
gv_model=0.038+0.565*gr-0.024*gr^2+0.26*gr^3-0.218*gr^4
;print,gv-gv_model
Dgv=gv-gv_model
;plot,gr,Dgv,psym=sym(1),charsize=2,xtitle='g-r',ytitle='Delta (g-V)'

;r = MPFITFUN('findcolor',gr, gb,error, c, cer, covar) ; reporoduce the best fit
cfitv=poly_fit(gr, gv,4,chisq=chisq,yfit=gv_fit, covar=covar,/double)
;oplot,gr,gv-gv_fit,psym=(1),color=240

; Calibrating 527
id=where(sdss_g-sdss_r lt 0.8 and sdss_g-sdss_r gt -0.4)
gr=sdss_g[id]-sdss_r[id]
gnb=sdss_g[id]-sup_527[id]
cfitnb=poly_fit(gr, gnb,4,chisq=chisq,yfit=gnb_fit, covar=covar,/double)

; Calibrating U
id=where(sdss_g-sdss_r lt 0.8 and sdss_g-sdss_r gt -0.4)
ug=sdss_u[id]-sdss_g[id]
uu=sdss_u[id]-sup_u[id]
cfitu=poly_fit(ug, uu,4,chisq=chisq,yfit=uu_fit, covar=covar,/double)

; Calibrating NB383
id=where(sdss_g-sdss_r lt 0.8 and sdss_g-sdss_r gt -0.4)
ug=sdss_u[id]-sdss_g[id]
u383=sdss_u[id]-nb383[id]
cfit383=poly_fit(ug, u383,4,chisq=chisq,yfit=u383_fit, covar=covar,/double)

c=fltarr(5,5)
c[0,*]=cfitb
c[1,*]=cfitv
c[2,*]=cfitnb
c[3,*]=cfitu
c[4,*]=cfit383
return,c
end


pro makemag
close,/all
;Reading LFC NB383
readcol,'~/Downloads/smoka/MITCCDs/NB383.txt',l383, t383, skipline=1100, numline=172
l383=l383*10.
t383=t383/max(t383)
id383=sort(l383)
l383=l383[id383]
t383=t383[id383]
readcol,'~/Dropbox/Research/LFCQE.csv',lfc,qelfc
lfc=lfc*10.0
qelfc=qelfc/100.0
idlfc=sort(lfc)
lfc=lfc[idlfc]
qelfc=qelfc[idlfc]
; Multipltying all LFC QE
qe383=interpol(qelfc,lfc,l383,/nan)
tt383=qe383*t383


;Reading Subaru filters
readcol,'~/Downloads/smoka/MITCCDs/Usubaru.dat',lu,tu,skipline=1
idu=sort(lu)
lu=lu[idu]
tu=tu[idu]
readcol,'~/Downloads/smoka/MITCCDs/V.txt',lv,tv
readcol,'~/Downloads/smoka/MITCCDs/NB527.txt',l527,t527
idv=sort(lv)
lv=lv[idv]
tv=tv[idv]

id527=sort(l527)
l527=l527[id527]
t527=t527[id527]
readcol,'~/Downloads/smoka/MITCCDs/Rc.txt',lrs,trs
readcol,'~/Downloads/smoka/MITCCDs/B.txt',lb,tb
idrs=sort(lrs)
lrs=lrs[idrs]
trs=trs[idrs]
idb=sort(lb)
lb=lb[idb]
tb=tb[idb]
;reading Subaru telescope responses
readcol,'~/Downloads/smoka/MITCCDs/focus.txt',lfoc,foc
idfoc=sort(lfoc)
lfoc=lfoc[idfoc]
foc=foc[idfoc]
readcol,'~/Downloads/smoka/MITCCDs/primarymirror.txt',lprim,prim
prim=prim*10.0
idprim=sort(lprim)
lprim=lprim[idprim]
prim=prim[idprim]
readcol,'~/Downloads/smoka/MITCCDs/oldccd.dat',lccd,qe
idccd=sort(lccd)
lccd=lccd[idccd]
qe=qe[idccd]

; Multipltying all Subaru responses
qeu=interpol(qe,lccd,lu,/nan)
primu=interpol(prim,lprim,lu,/nan)
focu=interpol(foc,lfoc,lu,/nan)
tu=qeu*primu*focu*tu

qeb=interpol(qe,lccd,lb,/nan)
primb=interpol(prim,lprim,lb,/nan)
focb=interpol(foc,lfoc,lb,/nan)
tb=qeb*primb*focb*tb

qer=interpol(qe,lccd,lrs,/nan)
primr=interpol(prim,lprim,lrs,/nan)
focr=interpol(foc,lfoc,lrs,/nan)
trs=qer*primr*focr*trs

qev=interpol(qe,lccd,lv,/nan)
primv=interpol(prim,lprim,lv,/nan)
focv=interpol(foc,lfoc,lv,/nan)
tv=qev*primv*focv*tv

qe527=interpol(qe,lccd,l527,/nan)
prim527=interpol(prim,lprim,l527,/nan)
foc527=interpol(foc,lfoc,l527,/nan)
t527=qe527*prim527*foc527*t527
;Reading SLOAN filters
readcol,'~/Downloads/SDSS/SDSSfilters.new',lams,su,sg,sr,si,sz,air
; Pivot wavelength of the filters
lsg=sqrt(int_tabulated(lams,lams*sg)/int_tabulated(lams,sg/lams))
lsr=sqrt(int_tabulated(lams,lams*sr)/int_tabulated(lams,sr/lams))
lsu=sqrt(int_tabulated(lams,lams*su)/int_tabulated(lams,su/lams))
lsi=sqrt(int_tabulated(lams,lams*si)/int_tabulated(lams,si/lams))

lfb=sqrt(int_tabulated(lb,lb*tb)/int_tabulated(lb,tb/lb))
lf527=sqrt(int_tabulated(l527,l527*t527)/int_tabulated(l527,t527/l527))
lfv=sqrt(int_tabulated(lv,lv*tv)/int_tabulated(lv,tv/lv))
lfu=sqrt(int_tabulated(lu,lu*tu)/int_tabulated(lu,tu/lu))
lfrs=sqrt(int_tabulated(lrs,lrs*trs)/int_tabulated(lrs,trs/lrs))

lf383=sqrt(int_tabulated(l383,l383*tt383)/int_tabulated(l383,tt383/l383))

spawn,'ls ~/softwares/synphotlib/bpgs/*.ascii > bpgs.list'
;Reading BPGS stellar library from Synphot, Units are Ang and Flam
readcol,'bpgs.list',name,format='(a)'
get_lun,lun
openw,lun,'synthethic.mags'
printf,lun,'# These are SDSS, Palomar/LFC and Subaru (SupCam) synthetic AB magnitudes of BPGS stellar library '
printf,lun,' SDSS_u     SDSS_g     SDSS_r     SDSS_i    U    B     IB527    V      R     NB383'
for i=0,n_elements(name)-1 do begin
   readcol,name[i],lam,flam
   ;calculating SDSS mags
   flam2=interpol(flam,lam,lams,/nan)
   sdss_u=int_tabulated(lams,flam2*su*lams,/double)/int_tabulated(lams,su*lams,/double)
   sdss_g=int_tabulated(lams,flam2*sg*lams,/double)/int_tabulated(lams,sg*lams,/double)
   sdss_i=int_tabulated(lams,flam2*si*lams,/double)/int_tabulated(lams,si*lams,/double)
   sdss_r=int_tabulated(lams,flam2*sr*lams,/double)/int_tabulated(lams,sr*lams,/double)
   ;calculating SupCam mags
   fu=interpol(flam,lam,lu,/nan)
   sup_u=int_tabulated(lu,fu*tu*lu,/double)/int_tabulated(lu,tu*lu,/double)
   fb=interpol(flam,lam,lb,/nan)
   sup_b=int_tabulated(lb,fb*tb*lb,/double)/int_tabulated(lb,tb*lb,/double)
   f527=interpol(flam,lam,l527,/nan)
   sup_527=int_tabulated(l527,f527*t527*l527,/double)/int_tabulated(l527,t527*l527,/double)
   fv=interpol(flam,lam,lv,/nan)
   sup_v=int_tabulated(lv,fv*tv*lv,/double)/int_tabulated(lv,tv*lv,/double)
   frs=interpol(flam,lam,lrs,/nan)
   sup_r=int_tabulated(lrs,frs*trs*lrs,/double)/int_tabulated(lrs,trs*lrs,/double)
   ;Palomar/LFC mag
   f383=interpol(flam,lam,l383,/nan)
   lfc_383=int_tabulated(l383,f383*tt383*l383,/double)/int_tabulated(l383,tt383*l383,/double)

   sdss_g=-2.5*alog10(sdss_g)-5.0*alog10(lsg)-2.406
   sdss_r=-2.5*alog10(sdss_r)-5.0*alog10(lsr)-2.406
   sdss_u=-2.5*alog10(sdss_u)-5.0*alog10(lsu)-2.406
   sdss_i=-2.5*alog10(sdss_i)-5.0*alog10(lsi)-2.406

   sup_b=-2.5*alog10(sup_b)-5.0*alog10(lfb)-2.406
   sup_527=-2.5*alog10(sup_527)-5.0*alog10(lf527)-2.406
   sup_v=-2.5*alog10(sup_v)-5.0*alog10(lfv)-2.406
   sup_r=-2.5*alog10(sup_r)-5.0*alog10(lfrs)-2.406
   sup_u=-2.5*alog10(sup_u)-5.0*alog10(lfu)-2.406

   lfc_383=-2.5*alog10(lfc_383)-5.0*alog10(lf383)-2.406

   printf,lun,sdss_u,sdss_g,sdss_r,sdss_i,sup_u,sup_b,sup_527,sup_v,sup_r,lfc_383,format='(10f9.2)'
endfor
free_lun,lun
close,/all
stop
end

pro recal
readcol,'sdssdr8.csv',objid,run,rerun,camcol,field,obj,type,ra0,dec0,u,g,r,i,z,Err_u,Err_g,Err_r,Err_i,Err_z
id=where(type eq 6 and i le 22)
ra0=ra0[id]
dec0=dec0[id]
u=u[id]
g=g[id]
r=r[id]
i=i[id]
z=z[id]
type=type[id]


readcol,'/Volumes/MacintoshHD2/supcam/quilt/sig.txt',skipline=2,filter,ap1,ap2,ap3,format='(a,f,f,f)'
sigv=ap1[0]
sigb=ap1[2]
signb=ap1[3]
sig383=ap1[4]
sigu=ap1[1]
b=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Bsingle.fits',1)
bm=b.mag_auto
f=b.flags
bf=b.flux_auto
xb=b.x_image-1
yb=b.y_image-1
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.B.1.fits',datab,headerb,/nodata
extast,headerb,astrb
xy2ad, xb, yb, astrb, rab, decb

nb=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_527single.fits',1)
nbm=nb.mag_auto
fnb=nb.flags
nbf=nb.flux_auto
xnb=nb.x_image-1
ynb=nb.y_image-1
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.527.1.fits',datanb,headernb,/nodata
extast,headernb,astrnb
xy2ad, xnb, ynb, astrnb, ranb, decnb
rmnb=where( nbf lt 5.0*signb)
remove,rmnb,ranb
remove,rmnb,decnb
remove,rmnb,nbm
remove,rmnb,nbf


v=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Vsingle.fits',1)
vm=v.mag_auto
fv=v.flags
vf=v.flux_auto
xv=v.x_image-1
yv=v.y_image-1

fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.V.1.fits',datav,headerv,/nodata
extast,headerv,astrv
xy2ad, xv, yv, astrv, rav, decv
rmv=where( vf lt 5.0*sigv)
remove,rmv,rav
remove,rmv,decv
remove,rmv,vm
remove,rmv,vf

su=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Unew2.fits',1)
um=su.mag_auto
fu=su.flags
uf=su.flux_auto
xu=su.x_image-1
yu=su.y_image-1

fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',datau,headeru,/nodata
extast,headeru,astru
xy2ad, xu, yu, astru, rau, decu
rmu=where( uf lt 5.0*sigu)
remove,rmu,rau
remove,rmu,decu
remove,rmu,um
remove,rmu,uf


nb3=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_383new.fits',1)
nb3m=nb3.mag_auto
fnb3=nb3.flags
nb3f=nb3.flux_auto
xnb3=nb3.x_image-1
ynb3=nb3.y_image-1

fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.NB383.1.fits',datanb3,headernb3,/nodata
extast,headernb3,astrnb3
xy2ad, xnb3, ynb3, astrnb3, ranb3, decnb3
rmnb3=where( nb3f lt 5.0*sig383)
remove,rmnb3,ranb3
remove,rmnb3,decnb3
remove,rmnb3,nb3m
remove,rmnb3,nb3f


gr=g-r
ug=u-g
rm=where(ra0 ge 34.8 or ra0 le 34.25 or dec0 le -5.6 or dec0 gt -5.08 or gr gt 0.7 or gr lt -0.4 )
remove,rm,ra0
remove,rm,dec0
remove,rm,g
remove,rm,r
remove,rm,u
remove,rm,gr
remove,rm,ug
;rm2=where(f ne 0)
;remove,rm2,rab
;remove,rm2,decb
;remove,rm2,bm
;remove,rm2,bf
mn=median(bm)
sigma=stddev(bm)
rm3=where(bf lt 5.*sigb)
if n_elements(rm3) gt 1 then begin 
   remove,rm3,rab
   remove,rm3,decb
   remove,rm3,bm
   remove,rm3,bf
endif

coordfk5,'OBJECT.527.1.fits',[[ra0],[dec0]],'SDSSRA0DEC0recal0.reg','red','2.5'
matchcat,ra0,dec0,rab,decb,in0,in,DT=1
print, 'in0 ',n_elements(in0)
coordfk5,'OBJECT.527.1.fits',[[rab],[decb]],'BrecalAll.reg','green','2'
coordfk5,'OBJECT.527.1.fits',[[rab[in]],[decb[in]]],'Brecal.reg','green','2'
rab1=rab[in]
decb1=decb[in]
bm1=bm[in]
bf1=bf[in]

ra01=ra0[in0]
dec01=dec0[in0]
g01=g[in0]
u01=u[in0]
r01=r[in0]
gr01=gr[in0]

;matching with V
matchcat,ra01,dec01,rav,decv,in01,inv,DT=1
ra02=ra01[in01]
dec02=dec01[in01]
g02=g01[in01]
r02=r01[in01]
u02=u01[in01]
gr02=gr01[in01]

rab2=rab1[in01]
decb2=decb1[in01]
bm2=bm1[in01]
bf2=bf1[in01]

rav2=rav[inv]
decv2=decv[inv]
vm2=vm[inv]
vf2=vf[inv]

c=fit()
cb=c[0,*]
cv=c[1,*]
cnb=c[2,*]
cu=c[3,*]
c383=c[4,*]

gb_model=cb[0]+cb[1]*gr02+cb[2]*gr02^2+cb[3]*gr02^3+cb[4]*gr02^4
gv_model=cv[0]+cv[1]*gr02+cv[2]*gr02^2+cv[3]*gr02^3+cv[4]*gr02^4

Gbo=g02-bm2
b_model=g02-gb_model
ccb=b_model-bm2
gvo=g02-vm2
v_model=g02-gv_model
ccv=v_model-vm2
plot,gr02,gbo-gb_model,psym=sym(1),xtitle='g-r',ytitle=textoidl('(g-B)_{obs}-(g-B)_{model}'),title=textoidl('Red: (g-V)_{obs}-(g-V)_{model}'),charsize=1.5,yr=[-0.5,0.5]
oplot,gr02,gvo-gv_model,psym=sym(1),color=get_colour_by_name('red')

;id=where(abs(gbo-gb_model) le 0.3 and abs(gvo-gv_model) le 0.3)

;gbo3=gbo[id]
;b_model3=b_model[id]
;gvo3=gvo[id]
;v_model3=v_model[id]
;ccv3=ccv[id]
;vvb3=ccb[id]
;vm3=vm2[id]
;bm3=bm2[id]
;rav3=rav2[id]
;decv3=decv2[id]
;coordfk5,'OBJECT.527.1.fits',[[rav3],[decv3]],'Vrecalbad.reg','yellow','3'
id1=where(vm2 gt 19 and v_model-vm2 gt -0.1)
id2=where(bm2 gt 19 and b_model-bm2 gt -0.2)
;coordfk5,'OBJECT.527.1.fits',[[rav2[id1]],[decv2[id1]]],'Vrecaloff.reg','red','3'
plot,v_model[id1],v_model[id1]-vm2[id1],charsize=1.5,psym=sym(1),xtitle=textoidl('V_{model}'),ytitle=textoidl('V_{mod}-V_{obs}')
plot,b_model[id2],b_model[id2]-bm2[id2],charsize=1.5,psym=sym(1),xtitle=textoidl('B_{model}'),ytitle=textoidl('B_{mod}-B_{obs}')

;Start from the begining: Matching with NB527
matchcat,ra0,dec0,ranb,decnb,in00,inn,DT=1
print, 'in0 ',n_elements(in0)
ranb1=ranb[inn]
decnb1=decnb[inn]
nbm1=nbm[inn]
nbf1=nbf[inn]

ra001=ra0[in00]
dec001=dec0[in00]
g001=g[in00]
u001=u[in00]
r001=r[in00]
gr001=gr[in00]

;matching with V
matchcat,ra001,dec001,rav,decv,in001,inv0,DT=1
ra002=ra001[in001]
dec002=dec001[in001]
g002=g001[in001]
r002=r001[in001]
u002=u001[in001]
gr002=gr001[in001]

ranb2=ranb1[in001]
decnb2=decnb1[in001]
nbm2=nbm1[in001]
nbf2=nbf1[in001]

rav02=rav[inv0]
decv02=decv[inv0]
vm02=vm[inv0]
vf02=vf[inv0]

;Start from the begining: Matching with U
matchcat,ra0,dec0,rau,decu,inu0,inu,DT=1
rau1=rau[inu]
decu1=decu[inu]
um1=um[inu]
uf1=uf[inu]

ra0u=ra0[inu0]
dec0u=dec0[inu0]
g0u=g[inu0]
u0u=u[inu0]
r0u=r[inu0]
gr0u=gr[inu0]
ug0u=ug[inu0]

;Start from the begining: Matching with NB383
matchcat,ra0,dec0,ranb3,decnb3,in30,innb3,DT=1
ranb31=ranb3[innb3]
decnb31=decnb3[innb3]
nb3m1=nb3m[innb3]
nb3f1=nb3f[innb3]

ra03=ra0[in30]
dec03=dec0[in30]
g03=g[in30]
u03=u[in30]
r03=r[in30]
gr03=gr[in30]
ug03=ug[in30]


gnb_model=cnb[0]+cnb[1]*gr002+cnb[2]*gr002^2+cnb[3]*gr002^3+cnb[4]*gr002^4
gv0_model=cv[0]+cv[1]*gr002+cv[2]*gr002^2+cv[3]*gr002^3+cv[4]*gr002^4
uu_model=cu[0]+cu[1]*ug0u+cu[2]*ug0u^2+cu[3]*ug0u^3+cu[4]*ug0u^4
u383_model=c383[0]+c383[1]*ug03+c383[2]*ug03^2+c383[3]*ug03^3+c383[4]*ug03^4

unb3o=u03-nb3m1
nb3_model=u03-u383_model

uuo=u0u-um1
u_model=u0u-uu_model

Gnbo=g002-nbm2
nb_model=g002-gnb_model
ccnb=nb_model-nbm2
gvo0=g002-vm02
v0_model=g002-gv0_model
ccv0=v0_model-vm02

plot,gr002,gnbo-gnb_model,psym=sym(1),xtitle='g-r',ytitle=textoidl('(g-527)_{obs}-(g-527)_{model}'),title=textoidl('Red: (g-V)_{obs}-(g-V)_{model}'),charsize=1.5,thick=4,yr=[-0.5,0.5]
oplot,gr002,gvo0-gv0_model,psym=sym(1),color=get_colour_by_name('red')

id=where(nb_model gt 19 and nb_model-nbm2 gt -0.1)
plot,nb_model, nb_model-nbm2,xtitle=textoidl('527_{model}'),ytitle=textoidl('527_{mod}-527_{obs}'),charsize=1.5,psym=sym(1),xr=[18,22],yr=[-0.3,0.3],ystyle=1

plot,u_model, u_model-um1,xtitle=textoidl('U_{model}'),ytitle=textoidl('U_{mod}-U_{obs}'),charsize=1.5,psym=sym(1);,xr=[18,22],yr=[-0.3,0.3],ystyle=1
idu=where(u_model gt 17.5 and u_model lt 20.5)
plot,u_model[idu], u_model[idu]-um1[idu],xtitle=textoidl('U_{model}'),ytitle=textoidl('U_{mod}-U_{obs}'),charsize=1.5,psym=sym(1),xr=[17.5,21.5],yr=[-0.3,0.3],ystyle=1


plot,nb3_model, nb3_model-nb3m1,xtitle=textoidl('NB383_{model}'),ytitle=textoidl('NB383_{mod}-NB383_{obs}'),charsize=1.5,psym=sym(1),xr=[16,22],yr=[-1,1],ystyle=1
id383=where(nb3_model gt 16 and nb3_model lt 20.5)
plot,nb3_model[id383], nb3_model[id383]-nb3m1[id383],xtitle=textoidl('NB383_{model}'),ytitle=textoidl('NB383_{mod}-NB383_{obs}'),charsize=1.5,psym=sym(1)
stop
end


pro testew
readcol,'/Users/mehdi/Dropbox/Research/SupCam/new/BVge0.4_err/BVge0.4_err.cat',RA,DEC,U,Uerr,B,Berr,nb,nberr,V,Verr,R,Rerr,EW,EWerr,nba,nbaerr,Lfratio
delnb=245d
delv=984d
ff=(ew+delnb)/(delnb+ew*(delnb/delv))
ff2=1.056*ff
ff3=0.946*ff
ew2=delnb*(ff2-1)/(1-ff2*(delnb/delv))
ew3=delnb*(ff3-1)/(1-ff3*(delnb/delv))

plot,ew,ew2-ew,psym=sym(1),charsize=1.5,xtitle=textoidl('EW'),ytitle=textoidl('\deltaEW') 
stop
end
