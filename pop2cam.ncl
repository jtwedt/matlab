;*************************************************
; regrid_1.ncl
; NOTE: THIS IS UNFINISHED AND NOT READY FOR TESTING. 
; Concepts illustrated:
;   - Interpolating from one grid to another using bilinear interpolation
 
;************************************************
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"  
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/shea_util.ncl"  
;************************************************
begin
;************************************************
; read in netCDF file
;************************************************
  pop_in = addfile("region_masks.nc","r")
;************************************************
; read in regions
;************************************************
  region = pop_in->REGION_MASK(0,0,:,{0:360}); remove cyclic point
  lon = pop_in->TLON({0:360})
  lat = pop_in->TLAT({-90 : 90})
;************************************************
; interpolate to new grid
;***********************************************
  cam_lat = addfile("lat_CAM.nc", "r")
  cam_lon = addfile("lon_CAM,nc", "r")
  newlat = cam_lat->lat_CAM
  newlon = cam_lon->lon_CAM
  newlat@units = "degrees_north"
  newlon@units = "degrees_east"

  newRegion = linint2(lon,region&LAT,region,True,newlon,newlat,0)

  newregion!0   ="lat"
  newregion!1   = "lon"
  newregion&lat = newlat
  newregion&lon = newlon
end
