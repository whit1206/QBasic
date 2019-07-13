COMMON SHARED ST$
DECLARE SUB MouseShow ()
DECLARE SUB MouseHide ()
DECLARE SUB MouseSetPos (x%, y%)
DECLARE SUB MouseSetH (x1%, x2%)
DECLARE SUB MouseSetV (y1%, y2%)
DECLARE SUB MouseStats ()

DECLARE FUNCTION MouseInit% ()
DECLARE FUNCTION ReturnButton$ ()
DECLARE FUNCTION ReturnX% ()
DECLARE FUNCTION ReturnY% ()

DIM SHARED Registers AS RegType
DIM SHARED MouseButton AS INTEGER
DIM SHARED MouseX AS INTEGER
DIM SHARED MouseY AS INTEGER
DIM SHARED LeftButton AS STRING
DIM SHARED RightButton AS STRING
DIM SHARED NoButton AS STRING
DIM SHARED True AS INTEGER

True = -1
NoButton = " 0"
LeftButton = " 1"
RightButton = " 2"

