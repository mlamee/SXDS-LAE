; This routine can be used to measure the total exposure time of the
; used images in each filter except B and V. I didn't make a
; seperate list for the "used+in the LFC field" images in B and V. One
; must just simply look at the inventory_Bexposure.cat and inventory_Vexposure.cat

pro expt
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.B.lst',namb,format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/goodfwhm527.lst',nam527,format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.U_final.lst',namu,format='a'
readcol, '/Volumes/MacintoshHD2/supcam/names/OBJECT.V.lst',namv,format='a'
readcol, '/Volumes/MacintoshHD2/supcam/inventory_all.cat',name,exp,format='(a,x,x,x,x,x,x,x,x,x,x,x,x,f)',skipline=24
readcol, '/Volumes/MacintoshHD2/sxdslfc/names/goodfwhm383.lst',nam383,format='a'
readcol, '/Volumes/MacintoshHD2/sxdslfc/inventory_all.cat',name2,exp2,format='(a,x,x,x,x,x,x,x,x,x,f)',skipline=19
expb=0
expv=0
expu=0
exp383=0
exp527=0
for i=0, n_elements(namb)-1 do begin
inb=where(name eq namb[i])
expb=expb+exp[inb]
;print,exp[inb]
endfor
for i=0, n_elements(namv)-1 do begin 
inv=where(name eq namv[i])
expv=expv+exp[inv]
;print,exp[inv]
endfor
for i=0, n_elements(nam527)-1 do begin 
in527=where(name eq nam527[i])
exp527=exp527+exp[in527]
;print,exp[in527]
endfor

for i=0, n_elements(namu)-1 do begin 
inu=where(name eq namu[i])
expu=expu+exp[inu]
print,exp[inu]
endfor

for i=0, n_elements(nam383)-1 do begin 
in383=where(name2 eq nam383[i])
exp383=exp383+exp2[in383]
print,exp2[in383]
endfor
;print,expb
;print,expv
;print,exp527
;print,expu
print,exp383
stop
end
