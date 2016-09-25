pro figurebv
!p.font = 1
!p.thick = 3
!x.thick = 2
!y.thick = 2
!z.thick = 2
;readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listUu',nameU,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listBb',nameB,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listVv',nameV,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listNBv',nameNB,format='a'
;readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listLCc',nameLC,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listR',nameR,format='a'

;badA=[1,7,8,11,19,44,48,54,62,70,72,73]

;nameU=nameU[badA]
;nameB=nameB[badA]
;nameV=nameV[badA]
;nameNB=nameNB[badA]
;nameLC=nameLC[badA]

;remove,badA,nameU
;remove,badA,nameB
;remove,badA,nameV
;remove,badA,nameNB
;remove,badA,nameLC
set_plot,'ps'
pos=0.
pos1=[0.,0.,1.,1.]
for k=0,n_elements(nameR)-1,8 do begin &$

   str=strtrim(string(k),1) &$
   print,str &$
   device,filename='/Users/mehdi/Dropbox/Research/SupCam/Aftermove/epsBVNB/Figure3_'+str+'.eps',/encap,xsize=12.6,ysize=29 &$
   for hh=0+k,7+k,1 do begin &$
      if hh gt n_elements(nameR)-1 then break &$
      h=hh &$
      if n_elements(nameR)- k lt 8 then h=hh+8-( n_elements(nameR)- k) &$
      dir='/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/' &$
      ;print,nameu[hh] &$
      ;u=mrdfits(dir+nameu[hh]) &$
      b=mrdfits(dir+nameb[hh]) &$
      r0=mrdfits(dir+namer[hh]) &$
      nb=mrdfits(dir+namenb[hh]) &$
      ;lc=mrdfits(dir+namelc[hh]) &$

      ;stdu=stddev(u[where(u gt -100. and u lt 100)]) &$
      stdnb=stddev(nb[where(nb gt -100 and nb lt 100)]) &$
      stdb=stddev(b[where(b gt -100. and b lt 100)]) &$
      stdr=stddev(r0[where(r0 gt -100. and r0 lt 100)]) &$
      ;stdlc=stddev(lc[where(lc gt -100.and lc lt 100)]) &$
      loadct,0 &$
      ;tvimage_t,bytscl(-lc,min=mean(lc[where(lc gt -100. and nb lt 100.)])-3.*stdlc,max=mean(lc[where(lc gt -100. and nb lt 100.)])+3.*stdlc ),position=[0.01,(0.01+0.17*(h-k))*0.71+0.02, 0.2, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
      
      ;plot,dindgen(fix(sqrt(n_elements(lc)))),dindgen(fix(sqrt(n_elements(lc)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.01,(0.01+0.17*(h-k))*0.71+0.02, 0.2, (0.2+0.17*(h-k))*0.71] &$
      ;d=(fix(sqrt(n_elements(lc)))-1)/2 &$
      ;r=21.15/sqrt(n_elements(lc))  &$ ;pixel size in arc-sec &$
      ;rr=0.7/r &$
      ;tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
      ;!p.thick = 7 &$
      ;xyouts, 1200,28000,'IB383',charsize=2,charthick=7,color=get_colour_by_name('white'),/device &$
      ;!p.thick = 3 &$
      ;xyouts, 1200,28000,'IB383',charsize=2,charthick=3,color=get_colour_by_name('green'),/device
      ;loadct,0 &$
      ;tvimage_t,bytscl(-u,min=mean(u[where(u gt -100. and nb lt 100.)])-3.*stdu,max=mean(u[where(u gt -100. and nb lt 100.)])+3.*stdu),position=[0.2,(0.01+0.17*(h-k))*0.71+0.02, 0.39, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
     ; plot,dindgen(fix(sqrt(n_elements(u)))),dindgen(fix(sqrt(n_elements(u)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.2,(0.01+0.17*(h-k))*0.71+0.02, 0.39, (0.2+0.17*(h-k))*0.71]
      ;d=(fix(sqrt(n_elements(u)))-1)/2 &$
      ;r=21.15/sqrt(n_elements(u)) &$ ;pixel size in arc-sec 
      ;rr=0.7/r
      ;tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
      ; xyouts, 5200,28000,'U',charsize=2,color=get_colour_by_name('white'),/device &$
       ;xyouts, 5200,28000,'U',charsize=2,color=get_colour_by_name('green'),/device
       loadct,0 &$
      tvimage_t,bytscl(-b,min=mean(b[where(b gt -100. and nb lt 100.)])-3.*stdb,max=mean(b[where(b gt -100. and nb lt 100.)])+3.*stdb),position=[0.01,(0.01+0.17*(h-k))*0.71+0.02, 0.32, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
     plot,dindgen(fix(sqrt(n_elements(b)))),dindgen(fix(sqrt(n_elements(b)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.01,(0.01+0.17*(h-k))*0.71+0.02, 0.32, (0.2+0.17*(h-k))*0.71] &$
      d=(fix(sqrt(n_elements(b)))-1)/2 &$
      r=21.15/sqrt(n_elements(b)) &$ ;pixel size in arc-sec
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
xyouts, 1200,28000,'B',charsize=2,color=get_colour_by_name('white'),/device &$
      ;xyouts, 9200,28000,'B',charsize=2,color=get_colour_by_name('green'),/device
       loadct,0 &$
      ; if k eq 56 and h eq 58 then stop
      tvimage_t,bytscl(-nb,min=mean(nb[where(nb gt -100. and nb lt 100.)])-3.*stdnb,max=mean(nb[where(nb gt -100. and nb lt 100.)])+3.*stdnb),position=[0.33,(0.01+0.17*(h-k))*0.71+0.02, 0.65, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
       plot,dindgen(fix(sqrt(n_elements(b)))),dindgen(fix(sqrt(n_elements(b)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.33,(0.01+0.17*(h-k))*0.71+0.02, 0.65, (0.2+0.17*(h-k))*0.71] &$
      d=(fix(sqrt(n_elements(b)))-1)/2 &$
      r=21.15/sqrt(n_elements(b)) &$;pixel size in arc-sec
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
            xyouts, 5200,28000,'IB527',charsize=2,color=get_colour_by_name('white'),/device &$

     ; xyouts, 13200,28000,'IB527',charsize=2,color=get_colour_by_name('green'),/device
       loadct,0 &$
      tvimage_t,bytscl(-r0,min=median(r0[where(r0 gt -100. and nb lt 100.)])-3.*stdr,max=median(r0[where(r0 gt -100. and nb lt 100.)])+3.*stdr),position=[0.66,(0.01+0.17*(h-k))*0.71+0.02, 0.99, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
      plot,dindgen(fix(sqrt(n_elements(r0)))),dindgen(fix(sqrt(n_elements(r0)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.66,(0.01+0.17*(h-k))*0.71+0.02, 0.99, (0.2+0.17*(h-k))*0.71] &$
      d=(fix(sqrt(n_elements(r0)))-1)/2 &$
      r=21.15/sqrt(n_elements(r0)) &$ ;pixel size in arc-sec
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
            xyouts, 9200,28000,'R',charsize=2,CHARTHICK=3,color=get_colour_by_name('white'),/device &$

     ; xyouts, 17200,28000,'V',charsize=2,CHARTHICK=3,color=get_colour_by_name('green'),/device
       loadct,0 &$
   endfor &$
   device,/close &$

   endfor

stop
end





pro figure
!p.font = 1
!p.thick = 3
!x.thick = 2
!y.thick = 2
!z.thick = 2
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listUu',nameU,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listBb',nameB,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listVv',nameV,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listNBv',nameNB,format='a'
readcol,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/listLCc',nameLC,format='a'
;badA=[1,7,8,11,19,44,48,54,62,70,72,73]

;nameU=nameU[badA]
;nameB=nameB[badA]
;nameV=nameV[badA]
;nameNB=nameNB[badA]
;nameLC=nameLC[badA]

;remove,badA,nameU
;remove,badA,nameB
;remove,badA,nameV
;remove,badA,nameNB
;remove,badA,nameLC
set_plot,'ps'
pos=0.
pos1=[0.,0.,1.,1.]
for k=0,n_elements(nameV)-1,8 do begin &$

   str=strtrim(string(k),1) &$
   print,str &$
   device,filename='/Users/mehdi/Dropbox/Research/SupCam/Aftermove/eps/Figure2_'+str+'.eps',/encap,xsize=21,ysize=29 &$
   for hh=0+k,7+k,1 do begin &$
      if hh gt n_elements(nameV)-1 then break &$
      h=hh &$
      if n_elements(nameV)- k lt 8 then h=hh+8-( n_elements(nameV)- k) &$
      dir='/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/new2/BVge0.4_err/flag0/' &$
      print,nameu[hh] &$
      u=mrdfits(dir+nameu[hh]) &$
      b=mrdfits(dir+nameb[hh]) &$
      v=mrdfits(dir+namev[hh]) &$
      nb=mrdfits(dir+namenb[hh]) &$
      lc=mrdfits(dir+namelc[hh]) &$

      stdu=stddev(u[where(u gt -100. and u lt 100)]) &$
      stdnb=stddev(nb[where(nb gt -100 and nb lt 100)]) &$
      stdb=stddev(b[where(b gt -100. and b lt 100)]) &$
      stdv=stddev(v[where(v gt -100. and v lt 100)]) &$
      stdlc=stddev(lc[where(lc gt -100.and lc lt 100)]) &$
      loadct,0 &$
      tvimage_t,bytscl(-lc,min=mean(lc[where(lc gt -100. and nb lt 100.)])-3.*stdlc,max=mean(lc[where(lc gt -100. and nb lt 100.)])+3.*stdlc ),position=[0.01,(0.01+0.17*(h-k))*0.71+0.02, 0.2, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
      
      plot,dindgen(fix(sqrt(n_elements(lc)))),dindgen(fix(sqrt(n_elements(lc)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.01,(0.01+0.17*(h-k))*0.71+0.02, 0.2, (0.2+0.17*(h-k))*0.71] &$
      d=(fix(sqrt(n_elements(lc)))-1)/2 &$
      r=21.15/sqrt(n_elements(lc))  &$ ;pixel size in arc-sec &$
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
      !p.thick = 7 &$
      xyouts, 1200,28000,'IB383',charsize=2,charthick=7,color=get_colour_by_name('white'),/device &$
      !p.thick = 3 &$
      ;xyouts, 1200,28000,'IB383',charsize=2,charthick=3,color=get_colour_by_name('green'),/device
      loadct,0 &$
      tvimage_t,bytscl(-u,min=mean(u[where(u gt -100. and nb lt 100.)])-3.*stdu,max=mean(u[where(u gt -100. and nb lt 100.)])+3.*stdu),position=[0.2,(0.01+0.17*(h-k))*0.71+0.02, 0.39, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
      plot,dindgen(fix(sqrt(n_elements(u)))),dindgen(fix(sqrt(n_elements(u)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.2,(0.01+0.17*(h-k))*0.71+0.02, 0.39, (0.2+0.17*(h-k))*0.71]
      d=(fix(sqrt(n_elements(u)))-1)/2 &$
      r=21.15/sqrt(n_elements(u)) &$ ;pixel size in arc-sec 
      rr=0.7/r
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
       xyouts, 5200,28000,'U',charsize=2,color=get_colour_by_name('white'),/device &$
       ;xyouts, 5200,28000,'U',charsize=2,color=get_colour_by_name('green'),/device
       loadct,0 &$
      tvimage_t,bytscl(-b,min=mean(b[where(b gt -100. and nb lt 100.)])-3.*stdb,max=mean(b[where(b gt -100. and nb lt 100.)])+3.*stdb),position=[0.39,(0.01+0.17*(h-k))*0.71+0.02, 0.58, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
     plot,dindgen(fix(sqrt(n_elements(u)))),dindgen(fix(sqrt(n_elements(u)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.39,(0.01+0.17*(h-k))*0.71+0.02, 0.58, (0.2+0.17*(h-k))*0.71]
      d=(fix(sqrt(n_elements(u)))-1)/2 &$
      r=21.15/sqrt(n_elements(u)) &$ ;pixel size in arc-sec
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
xyouts, 9200,28000,'B',charsize=2,color=get_colour_by_name('white'),/device &$
      ;xyouts, 9200,28000,'B',charsize=2,color=get_colour_by_name('green'),/device
       loadct,0 &$
      ; if k eq 56 and h eq 58 then stop
      tvimage_t,bytscl(-nb,min=mean(nb[where(nb gt -100. and nb lt 100.)])-3.*stdnb,max=mean(nb[where(nb gt -100. and nb lt 100.)])+3.*stdnb),position=[0.58,(0.01+0.17*(h-k))*0.71+0.02, 0.77, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
       plot,dindgen(fix(sqrt(n_elements(u)))),dindgen(fix(sqrt(n_elements(u)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.58,(0.01+0.17*(h-k))*0.71+0.02, 0.77, (0.2+0.17*(h-k))*0.71] &$
      d=(fix(sqrt(n_elements(u)))-1)/2 &$
      r=21.15/sqrt(n_elements(u)) &$;pixel size in arc-sec
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
            xyouts, 13200,28000,'IB527',charsize=2,color=get_colour_by_name('white'),/device &$

     ; xyouts, 13200,28000,'IB527',charsize=2,color=get_colour_by_name('green'),/device
       loadct,0 &$
      tvimage_t,bytscl(-v,min=median(v[where(v gt -100. and nb lt 100.)])-3.*stdv,max=median(v[where(v gt -100. and nb lt 100.)])+3.*stdv),position=[0.77,(0.01+0.17*(h-k))*0.71+0.02, 0.96, (0.2+0.17*(h-k))*0.71],/KEEP_ASPECT_RATIO &$
      plot,dindgen(fix(sqrt(n_elements(u)))),dindgen(fix(sqrt(n_elements(u)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=get_colour_by_name('white'),position=[0.77,(0.01+0.17*(h-k))*0.71+0.02, 0.96, (0.2+0.17*(h-k))*0.71] &$
      d=(fix(sqrt(n_elements(u)))-1)/2 &$
      r=21.15/sqrt(n_elements(u)) &$ ;pixel size in arc-sec
      rr=0.7/r &$
      tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green') &$
            xyouts, 17200,28000,'V',charsize=2,CHARTHICK=3,color=get_colour_by_name('white'),/device &$

     ; xyouts, 17200,28000,'V',charsize=2,CHARTHICK=3,color=get_colour_by_name('green'),/device
       loadct,0 &$
   endfor &$
   device,/close &$

   endfor

stop
end


pro eps
!p.font = 1
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2
set_plot,'ps'
spawn,'rm -f /Users/mehdi/Dropbox/Research/SupCam/eps/*.eps'
position=[0.,0.,1.,1.]
readcol,'/Volumes/MacintoshHD2/supcam/quilt/BVge0.4_err/flag0/list',name,format='a'
name[0]='34.330404-5.4120821dtR.fits'
name[1]='34.330404-5.4120821dtR.fits'
for i=0,1 do begin
fxread,'/Volumes/MacintoshHD2/supcam/quilt/BVge0.4_err/flag0/'+name[i],im,h
im[where(im-im ne 0)]=-1000
im[where(im le 0)]=-(alog(abs(im[where(im le 0)])))^1.5
im[where(im gt 0)]=(alog(abs(im[where(im gt 0)])))^1.5

device,filename='/Users/mehdi/Dropbox/Research/SupCam/eps/'+name[i]+'.eps',/encap,/color,xsize=12,ysize=12
TVIMAGE,im,bytscl(im,min=-1000,max=2401, top=10,/nan),/KEEP_ASPECT_RATIO
;tvscl,im/max(im)

plot,dindgen(fix(sqrt(n_elements(im)))),dindgen(fix(sqrt(n_elements(im)))),xtickformat='(a1)',ytickformat='(a1)',xthick=6,ythick=6,/noerase, /nodata, /xstyle, /ystyle, ticklen=0,color=0,position=position
d=(fix(sqrt(n_elements(im)))-1)/2
r=21.15/sqrt(n_elements(im)) ;pixel size in arc-sec
rr=0.7/r
tvcircle,rr,d,d,/data,thick=3, color=get_colour_by_name('green')
;cgtext,20,140,'IB383',charsize=3.0,charthick=3,/data, color='green'
device, /close

endfor


stop
end
