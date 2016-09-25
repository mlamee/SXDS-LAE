pro pros
readcol,'radec.lst',ra,dec
set_plot,'ps'
device,file='~/Dropbox/proposal/figure1b.eps',/encap,/color
plot, [0], [0],psym=sym(6), xtitle='RA [Degrees]',ytitle='DEC [Degrees]',xstyle=1,ystyle=1,thick=5,charsize=3,xr=[34.3,34.7],yr=[-5.63,-5.15]
oplot, ra,dec,psym=sym(5),color=get_colour_by_name('blue')
device,/close
set_plot,'x'
end
