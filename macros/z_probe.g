; Z probe on touch plate (corner position)

; set parameters
#<fast_rate>=80
#<slow_rate>=10
#<probe_dist>=100
#<probe_offset>=13
#<retract_height>=5

G91
G38.2 Z[-#<probe_dist>] F#<fast_rate> ; probe fast
G38.5 Z[#<probe_dist>] F#<slow_rate>; probe slowly away from probe
#<z_touch>=#5063 ; save the z touch WCO location
G0 Z[#<retract_height>] ; retract
(PRINT, Z touch = [#<z_touch>])
#<z_reference> = [#<z_touch>-#<probe_offset>]
(PRINT, Setting Z ref = [#<z_reference>])
G10 L2 P0 Z[#<z_reference>]
G90

M0 ; pause to remove probe clip
(PRINT, Remove the probe clip)


M05
M6T001