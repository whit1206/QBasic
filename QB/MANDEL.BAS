CLS
SCREEN 12
   FOR Y = 0 TO 479
        FOR X = 0 TO 639
            'LOCATE 1, 1: PRINT X, Y
            creal = (X - 320) / 300
            cimag = (Y - 240) / 200
            zreal = 0
            zimag = 0
            FOR counter = 0 TO 50
                IF zreal ^ 2 + zimag ^ 2 > 4 THEN
                    PSET (X, Y), counter MOD 16
                    EXIT FOR
                END IF
                znewreal = zreal ^ 2 - zimag ^ 2 + creal
                znewimag = 2 * zreal * zimag + cimag
                zimag = znewimag
                zreal = znewreal
            NEXT counter

        NEXT X
   NEXT Y

