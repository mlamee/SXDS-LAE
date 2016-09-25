pro col
readcol, '/Volumes/MacintoshHD2/supcam/astroref3.cat',id,ra0,dec0,u,g, r, i, z
;readcol, '/Volumes/MacintoshHD2/supcam/astroref6.txt',ra0,dec0,u, g, r, i, z
readcol,'~/Downloads/CFHTLS/CFHTfilters.txt',lam,p,skipline=2
readcol, '~/Downloads/smoka/MITCCDs/NB527.txt',lam527, p527,skipline=22
lu=3551
lg=4686
lr=6165
li=7481
readcol,'~/Downloads/CFHTLS/u.filter',lamu,pu
lu=int_tabulated(lamu,lamu*pu,/double)/int_tabulated(lamu,pu,/double)
print,lu
readcol,'~/Downloads/CFHTLS/g.filter.res',lamg,pg
lg=int_tabulated(lamg,lamg*pg,/double)/int_tabulated(lamg,pg,/double)
print,lg
readcol,'~/Downloads/CFHTLS/r.filter.res',lamr,pr
lr=int_tabulated(lamr,lamr*pr,/double)/int_tabulated(lamr,pr,/double)
print,lr
readcol,'~/Downloads/CFHTLS/i.filter.res',lami,pi
li=int_tabulated(lami,lami*pi,/double)/int_tabulated(lami,pi,/double)
print,li
x=[lu,lg,lr,li]
name=['black','blue','green','red','brown']
set_plot,'ps'
device,file='ccalib.eps',/encap,/color
;plot,lam,p*30,charsize=1.5,thick=1.50,xtitle='wavelength',ytitle='Mag'
plot,lam[0:2700],p[0:2700]*30,charsize=1.5,thick=1.50,xtitle='Wavelength (' +cgsymbol('Angstrom') + ')',ytitle='Mag',xr=[3d3,9d3],xstyle=1
oplot,lam527,p527*30,color=get_colour_by_name('purple')
for j=200,1000,200 do begin

y=[u[j],g[j],r[j],i[j]]
res=linfit(x,y,yfit=yy)
oplot,x,y,psym=sym(j/200),color=get_colour_by_name(name[j/200-1])
oplot,lam,res[1]*lam+res[0],color=get_colour_by_name(name[j/200-1])
endfor
device,/close

set_plot,'x'

stop
readcol,'~/Downloads/CFHTLS/u.filter',lamu,pu
flu=int_tabulated(lamu,lamu*pu,/double)/int_tabulated(lamu,pu,/double)
print,flu
readcol,'~/Downloads/CFHTLS/g.filter.res',lamg,pg
flg=int_tabulated(lamg,lamg*pg,/double)/int_tabulated(lamg,pg,/double)
print,flg
readcol,'~/Downloads/CFHTLS/r.filter.res',lamr,pr
flr=int_tabulated(lamr,lamr*pr,/double)/int_tabulated(lamr,pr,/double)
print,flr
readcol,'~/Downloads/CFHTLS/u.filter.res',lamu,pu
fli=int_tabulated(lami,lami*pi,/double)/int_tabulated(lami,pi,/double)
print,fli
end
