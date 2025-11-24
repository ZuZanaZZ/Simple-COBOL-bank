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
           03 ClientName       PIC A(4).
           03 Filler           PIC X(1).
           03 ClientSurname    PIC A(3).
           03 Filler           PIC X(1).
           03 ClientID         PIC X(8).
           03 Filler           PIC X(1).
           03 ClientFund       PIC 9(3).

       WORKING-STORAGE SECTION.
       01 BankInfo.
           03 BankName         PIC A(30) VALUE "BankX".
           03 BankFund         PIC 9(20) VALUE 10000000.
       01 TransactionInfo.
           03 TransactionTotal PIC 9(20).

      * File handling https://www.geeksforgeeks.org/cobol/file-handling-in-cobol/
       01 EndOfFile            PIC X(3) VALUE "NO".
       01 CIndex               PIC 9(2) VALUE 1.
       01 CLoop                PIC 9(2) VALUE 1.
       01 SelectedClient       PIC 9(2).
       01 ClientTable.
           03 ClientEntry OCCURS 10 TIMES.
               05 ClientNames       PIC A(4).
               05 ClientSurnames    PIC A(3).
               05 ClientIDs         PIC X(8).
               05 ClientFunds       PIC 9(3).

       PROCEDURE DIVISION.
      * Main Procedure
           PERFORM LoadClientsProcedure
           PERFORM SelectClientProcedure
           PERFORM MakeTransactionProcedure.

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
           PERFORM DisplayClientsProcedure
           ACCEPT SelectedClient
       
           MOVE SelectedClient TO CIndex
           DISPLAY "You Selected: " 
           DISPLAY ClientNames(CIndex) " " ClientSurnames(CIndex)
           DISPLAY "You have " ClientFunds(CIndex) " coins in account.".

       DisplayClientsProcedure.
      * Displays available clients
           PERFORM DisplayClientProcedure UNTIL CLoop=CIndex.

       DisplayClientProcedure.
           DISPLAY CLoop":" ClientNames(CLoop) " " ClientSurnames(CLoop)
           ADD 1 TO CLoop.

       MakeTransactionProcedure.
      * Setting up the transaction.
           DISPLAY "How much would you like to transfer to your bank?".
           ACCEPT TransactionTotal

      * Checking if client has enough funds.
           IF ClientFunds(CIndex) >= TransactionTotal THEN
      *    Transaction was successful
                  DISPLAY "Client transfers " TransactionTotal
                  DISPLAY "coins to the bank"
                  SUBTRACT TransactionTotal FROM ClientFunds(CIndex)
                  ADD TransactionTotal TO BankFund

      *    Displaying information about the transaction.     
                  DISPLAY "Transaction was successful."
                  DISPLAY "Client funds: " ClientFunds(CIndex)
                  DISPLAY "Bank funds: " BankFund

      *    Transaction was unsuccessful due to lack of funds.
           ELSE
               DISPLAY "Transaction was unsuccessful."
               DISPLAY "You do not have enough funds."
           END-IF.

           STOP RUN.
       END PROGRAM SimpleBank.
