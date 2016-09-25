;This routine fits a Gaussian to the left side of the out histogram of
;randphot.pro 
pro checksig
zp527=33.75
close,/all
readcol,'f_527_1.txt',flux1,err1,flux2,err2,flux3,err3,skipline=4
readcol,'f_527_2.txt',flux11,err11,flux22,err22,flux33,err33,skipline=4
readcol,'f_527_3.txt',flux111,err111,flux222,err222,flux333,err333,skipline=4
readcol,'f_527_4.txt',flux1111,err1111,flux2222,err2222,flux3333,err3333,skipline=4

readcol,'f_527_1.txt',r1,r2,r3,numline=1,format='(x,x,x,f5.2,f5.2,f5.2)'
readcol,'f_527_2.txt',r4,r5,r6,numline=1,format='(x,x,x,f5.2,f5.2,f5.2)'
readcol,'f_527_3.txt',r7,r8,r9,numline=1,format='(x,x,x,f5.2,f5.2,f5.2)'
readcol,'f_527_4.txt',r10,r11,r12,numline=1,format='(x,x,x,f5.2,f5.2,f5.2)'

openw,1,'sigcheck.txt'

; for 527
 ib33=histogram(flux33,min=-1000,max=1000,binsize=30,locations=locib33)
locib33=locib33+10
 ib22=histogram(flux22,min=-500,max=1000,binsize=20,locations=locib22)
locib22=locib22+4
 ib11=histogram(flux11,min=-500,max=1000,binsize=8,locations=locib11)
locib11=locib11+4
maxib33=max(ib33,inib33)
maxib22=max(ib22,inib22)
maxib11=max(ib11,inib11)
yib33=gaussfit(locib33[0:inib33],ib33[0:inib33],coib33,nterms=3)
yib22=gaussfit(locib22[0:inib22],ib22[0:inib22],coib22,nterms=3)
yib11=gaussfit(locib11[0:inib11],ib11[0:inib11],coib11,nterms=3)
sib33=coib33[2]
sib22=coib22[2]
sib11=coib11[2]

 ib3=histogram(flux3,min=-1000,max=1000,binsize=30,locations=locib3)
locib3=locib3+10
 ib2=histogram(flux2,min=-500,max=1000,binsize=20,locations=locib2)
locib2=locib2+4
 ib1=histogram(flux1,min=-500,max=1000,binsize=8,locations=locib1)
locib1=locib1+4
maxib3=max(ib3,inib3)
maxib2=max(ib2,inib2)
maxib1=max(ib1,inib1)
yib3=gaussfit(locib3[0:inib3],ib3[0:inib3],coib3,nterms=3)
yib2=gaussfit(locib2[0:inib2],ib2[0:inib2],coib2,nterms=3)
yib1=gaussfit(locib1[0:inib1],ib1[0:inib1],coib1,nterms=3)
sib3=coib3[2]
sib2=coib2[2]
sib1=coib1[2]


 ib333=histogram(flux333,min=-1000,max=1000,binsize=30,locations=locib333)
locib333=locib333+10
 ib222=histogram(flux222,min=-500,max=1000,binsize=20,locations=locib222)
locib222=locib222+4
 ib111=histogram(flux111,min=-500,max=1000,binsize=8,locations=locib111)
locib111=locib111+4
maxib333=max(ib333,inib333)
maxib222=max(ib222,inib222)
maxib111=max(ib111,inib111)
yib333=gaussfit(locib333[0:inib333],ib333[0:inib333],coib333,nterms=3)
yib222=gaussfit(locib222[0:inib222],ib222[0:inib222],coib222,nterms=3)
yib111=gaussfit(locib111[0:inib111],ib111[0:inib111],coib111,nterms=3)
sib333=coib333[2]
sib222=coib222[2]
sib111=coib111[2]


ib3333=histogram(flux3333,min=-1000,max=1000,binsize=30,locations=locib3333)
locib3333=locib3333+10
 ib2222=histogram(flux2222,min=-500,max=1000,binsize=20,locations=locib2222)
locib2222=locib2222+4
 ib1111=histogram(flux1111,min=-500,max=1000,binsize=8,locations=locib1111)
locib1111=locib1111+4
maxib3333=max(ib3333,inib3333)
maxib2222=max(ib2222,inib2222)
maxib1111=max(ib1111,inib1111)
yib3333=gaussfit(locib3333[0:inib3333],ib3333[0:inib3333],coib3333,nterms=3)
yib2222=gaussfit(locib2222[0:inib2222],ib2222[0:inib2222],coib2222,nterms=3)
yib1111=gaussfit(locib1111[0:inib1111],ib1111[0:inib1111],coib1111,nterms=3)
sib3333=coib3333[2]
sib2222=coib2222[2]
sib1111=coib1111[2]


printf,1,' Aperture radius' 
printf,1, r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12, format='(12(2x,F5.2))'
set_plot,'ps'
device,filename='ib1.eps',/color,/encap
plot,locib1,ib1,xr=[-400,500],yr=[0,800],charsize=1.5, thick=1.5,xstyle=1,ystyle=1,xtitle='Flux', ytitle='Number', title=strcompress('IB527_  '+string(r1)+'_'+string(r2)+'_'+string(r3),/remove_all),psym=10
oplot,locib1,yib1,color=get_colour_by_name('red')
oplot,locib3,ib3,color=get_colour_by_name('orange'),psym=10
oplot,locib3,yib3,color=get_colour_by_name('red')
oplot,locib2,ib2,color=get_colour_by_name('blue'),psym=10
oplot,locib2,yib2,color=get_colour_by_name('red')
device,/close
device,filename='ib2.eps',/color,/encap
plot,locib11,ib11,xr=[-400,500],yr=[0,800],charsize=1.5, thick=1.5,xstyle=1,ystyle=1,xtitle='Flux', ytitle='Number', title=strcompress('IB527_ '+string(r4)+'_'+string(r5)+'_'+string(r6),/remove_all),psym=10
oplot,locib11,yib11,color=get_colour_by_name('red')
oplot,locib33,ib33,color=get_colour_by_name('orange'),psym=10
oplot,locib33,yib33,color=get_colour_by_name('red')
oplot,locib22,ib22,color=get_colour_by_name('blue'),psym=10
oplot,locib22,yib22,color=get_colour_by_name('red')
device,/close
device,filename='ib3.eps',/color,/encap
plot,locib111,ib111,xr=[-400,500],yr=[0,800],charsize=1.5, thick=1.5,xstyle=1,ystyle=1,xtitle='Flux', ytitle='Number', title=strcompress('IB527_ '+string(r7)+'_'+string(r8)+'_'+string(r9),/remove_all),psym=10
oplot,locib111,yib111,color=get_colour_by_name('red')
oplot,locib333,ib333,color=get_colour_by_name('orange'),psym=10
oplot,locib333,yib333,color=get_colour_by_name('red')
oplot,locib222,ib222,color=get_colour_by_name('blue'),psym=10
oplot,locib222,yib222,color=get_colour_by_name('red')
device,/close
device,filename='ib4.eps',/color,/encap
plot,locib1111,ib1111,xr=[-400,500],yr=[0,800],charsize=1.5, thick=1.5,xstyle=1,ystyle=1,xtitle='Flux', ytitle='Number', title=strcompress('IB527_ '+string(r10)+'_'+string(r11)+'_'+string(r12),/remove_all),psym=10
oplot,locib1111,yib1111,color=get_colour_by_name('red')
oplot,locib3333,ib3333,color=get_colour_by_name('orange'),psym=10
oplot,locib3333,yib3333,color=get_colour_by_name('red')
oplot,locib2222,ib2222,color=get_colour_by_name('blue'),psym=10
oplot,locib2222,yib2222,color=get_colour_by_name('red')
device,/close
mag=[ -2.5*alog10(5*sib1)+zp527, -2.5*alog10(5*sib2)+zp527 ,-2.5*alog10(5*sib3)+zp527, -2.5*alog10(5*sib11)+zp527, -2.5*alog10(5*sib22)+zp527 ,-2.5*alog10(5*sib33)+zp527, -2.5*alog10(5*sib111)+zp527, -2.5*alog10(5*sib222)+zp527 ,-2.5*alog10(5*sib333)+zp527, -2.5*alog10(5*sib1111)+zp527, -2.5*alog10(5*sib2222)+zp527 ,-2.5*alog10(5*sib3333)+zp527]
r=[r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12]
N=!pi*r^2
sig=[ sib1, sib2 ,sib3, sib11, sib22 ,sib33, sib111, sib222 ,sib333, sib1111, sib2222 ,sib3333]
printf,1,'sig  ', sib1, sib2 ,sib3, sib11, sib22 ,sib33, sib111, sib222 ,sib333, sib1111, sib2222 ,sib3333, format='(a,12(2x,F6.2))'
printf,1,'5*sig_mag  ', -2.5*alog10(5*sib1)+zp527, -2.5*alog10(5*sib2)+zp527 ,-2.5*alog10(5*sib3)+zp527, -2.5*alog10(5*sib11)+zp527, -2.5*alog10(5*sib22)+zp527 ,-2.5*alog10(5*sib33)+zp527, -2.5*alog10(5*sib111)+zp527, -2.5*alog10(5*sib222)+zp527 ,-2.5*alog10(5*sib333)+zp527, -2.5*alog10(5*sib1111)+zp527, -2.5*alog10(5*sib2222)+zp527 ,-2.5*alog10(5*sib3333)+zp527, format='(a, 12(2x,F5.2))'
device,filename='sigcheck.eps',/encap,/color
plot,N[sort(r)],sig[sort(r)],xtitle='N',ytitle='sig',title='IB527',charsize=1.5, thick=1.5,psym=sym(3)
oplot,N[sort(r)],14.34*sqrt(N[sort(r)]),color=get_colour_by_name('blue')
device,/close


set_plot,'X'
close,/all
stop
end
