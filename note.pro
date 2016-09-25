pro note
ab=indgen(100)/(99.0/4.765)+22.0
fnb=10.0^((ab+5.*alog10(5270)+2.406)/(-2.5))
ewl=700.0/(31.25-ab)+5
flm=245.7*fnb/(1+245.7/ewl)
plot,ab,flm,charsize=2
stop
end
lfr=int_tabulated(lamr,lamr*pr)/int_tabulated(lamr,pr)
readcol,'~/Downloads/smoka/MITCCDs/r.txt',lamr,pr
mr_m383=-2.23
fr_383=10.0^(-1*(mr_m383)/2.5);-2.*alog10(6288.0/3830.))
print,fr_383
