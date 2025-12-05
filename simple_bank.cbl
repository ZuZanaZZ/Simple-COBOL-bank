      * Simulation of a simple bank.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SimpleBank.

      * Loading file with clients.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT Client
           ASSIGN TO "./clients.dat"
           ORGANISATION IS LINE SEQUENTIAL. 

       DATA DIVISION.
       FILE SECTION.
       FD Client.
       01 CRecord.
           03 ClientName       PIC A(16).
           03 Filler           PIC X(1).
           03 ClientSurname    PIC A(16).
           03 Filler           PIC X(1).
           03 ClientID         PIC X(8).
           03 Filler           PIC X(1).
           03 ClientFund       PIC 9(16).

       WORKING-STORAGE SECTION.
       01 BankInfo.
           03 BankName         PIC A(30) VALUE "BankX".
           03 BankFund         PIC 9(16) VALUE 10000000.
       01 TrInfo.
           03 TrTotal          PIC 9(16).

      * File handling https://www.geeksforgeeks.org/cobol/file-handling-in-cobol/
       01 EndOfFile            PIC X(3) VALUE "NO".
       01 CIndex               PIC 9(2) VALUE 1.
       01 CLoop                PIC 9(2) VALUE 1.
       01 SelectedClient       PIC 9(2).
       01 ClientTable.
           03 ClientEntry OCCURS 10 TIMES.
               05 ClientNames       PIC A(16).
               05 ClientSurnames    PIC A(16).
               05 ClientIDs         PIC X(8).
               05 ClientFunds       PIC 9(16).

       PROCEDURE DIVISION.
      * Main Procedure
           PERFORM LoadClientsProcedure
           PERFORM SelectClientProcedure
           CALL "MakeTransaction" USING BankInfo, TrInfo,
      -        CIndex, ClientTable.
           STOP RUN.

       LoadClientsProcedure.
           OPEN INPUT Client
               PERFORM UNTIL EndOfFile = 'YES' 
                   PERFORM ReadClientProcedure
               END-PERFORM
           CLOSE Client.

       ReadClientProcedure.
           READ Client
               AT END 
                   MOVE "YES" TO EndOfFile
               NOT AT END
                   MOVE ClientName TO ClientNames(CIndex)
                   MOVE ClientSurname TO ClientSurnames(CIndex)
                   MOVE ClientID TO ClientIDs(CIndex)
                   MOVE ClientFund TO ClientFunds(CIndex)

                   ADD 1 TO CIndex
           END-READ.

       SelectClientProcedure.
           DISPLAY "Select client by number."
           DISPLAY "Available clients:"
           CALL "DisplayClients" USING CLoop, CIndex, ClientTable.
           DISPLAY "Or add a new client by pressing ""0"""
           ACCEPT SelectedClient
       
           IF SelectedClient = 0 THEN
               PERFORM AddNewClientProcecure
               DISPLAY "Added a new client."
           ELSE
               MOVE SelectedClient TO CIndex
               DISPLAY "You Selected: " 
               DISPLAY ClientNames(CIndex) " " ClientSurnames(CIndex)
           END-IF.
       
       AddNewClientProcecure.
      * Adds new client to the file
      * Writing to file: https://codesignal.com/learn/courses/cobol-file-handling/lessons/creating-and-writing-to-a-sequential-file
           DISPLAY "Enter character name:"
           ACCEPT ClientName
           DISPLAY "Enter character surname:"
           ACCEPT ClientSurname
           DISPLAY "Enter 8 character alphanumeric ID:"
           ACCEPT ClientID
           DISPLAY "Enter your funds:"
           ACCEPT ClientFund

           OPEN EXTEND Client
           WRITE CRecord
           CLOSE Client

           MOVE ClientName TO ClientNames(CIndex)
           MOVE ClientSurname TO ClientSurnames(CIndex)
           MOVE ClientID TO ClientIDs(CIndex)
           MOVE ClientFund TO ClientFunds(CIndex).
       
       END PROGRAM SimpleBank.