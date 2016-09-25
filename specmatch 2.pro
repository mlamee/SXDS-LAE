pro specmatch
; Hydra
  readcol,'~/Dropbox/Reports/Hydra.list', id, nb,ew, hh, mm, ss, dd,dmm,dss
; Hectospec  
  readcol,'~/Dropbox/Reports/Hectospec.list', hh1, mm1, ss1, dd1,dmm1,dss1

  ra=hh*15.0+mm*15.0/60.0+ss*15.0/3600.0
  dec=dd-dmm/60.0-dss/3600.0
  rahec=hh1*15.0+mm1*15.0/60.0+ss1*15.0/3600.0
  dechec=dd1-dmm1/60.0-dss1/3600.0
; Table 6 and 7 in the paper  
  readcol,'~/Dropbox/Reports/Table6.txt',ra00,dec00,ew00
  readcol,'~/Dropbox/Reports/Table7.txt',ra01,dec01,ew01
  
  ra0=[ra00,ra01]
  dec0=[dec00,dec01]
  ew0=[ew00,ew01]
  
  matchcat,ra0,dec0,ra,dec,dt=1,in0,in ; 1 arcsec matching radius "in0" are the indexes for the objects in table6+table7 and "in" are indexes for Hydra list.
  matchcat,ra0,dec0,rahec,dechec,dt=1,in02,in2; 1 arcsec matching radius "in02" are the indexes for the objects in table6+table7 and "in2" are indexes for Hectospec list.


  
  
stop
end
