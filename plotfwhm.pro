pro fwplot
readcol, '/Volumes/MacintoshHD2/supcam/quilt/Bfwhmgood.dat',btag,brh,bstd, format='a,f,f'
readcol, '/Volumes/MacintoshHD2/supcam/quilt/Vfwhmgood.dat',vtag,vrh,vstd, format='a,f,f'
readcol, '/Volumes/MacintoshHD2/supcam/quilt/527fwhmgood.dat',ibtag,ibrh,ibstd, format='a,f,f'
readcol,'/Volumes/MacintoshHD2/starsLyc-only/383goodfwhm.dat',lyctag,nbrh,nbstd,format='a,f,f'
set_plot,'ps'
device,file='B-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(btag))+1
xerr=xx*0.
plot,xx,brh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='B band',thick=1.5,charsize=1.5
oploterror,xx,brh,xerr,bstd
device,/close
device,file='V-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(vtag))+1
xerr=xx*0.
plot,xx,vrh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='V band',thick=1.5,charsize=1.5
oploterror,xx,vrh,xerr,vstd
device,/close
device,file='IB527-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(ibtag))+1
xerr=xx*0.
plot,xx,ibrh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='IB527 band',thick=1.5,charsize=1.5
oploterror,xx,ibrh,xerr,ibstd
device,/close
device,file='IB383-FWHM-good.eps',/encap,/color
xx=indgen(n_elements(lyctag))+1
xerr=xx*0.
plot,xx,nbrh,psym=sym(2),xtitle='Index',ytitle='FWHM (ArcSec)',title='IB383 band',thick=1.5,charsize=1.5
oploterror,xx,nbrh,xerr,nbstd
device,/close
set_plot,'x'
stop
end
