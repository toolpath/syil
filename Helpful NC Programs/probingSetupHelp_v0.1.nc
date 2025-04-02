; Copyright 2025 Robot Oblivion

; ProbingConfigHelper
; A NC program to suport the process of doing the first full probing calibration 
; Initial Coding: Robot Oblivion

; Before running, ensure the following:  
;   - backup your tool table, offset table and @10, @11, @100-@117, @127-@133, @980-@987 and @1508 variables in case of wanting to revert
;   - Set all user inputs in the ProbeConfig file.
;   - copy all macro files CNC control 
;   - Clear as many items as possible from the table to prevent collisions with stock, jigs, fixtures, or vices.  
;   - Ensure the table zero point is empty, lightly stoned, and free of coolant.  
;   - Find the tool setter's centre and store this location to the extended work offset chosen in @111 PROBECONFIG.
;   - Copy the table zero point (XYZ) offsets to the extended work offsets that will store the calibration artifact location.  
;   - Have your master tool, probe, and ring gauge ready.  

G65 "PROBECONFIG" T1 

G90 G94 G17 G49 G40 G80
G53 G00 Z0

; toolchange to probe tool pocket
IF [@100 != R_SYS_INFO[0,2]]
  G53 G00 X-390 Y0 
  G65 "LOADTOOL" M0 T@100
END_IF

#96 = MSG_YES["Ready to start?", "Is the master tool loaded in the spindle",""]
IF [#96 == 0]
    MSG_OK["Install the master tool", "Switch to MPG mode and install the master tool (T@100) then switch back to auto and retry calibration", ""]
    M30
END_IF

#96 = MSG_YES["Calibrate Tool Setter?", "would you like to run the tool setter calibration?",""]
IF [#96 == 1]
  #96 = MSG_YES["Tool setter WCS set?", "Is the tool setter centre location loaded into G54 P@112?",""]
  IF [#96 == 0]
    MSG_OK["Set missing WCS", "Make sure to find the tool setters center and update offsets G54 P@112", ""]
    M30
  END_IF
  G65 "CALIBRATETOOLSET"
END_IF

#96 = MSG_YES["Probing WCS set?", "Is the location of the Z probing object loaded into G54 P@111?",""]
IF [#96 == 0]
  M1430
END_IF

G54 P@111
G1 F2000 X0 Y0

;G65 "CALIBRATEPROBEZ" A1 ; full Z calibration

G43 H@100
G65 "PROTECTEDMOVE" Z100

; swap out block for ring gauge
MSG_OK["Load ring gauge", "Switch to MPG mode and install the ring gauge onto the table. Lower the probe tip into the ring gauge, then press Cycle Start only when ready to proceed. ",""]
M00

G65 "CALIBRATEPROBERING"

G53 G00 Z0.
G53 G00 X-390 Y0
M30