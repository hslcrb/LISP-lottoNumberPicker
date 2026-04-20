       IDENTIFICATION DIVISION.
       PROGRAM-ID. LOTTO-REPORTER.
       AUTHOR. POLY-LOTTO-SYSTEM.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.

       DATA DIVISION.
       FILE SECTION.

       WORKING-STORAGE SECTION.
       01 WS-INPUT-LINE         PIC X(80).
       01 WS-EOF                PIC X VALUE 'N'.
       01 WS-GAME-COUNT         PIC 9(4) VALUE 0.
       01 WS-NUM-ARRAY.
          05 WS-NUM             PIC 99 OCCURS 6 TIMES.
       01 WS-I                  PIC 9.
       
       01 WS-REPORT-HEADER.
          05 FILLER             PIC X(40) VALUE 
             "========================================".
       01 WS-REPORT-TITLE.
          05 FILLER             PIC X(10) VALUE " ".
          05 FILLER             PIC X(25) VALUE "LOTTO BUSINESS REPORT".
       
       01 WS-LINE-OUT.
          05 FILLER             PIC X(10) VALUE "GAME #".
          05 WS-OUT-COUNT       PIC ZZZ9.
          05 FILLER             PIC X(5) VALUE " : ".
          05 WS-OUT-NUMS        PIC X(20).

       PROCEDURE DIVISION.
       MAIN-LOGIC.
           DISPLAY WS-REPORT-HEADER.
           DISPLAY WS-REPORT-TITLE.
           DISPLAY WS-REPORT-HEADER.
           DISPLAY " SEQ | NUMBERS ".
           DISPLAY "-----+----------------------------------".

           PERFORM UNTIL WS-EOF = 'Y'
               ACCEPT WS-INPUT-LINE
               IF WS-INPUT-LINE = SPACES
                   MOVE 'Y' TO WS-EOF
               ELSE
                   ADD 1 TO WS-GAME-COUNT
                   DISPLAY " " WS-GAME-COUNT " | " WS-INPUT-LINE
               END-IF
           END-PERFORM.

           DISPLAY "-----+----------------------------------".
           DISPLAY " TOTAL GAMES PROCESSED: " WS-GAME-COUNT.
           DISPLAY WS-REPORT-HEADER.
           STOP RUN.
