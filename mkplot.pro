pro mkplot
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
set_plot,'ps'

position=[0.,0.,1.,1.]
fxread,'0-34.6390-5.50941dt383.fits',im,h
im[where(im eq -12000)]=-20
device,filename='test.eps',/encap,/color,xsize=12,ysize=12
TVIMAGE,im,bytscl(im,min=0,max=10),/KEEP_ASPECT_RATIO
plot,dindgen(161),dindgen(161),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=0,position=position
tvcircle,4.36,80,80,/data,thick=3, color=get_colour_by_name('green')
;tvcircle,0.2/pixelsize,x_c,y_c,/data,thick=3,color='red'
;tvcircle,0.2/pixelsize,x0,y0,/data,thick=3,color='blue'
cgtext,20,140,'IB383',charsize=3.0,charthick=3,/data, color='green'
device, /close
spawn,'open test.eps'
set_plot, 'x'

end
