pro select
close,/all
nb=mrdfits('CAT_527.fits',1)
b=mrdfits('CAT_B.fits',1)
v=mrdfits('CAT_V.fits',1)


plot,nb.mag_auto-v.mag_auto,b.mag_auto-nb.mag_auto,psym=3,xr=[-5,3],yr=[-5,5],xtitle='NB-V',ytitle='B-NB'


xx=dindgen(21)/10.
yy=0.25*xx+1.2
ss=xx
a1=dindgen(50)/10.0+11
b1=0.05*a1+0.8
a2=a1+4.9
b2=-0.08*a2+2.85
c1=[a1,a2]
c2=[b1,b2]
nbm=nb.mag_auto
bm=b.mag_auto
vm=v.mag_auto
ra=nb.x_image
dec=nb.y_image

openw,1,'candidates.coords'
openw,2,'candidates.coords2'

for j=0,20,1 do begin
indbin=where(bm-vm gt xx[j]-0.05 and bm-vm le xx[j]+0.05 and nbm-vm gt -3 and nbm -vm lt 3)
;indbin=where(vm gt xx[j]-0.05 and vm le xx[j]+0.05 and nbm-vm gt -3 and nbm-vm lt 3)

;yy[j]=median(nbm[indbin]-vm[indbin])
;ss[j]=stddev(nbm[indbin]-vm[indbin])

;index_candidates=where(bm-vm gt xx[j]-0.05 and bm-vm le xx[j]+0.05 and nbm-vm gt -3 and nbm -vm lt 3 and nbm-vm lt yy[j]-3.d*ss[j])
index_candidates=where(bm-vm gt xx[j]-0.05 and bm-vm le xx[j]+0.05 and nbm-vm gt -3 and nbm -vm lt 3 and nbm-vm lt yy[j])

if j eq 0 then in=index_candidates
ra_cand=ra[index_candidates]
dec_cand=dec[index_candidates]
;print, index_candidates
if j ne 0 then in=[in,index_candidates]

for i=0,n_elements(ra_cand)-1,1 do printf,1,ra_cand[i],dec_cand[i],format='((d15.6)," ",(d15.6))'
endfor
for j=0,99 do begin
index_candidates2=where(vm gt c1[j]-0.05 and vm le c1[j]+0.05 and nbm-vm gt -3 and nbm-vm lt 3 and nbm-vm lt c2[j])

if (j eq 0)  then begin
   in2=index_candidates2
   print,in2
endif
ra_cand2=ra[index_candidates2]
dec_cand2=dec[index_candidates2]
;print, index_candidates2
if (j ne 0)  then in2=[in2,index_candidates2]

for i=0,n_elements(ra_cand2)-1,1 do printf,2,ra_cand2[i],dec_cand2[i],format='((d15.6)," ",(d15.6))'
endfor
;print, n_elements(in)
;print, n_elements(in2)

close,/all

set_plot,'ps'
device,filename='selection2.ps',/encap,/color
plotsym,0,0.2,/fill
plot,b.mag_auto-v.mag_auto,nb.mag_auto-v.mag_auto,psym=8,xr=[-0.5,2.5],yr=[-2,3],ytitle='NB-V',xtitle='B-V',xstyle=1
;plot,v.mag_auto,nb.mag_auto-v.mag_auto,psym=8,xr=[10,25],yr=[-2,3],ytitle='V',xtitle='B-V',xstyle=1

for i=0,n_elements(in)-2 do begin
h=in[i]
;print,h
oplot,[bm[h]-vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('blue')
;oplot,[vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('blue')

endfor
oplot,xx,yy,color=get_colour_by_name('red')
device,/close
device,filename='selection3.ps',/encap,/color
plotsym,0,0.2,/fill

plot,v.mag_auto,nb.mag_auto-v.mag_auto,psym=8,xr=[10,25],yr=[-2,3],ytitle='NB-V',xtitle='V',xstyle=1

for i=0,n_elements(in)-2 do begin
h=in[i]

oplot,[vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('blue')


endfor
device,/close
device,filename='selection4.ps',/encap,/color
plotsym,0,0.2,/fill

plot,v.mag_auto,nb.mag_auto-v.mag_auto,psym=8,xr=[10,25],yr=[-2,3],ytitle='NB-V',xtitle='V',xstyle=1
remove,[0,2,3],in2
for i=0,n_elements(in2)-1 do begin
h=in2[i]

oplot,[vm[h]],[nbm[h]-vm[h]],psym=sym(1), color=get_colour_by_name('green')


endfor
loadct,13
;plotsym,0,2,/fill,color=255
;oplot,xx,yy,psym=8

;for j=0,20,1 do begin
;oplot,[xx[j],xx[j]],[yy[j]-ss[j],yy[j]+ss[j]],thick=3,color=255
;endfor

device,/close
set_plot,'x'
spawn,'open selection2.ps '
spawn,'open selection3.ps '
spawn,'open selection4.ps '
stop
end
