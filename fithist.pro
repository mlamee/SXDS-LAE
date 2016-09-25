;This routine fits a Gaussian to the left side of the out histogram of
;randphot.pro 
pro fithist
close,/all
readcol,'fluxVV.txt',fluxv1,errv1,fluxv2,errv2,fluxv3,errv3,skipline=3
readcol,'fluxBB.txt',fluxb1,errb1,fluxb2,errb2,fluxb3,errb3,skipline=3
readcol,'flux527527.txt',fluxib1,errib1,fluxib2,errib2,fluxib3,errib3,skipline=3
readcol,'fluxU.txt',fluxu1,erru1,fluxu2,erru2,fluxu3,erru3,skipline=3

;readcol,'test.txt',fluxib1,errib1,fluxib2,errib2,fluxib3,errib3,skipline=3
readcol,'flux383383.txt',fluxnb1,errnb1,fluxnb2,errnb2,fluxnb3,errnb3,skipline=3
readcol,'flux383new.txt',fluxnew1,errnew1,fluxnew2,errnew2,fluxnew3,errnew3,skipline=3
openw,1,'sig.txt'
openw,2,'mag.txt'
;for V band

 v3=histogram(fluxv3,min=-1000,max=1000,binsize=40,locations=locv3)
locv3=locv3+20.
 v2=histogram(fluxv2,min=-500,max=1000,binsize=16,locations=locv2)
locv2=locv2+8
 v1=histogram(fluxv1,min=-500,max=1000,binsize=12,locations=locv1)
locv1=locv1+6
; for B
 b3=histogram(fluxb3,min=-1000,max=1000,binsize=30,locations=locb3)
locb3=locb3+15
 b2=histogram(fluxb2,min=-500,max=1000,binsize=10,locations=locb2)
locb2=locb2+5
 b1=histogram(fluxb1,min=-500,max=1000,binsize=8,locations=locb1)
locb1=locb1+4
; for 527
 ib3=histogram(fluxib3,min=-1000,max=1000,binsize=20,locations=locib3)
locib3=locib3+10
 ib2=histogram(fluxib2,min=-500,max=1000,binsize=8,locations=locib2)
locib2=locib2+4
 ib1=histogram(fluxib1,min=-500,max=1000,binsize=8,locations=locib1)
locib1=locib1+4
; for U
 u3=histogram(fluxu3,min=-1000,max=1000,binsize=20,locations=locu3)
locu3=locu3+10
 u2=histogram(fluxu2,min=-500,max=1000,binsize=8,locations=locu2)
locu2=locu2+4
 u1=histogram(fluxu1,min=-500,max=1000,binsize=8,locations=locu1)
locu1=locu1+4
; for original 383
 nb3=histogram(fluxnb3,min=-50,max=50,binsize=4,locations=locnb3)
locnb3=locnb3+2
 nb2=histogram(fluxnb2,min=-50,max=50,binsize=4,locations=locnb2)
locnb2=locnb2+2
 nb1=histogram(fluxnb1,min=-50,max=50,binsize=4,locations=locnb1)
locnb1=locnb1+2
;for new 383
 nbnew3=histogram(fluxnew3,min=-1000,max=1000,binsize=13,locations=locnbnew3)
locnbnew3=locnbnew3+6
 nbnew2=histogram(fluxnew2,min=-500,max=1000,binsize=13,locations=locnbnew2)
locnbnew2=locnbnew2+6
 nbnew1=histogram(fluxnew1,min=-500,max=1000,binsize=13,locations=locnbnew1)
locnbnew1=locnbnew1+6

maxv3=max(v3,inv3)
maxv2=max(v2,inv2)
maxv1=max(v1,inv1)

maxu3=max(u3,inu3)
maxu2=max(u2,inu2)
maxu1=max(u1,inu1)

maxb3=max(b3,inb3)
maxb2=max(b2,inb2)
maxb1=max(b1,inb1)

maxib3=max(ib3,inib3)
maxib2=max(ib2,inib2)
maxib1=max(ib1,inib1)

maxnb3=max(nb3,innb3)
maxnb2=max(nb2,innb2)
maxnb1=max(nb1,innb1)

maxnbnew3=max(nbnew3,innbnew3)
maxnbnew2=max(nbnew2,innbnew2)
maxnbnew1=max(nbnew1,innbnew1)
yv3=gaussfit(locv3[0:inv3],v3[0:inv3],cov3,nterms=3)
yv2=gaussfit(locv2[0:inv2],v2[0:inv2],cov2,nterms=3)
yv1=gaussfit(locv1[0:inv1],v1[0:inv1],cov1,nterms=3)

yu3=gaussfit(locu3[0:inu3],u3[0:inu3],cou3,nterms=3)
yu2=gaussfit(locu2[0:inu2],u2[0:inu2],cou2,nterms=3)
yu1=gaussfit(locu1[0:inu1],u1[0:inu1],cou1,nterms=3)


yb3=gaussfit(locb3[0:inb3],b3[0:inb3],cob3,nterms=3)
yb2=gaussfit(locb2[0:inb2],b2[0:inb2],cob2,nterms=3)
yb1=gaussfit(locb1[0:inb1],b1[0:inb1],cob1,nterms=3)

yib3=gaussfit(locib3[0:inib3],ib3[0:inib3],coib3,nterms=3)
yib2=gaussfit(locib2[0:inib2],ib2[0:inib2],coib2,nterms=3)
yib1=gaussfit(locib1[0:inib1],ib1[0:inib1],coib1,nterms=3)

ynb3=gaussfit(locnb3[0:innb3],nb3[0:innb3],conb3,nterms=3)
ynb2=gaussfit(locnb2[0:innb2],nb2[0:innb2],conb2,nterms=3)
ynb1=gaussfit(locnb1[0:innb1],nb1[0:innb1],conb1,nterms=3)

ynbnew3=gaussfit(locnbnew3[0:innbnew3],nbnew3[0:innbnew3],conbnew3,nterms=3)
ynbnew2=gaussfit(locnbnew2[0:innbnew2],nbnew2[0:innbnew2],conbnew2,nterms=3)
ynbnew1=gaussfit(locnbnew1[0:innbnew1],nbnew1[0:innbnew1],conbnew1,nterms=3)

sv3=cov3[2]
sv2=cov2[2]
sv1=cov1[2]

su3=cou3[2]
su2=cou2[2]
su1=cou1[2]


sb3=cob3[2]
sb2=cob2[2]
sb1=cob1[2]

sib3=coib3[2]
sib2=coib2[2]
sib1=*coib1[2]

snb3=conb3[2]
snb2=conb2[2]
snb1=conb1[2]

snbnew3=2*SQRT(2*ALOG(2))*conbnew3[2]
snbnew2=2*SQRT(2*ALOG(2))*conbnew2[2]
snbnew1=2*SQRT(2*ALOG(2))*conbnew1[2]
printf,1,' The 3 apertures used to get the sigma are 1 , 1.5 and 2 times FWHM of the image. For Subaru B and V I used [2.53, 3.8, 5.06] pixels for radius. For U band [3.36, 5.05, 6.72] and for IB527 [2.4, 3.6, 4.8], For the LFC LyC image: [2.18,3.27, 4.36] pixels' 
printf,1, 'sigma_Aper1    ' ,'  sigma_Aper2    ' ,'  sigma_Aper3    '
set_plot,'ps'
device,filename='vv.ps',/color,/encap
plot,locv1,v1,xr=[-1000,1000],yr=[0,1800],psym=10
oplot,locv1,yv1,color=get_colour_by_name('red')
oplot,locv3,v3,color=get_colour_by_name('orange'),psym=10
oplot,locv3,yv3,color=get_colour_by_name('red')
oplot,locv2,v2,color=get_colour_by_name('blue'),psym=10
oplot,locv2,yv2,color=get_colour_by_name('red')
print,'sig v1= ',sv1, ' sigv2= ',sv2,' sigv3= ',sv3
printf,1,'V  ', sv1, sv2 ,sv3
device,/close
device,filename='u.ps',/color,/encap
plot,locu1,u1,xr=[-1000,1000],yr=[0,1800],psym=10
oplot,locu1,yu1,color=get_colour_by_name('red')
oplot,locu3,u3,color=get_colour_by_name('orange'),psym=10
oplot,locu3,yu3,color=get_colour_by_name('red')
oplot,locu2,u2,color=get_colour_by_name('blue'),psym=10
oplot,locu2,yu2,color=get_colour_by_name('red')
print,'sig u1= ',su1, ' sigu2= ',su2,' sigu3= ',su3
printf,1,'u  ', su1, su2 ,su3
device,/close
device,filename='bb.ps',/color,/encap
plot,locb1,b1,xr=[-1000,1000],yr=[0,1800],psym=10
oplot,locb1,yb1,color=get_colour_by_name('red')
oplot,locb3,b3,color=get_colour_by_name('orange'),psym=10
oplot,locb3,yb3,color=get_colour_by_name('red')
oplot,locb2,b2,color=get_colour_by_name('blue'),psym=10
oplot,locb2,yb2,color=get_colour_by_name('red')
print,'sig b1= ',sb1, ' sigb2= ',sb2,' sigb3= ',sb3
printf,1,'B  ', sb1, sb2 ,sb3
device,/close
device,filename='ibb.ps',/color,/encap
plot,locib1,ib1,xr=[-1000,1000],yr=[0,1000],psym=10
oplot,locib1,yib1,color=get_colour_by_name('red')
oplot,locib3,ib3,color=get_colour_by_name('orange'),psym=10
oplot,locib3,yib3,color=get_colour_by_name('red')
oplot,locib2,ib2,color=get_colour_by_name('blue'),psym=10
oplot,locib2,yib2,color=get_colour_by_name('red')
print,'sig ib1= ',sib1, ' sigib2= ',sib2,' sigib3= ',sib3
printf,1,'ib  ', sib1, sib2 ,sib3
device,/close
device,filename='nbb.ps',/color,/encap
plot,locnb1,nb1,xr=[-50,50],yr=[0,1000],psym=10
oplot,locnb1,ynb1,color=get_colour_by_name('red')
oplot,locnb3,nb3,color=get_colour_by_name('orange'),psym=10
oplot,locnb3,ynb3,color=get_colour_by_name('red')
oplot,locnb2,nb2,color=get_colour_by_name('blue'),psym=10
oplot,locnb2,ynb2,color=get_colour_by_name('red')
print,'sig nb1= ',snb1, ' signb2= ',snb2,' signb3= ',snb3
printf,1,'nb  ', snb1, snb2 ,snb3
device,/close
printf,2,' These are 5 sigma detection limit in each image for 3 apertures [1, 1.5, 2]*FWHM'
printf,2,'        Mag1           Mag2         Mag3'
printf,2, 'sigib ',-2.5*alog10(5*sib1)+33.6880,-2.5*alog10(5*sib2)+33.6880,-2.5*alog10(5*sib3)+33.6880
printf,2, 'sigb ',-2.5*alog10(5*sb1)+35.2590,-2.5*alog10(5*sb2)+35.2590,-2.5*alog10(5*sb3)+35.2590
printf,2, 'sigU ',-2.5*alog10(5*su1)+32.7402,-2.5*alog10(5*su2)+32.7402,-2.5*alog10(5*su3)+32.7402
printf,2, 'sigv ',-2.5*alog10(5*sv1)+35.4005,-2.5*alog10(5*sv2)+35.4005,-2.5*alog10(5*sv3)+35.4005
printf,2,'sig383 ',-2.5*alog10(5*snb1)+31.5187,-2.5*alog10(5*snb2)+31.5187,-2.5*alog10(5*snb3)+31.5187
;plothist, fluxv3,xhistv3,yhistv3,bin=100,xr=[-8000,15000]

;plothist, fluxv2,xhistv2,yhistv2,bin=70,color=get_colour_by_name('blue'),/overplot
;plothist,
;fluxv1,xhistv1,yhistv1,bin=50,color=get_colour_by_name('red'),/overplot
makepdf,'vv','vv'
makepdf,'u','u'
makepdf,'bb','bb'
makepdf,'ibb','ibb'
makepdf,'nbb','nbb'
set_plot,'X'
close,/all
end
