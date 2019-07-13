CONST ScreenMode = 12, XMAX = 640 'Change for other screen modes
CONST BaseAddr = &H220 'Change if your sound card uses another base address

CONST COMMADDR = BaseAddr + &HC, DataAddr = BaseAddr + &HA

DEFINT A-Z
DIM BYTE(XMAX)
SCREEN ScreenMode
PSET (0, 128)
DO
  OUT COMMADDR, &H20 'Give command to sample a byte
  PRESET (I, BYTE(I))
  BYTE(I) = INP(DataAddr) 'Read value from data port
  PSET (I, BYTE(I))
  I = (I + 1) 'MOD xMax 'Wrap i when end is reached
  IF I > XMAX THEN I = 0
LOOP UNTIL INKEY$ <> ""

