
DECLARE SUB ResetSB ()
DECLARE SUB PlayWav (filename$)
COMMON SHARED cb%
CONST BaseAddr = &H220 'Change if your sound card uses another base address

CONST COMMADDR = BaseAddr + &HC, ResetAddr = BaseAddr + &H6

DEFINT A-Z
c$ = COMMAND$
IF c$ = "" THEN c$ = "15000"
cb% = VAL(c$)
LINE INPUT "Enter file name: "; filename$
IF filename$ = "" THEN filename$ = "c:\windows\media\chimes.wav"
PlayWav filename$
END

SUB PlayWav (filename$)
  PRINT "Loading file..."
  OPEN filename$ FOR BINARY AS #1
  dummy$ = INPUT$(40, #1) 'Discard first 40 bytes
  length& = CVL(INPUT$(4, #1)) 'Next 4 bytes is length (4 bytes = LONG)
  IF length& > 32766 THEN 'Only WAVs shorter than 32767 bytes can be played
    PRINT "Lenght of file exceeds maximum array length."
    PRINT "Only the first 32766 bytes will be played."
    length& = 32766
  END IF
  length = length& 'Convert to integer for more speed
  DIM Byte(1 TO length)
  FOR i = 1 TO length
    Byte(i) = ASC(INPUT$(1, #1)) 'Read a byte in
    FOR iz = 1 TO cb%: NEXT iz
  NEXT i
  CLOSE #1
 
  PRINT "Playing back..."
  ResetSB
  DO
  LOOP UNTIL (INP(COMMADDR) AND 128) = 0
  OUT COMMADDR, &HD1 'Turn speaker on
  FOR i = 1 TO length
    DO
    LOOP UNTIL (INP(COMMADDR) AND 128) = 0

    OUT COMMADDR, &H10 'Give command to output a byte
    OUT COMMADDR, Byte(i) 'Output value
    FOR delay = 1 TO 15000: NEXT delay
  NEXT i
  DO
  LOOP UNTIL (INP(COMMADDR) AND 128) = 0
  OUT COMMADDR, &HD3 'Turn speaker off
END SUB

SUB ResetSB
  DO
  LOOP UNTIL (INP(COMMADDR) AND 128) = 0

  OUT ResetAddr, 1
  OUT ResetAddr, 0
END SUB

