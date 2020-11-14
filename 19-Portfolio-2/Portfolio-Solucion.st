!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:48:30'!
assert:anAccount hasAccountSummary: aCollectionOfStrings
	
	self assert: aCollectionOfStrings equals: (AccountSummary for: anAccount).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:48:30'!
test01AnAccountSummaryOfAnEmptyAccountReturnsBalanceIs0	
	|account1|
	account1 := ReceptiveAccount new.
	
	self assert:account1 hasAccountSummary: (OrderedCollection with: 'Balance = 0').! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:48:30'!
test02AnAccountSummaryOfAnAccountWithADepositReturnsAccurate
	
	|account1|
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	self assert:account1 hasAccountSummary: (OrderedCollection with:'Depóstio por 100.' with: 'Balance = 100').
! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:52:00'!
test03AnAccountSummaryOfAnAccountWithAWithdrawReturnsAccurate

	|account1|
	account1 := ReceptiveAccount new.
	Withdraw register: 100 on: account1.
	
	self assert:account1 hasAccountSummary: (OrderedCollection with:'Extracción por 100.' with: 'Balance = -100').! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:51:51'!
test04AnAccountSummaryOfAnAccountWithAnOutgoingTransfer

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account1 to: account2 of: 20.	
	
	self assert:account1 hasAccountSummary: (OrderedCollection with:'Salida por transferencia de 20.' with: 'Balance = -20').! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:51:45'!
test05AnAccountSummaryOfAnAccountWithAnIncommingTransfer

	|account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Transfer from: account2 to: account1 of: 30.	
	
	self assert:account1 hasAccountSummary: (OrderedCollection with:'Entrada por transferencia de 30.' with: 'Balance = 30').! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:49:17'!
test06APortfolioWithNoAccountsHasBalance0

	| portfolio1 |

	portfolio1 := Portfolio new.

	self assert: portfolio1 hasAccountSummary: (OrderedCollection with: 'Balance = 0').! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:49:42'!
test07APortfolioWithOneAccountsHasAccountsReport

	| portfolio1 account1 account2 |

	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	
	portfolio1 add: account1.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer from: account1 to: account2 of: 20.
	Transfer from: account2 to: account1 of: 30.

	self assert: portfolio1 hasAccountSummary: (OrderedCollection
		with: 'Depóstio por 100.'
		with: 'Extracción por 50.'
		with: 'Salida por transferencia de 20.'
		with: 'Entrada por transferencia de 30.'
		with: 'Balance = 60'
	).! !

!AccountSummaryTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:51:33'!
test08APortfolioWithManyAccountsHasCorrectBalanceInReport

	| portfolio1 account1 account2 account3 report |
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.	
	account3 := ReceptiveAccount new.
	
	portfolio1 add: account1. 
	portfolio1 add: account2. 	

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer from: account1 to: account3 of: 20.
	Transfer from: account3 to: account1 of: 30.
	
	Deposit register: 200 on: account2.
	Withdraw register: 100 on: account2.
	Transfer from: account2 to: account3 of: 40.
	Transfer from: account3 to: account2 of: 60.

	report := OrderedCollection
		with: 'Depóstio por 100.'
		with: 'Extracción por 50.'
		with: 'Salida por transferencia de 20.'
		with: 'Entrada por transferencia de 30.'.

	report add: 'Depóstio por 200.'.
	report add: 'Extracción por 100.'.
	report add: 'Salida por transferencia de 40.'.
	report add: 'Entrada por transferencia de 60.'.
	
	report add: 'Balance = 180'.

	self assert: portfolio1 hasAccountSummary: report .! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:00:12'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/9/2020 06:02:30'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 100 on: account.
		
	self assert: 1 equals: account transactions size .
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'firstAccount secondAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:57:06'!
setUp
	
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:57:00'!
test01ATransferDecreasesBalanceOfSenderAndIncreasesOnReceiver
	
	self setUp.
	self validTransferOf100Value.
	
	self assert: 100 equals: secondAccount balance.
	self assert: -100 equals: firstAccount balance.! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:57:55'!
test02ATransferRegistersATransferDepositAndATransferWithdraw
	|aTransfer|
	
	self setUp.
	aTransfer := self validTransferOf100Value.
	
	self assert: (secondAccount hasRegistered: aTransfer deposit).
	self assert: (firstAccount hasRegistered: aTransfer withdraw).! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:58:35'!
test03ATransferWithdrawAndDepositKnowTheirTransfer
	|aTransfer|
	
	self setUp.
	aTransfer := self validTransferOf100Value.
	
	self assert: aTransfer equals: aTransfer deposit transfer.
	self assert: aTransfer equals: aTransfer withdraw transfer.! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:58:50'!
test04ATransferCantBeDoneBetweenTheSameAccount

	self setUp.
	
	self should:[Transfer from: firstAccount to: firstAccount of: 100.]
		raise: Error
		withMessageText: Transfer canNotTransferBeetweenTheSameAccount.
	! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/10/2020 18:01:38'!
test05ATransferCantBeDoneBeOf0Value

	self setUp.
	
	self should:[Transfer from: firstAccount to: secondAccount of: 0.]
		raise: Error
		withMessageText: Transfer invalidValue.
	! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/10/2020 18:02:00'!
test06ATransferCantBeOfNegativeValue
	
	self setUp.
	
	self should:[Transfer from: firstAccount to: secondAccount of: -1.]
		raise: Error
		withMessageText: Transfer invalidValue.
	! !

!TransferTest methodsFor: 'test' stamp: 'LH 11/14/2020 17:56:05'!
validTransferOf100Value

	^Transfer from: firstAccount to: secondAccount of: 100.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!Account methodsFor: 'reports' stamp: 'LH 11/14/2020 17:24:59'!
gatherAccountSummaryIn: anAccountSummary
	"gathers the data of this account for an account summary"
	
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'reports' stamp: 'LH 11/14/2020 17:25:27'!
gatherAccountSummaryIn: anAccountSummary
	"see superclass"
	
	accounts do: [:anAccount | anAccount gatherAccountSummaryIn: anAccountSummary ].! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'NR 11/9/2020 06:01:26'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio!!'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'NR 11/9/2020 05:56:36'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'LH 11/14/2020 17:25:35'!
gatherAccountSummaryIn: anAccountSummary
	"see superclass"
	
	transactions do: [:aTransaction | aTransaction gatherAccountSummaryIn: anAccountSummary ].! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Object subclass: #AccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialization' stamp: 'LH 11/14/2020 16:36:55'!
initialize
	report := OrderedCollection new..! !

!AccountSummary methodsFor: 'initialization' stamp: 'LH 11/14/2020 16:35:29'!
initializeFor: anAccount

	report := OrderedCollection new..! !


!AccountSummary methodsFor: 'evaluating' stamp: 'LH 11/14/2020 17:13:14'!
accountSummaryFor: anAccount

	anAccount gatherAccountSummaryIn: self.
	
	report add: ('Balance = ', anAccount balance asString).
	
	^report.! !


!AccountSummary methodsFor: 'gathering transactions' stamp: 'LH 11/14/2020 17:18:55'!
gatherAccountSummaryForDeposit: aDeposit
	
	self gatherForTransaction: aDeposit withText: 'Depóstio por '.! !

!AccountSummary methodsFor: 'gathering transactions' stamp: 'LH 11/14/2020 17:19:39'!
gatherAccountSummaryForTransferDeposit: aTransferDeposit

	self gatherForTransaction: aTransferDeposit withText: 'Entrada por transferencia de '.
	! !

!AccountSummary methodsFor: 'gathering transactions' stamp: 'LH 11/14/2020 17:20:08'!
gatherAccountSummaryForTransferWithdraw: aTransferWithdraw

	self gatherForTransaction: aTransferWithdraw withText: 'Salida por transferencia de '.! !

!AccountSummary methodsFor: 'gathering transactions' stamp: 'LH 11/14/2020 17:20:39'!
gatherAccountSummaryForWithdraw: aWithdraw

	self gatherForTransaction: aWithdraw withText: 'Extracción por '.! !

!AccountSummary methodsFor: 'gathering transactions' stamp: 'LH 11/14/2020 17:17:41'!
gatherForTransaction: aTransaction withText: reportMessage

	report add: (reportMessage, aTransaction value asString, '.').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'LH 11/14/2020 16:37:37'!
for: anAccount
	^self new initialize accountSummaryFor: anAccount! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'reports' stamp: 'LH 11/14/2020 17:31:47'!
gatherAccountSummaryIn: anAccountSummary
	"communicates to an account summary what class this transaction is"
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'reports' stamp: 'LH 11/14/2020 17:05:38'!
gatherAccountSummaryIn: anAccountSummary

	anAccountSummary gatherAccountSummaryForDeposit: self.! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferComponents category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferComponents
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferComponents methodsFor: 'value' stamp: 'LH 11/10/2020 17:48:39'!
value
	"returns the value of this transaction"
	^transfer value.! !


!TransferComponents methodsFor: 'balance' stamp: 'LH 11/10/2020 17:46:43'!
affectBalance: aBalance
	"includes the net value of this transaction in aBalance"
	self subclassResponsibility ! !


!TransferComponents methodsFor: 'initialization' stamp: 'LH 11/9/2020 21:09:13'!
initialization: aTransfer

	self subclassResponsibility .! !


!TransferComponents methodsFor: 'accessing' stamp: 'LH 11/10/2020 17:47:47'!
transfer
	"returns the transfer from wich this transaction originates"
	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferComponents class' category: 'Portfolio-Solucion'!
TransferComponents class
	instanceVariableNames: ''!

!TransferComponents class methodsFor: 'instance creation' stamp: 'LH 11/9/2020 21:07:39'!
for: aTransfer

	^self basicNew initialize: aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferComponents subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'LH 11/10/2020 17:48:04'!
affectBalance: aBalance
	"see superclass"
	^aBalance + self value.! !


!TransferDeposit methodsFor: 'initialization' stamp: 'LH 11/9/2020 21:08:15'!
initialize: aTransfer

	transfer := aTransfer .! !


!TransferDeposit methodsFor: 'reports' stamp: 'LH 11/14/2020 17:05:38'!
gatherAccountSummaryIn: anAccountSummary

	anAccountSummary gatherAccountSummaryForTransferDeposit: self.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferComponents subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'LH 11/10/2020 17:48:18'!
affectBalance: aBalance
	"see superclass"
	^aBalance - self value.! !


!TransferWithdraw methodsFor: 'reports' stamp: 'LH 11/14/2020 17:05:38'!
gatherAccountSummaryIn: anAccountSummary

	anAccountSummary gatherAccountSummaryForTransferWithdraw: self.! !


!TransferWithdraw methodsFor: 'initialization' stamp: 'LH 11/9/2020 21:08:48'!
initialize: aTransfer

	transfer := aTransfer.! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'reports' stamp: 'LH 11/14/2020 17:05:38'!
gatherAccountSummaryIn: anAccountSummary

	anAccountSummary gatherAccountSummaryForWithdraw: self.! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdraw deposit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'LH 11/9/2020 21:18:11'!
initializeFrom: aSenderAccount to: aRecipientAccount of: aValue 

	withdraw := aSenderAccount.
	deposit := aRecipientAccount.
	value := aValue.! !


!Transfer methodsFor: 'accesing' stamp: 'LH 11/10/2020 17:50:06'!
deposit
	"returns the transferDeposit associated with this transfer"
	^deposit.! !

!Transfer methodsFor: 'accesing' stamp: 'LH 11/10/2020 17:50:31'!
value
	"returns the value of this transfer"
	^value.! !

!Transfer methodsFor: 'accesing' stamp: 'LH 11/10/2020 17:50:16'!
withdraw
	"returns the transferWithdraw associated with this transfer"
	^withdraw.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'LH 11/10/2020 17:42:39'!
from: aSenderAccount to: aRecipientAccount of: aValue
	|aTransfer aTransferDeposit aTransferWithdraw|
	
	self ifAnEvaluation: [aSenderAccount = aRecipientAccount] sendTheTransferError: #canNotTransferBeetweenTheSameAccount.
	self ifAnEvaluation: [aValue <= 0] sendTheTransferError: #invalidValue.

	aTransfer := Transfer new.
	aTransferDeposit := TransferDeposit register: aTransfer on: aRecipientAccount.
	aTransferWithdraw := TransferWithdraw register: aTransfer on: aSenderAccount.
	
	^aTransfer initializeFrom: aTransferWithdraw to: aTransferDeposit of: aValue.! !


!Transfer class methodsFor: 'error description' stamp: 'LH 11/10/2020 17:31:10'!
canNotTransferBeetweenTheSameAccount
	^'Can not make a transfer between the same account'! !

!Transfer class methodsFor: 'error description' stamp: 'LH 11/10/2020 17:40:41'!
ifAnEvaluation: aClosureEvaluation sendTheTransferError: aMessageForErorText
	
	
	aClosureEvaluation value  ifTrue: [^self error: (aMessageForErorText sendTo: Transfer)].
! !

!Transfer class methodsFor: 'error description' stamp: 'LH 11/10/2020 17:34:53'!
invalidValue
	^'Invalid value for a transfer'! !
