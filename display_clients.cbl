       IDENTIFICATION DIVISION.
       PROGRAM-ID. DisplayClients.
       
       DATA DIVISION.
       LINKAGE SECTION.
       01 L-CIndex    PIC 9(2).
       01 L-CLoop       PIC 9(2).
       01 L-ClientTable.
           03 L-ClientEntry OCCURS 10 TIMES.
               05 L-ClientNames       PIC A(4).
               05 L-ClientSurnames    PIC A(3).
               05 L-ClientIDs         PIC X(8).
               05 L-ClientFunds       PIC 9(3).

       PROCEDURE DIVISION USING L-CLoop, L-CIndex, L-ClientTable.
       PERFORM DisplayClientsProcedure.
       EXIT PROGRAM.

       DisplayClientsProcedure.
           PERFORM DisplayClientProcedure UNTIL L-CLoop=L-CIndex.

       DisplayClientProcedure.
      * Displays 1 client 
           DISPLAY L-CLoop":" L-ClientNames(L-CLoop) " "
      -    L-ClientSurnames(L-CLoop)
           ADD 1 TO L-CLoop.
