bank_program: simple_bank.cbl display_clients.cbl make_transaction.cbl
	cobc -x simple_bank.cbl display_clients.cbl make_transaction.cbl -o bank_program