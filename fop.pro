pro fop
readcol,'fop.list',id,ras,raser,decs,decser,date,g,r,i,pm1,pm2
gr=g-r
ri=r-i
pm=sqrt(pm1^2+pm2^2)
fxread,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',im,h
u=mrdfits('/Volumes/MacintoshHD2/supcam/quilt/CAT_Unew2.fits',1,hu)
x=u.x_image-1
y=u.y_image-1
extast,h,astr

xy2ad,x,y,astr,ra,dec
readcol,'/Volumes/MacintoshHD2/supcam/astroref-u.txt',ra2,dec2,u2,g2,r2,i2,z2
matchcat,ras,decs,ra2,dec2,ins,in2,DT=0.5
ra2=ra2[in2]
dec2=dec2[in2]
ras=ras[ins]
decs=decs[ins]
pm=pm[ins]
r=r[ins]
;set_plot,'ps'
;device,filename='AST-SDSS.eps',/color,/encap
;plot,r,3600.0*sqrt((ra-ras)^2+(dec-decs)^2),psym=sym(1),xtitle='r band',title='SDSS', ytitle='Distance [arc-sec]',charsize=1.5, thick=1.5
;device,/close
;matchcat,ra2,dec2,ra,dec,in2,in,DT=0.5
;ra2=ra2[in2]
;r2=r2[in2]
;dec2=dec2[in2]
;ra=ra[in]
;dec=dec[in]
;pm=pm[in]
;coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ra],[dec]],'fop_u.reg','blue','2.0'
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ra2],[dec2]],'fop_CFHT.reg','green','2.0'
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ras],[decs]],'fop_SDSS.reg','blue','2.0'

dd=3600.0*sqrt((ra-ra2)^2+(dec-dec2)^2)
ind=where(dd gt 0.1)
;coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ra[ind]],[dec[ind]]],'fop_largedd.reg','yellow','2.0'
;coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ra2[ind]],[dec2[ind]]],'fop_largedd_cfht.reg','blue','2.0'


;device,filename='AST.eps',/color,/encap
;plot,r2,3600.0*sqrt((ra-ra2)^2+(dec-dec2)^2),psym=sym(1),xtitle='r band',title='CFHT', ytitle='Distance [arc-sec]',charsize=1.5, thick=1.5
;device,/close


set_plot,'x'
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ras],[decs]],'fop_sdss.reg','red','1.0'


stop
end

pro fop2
readcol,'fop_correct.list',ra,dec
readcol,'fop.list',id,ras,raser,decs,decser,date,g,r,i;,pm1,pm2
matchcat,ra,dec,ras,decs,in,ins,DT=0.4
r=r[ins]
g=g[ins]
ras=ras[ins]
decs=decs[ins]

id=sort(r[ins])
r=r[ins]
r=r[id]
g=g[id]
ras=ras[id]
decs=decs[id]
ra3=ra[id]
dec3=dec[id]
ra4=ra
dec4=dec
remove,id,ra4
remove,id,dec4
ra5=[ra3,ra4]
dec5=[dec3,dec4]
;openw,1,'FOP_final.list'
;ras=ras[ins2]
;raser=raser[ins2]
;decs=decs[ins2]
;decser=decser[ins2]
;date=date[ins2]
;g=g[ins2]
;r=r[ins2]
;i=i[ins2]
;pm1=pm1[ins2]
;pm2=pm2[ins2]
;pm=pm[ins2]
;ri=ri[ins2]
;gr=gr[ins2]
;printf,1, 'RA  RAer   DEC     DECer    DATE      g     r     i      pmRA     pmDEC      PM       r-i        g-r'   
;for ins2=0, n_elements(in0)-1 do printf,1, ras[ins2],raser[ins2], decs[ins2],decser[ins2],date[ins2],g[ins2],r[ins2],i[ins2],pm1[ins2],pm2[ins2],pm[ins2],ri[ins2],gr[ins2], Format='(f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x,f15.5, 3x)'
close,/all
coordfk5,'/Volumes/MacintoshHD2/supcam/quilt/OBJECT.Unew2.1.fits',[[ra3],[dec3]],'fop_correct.reg','blue','2.0'

hh=fix(ra3/15)
mm=fix((ra3-(hh*15.))*60./15.)
ss=(ra3-(hh*15.+mm*15./60.))*3600./15.
;print,hh,mm,ss
dd=fix(dec3)
mmd=fix(-(dec3-dd)*60)
ssd=-(dec3-(dd-mmd/60.0))*3600.0
openw,lun,'FOP.hydra',/get_lun
for i=0,n_elements(ra3)-1 do printf,lun,hh[i],mm[i],ss[i],dd[i],mmd[i],ssd[i],'F',r[i], format='(I02,1x,I02,1x,f6.3,1x,I02,1x,I02,1x,f6.3,1x,a,1x,f5.2)'
free_lun,lun



stop
end
