DECLARE SUB ResetSB ()
DECLARE SUB record ()
DECLARE SUB PlayBack ()
COMMON SHARED DELAY%
CONST NoOfSamples = 32642 'Maximum array length
CONST BaseAddr = &H220 'Change if your sound card uses another base address

CONST commaddr = BaseAddr + &HC, DataAddr = &H388
CONST ResetAddr = BaseAddr + &H6
defint a-y
DIM SHARED BYTE(NoOfSamples) AS INTEGER
ZTARTTIME = 0
ZTARTTIME = TIMER
FOR Z# = 1 TO 200000
NEXT Z#
Z# = INT((TIMER - ZTARTTIME) * 18.5) * 45
DELAY% = Z# + 50
DELAY% = 100

DO
  CLS
  PRINT "1. Record sound"
  PRINT "2. Play back sound"
  PRINT "3. Quit"
  DO
    Choice$ = INPUT$(1)
  LOOP WHILE INSTR("123", Choice$) = 0 'Check for valid choice
  SELECT CASE Choice$
  CASE "1"
    record
  CASE "2"
    PlayBack
  CASE "3"
    CLS
    END
  END SELECT
LOOP

SUB PlayBack
  CLS
  PRINT "Playing back..."
  LOCATE 3, 1
  PRINT STRING$(NoOfSamples / 500, "±"); 'Print bar
  LOCATE 3, 1
  ResetSB

  OUT commaddr, &HD1 'Turn speaker on
  time! = TIMER
  FOR I = 0 TO NoOfSamples STEP 1
    IF I MOD 500 = 0 THEN PRINT "Û"; 'Fill up bar
    OUT commaddr, &H10 'Give command to output a byte
    OUT commaddr, BYTE(I) 'Output value
    FOR J = 1 TO 3000: NEXT J
  NEXT I
  time! = TIMER - time!
 
  OUT commaddr, &HD3 'Turn speaker off
  LOCATE 5, 1
  PRINT "Play back rate:"; NoOfSamples / time!; "Hz."
  PRINT "Press any key to continue."
  key$ = INPUT$(1)
END SUB

SUB record
  CLS
  PRINT "Recording..."
  LOCATE 3, 1
  PRINT STRING$(NoOfSamples / 500, "±"); 'Print bar
  LOCATE 3, 1
  'ResetSB
  time! = TIMER
  FOR I = 0 TO NoOfSamples
    IF I MOD 500 = 0 THEN PRINT "Û"; 'Fill up bar
    OUT commaddr, &H20 'Give command to sample a byte
    BYTE(I) = INP(DataAddr) 'Read value from data port
    FOR J = 1 TO DELAY%: NEXT J
  NEXT I
  time! = TIMER - time!
  LOCATE 5, 1
  PRINT "Sampling rate:"; NoOfSamples / time!; "Hz."
  PRINT "Press any key to continue."
  key$ = INPUT$(1)
END SUB

SUB ResetSB
  DO
  LOOP UNTIL (INP(commaddr) AND 128) = 128
  OUT ResetAddr, 1           'RESET SB
  OUT ResetAddr, 0
END SUB

