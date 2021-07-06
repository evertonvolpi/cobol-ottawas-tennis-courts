       IDENTIFICATION DIVISION.
       PROGRAM-ID. READINDEX.
       AUTHOR. EVERTON VOLPI.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   
	   SELECT TENNISCOURTS ASSIGN TO "indexed.dat"
        FILE STATUS IS FILE-CHECK-KEY
        ORGANIZATION IS INDEXED
        ACCESS MODE IS DYNAMIC
        RECORD KEY IS ROW-ID-IDX 
        ALTERNATE RECORD KEY IS REGION-IDX WITH DUPLICATES
        ALTERNATE RECORD KEY IS LIGHTS-IDX WITH DUPLICATES
        ALTERNATE RECORD KEY IS CLUBHOUSE-IDX WITH DUPLICATES
        ALTERNATE RECORD KEY IS BENCHES-IDX WITH DUPLICATES
        ALTERNATE RECORD KEY IS FENCE-IDX WITH DUPLICATES
        ALTERNATE RECORD KEY IS PRACTICE-IDX WITH DUPLICATES
        ALTERNATE RECORD KEY IS BACKWALL-IDX WITH DUPLICATES.
		       
       DATA DIVISION.
       FILE SECTION.
	   FD TENNISCOURTS.
	   01 TENNISCOURTSIDX.
	       88 ENDOFFILE            VALUE HIGH-VALUES.
           05 ROW-ID-IDX           PIC 9(3).
           05 PARK-ID-IDX          PIC X(10).
           05 REGION-IDX           PIC A(13).
           05 PARK-NAME-IDX        PIC A(62).
           05 PARK-ADDRESS-IDX     PIC A(51).
           05 TOTAL-COURTS-IDX     PIC X(5).
           05 INDOOR-COURTS-IDX    PIC X(5).
           05 OUTDOOR-COURTS-IDX   PIC X(10).
           05 LIGHTS-IDX           PIC X(9).
           05 CLUBHOUSE-IDX        PIC X(9).
           05 BENCHES-IDX          PIC X(9).
           05 FENCE-IDX            PIC X(9).
           05 PRACTICE-IDX         PIC X(9).
           05 BACKWALL-IDX         PIC X(9).
		
       WORKING-STORAGE SECTION.
       01  WS-WORKING-STORAGE.
           05 FILLER               PIC X(27) VALUE 
		      'WORKING STORAGE STARTS HERE'.    
   
	   01  WS-WORK-AREAS.
	       05  FILE-CHECK-KEY      PIC X(2).
		       88 RECORDFOUND      VALUE "00".
			   
		   05  READTYPE            PIC 9.
		       88 ROW-ID-KEY       VALUE 1.
		       88 REGION-KEY       VALUE 2.
               88 LIGHTS-KEY       VALUE 3.
               88 CLUB-KEY         VALUE 4.
               88 BENCHES-KEY      VALUE 5.
               88 FENCE-KEY        VALUE 6.
               88 PRACTICE-KEY     VALUE 7.
               88 BACKWALL-KEY     VALUE 8.
               88 ALL-KEY          VALUE 9.

           05 REGION-CHOICE        PIC A.
           05 MENU-CHOICE          PIC A.
           05 WS-REGION            PIC X(13).
           05 WS-FOUND             PIC 999 VALUE ZEROES.
       
       01  BLANK-LINE.
           05 FILLER       PIC X(200) VALUE SPACES.

       01  HEADING-LINE.
           05 FILLER	   PIC X(6)  VALUE 'ID'.
           05 FILLER	   PIC X(7)  VALUE 'PARK#'.
           05 FILLER	   PIC X(13)  VALUE 'REGION'.
           05 FILLER	   PIC X(62)  VALUE 'PARK'.
           05 FILLER	   PIC X(50)  VALUE 'ADDRESS'.
           05 FILLER	   PIC X(7)  VALUE 'TOTAL'.
           05 FILLER	   PIC X(4)  VALUE 'IN'.
           05 FILLER	   PIC X(7)  VALUE 'OUT'.
           05 FILLER       PIC X(8)  VALUE 'LIGHTS'.
           05 FILLER       PIC X(10)  VALUE 'CLUBHOUSE'.
           05 FILLER       PIC X(10)  VALUE 'BENCHES'.
           05 FILLER       PIC X(9)  VALUE 'FENCE'.
           05 FILLER       PIC X(8)  VALUE 'PRACT.'.
           05 FILLER       PIC X(8)  VALUE 'BACKWALL'.

       01  TITLE-LINE.
           05 FILLER       PIC X(15)  VALUE '---------------'.
		   05 FILLER       PIC X(5)  VALUE SPACES.
           05 FILLER       PIC X(14)  VALUE 'CITY OF OTTAWA'.
           05 FILLER       PIC X(16)  VALUE ' - TENNIS COURTS'.
		   05 FILLER       PIC X(5)  VALUE SPACES.
           05 FILLER       PIC X(15)  VALUE '---------------'.

       01  FOOTER-LINE.
           05 FILLER       PIC X(15)  VALUE 'RESULTS FOUND: '.
		   05 FOUND        PIC ZZ9.

       PROCEDURE DIVISION.
       0100-START.

		   OPEN INPUT TENNISCOURTS.
           DISPLAY 'ID                        ENTER 1'.
		   DISPLAY 'REGION                    ENTER 2'.
           DISPLAY 'HAS/HAVE LIGHTS           ENTER 3'.
           DISPLAY 'HAS/HAVE CLUBHOUSE        ENTER 4'.
           DISPLAY 'HAS/HAVE BENCHES          ENTER 5'.
           DISPLAY 'HAS/HAVE FENCE            ENTER 6'.
           DISPLAY 'HAS/HAVE PRACTICE COURT   ENTER 7'.
           DISPLAY 'HAS/HAVE BACKWALL         ENTER 8'.
           DISPLAY 'ALL ENTRIES               ENTER 9'.			  
		   ACCEPT READTYPE.
		   
		   IF ROW-ID-KEY 
		      DISPLAY "ENTER ROW ID (3 DIGITS): " 
			    WITH NO ADVANCING		    
			  ACCEPT ROW-ID-IDX
			  READ TENNISCOURTS
			    KEY IS ROW-ID-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
           END-IF.

           IF REGION-KEY
              DISPLAY 'CUMBERLAND       ENTER A'
              DISPLAY 'GLOUCESTER       ENTER B'     
              DISPLAY 'GOULBOURN        ENTER C'    
              DISPLAY 'KANATA           ENTER D' 
              DISPLAY 'NEPEAN           ENTER E' 
              DISPLAY 'OSGOODE          ENTER F'  
              DISPLAY 'OTTAWA           ENTER G' 
              DISPLAY 'RIDEAU           ENTER H' 
              DISPLAY 'ROCKCLIFFE       ENTER I'     
              DISPLAY 'VANIER           ENTER J' 
              DISPLAY 'WEST CARLE       ENTER K'   
			  ACCEPT REGION-CHOICE
              EVALUATE REGION-CHOICE
                  WHEN 'A'
                     MOVE 'Cumberland'     TO REGION-IDX
                  WHEN 'B'
                     MOVE 'Gloucester'     TO REGION-IDX
                  WHEN 'C'
                     MOVE 'Goulbourn'      TO REGION-IDX
                  WHEN 'D'
                     MOVE 'Kanata'         TO REGION-IDX
                  WHEN 'E'
                     MOVE 'Nepean'         TO REGION-IDX
                  WHEN 'F'
                     MOVE 'Osgoode'        TO REGION-IDX
                  WHEN 'G'
                     MOVE 'Ottawa'         TO REGION-IDX
                  WHEN 'H'
                     MOVE 'Rideau'         TO REGION-IDX
                  WHEN 'I'
                     MOVE 'Rockcliffe'     TO REGION-IDX
                  WHEN 'J'
                     MOVE 'Vanier'         TO REGION-IDX
                  WHEN 'K'
                     MOVE 'West Carle'     TO REGION-IDX
              END-EVALUATE
              MOVE REGION-IDX TO WS-REGION
              READ TENNISCOURTS
                KEY IS REGION-IDX			  
                INVALID KEY DISPLAY "STATUS: ", FILE-CHECK-KEY
              END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
              PERFORM 0200-REGION-READ-NEXT THRU 0200-END
                   UNTIL ENDOFFILE
              MOVE WS-FOUND TO FOUND
              DISPLAY FOOTER-LINE
		   END-IF.

           IF LIGHTS-KEY 
		      MOVE 'Y' TO LIGHTS-IDX
			  READ TENNISCOURTS
			    KEY IS LIGHTS-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
               PERFORM 0220-LIGHT-READ-NEXT THRU 0220-END
                   UNTIL ENDOFFILE
              MOVE WS-FOUND TO FOUND
              DISPLAY FOOTER-LINE
           END-IF.

           IF CLUB-KEY 
		      MOVE 'Y' TO CLUBHOUSE-IDX
			  READ TENNISCOURTS
			    KEY IS CLUBHOUSE-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
               PERFORM 0240-CLUB-READ-NEXT THRU 0240-END
                   UNTIL ENDOFFILE
               MOVE WS-FOUND TO FOUND
               DISPLAY FOOTER-LINE
           END-IF.

           IF BENCHES-KEY 
		      MOVE 'Y' TO BENCHES-IDX
			  READ TENNISCOURTS
			    KEY IS BENCHES-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
               PERFORM 0260-BENCHES-READ-NEXT THRU 0260-END
                   UNTIL ENDOFFILE
               MOVE WS-FOUND TO FOUND
               DISPLAY FOOTER-LINE
           END-IF.

           IF FENCE-KEY 
		      MOVE 'Y' TO FENCE-IDX
			  READ TENNISCOURTS
			    KEY IS FENCE-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
               PERFORM 0280-FENCE-READ-NEXT THRU 0280-END
                   UNTIL ENDOFFILE
               MOVE WS-FOUND TO FOUND
               DISPLAY FOOTER-LINE
           END-IF.

           IF PRACTICE-KEY 
		      MOVE 'Y' TO PRACTICE-IDX
			  READ TENNISCOURTS
			    KEY IS PRACTICE-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
               PERFORM 0300-PRACTICE-READ-NEXT THRU 0300-END
                   UNTIL ENDOFFILE
               MOVE WS-FOUND TO FOUND
               DISPLAY FOOTER-LINE
           END-IF.

           IF BACKWALL-KEY 
		      MOVE 'Y' TO BACKWALL-IDX
			  READ TENNISCOURTS
			    KEY IS BACKWALL-IDX
			    INVALID KEY DISPLAY "STATUS: ", 
                   FILE-CHECK-KEY
			  END-READ
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = 1
               PERFORM 0320-BACKWALL-READ-NEXT THRU 0320-END
                   UNTIL ENDOFFILE
               MOVE WS-FOUND TO FOUND
               DISPLAY FOOTER-LINE
           END-IF.
           
           IF ALL-KEY
               READ TENNISCOURTS 
                 KEY IS ROW-ID-IDX
                 END-READ
                 DISPLAY TITLE-LINE
                 DISPLAY HEADING-LINE
                 COMPUTE WS-FOUND = 0
               PERFORM 0350-READ-ALL THRU 0350-END 
                  UNTIL ENDOFFILE
               MOVE WS-FOUND TO FOUND
               DISPLAY FOOTER-LINE
           END-IF.

		   IF RECORDFOUND
               COMPUTE WS-FOUND = 1
               MOVE WS-FOUND TO FOUND
               DISPLAY TITLE-LINE
               DISPLAY HEADING-LINE
			   DISPLAY TENNISCOURTSIDX
               DISPLAY FOOTER-LINE
		   END-IF.

		   PERFORM 0400-MENU.
		   
	   0100-END.

       0200-REGION-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
            END-READ. 		  
           IF REGION-IDX = WS-REGION
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.        
       0200-END.

       0220-LIGHT-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
            END-READ. 		  
           IF LIGHTS-IDX = 'Y'
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.
       0220-END.

       0240-CLUB-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
            END-READ. 		  
           IF CLUBHOUSE-IDX = 'Y'
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.
       0240-END.

       0260-BENCHES-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
            END-READ. 		  
           IF BENCHES-IDX = 'Y'
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.
       0260-END.

       0280-FENCE-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
            END-READ. 		  
           IF FENCE-IDX = 'Y'
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.
       0280-END.

       0300-PRACTICE-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
           END-READ. 		  
           IF PRACTICE-IDX = 'Y'
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.
       0300-END.

       0320-BACKWALL-READ-NEXT.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
           END-READ. 		  
           IF BACKWALL-IDX = 'Y'
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.
       0320-END.

       0350-READ-ALL.
           READ TENNISCOURTS NEXT RECORD
             AT END SET ENDOFFILE TO TRUE
           END-READ. 		  
           IF RECORDFOUND 
			   DISPLAY TENNISCOURTSIDX
               COMPUTE WS-FOUND = WS-FOUND + 1
           END-IF.        
       0350-END.

       0400-MENU.
           DISPLAY BLANK-LINE.
           DISPLAY 'NEW SEARCH    ENTER N'.
           DISPLAY 'QUIT          ENTER Q'.
           ACCEPT MENU-CHOICE.
           EVALUATE MENU-CHOICE
               WHEN 'N'
                   DISPLAY BLANK-LINE
                   PERFORM 0100-START
               WHEN 'Q'
                   PERFORM 9000-END-PROGRAM
           END-EVALUATE.
       0400-END.   
	 
	   9000-END-PROGRAM.
           CLOSE TENNISCOURTS.    	   
		                 
           STOP RUN.
           
          END PROGRAM READINDEX.
