      *> Simulation of a simple bank.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANK.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 ClientInfo.
           03 ClientName   PIC A(30).
           03 ClientID     PIC X(8) VALUE "1234abcd".
           03 ClientFunds  PIC 9(20) VALUE 100.
       01 BankInfo.
           03 BankName     PIC A(30) VALUE "BankX".
           03 BankFunds    PIC 9(20) VALUE 10000000.

       PROCEDURE DIVISION.
      *> Initial set up and information display.
           DISPLAY "Please enter your name.".
           ACCEPT ClientName.
           DISPLAY "Client name:" ClientName.
           DISPLAY "Client funds:" ClientFunds.
           DISPLAY "Bank name:" BankName.
           DISPLAY "Bank funds:" BankFunds.

      *> Transaction
           DISPLAY "Client transfers 10 coins to the bank".
           SUBTRACT 10 FROM ClientFunds.
           ADD 10 TO BankFunds.

      *> Displaying information about the transaction.     
           DISPLAY "Transaction was successful.".
           DISPLAY "Client funds:" ClientFunds.
           DISPLAY "Bank funds:" BankFunds.

           STOP RUN.
       END PROGRAM BANK.
