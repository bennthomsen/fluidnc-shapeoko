; XYZ probe macro

; set parameters
#<fast_rate>=20
#<slow_rate>=10
#<tool_diameter> = 6.35
#<probe_diameter> = 14.9
#<probe_dist> = 8
#<retract_height>=15

#<z_fast_rate>=80
#<z_probe_dist> = 15
#<probe_plate_offset> = 13

; Start position
#<Xs>=#<_x>
#<Ys>=#<_y>

T000

G91
G38.2 X[-#<probe_dist>] F#<fast_rate> ; probe fast
G38.5 X[#<probe_dist>] F#<slow_rate>; probe slowly away from probe
#<left_touch>=#5061 ; save the x touch WCO location
(PRINT, Left touch = [#<left_touch>])
G90 G0 X[#<Xs>]  ; return to initial x position
G91
G38.2 X[#<probe_dist>] F#<fast_rate> ; probe fast
G38.5 X[-#<probe_dist>] F#<slow_rate>; probe slowly away from probe
#<right_touch>=#5061 ; save the x touch WCO location
(PRINT, Right touch = [#<right_touch>])
#<x0_touch> = [ROUND[500*[#<left_touch>+#<right_touch>]]/1000]
(PRINT, x0 = [#<x0_touch>])
G10 L2 P0 X[#<x0_touch>]
G90 G0 X0

;Probe Y
G91
G38.2 Y[-#<probe_dist>] F#<fast_rate> ; probe fast towards probe
G38.5 Y[#<probe_dist>] F#<slow_rate>; probe slowly away from probe
#<bottom_touch>=#5062 ; save the y touch WCO location
G90 G0 Y[#<Ys>]  ; return to initial y position
(PRINT, Bottom touch = [#<bottom_touch>])
G91
G38.2 Y[#<probe_dist>] F#<fast_rate> ; probe fast
G38.5 Y[-#<probe_dist>] F#<slow_rate>; probe slowly away from probe
#<top_touch>=#5062 ; save the y touch WCO location
(PRINT, Top touch = [#<top_touch>])
#<y0_touch> = [ROUND[500*[#<bottom_touch>+#<top_touch>]]/1000]
(PRINT, y0 = [#<y0_touch>])
G10 L2 P0 Y[#<y0_touch>]
G90 G0 Y0
G91 G0 Z[#<retract_height>]

;Probe Z
G91
G0 X10 Y10 ; Move to top of touch plate
G38.2 Z[-#<z_probe_dist>] F#<z_fast_rate> ; probe fast
G38.5 Z[#<z_probe_dist>] F#<slow_rate>; probe slowly away from probe
#<z_touch>=#5063 ; save the z touch WCO location
G0 Z[#<retract_height>] ; retract
(PRINT, Z touch = [#<z_touch>])
#<z_reference> = [#<z_touch>-#<probe_plate_offset>]
(PRINT, Setting Z ref = [#<z_reference>])
G10 L2 P0 Z[#<z_reference>]
G90
G0 X0 Y0

M0 ; pause to remove probe clip
(PRINT, Remove the probe clip)

M05
M6T001