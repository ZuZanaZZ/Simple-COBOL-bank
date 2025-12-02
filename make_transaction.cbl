       IDENTIFICATION DIVISION.
       PROGRAM-ID. MakeTransaction.
       
       DATA DIVISION.
       LINKAGE SECTION.
       01 L-BankInfo.
           03 L-BankName             PIC A(30).
           03 L-BankFund             PIC 9(16).
       01 L-TrInfo.
           03 L-TrTotal              PIC 9(16).
       01 L-CIndex                     PIC 9(2).
       01 L-ClientTable.
           03 L-ClientEntry            OCCURS 10 TIMES.
               05 L-ClientNames        PIC A(16).
               05 L-ClientSurnames     PIC A(16).
               05 L-ClientIDs          PIC X(8).
               05 L-ClientFunds        PIC 9(16).

       PROCEDURE DIVISION USING L-BankInfo, L-TrInfo,
      -         L-CIndex, L-ClientTable.
       PERFORM MakeTransactionProcedure.
       EXIT PROGRAM.
       
       MakeTransactionProcedure.
      * Setting up the transaction.
           DISPLAY "You have " L-ClientFunds(L-CIndex) " coins."
           DISPLAY "How much would you like to transfer to your bank?"
           ACCEPT L-TrTotal

      * Checking if client has enough funds.
           IF L-ClientFunds(L-CIndex) >= L-TrTotal THEN
      *    Transaction was successful
               DISPLAY "Client transfers " L-TrTotal " coins."
               SUBTRACT L-TrTotal FROM L-ClientFunds(L-CIndex)
               ADD L-TrTotal TO L-BankFund

      *    Displaying information about the transaction.     
               DISPLAY "Transaction was successful."
               DISPLAY "Client funds: " L-ClientFunds(L-CIndex)
               DISPLAY "Bank funds: " L-BankFund

      *    Transaction was unsuccessful due to lack of funds.
           ELSE
               DISPLAY "Transaction was unsuccessful."
               DISPLAY "You do not have enough funds."
           END-IF.



