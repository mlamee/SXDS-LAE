;This Routine make region files for ds9 from star catalogs like
;sxds.u.txt 
pro mkreg
coordim,'OBJECT.Unew2.1.fits','sxds.u.txt','sxds.u.reg'
coordim,'OBJECT.B.1.fits','sxds.B.txt','sxds.B.reg'
coordim,'OBJECT.V.1.fits','sxds.V.txt','sxds.V.reg'
coordim,'OBJECT.527.1.fits','sxds.527.txt','sxds.527.reg'
coordim,'OBJECT.NB383.1.fits','sxds.383.txt','sxds.383.reg'

end
