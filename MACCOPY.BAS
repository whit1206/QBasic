DECLARE SUB cursor (c%)
DEFINT A-Z
DECLARE SUB wndwmngr (x, y, length, hth, num)
DECLARE SUB BUTTON (TXT$, x%, y%, wdth%, hth%, c%, c2%, way$)
DECLARE SUB buttondetect (TXT$, x%, y%, wdth%, hth%, c%, c2%, num)
DECLARE SUB deletewin (num)
DECLARE SUB saver ()
DECLARE SUB backsave (f$)
DECLARE SUB backload (f$)
DECLARE SUB wndow (x, y, xsize, ysize, title$, totmes, num)
DECLARE SUB dropmenu (main$, typ)
DECLARE SUB eyes ()
DECLARE SUB setrange (x1%, y1%, x2%, y2%)
DECLARE SUB loadimg (f$)
DECLARE SUB MouseDriver (ax%, BX%, cx%, dx%)
DECLARE FUNCTION MOUSEINIT% ()
DECLARE SUB mouseshow ()
DECLARE SUB mousehide ()
DECLARE SUB mousestats ()
DECLARE SUB mousesetpos (x%, y%)
DECLARE SUB font (TXT$, x, y, bc, fc, wdthsze, hthsze, typ)
DECLARE SUB loadfnt (file$, typ)
COMMON SHARED SH%
COMMON SHARED PI#
COMMON SHARED SV%
COMMON SHARED ST%
COMMON SHARED left%
COMMON SHARED RIGHT%
COMMON SHARED mssize
COMMON SHARED MODE%
COMMON SHARED b%
COMMON SHARED MX%
COMMON SHARED MY%
COMMON SHARED pict%()
COMMON SHARED mpc%()
COMMON SHARED eyex%()
COMMON SHARED eyey%()
COMMON SHARED x()
COMMON SHARED y()
COMMON SHARED oldx%()
COMMON SHARED oldy%()
COMMON SHARED fb%()
COMMON SHARED f%()
COMMON SHARED f2%()
COMMON SHARED menu$()
COMMON SHARED menusize()
COMMON SHARED menunum
COMMON SHARED menuchoice
COMMON SHARED menutype
COMMON SHARED butprs$()
COMMON SHARED mes$()
COMMON SHARED fontuse%
COMMON SHARED cursr%
PRINT COMMAND$: SLEEP 1
OPTION BASE 1
RIGHT% = 2
left% = 1
DIM SHARED MOUSE$
MOUSE$ = SPACE$(57)
FOR Ifg% = 1 TO 57
READ a$
h$ = CHR$(VAL("&H" + a$))
MID$(MOUSE$, Ifg%, 1) = h$
NEXT Ifg%
DATA 55,89,E5,8B,5E,0C,8B,07,50,8B,5E,0A,8B,07,50,8B
DATA 5E,08,8B,0F,8B,5E,06,8B,17,5B,58,1E,07,CD,33,53
DATA 8B,5E,0C,89,07,58,8B,5E,0A,89,07,8B,5E,08,89,0F
DATA 8B,5E,06,89,17,5D,CA,08,00
DOTS = 2
DIM fb%(2)
DIM x(DOTS)
DIM y(DOTS)
DIM eyex%(DOTS)
DIM eyey%(DOTS)
DIM oldx%(DOTS)
DIM oldy%(DOTS)
DIM pict%(4000)
DIM back%(1)
DIM menu$(20, 20)
DIM menusize(20, 2)
DIM butprs$(30)
DIM mes$(30)
CLS
SCREEN 12
maxsize = 40
MODE% = 12
PI# = 3.1415926#
loadfnt "default.fnt", 0
loadfnt "mode13c.fnt", 1
1 RANDOMIZE TIMER
mssize = maxsize
CLS
PAINT (0, 0), 1'"j"
LINE (0, 0)-(640, 20), 15, BF
mousesetpos 320, 240
size = 8
LILSIZE = size / 3
mouseshow
SHELL "c:\bas\editor\cmouse 1"
FOR i = 3 TO -3 STEP -1
CIRCLE (320, 240), 400 + i, 0
NEXT i
loadimg "mac1.img"
PUT (5, 1), pict%, PSET
loadimg "compu1.img"
PUT (545, 100), pict%, PSET
fontuse = 1
font "CHRIS'S SLAVE", 515, 140, 1, 7, 1, 1, 1
fontuse = 0
dropmenu "File:Edit:Views:Label:Special:Help", 0
menu$(1, 1) = "NEW"
menu$(1, 2) = "RUN"
menu$(1, 3) = "SAVE"
menu$(1, 4) = "GET INFO"
menu$(1, 5) = "FIND FILE"
menu$(1, 6) = "COMMAND PROMPT"
menu$(1, 7) = "QUIT"
menu$(2, 1) = "CUT"
menu$(2, 2) = "COPY"
menu$(2, 3) = "PASTE"
menu$(2, 4) = "SELECT ALL"
menu$(2, 5) = "FIND FILE"
menu$(3, 1) = "NONE"
menu$(4, 1) = "NONE"
menu$(5, 1) = "CLEAN UP DESKTOP"
menu$(5, 2) = "SCREEN SAVER"
menu$(5, 3) = "SHUTDOWN COMPUTER"
menu$(5, 4) = "RESTART COMPUTER"
menu$(6, 1) = "NONE"
menu$(7, 1) = "NONE"
mes$(1) = "WELCOME TO NOVICE MAC95!!"
wndow 100, 100, 220, 80, "NOVICE SOFTWARE", 1, 1
butprs$(1) = "UP"
BUTTON "I understand", 135, 145, 150, 25, 7, 8, "UP"
DO
   a$ = INKEY$
   oldmx = MX%: oldmy = MY%
   mousestats
   wndwmngr 100, 100, 220, 80, 1
   buttondetect "I understand", 135, 145, 150, 25, 7, 8, 1
   IF a$ = "" AND MX% = oldmx AND MY% = oldmy AND b% = 0 THEN savercntr = savercntr + 1 ELSE savercntr = 0
   IF savercntr > 5000 THEN savercntr = 0: saver
   dropmenu "", 1
   IF menutype = 1 THEN
      IF menuchoice = 6 THEN
         mousehide
         backsave "temp"
         SCREEN 0
         WIDTH 80
         SHELL
         SCREEN 12
         backload "temp"
         mouseshow
      END IF
      IF menuchoice = 7 THEN END
   END IF
   IF menutype = 5 THEN
      IF menuchoice = 2 THEN savercntr = 0: saver
   END IF

   IF menuchoice <> 0 THEN BEEP: menuchoice = 0
   font TIME$, 450, 3, 15, 3, 1, 1, 1
   eyes
LOOP UNTIL a$ = CHR$(27)

SUB backload (f$)
SHELL "LOAD " + f$ + ".BLU" + " " + f$ + ".GRN" + " " + f$ + ".RED" + " " + f$ + ".INT"
END SUB

SUB backsave (f$)
SHELL "SAVE " + f$ + ".BLU" + " " + f$ + ".GRN" + " " + f$ + ".RED" + " " + f$ + ".INT"
END SUB

SUB BUTTON (TXT$, x%, y%, wdth%, hth%, c%, c2%, way$)
mousehide
LINE (x%, y%)-(x% + wdth%, y% + hth%), c%, BF
LINE (x%, y%)-(x% + wdth%, y% + hth%), 0, B
IF way$ = "UP" THEN a = 15: b = c2%: DWN = 0 ELSE a = c2%: b = 15: DWN = 2
LINE (x% + 1, y% + 1)-(x% + wdth% - 1, y% + hth% - 1), a, B
LINE (x% + 2, y% + 2)-(x% + wdth% - 2, y% + hth% - 1), a, B
LINE (x% + 3, y% + 3)-(x% + wdth% - 1, y% + hth% - 1), b, BF
LINE (x% + 3, y% + 3)-(x% + wdth% - 3, y% + hth% - 3), c%, BF
LINE (x% + wdth% - 2, y% + 2)-(x% + wdth% - 1, y% + 1), c%, BF
LINE (x% + 1, y% + hth% - 1)-(x% + 2, y% + hth% - 2), c%, B
PSET (x%, y%), c%
PSET (x% + wdth%, y%), c%
PSET (x%, y% + hth%), c%
PSET (x% + wdth%, y% + hth%), c%
IF TXT$ <> "" THEN
   ZR = x% + wdth% + x%
   VIEW SCREEN (x% + 3, y% + 3)-(x% + wdth% - 3, y% + hth% - 3)
   font TXT$, ZR / 2 - (LEN(TXT$) * 4) + 2 + DWN, (y% + hth% + y%) / 2 - fb%(1) / 2 + 1 + DWN, -1, 15, 1, 1, 1
   VIEW
END IF
mouseshow

END SUB

SUB buttondetect (TXT$, x%, y%, wdth%, hth%, c%, c2%, num)
IF b% = left% AND MX% > x% AND MX% < x% + wdth% AND MY% > y% AND MY% < y% + hth% THEN
   mousehide
   IF butprs$(num) = "DOWN" THEN butprs$(num) = "UP" ELSE butprs$(num) = "DOWN"
      GET (x% + 8, y% + 8)-(x% + wdth% - 5 + 1, y% + hth% - 8 + 1), pict%
      IF butprs$(num) = "UP" THEN a = 15: b = c2% ELSE a = c2%: b = 15
      LINE (x% + 1, y% + 1)-(x% + wdth% - 1, y% + hth% - 1), a, B
      LINE (x% + 2, y% + 2)-(x% + wdth% - 2, y% + hth% - 1), a, B
      LINE (x% + 3, y% + 3)-(x% + wdth% - 1, y% + hth% - 1), b, BF
      LINE (x% + 3, y% + 3)-(x% + wdth% - 3, y% + hth% - 3), c%, BF
      LINE (x% + wdth% - 2, y% + 2)-(x% + wdth% - 1, y% + 1), c%, B
      LINE (x% + 1, y% + hth% - 1)-(x% + 2, y% + hth% - 2), c%, B
      IF butprs$(num) = "DOWN" THEN n% = 10 ELSE n% = 8
      PUT (x% + n% - 1, y% + n% - 1), pict%, PSET
   press% = num
   DO
      mousestats
   LOOP UNTIL b% = 0
   mouseshow
END IF

END SUB

SUB cursor (c%)
IF cursr% = c% THEN EXIT SUB
cursr% = c%
SHELL "CMOUSE" + STR$(c%)
END SUB

SUB deletewin (num)
mousehide
n$ = MID$(STR$(num), 2)
backload "temp" + n$
KILL "temp" + n$ + ".red"
KILL "temp" + n$ + ".blu"
KILL "temp" + n$ + ".grn"
KILL "temp" + n$ + ".int"
mouseshow

END SUB

SUB dropmenu (main$, typ)
IF typ = 0 THEN
   menustart = 30
   menusize(1, 1) = menustart - 8
   menunum = 1
   FOR i = 1 TO LEN(main$)
      s$ = MID$(main$, i, 1)
      j = j + 1
      IF s$ = ":" THEN
         menusize(menunum, 2) = j - 1
         s$ = "  "
         menunum = menunum + 1
         j = 0
      END IF
      mn$ = mn$ + s$
   NEXT i
   menusize(menunum, 2) = j
   m = menustart
   FOR i = 2 TO menunum + 1
      m = m + (menusize(i - 1, 2) + 2) * 8
      menusize(i, 1) = m - 8
   NEXT i
   font mn$, 30, 3, 15, 8, 1, 1, 1
END IF
IF typ = 1 THEN
   IF MY% < 20 AND MX% > 22 AND MX% < menusize(menunum + 1, 1) AND b% <> 0 THEN
      FOR i = 1 TO menunum
         IF MX% >= menusize(i, 1) AND MX% <= menusize(i + 1, 1) THEN pick = i: EXIT FOR
      NEXT i
34.5
      FOR i = 1 TO 20
         IF menu$(pick, i) = "" THEN numofitems = i - 1: EXIT FOR
         l = (LEN(menu$(pick, i)) + 2) * 8
         IF l > lnth THEN lnth = l
      NEXT i
      mousehide
      backsave "temp"
      LINE (menusize(pick, 1), 21)-(menusize(pick, 1) + lnth, (numofitems + 1) * 17 + 21), 15, BF
      LINE (menusize(pick, 1), 21)-(menusize(pick, 1) + lnth, (numofitems + 1) * 17 + 21), 8, B
      FOR i = 1 TO numofitems
          IF i = 1 THEN font menu$(pick, 1), menusize(pick, 1) + 8, 12 + 17, 8, 15, 1, 1, 1
          IF i <> 1 THEN font menu$(pick, i), menusize(pick, 1) + 8, 12 + i * 17, 15, 8, 1, 1, 1
      NEXT i
      mouseshow
      mousestats
      ob% = b%
      menuy = 1
      DO
         eyes
         font TIME$, 450, 3, 15, 3, 1, 1, 1
         a$ = INKEY$
         mousestats
         but% = b%
         'see if different option on main menu bar is clicked
         IF MY% <= 20 AND (MX% < menusize(i, 1) OR MX% > menusize(i + 1, 1)) THEN
            FOR i = 1 TO menunum
               IF MX% >= menusize(i, 1) AND MX% <= menusize(i + 1, 1) THEN
                  IF pick <> i THEN
                     pick = i
                     mousehide
                     backload "temp"
                     mouseshow
                     GOTO 34.5
                  END IF
               END IF
            NEXT i
         END IF
         'highlights selectable submenu options
         IF MX% >= menusize(pick, 1) AND MX% <= menusize(pick + 1, 1) + lnth AND MY >= 21 AND MY% <= (numofitems + 1) * 17 + 21 THEN
             dum% = INT((MY% - 10) / 17)
             IF dum% <= 0 THEN dum% = 1
             IF dum% >= numofitems THEN dum% = numofitems
             IF dum% <> menuy THEN
                mousehide
                font menu$(pick, menuy), menusize(pick, 1) + 8, 12 + menuy * 17, 15, 8, 1, 1, 1
                font menu$(pick, dum%), menusize(pick, 1) + 8, 12 + dum% * 17, 8, 15, 1, 1, 1
                mouseshow
                menuy = dum%
             END IF
         END IF
         'selects submenu option
         IF but% <> ob% AND (MX% >= menusize(pick, 1) AND MX% <= menusize(pick, 1) + lnth AND MY >= 21 AND MY% <= (numofitems + 1) * 17 + 21) THEN
            menuchoice = menuy
            EXIT DO
         END IF
         IF but% <> ob% AND (MX% < menusize(pick, 1) OR MX% > menusize(pick, 1) + lnth OR MY% > (numofitems + 1) * 17 + 21) THEN menuchoice = 0: EXIT DO
      LOOP UNTIL a$ = CHR$(27)
      menutype = pick
      mousehide
      backload "temp"
      mouseshow
   END IF
END IF
END SUB

SUB eyes
   size = 8
   LILSIZE = size / 3
   mousestats
   eyex%(1) = 540: eyey%(1) = 10
   eyex%(2) = eyex%(1) + size * 2.5: eyey%(2) = eyey%(1)
   oldmx = MX%: oldmy = MY%
   CIRCLE (eyex%(1), eyey%(1)), size, 2
   CIRCLE (eyex%(2), eyey%(2)), size, 2
   IF MX% >= eyex%(1) - size * 2.7 AND MX% <= eyex%(2) + size + 5 AND MY% >= eyey%(1) - size * 2.7 - 3 AND MY% <= eyey%(1) + size + 3 AND hide = 0 THEN mousehide: hide = 1 ELSE mouseshow
   IF (MX% <= eyex%(1) - size * 2.7 OR MX% >= eyex%(2) + size + 5 OR MY% <= eyey%(1) - size * 2.7 - 3 OR MY% >= eyey%(1) + size + 3) THEN hide = 0: mouseshow
   FOR i = 1 TO 2
      b = ABS(eyex%(i) - MX%)
      IF b = 0 THEN b = .001
      a = ABS(eyey%(i) - MY%)
      IF a = 0 THEN a = .001
      IF MX% > eyex%(i) AND MY% < eyey%(i) THEN ang = INT(ATN(a / b) * 57.2958)
      IF MX% < eyex%(i) AND MY% < eyey%(i) THEN ang = (90 - INT(ATN(a / b) * 57.2958)) + 90
      IF MY% > eyey%(i) AND MX% < eyex%(i) THEN ang = INT(ATN(a / b) * 57.2958) + 180
      IF MY% > eyey%(i) AND MX% > eyex%(i) THEN ang = (270 - INT(ATN(a / b) * 57.2958)) + 90
      IF ang >= 178 AND ang <= 181 AND MX% > eyex%(i) THEN ang = 0
      IF (ang >= 2 AND ang >= 358) AND MX% < eyex%(i) THEN ang = 180
      IF MX% < eyex%(i) AND MY% = eyey%(i) THEN ang = 180
      oldx%(i) = x(i): oldy%(i) = y(i)
      DIST = SQR(a ^ 2 + b ^ 2)
      IF DIST > size - LILSIZE - 1 THEN
      x(i) = eyex%(i) + COS(ang * PI# / 180) * (size - LILSIZE - 1)
      y(i) = eyey%(i) - SIN(ang * PI# / 180) * (size - LILSIZE - 1)
      END IF
      IF blinkh = 0 THEN blink = INT(RND * 570)
      IF DIST <= size - LILSIZE - 1 THEN
      x(i) = MX%: y(i) = MY%
      END IF
      CIRCLE (oldx%(i), oldy%(i)), LILSIZE, 15
      CIRCLE (oldx%(i), oldy%(i)), 1, 15
      IF blink <> 1 THEN
         CIRCLE (x(i), y(i)), LILSIZE, 1
         CIRCLE (x(i), y(i)), 1, 1
      END IF
      IF count = 1 THEN blinkh = blinkh + 1
      IF blinkh > 32000 THEN blinkh = 0: blink = 0: count = 0
      IF blink = 1 AND blinkh <= 1 THEN
         count = 1
         FOR z = 1 TO 360
            FOR a = 1 TO 2
               IF z <= 180 THEN i = z ELSE i = 360 - z
               oldx1 = x1: oldy1 = y1: oldx2 = x2: oldy2 = y2
               x1 = eyex%(a) + COS((i + 90) * PI# / 180) * (size - 1)
               y1 = eyey%(a) - SIN((i + 90) * PI# / 180) * (size - 1)
               x2 = eyex%(a) + COS((-i + 90) * PI# / 180) * (size - 1)
               y2 = eyey%(a) - SIN((-i + 90) * PI# / 180) * (size - 1)
               LINE (x1, y1)-(x2, y2), 0
               IF z >= 180 THEN LINE (oldx1, oldy1)-(oldx2, oldy2), 15
            NEXT a
         NEXT z
      END IF
   NEXT i
END SUB

SUB font (TXT$, x, y, bc, fc, wdthsze, hthsze, typ)
rt = 0: CLR = 0: IF TXT$ = "" THEN EXIT SUB
IF typ <= 0 THEN typ = 1
FOR i = 1 TO LEN(TXT$)
   IF i = 1 AND highl <> 0 THEN fc2% = highl ELSE fc2% = fc
   k = ASC(MID$(TXT$, i, 1)) - 33
   IF k > 93 OR k < 0 THEN GOTO 78
   FOR b = 0 TO fb%(fontuse + 1)
      FOR a = 0 TO 7
         IF fontuse <> 1 THEN
            IF f%(a + 1, b + 1, k + 1) = 0 THEN CLR = bc ELSE CLR = fc2%
         ELSE
            IF f2%(a + 1, b + 1, k + 1) = 0 THEN CLR = bc ELSE CLR = fc2%
         END IF

         IF CLR <> -1 THEN
            IF JK = 1 THEN CLR = bc
            IF typ = 2 THEN LINE (x + (a * wdthsze) + rt, y + b * hthsze)-(x + ((a + 1) * wdthsze) + rt, y + (b + 1) * hthsze), CLR, BF
            IF typ = 1 THEN PSET (x + a * wdthsze + rt, y + b * hthsze), CLR
            IF typ = 3 THEN LINE (x + (a * wdthsze) + rt, y + b * hthsze)-(x + ((a + 1) * wdthsze) + rt, y + (b + 1) * hthsze), CLR, B
            IF typ = 4 THEN CIRCLE (x + a * wdthsze + rt, y + b * hthsze), (wdthsze + hthsze) / 2, CLR
         END IF
      NEXT a
   NEXT b
78 rt = rt + (8 * wdthsze)
NEXT i
END SUB

SUB loadfnt (file$, typ)
OPEN file$ FOR INPUT AS #1
   INPUT #1, s$
   IF UCASE$(s$) <> "NOVICE FONT FILE" THEN CLOSE #1: EXIT SUB
   INPUT #1, s$: IF VAL(s$) = 15 THEN fb%(typ + 1) = 15 ELSE fb%(typ + 1) = 7
   IF typ = 0 THEN REDIM f%(9, fb%(1) + 1, 94)
   IF typ = 1 THEN REDIM f2%(9, fb%(2) + 1, 94)
   j = CSRLIN: k = POS(0)
   FOR i = 0 TO 93
      LOCATE j, k: PRINT INT(i / 93 * 100);
      FOR b = 0 TO fb%(typ + 1)
         INPUT #1, D$
         IF D$ <> "-1" THEN
            FOR a = 0 TO LEN(D$) - 1
               IF typ = 0 THEN f%(a + 1, b + 1, i + 1) = VAL(MID$(D$, a + 1, 1))
               IF typ = 1 THEN f2%(a + 1, b + 1, i + 1) = VAL(MID$(D$, a + 1, 1))
            NEXT a
         END IF
      NEXT b
   NEXT i
   PRINT
CLOSE #1
END SUB

SUB loadimg (f$)
3.4543 OPEN f$ FOR BINARY AS #1 LEN = 2
FOR ctr% = 1 TO LOF(1) STEP 2
        GET #1, (ctr%), pict%((ctr% + 1) / 2)
NEXT ctr%
CLOSE #1
END SUB

SUB MouseDriver (ax%, BX%, cx%, dx%)
DEF SEG = VARSEG(MOUSE$)
MOUSE% = SADD(MOUSE$)
CALL ABSOLUTE(ax%, BX%, cx%, dx%, MOUSE%)
END SUB

SUB mousehide
ax% = 2
MouseDriver ax%, 0, 0, 0
END SUB

FUNCTION MOUSEINIT%
ax% = 0
MouseDriver ax%, 0, 0, 0
MSI% = ax%
IF NOT MSI% THEN MOUSEINIT% = 0 ELSE MOUSEINIT% = 1
END FUNCTION

SUB mousesetpos (x%, y%)
ax% = 4
cx% = x%
dx% = y%
MouseDriver ax%, 0, cx%, dx%
END SUB

SUB mouseshow
ax% = 1
MouseDriver ax%, 0, 0, 0
END SUB

SUB mousestats
ax% = 3
MouseDriver ax%, BX%, cx%, dx%
b% = BX%
IF MODE% = 13 THEN MX% = cx% / 2 ELSE MX% = cx%
MY% = dx%
ax% = 27
BX% = 0
cx% = 0
dx% = 0
MouseDriver ax%, BX%, cx%, dx%
SH% = BX%
SV% = cx%
ST% = dx%
END SUB

SUB saver
mousehide
oldmx% = MX%
oldmy% = MY%
backsave "temp"
SHELL "c:\bas\rad2.exe 59"
backload "temp"
mousesetpos oldmx%, oldmy%
mouseshow
END SUB

SUB setrange (x1%, y1%, x2%, y2%)
ax% = 7
cx% = x1%
IF MODE% <> 12 AND MODE% <> 2 AND MODE% <> 8 AND MODE% <> 9 AND MODE% <> 10 AND MODE% <> 11 THEN dx% = x2% * 2 ELSE dx% = x2%
MouseDriver ax%, 0, cx%, dx%
ax% = 8
cx% = y1%
dx% = y2%
MouseDriver ax%, 0, cx%, dx%
END SUB

SUB wndow (x, y, xsize, ysize, title$, totmes, num)
oldhl = highl
highl = 0
IF xsize < 30 OR ysize < 10 THEN EXIT SUB
row = y: height = ysize
column = x: length = xsize - 3
mousehide
IF title$ <> "NO BACKGRND" THEN backsave "temp" + MID$(STR$(num), 2)
IF title$ = "NO BACKGRND" THEN title$ = "MESSAGE"
LINE (column, row)-(column + length, row + height), 0, B
FOR i% = 1 TO 2
   row = row + 1: column = column + 1: height = height - 1: length = length - 1
   LINE (column, row)-(column + length, row), 7
   LINE (column, row)-(column, row + height), 7
NEXT i%
row = row + 1: column = column + 1: height = height - 1: length = length - 1
LINE (column, row)-(column + length, row), 0
LINE (column, row)-(column, row + height), 0
LINE (column, row)-(column + 18, row + 18), 7, BF
LINE (column, row)-(column + 18, row + 18), 0, B
LINE (column + 18, row - 2)-(column + 18, row + 5), 0
LINE (column - 2, row + 18)-(column + 5, row + 18), 0
CIRCLE (column + 9, row + 9), 4, 8
CIRCLE (column + 9, row + 9), 5, 8
CIRCLE (column + 9, row + 9), 3, 15
PAINT (column + 9, row + 9), 15
LINE (column + 18, row)-(column + length, row + 18), 9, BF
LINE (column + 18, row)-(column + length, row + 18), 0, B
LINE (column + length, row - 3)-(column + length + 2, row + height), 7, BF
LINE (column + length, row - 3)-(column + length + 3, row + height), 0, B
LINE (column + length, row - 2)-(column + length, row - 1), 7
LINE (column + length - 18, row - 2)-(column + length - 18, row - 1), 0
LINE (column + length, row + 18)-(column + length + 2, row + 18), 0
LINE (column, row + height - 3)-(column + length, row + height - 3), 0, B
LINE (column, row + height - 2)-(column + length + 2, row + height), 7, BF
LINE (column - 2, row + height)-(column + length + 2, row + height), 0, B
LINE (column - 2, row + height - 18)-(column, row + height - 18), 0
LINE (column + length - 2, row + height - 18)-(column + length + 2, row + height - 18), 0
LINE (column + 18, row + height)-(column + 18, row + height - 2), 0
LINE (column + length - 18, row + height)-(column + length - 18, row + height - 2), 0
LINE (column + 1, row + 19)-(column + length - 1, row + height - 4), 7, BF
VIEW SCREEN (column + 19, row + 1)-(column + length - 1, row + 20)
font title$, column + ABS((length / 2) - (LEN(title$) * 4)), row + 2, -1, 15, 1, 1, 1
VIEW
IF totmes <> 0 THEN
   VIEW SCREEN (column, row + 20)-(column + length - 1, row + height)
   FOR i = 1 TO totmes
      font mes$(i), column + 5, row + (fb% + 2) * (i) + 20 - fb%, -1, 15, 1, 1, 1
   NEXT i
   VIEW
END IF
mouseshow
highl = oldhl
END SUB

SUB wndwmngr (x, y, length, hth, num)
hth = hth - 1: length = length - 1
IF MX% >= x AND MX% <= x + length AND MY% >= y AND MY% < y + hth THEN
  IF MX% <= x + 20 AND MY% <= y + 20 AND b% = left% AND MX% > x + 2 AND MY% > y + 2 THEN BEEP: EXIT SUB
  IF (MX% >= x AND MY% >= y AND cursr% <> 10) AND ((MX% <= x + 2 AND MY% <= y + 20) OR (MX% <= x + 20 AND MY% <= y + 2)) THEN cursor 10: EXIT SUB
  IF cursr% <> 10 AND MX% <= x + length AND MY% <= y + hth AND ((MX% >= x + length - 20 AND MY% >= y + hth - 2) OR (MX% >= x + length - 2 AND MY% >= y + hth - 20)) THEN cursor 10: EXIT SUB
  IF cursr% <> 9 AND MX% >= x AND MY% <= y + hth AND ((MX% <= x + 2 AND MY% >= y + hth - 20) OR (MX% <= x + 20 AND MY% >= y + hth - 2)) THEN cursor 9
  IF cursr% <> 9 AND MX% <= x + length AND MY% >= y AND ((MX% >= x + length - 20 AND MY% <= y + 2) OR (MX% >= x + length - 2 AND MY% <= y + 20)) THEN cursor 9
  IF cursr% <> 7 AND MX% >= x AND MX% <= x + 2 AND MY% >= y + 21 AND MY% <= y + hth - 21 THEN cursor 7
  IF cursr% <> 7 AND MX% >= x + length - 2 AND MX% <= x + length AND MY% >= y + 21 AND MY% <= y + hth - 21 THEN cursor 7
  IF cursr% <> 8 AND MX% >= x + 21 AND MX% <= x + length - 21 AND MY% >= y AND MY% <= y + 2 THEN cursor 8
  IF cursr% <> 8 AND MX% >= x + 21 AND MX% <= x + length - 21 AND MY% >= y + hth - 2 AND MY% <= y + hth THEN cursor 8
END IF
IF b% = left% AND cursr% <> 1 THEN
   DO
      mousestats
   LOOP UNTIL b% <> 1
END IF
IF cursr% <> 1 AND ((MX% < x OR MY% < y OR MX% > x + length OR MY% > y + hth) OR (MX% > x + 2 AND MY% > y + 2 AND MX% < x + length - 2 AND MY% < y + hth - 2)) THEN cursor 1

END SUB

