       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROCESSCSV.
       AUTHOR. EVERTON VOLPI.

       ENVIRONMENT DIVISION.                
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   SELECT TENNISCOURTS ASSIGN TO "ottawaTennisCourts.csv"
           FILE STATUS IS INPUT-FILE-CHECK-KEY
           ORGANIZATION IS LINE SEQUENTIAL.
	
       SELECT PRTENNISCOURTS ASSIGN TO "ottawaTennisCourts.dat"
           FILE STATUS IS OUTPUT-FILE-CHECK-KEY
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
	   FD TENNISCOURTS.
	   01 INPUTDETAILS.
           88 ENDOFFILE VALUE HIGH-VALUES.
           02 DETAILS  	 PIC X(145).
		
       FD PRTENNISCOURTS.
       01 PR-RECORD.
	       05  ROW-ID               PIC 999.
           05  PARK-ID              PIC ZZZ9999BBB.
           05  REGION               PIC A(13).
		   05  PARK-NAME            PIC A(62).
           05  PARK-ADDRESS         PIC A(51).
		   05  TOTAL-COURTS         PIC Z9BBB.
		   05  INDOOR-COURTS        PIC Z9BBB.
		   05  OUTDOOR-COURTS       PIC Z9BBBBBBBB.
		   05  LIGHTS               PIC A(9).
		   05  CLUBHOUSE            PIC A(9).
		   05  BENCHES              PIC A(9).
		   05  FENCE                PIC A(9).
		   05  PRACTICE-COURT       PIC A(9).
		   05  BACKWALL             PIC A(9).

       WORKING-STORAGE SECTION.   
	   01  WS-WORKING-STORAGE.
	       05  FILLER  PIC X(27) VALUE 
		       'WORKING STORAGE STARTS HERE'.		
	       05  WS-ROW-ID            PIC 9(3).
           05  WS-PARK-ID           PIC 9(4).
		   05  WS-PARK-NAME         PIC A(59).
           05  WS-PARK-ADDRESS      PIC A(48).
           05  WS-REGION            PIC A(10).
		   05  WS-TOTAL-COURTS      PIC 9(2).
		   05  WS-INDOOR-COURTS     PIC 9(2).
		   05  WS-OUTDOOR-COURTS    PIC 9(2).
		   05  WS-LIGHTS            PIC X(7).
		   05  WS-CLUBHOUSE         PIC X(7).
		   05  WS-BENCHES           PIC X(7).
		   05  WS-FENCE             PIC X(7).
		   05  WS-PRACTICE-COURT    PIC X(7).
		   05  WS-BACKWALL          PIC X(7).		   
           05  STRINGEND            PIC 9999.

       01  WS-WORK-AREAS.
           05  INPUT-FILE-CHECK-KEY   PIC X(2).
           05  OUTPUT-FILE-CHECK-KEY  PIC X(2).	   

       PROCEDURE DIVISION.
       
	   0100-BEGIN.
		    
		   OPEN INPUT TENNISCOURTS.
		   OPEN OUTPUT PRTENNISCOURTS.

           IF INPUT-FILE-CHECK-KEY NOT= "00" 
               DISPLAY "Non-zero file status: ", INPUT-FILE-CHECK-KEY
               GO TO 0300-STOP-RUN
           END-IF.
	
		   READ TENNISCOURTS
		     AT END SET ENDOFFILE TO TRUE
		     END-READ.
		  		   
           PERFORM 0200-PROCESS-RECORDS UNTIL ENDOFFILE.
		 
		   PERFORM 0300-STOP-RUN.
	   
	   0200-PROCESS-RECORDS.
	       
		   PERFORM VARYING STRINGEND FROM 146 BY -1
               UNTIL DETAILS(STRINGEND:1) NOT = SPACE
		   END-PERFORM.
			  
           UNSTRING INPUTDETAILS(1:STRINGEND) DELIMITED BY ","
               INTO WS-ROW-ID         
                    WS-PARK-ID        
		            WS-PARK-NAME      
                    WS-PARK-ADDRESS    
                    WS-REGION    
		            WS-TOTAL-COURTS   
		            WS-INDOOR-COURTS  
		            WS-OUTDOOR-COURTS 
		            WS-LIGHTS         
		            WS-CLUBHOUSE      
		            WS-BENCHES        
		            WS-FENCE          
		            WS-PRACTICE-COURT 
		            WS-BACKWALL
           END-UNSTRING.

           MOVE WS-ROW-ID            TO ROW-ID.
		   MOVE WS-PARK-ID           TO PARK-ID.
           MOVE WS-PARK-NAME         TO PARK-NAME.
		   MOVE WS-PARK-ADDRESS      TO PARK-ADDRESS.
		   MOVE WS-REGION            TO REGION.
		   MOVE WS-TOTAL-COURTS      TO TOTAL-COURTS.	
		   MOVE WS-INDOOR-COURTS     TO INDOOR-COURTS.	
		   MOVE WS-OUTDOOR-COURTS    TO OUTDOOR-COURTS.	
           IF WS-LIGHTS  = 'yes/oui'
              MOVE 'Y' TO LIGHTS
           ELSE MOVE 'N' TO LIGHTS
           END-IF.
           IF WS-CLUBHOUSE = 'yes/oui'
              MOVE 'Y' TO CLUBHOUSE
           ELSE MOVE 'N' TO CLUBHOUSE
           END-IF.
           IF WS-BENCHES = 'yes/oui'
              MOVE 'Y' TO BENCHES
           ELSE MOVE 'N' TO BENCHES
           END-IF.
           IF WS-FENCE = 'yes/oui'
              MOVE 'Y' TO FENCE
           ELSE MOVE 'N' TO FENCE
           END-IF.
           IF WS-PRACTICE-COURT = 'yes/oui'
              MOVE 'Y' TO PRACTICE-COURT
           ELSE MOVE 'N' TO PRACTICE-COURT
           END-IF.
		   IF WS-BACKWALL = 'yes/oui'
              MOVE 'Y' TO BACKWALL
           ELSE MOVE 'N' TO BACKWALL
           END-IF.
		
		   WRITE PR-RECORD
           END-WRITE.
		   
           READ TENNISCOURTS 
               AT END SET ENDOFFILE TO TRUE
		   END-READ.
	   
	   0200-END.
	   
	   0300-STOP-RUN.	
		
           CLOSE TENNISCOURTS, PRTENNISCOURTS.		
           STOP RUN.
           
       END PROGRAM PROCESSCSV.
