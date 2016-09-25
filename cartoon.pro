; This routine simulates a simple 2D structure with a number of
; magnetic patches with random orientation but the same
; strength. Assuming the structure is much smaller than the beam size
; we can calculate the most probable number of patches to reduce the
; degree of polarization from values around 50% to 4%. 
pro sim
  b0=50.0
  num=1500
  Bprob=fltarr(num)
  for j=0,num-1 do begin &$
   Bvec=fltarr(1000) &$
   for i=0, 999 do begin &$
     th=randomu(seed,j+1) &$
     thrad=2.0*!pi*th &$
     B=b0*(sqrt(total(sin(thrad))^2+total(cos(thrad))^2))/((j+1)*100.0) &$
     Bvec[i]=B &$
     endfor &$
     bin= (max(Bvec)-min(Bvec))*0.04 &$
     distfreq = Histogram(Bvec, MIN=Min(Bvec),binsize=bin,locations=xbin) &$
     dum = max(distfreq,id) &$
     mode=xbin[id] &$
     Bprob[j]=mode &$
  endfor
plot,indgen(num)+1,Bprob,xtitle=textoidl('Number of B field patches'),ytitle=textoidl('\pi'),thick=6,xthick=4,ythick=4, charsize=1.5,psym=sym(0),yr=[0.005,0.5],ystyle=1,/ylog

n=30
s1=num/n
dloc=[]
md=[]
mdstd=[]
depgd=Bprob
zgd=indgen(num)+1
iddsort=sort(zgd)
zgd=zgd[iddsort]
depgd=depgd[iddsort]

for i=0, num-n-1 do begin &$
   dloc=[dloc,median(zgd[i : i+n-1])] &$
   md=[md,median(depgd[i : i+n-1])] &$
endfor
oplot,dloc,md,thick=4.0,color=get_colour_by_name('red')

  stop
  end
