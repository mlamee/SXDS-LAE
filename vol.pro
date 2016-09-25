pro vol ;Calculating the expected number of LAE in our field based on Gronwall et al. 2007
;a=-1.36 ; Gronwall
a=-1.49  ; Gronwall
a=-1.5 ; Ouchi

phi=1.28d-3 ;Mpc^-3 grownwall z=3.1 EW>22
phi=9.2d-4 ;Ouchi z=3.1 EW > 64
;phi=10.8d-4 ;Ouchi z=3.1 EW> 0 modeled

;phi=3.4d-4 ;Ouchi z=3.7
ll=4.36d42 ; erg/s Gronwall z=3.1
ll=5.8d42 ; Ouchi z=3.1
;ll=10.2d42 ;Ouchi z=3.7
;lmin=1.3d42 ; What Gronwall used
;lmin=1.89d42 ; what I have for 5sigma detection in IB527 for a source
;at z=3.34
lmin=3.03d41; Nestor 2013 I guess
;lmin=5.4d41 ;new Dec 2014
;lmin=7.57d41;test 
;lmin=1.25893d42 ;ouchi  

;a=-2 ;second set for ouchi z=3.1
;phi=3.9d-4
;ll=9.1d42
l=(lindgen(1000)+1)*lmin+1
n=phi*int_tabulated(l/ll,(l/ll)^a*exp(-l/ll),/double) ; number/Mpc^3
print,n
print,n*2.61d5 ;Number in volume probed by IB383
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/l527new3.exp',w,h
;idw=where(w ne 0)
;ar1=n_elements(w)*(0.15*!pi/(180.0*3600.0))^2
;ar2=n_elements(w[idw])*(0.15*!pi/(180.0*3600.0))^2
fxread,'/Volumes/Mehdi2TB/manual-backup/April24_2015/quilt/OBJECT.NB383.1.exp',nb,h383
x=indgen(sqrt(n_elements(nb)))
y=x
extast,h383,astr_383
extast,h,astr_527

xy2ad, x, y, astr_383, ra, dec
ad2xy, ra,dec, astr_527, x527, y527
;count=0
;for i=0,n_elements(x)-1 do begin
;   for j=0,n_elements(y)-1 do begin
 ;  if nb[x[i],y[j]] gt 0 and w[x527[i],y527[j]] gt 0 then count=count+1
;endfor
;endfor

np=n_elements(where(nb gt 0))
Area=np*(0.365*!pi/(180.0*3600.0))^2. ;effective area in radians
num=n*area/(4.*!pi)*(1276.255-1190.643)*1e9
n=15d-4
area_ouchi=3538.0*(!pi/(180.*60))^2
numouchi=n*area_ouchi*(1137.324-1109.264)*1d9/(!pi*4.)
Print,'Ouchi   ', numouchi
print,num




z=3.24+indgen(100)/550.
wl=0.7
wm=0.3
Ez=sqrt(wm(1+z)^3+wl)
DH=3000/0.7; h^-1 Mpc
DA=fltarr(n_elements(z))

wl=0.7
wm=0.3
z0=3.42
z1=indgen(100)/(99./z0)
DH=3000./0.7
Ez1=sqrt(wm*(1+z1)^3.+wl)
 DM=DH*int_tabulated(z1,1/Ez1,/double)

v2=(4./3)*!pi*DM^3/1e9
print,v2
stop
end

pro emis
; I use Ouchi 2008 UV luminosity function parameters, and assume all
; our LAEs are at z=3.34 to calculate the absolute R mags. Then I use
; eq (8) in Ouchi 2008 and our lower limit on UV/LyC flux ratio to
; calculate emissivity.
;etane=3.7 ;Nestor 2013 LAE
c=0.4*alog(10)
al=-1.6

;for z=3.1
;phis=5.6d-4; what is in Ouchi 2008
;phis=1.01d-3; mpc^-3 What Nestor used to account for the fact that they have EW > 22 not 64
phis=11.2d-4 ; I multiplied the Ouchi value by 2 to account for EW > 25 based on groip A EW distribution and Gronwall
ms=-19.8
ls=4d*!pi*(10d*3.08567758d18)^2*10d^((ms+48.6)/(-2.5))

;for z=3.7
;phis=5.2d-4; what is in Ouchi 2008
;phis=0.93d-3; mpc^-3 I multiplied 5.2d-4  by 1.8 to account for the fact that they have EW > 23 not 64
;ms=-19.8
;ls=4L*!pi*(10L*3.08567758d18)^2*10L^((ms+48.6)/(-2.5))

;mn=lindgen(151)/50.0-21.9 ;Ouchi at z=3.1
mn=lindgen(230)/100.0-22 ;Mehdi at z=3.3.4 
;mn=lindgen(171)/100.0-20.0 ; What Nestor used for their LAEs
l=4d*!pi*(10d*3.08567758d18)^2*10d^((mn+48.6)/(-2.5))
l=l[sort(l)]
ro=phis*int_tabulated(l/ls,l*(l/ls)^al*exp(-l/ls),/double)
print,ro 
;sci=exp(-c*(al+1)*(mn-ms)-exp(-c*(mn-ms))) ; abs MAG/MPc^3
;n=c*phis*int_tabulated(mn,sci); mag/Mpc^3
;1 pc= 3.08567758d18 cm
eta=14.4d  ; This is the old value
eta=13.8 ; This is the new and correct value 08/11/2015
lyc=ro/eta
print,lyc
stop
end
