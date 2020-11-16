!classDefinition: #AccountReporterTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test01AccountSummaryForAnEmptyAccount

	| accounts |
	accounts := AccountTestUtility withOneAccount.
	
	self assert: accounts account1 hasAccountSummary: (OrderedCollection with: 'Balance = 0').! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test02AccountSummaryForAnAccountWithADeposit

	| accounts |
	accounts := AccountTestUtility withOneAccount.

	Deposit register: 100 on: accounts account1.
	
	self assert: accounts account1 hasAccountSummary: (OrderedCollection with:'Depóstio por 100.' with: 'Balance = 100').
! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test03AccountSummaryForAnAccountWithAWithdraw

	| accounts |
	accounts := AccountTestUtility withOneAccount.

	Withdraw register: 100 on: accounts account1.
	
	self assert: accounts account1 hasAccountSummary: (OrderedCollection with:'Extracción por 100.' with: 'Balance = -100').! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test04AccountSummaryForAnAccountWithAWithdrawTransfer

	| accounts |
	accounts := AccountTestUtility withTwoAccounts.

	Transfer register: 20 from: accounts account1 to: accounts account2.	
	
	self assert: accounts account1 hasAccountSummary: (OrderedCollection with:'Salida por transferencia de 20.' with: 'Balance = -20').! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test05AccountSummaryOfAnAccountWithADepositTransfer

	| accounts |
	accounts := AccountTestUtility withTwoAccounts.

	Transfer register: 30 from: accounts account2 to: accounts account1.	
	
	self assert: accounts account1 hasAccountSummary: (OrderedCollection with:'Entrada por transferencia de 30.' with: 'Balance = 30').! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test06AccountSummaryForAPortfolioWithNoAccounts

	| accounts |
	accounts := AccountTestUtility withEmptyPortfolio.

	self assert: accounts portfolio1 hasAccountSummary: (OrderedCollection with: 'Balance = 0').
! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test07AccountReportForPortfolioWithOneAccount
	
	| accounts report |

	accounts := AccountTestUtility withPortfolioAndTwoAccounts.

	accounts mockAllTransactions.
	
	report := accounts mockedTransactionsAccountSummary.
		
	report add: 'Balance = 60'.

	self assert: accounts portfolio1 hasAccountSummary: report.
! !

!AccountReporterTest methodsFor: 'account summary' stamp: 'IO 11/15/2020 21:34:11'!
test08AccountSummaryForPortfolioWithManyAccounts

	| accounts account3 report |

	accounts := AccountTestUtility withPortfolioAndTwoAccounts.
	
	accounts mockAllTransactions.
	
	account3 := ReceptiveAccount new.
	accounts portfolio1 add: account3.
	
	Deposit register: 200 on: account3.
	Withdraw register: 100 on: account3.
	Transfer register: 40 from: account3 to: accounts account2.
	Transfer register: 60 from: accounts account2 to: account3.

	report := accounts mockedTransactionsAccountSummary.

	report add: 'Depóstio por 200.'.
	report add: 'Extracción por 100.'.
	report add: 'Salida por transferencia de 40.'.
	report add: 'Entrada por transferencia de 60.'.
	
	report add: 'Balance = 180'.

	self assert: accounts portfolio1 hasAccountSummary: report .! !


!AccountReporterTest methodsFor: 'transfer net' stamp: 'IO 11/15/2020 21:34:11'!
test09TransferNetForAnEmptyAccount

	| accounts |

	accounts := AccountTestUtility withEmptyPortfolio.

	self assert: accounts portfolio1 hasTransferNet: 0.
! !

!AccountReporterTest methodsFor: 'transfer net' stamp: 'IO 11/15/2020 21:34:11'!
test10TransferNetForAnAccountWithADepositTransfer

	| accounts |

	accounts := AccountTestUtility withPortfolioAndTwoAccounts.
	
	Transfer register: 100 from: accounts account2 to: accounts account1.

	self assert: accounts portfolio1 hasTransferNet: 100.
! !

!AccountReporterTest methodsFor: 'transfer net' stamp: 'IO 11/15/2020 21:34:11'!
test11TransferNetForAnAccountWithAWidthdrawTransfer

	| accounts |

	accounts := AccountTestUtility withPortfolioAndTwoAccounts.

	Transfer register: 100 from: accounts account1 to: accounts account2.

	self assert: accounts portfolio1 hasTransferNet: -100.
! !

!AccountReporterTest methodsFor: 'transfer net' stamp: 'IO 11/15/2020 21:34:11'!
test12TransferNetForAnAccountWithManyTransfers

	| accounts |

	accounts := AccountTestUtility withPortfolioAndTwoAccounts.
	
	Transfer register: 50 from: accounts account1 to: accounts account2.
	Transfer register: 100 from: accounts account2 to: accounts account1.

	self assert: accounts portfolio1 hasTransferNet: 50.
! !


!AccountReporterTest methodsFor: 'assertions' stamp: 'IO 11/14/2020 20:14:54'!
assert: anAccount hasAccountSummary: aCollectionOfStrings

	self assert: anAccount hasReport: AccountSummaryReporter withResult: aCollectionOfStrings.
! !

!AccountReporterTest methodsFor: 'assertions' stamp: 'IO 11/15/2020 22:44:57'!
assert: anAccount hasAccountTree: anAccountTreeReport

	self assert: anAccount hasReport: AccountTreeReporter withResult: anAccountTreeReport.! !

!AccountReporterTest methodsFor: 'assertions' stamp: 'IO 11/14/2020 20:14:39'!
assert: anAccount hasReport: aReporterClass withResult: aReportResult

	| reporter |
	reporter := aReporterClass for: anAccount.
	self assert: aReportResult equals: (reporter emitReport).
! !

!AccountReporterTest methodsFor: 'assertions' stamp: 'IO 11/14/2020 20:15:12'!
assert: anAccount hasTransferNet: aNetValue

	self assert: anAccount hasReport: TransferNetReporter withResult: aNetValue.

! !


!AccountReporterTest methodsFor: 'account tree' stamp: 'IO 11/15/2020 22:46:06'!
test13AccountTreeForAnAccount
	| johnsAccount |
	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.

	self assert: johnsAccount hasAccountTree: (OrderedCollection with: 'Cuenta de Juan').! !

!AccountReporterTest methodsFor: 'account tree' stamp: 'IO 11/15/2020 22:46:31'!
test14AccountTreeForAnEmptyPortfolio
	| childrenPortfolio |
	childrenPortfolio := Portfolio named: 'Portfolio de hijos'.

	self assert: childrenPortfolio hasAccountTree: (OrderedCollection with: 'Portfolio de hijos').! !

!AccountReporterTest methodsFor: 'account tree' stamp: 'IO 11/15/2020 22:46:56'!
test15AccountTreeForAPortfolioWithAccounts
	| childrenPortfolio johnsAccount angiesAccount |

	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.

	self assert: childrenPortfolio hasAccountTree: (OrderedCollection
		with: 'Portfolio de hijos'
		with: '  Cuenta de Juan'
		with: '  Cuenta de Angeles'
	).! !

!AccountReporterTest methodsFor: 'account tree' stamp: 'IO 11/15/2020 22:50:20'!
test16AccountTreeForAPortfolioWithPortfolios
	| report childrenPortfolio johnsAccount angiesAccount myAccount familyPortfolio |

	johnsAccount := ReceptiveAccount named: 'Cuenta de Juan'.
	angiesAccount := ReceptiveAccount named: 'Cuenta de Angeles'.
	childrenPortfolio := Portfolio named: 'Portfolio de hijos' with: johnsAccount with: angiesAccount.
	myAccount := ReceptiveAccount named: 'Cuenta mia'.
	familyPortfolio := Portfolio named: 'Portfolio de la familia' with: myAccount with: childrenPortfolio.

	report := OrderedCollection
		with: 'Portfolio de la familia'
		with: '  Cuenta mia'
		with: '  Portfolio de hijos'
		with: '    Cuenta de Juan'
		with: '    Cuenta de Angeles'.

	self assert: familyPortfolio hasAccountTree: report.! !


!classDefinition: #AccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
AccountTest subclass: #PortfolioTest
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
AccountTest subclass: #ReceptiveAccountTest
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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'test' stamp: 'IO 11/15/2020 21:34:11'!
assertInvalidValue: aValue

	| accounts |
	accounts := AccountTestUtility withTwoAccounts.
	
	self should: [Transfer register: aValue from: accounts account1 to: accounts account2]
		raise: Error
		withMessageText: Transfer invalidValueErrorMessage.
! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/15/2020 21:34:11'!
assertTransferCreatedWith: transferConstructorArguments raises: anErrorMessage

	| accounts |
	accounts := AccountTestUtility withTwoAccounts.
	
	self should: [#register:from:to: sendTo: Transfer with: transferConstructorArguments]
		raise: Error
		withMessageText: anErrorMessage.
! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/15/2020 21:34:11'!
test01ATransferDecreasesBalanceOfSenderAndIncreasesOnReceiver
	
	| accounts |
	accounts := AccountTestUtility withTwoAccounts.

	accounts mockTransfer.

	self assert: 100 equals: accounts account2 balance.
	self assert: -100 equals: accounts account1 balance.! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/15/2020 21:34:11'!
test02ATransferRegistersATransferDepositAndATransferWithdraw
	
	| accounts aTransfer |
	accounts := AccountTestUtility withTwoAccounts.

	aTransfer := accounts mockTransfer.

	self assert: (accounts account2 hasRegistered: aTransfer deposit).
	self assert: (accounts account1 hasRegistered: aTransfer withdraw).! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/15/2020 21:34:11'!
test03ATransferWithdrawAndDepositKnowTheirTransfer
	
	| accounts aTransfer |
	accounts := AccountTestUtility withTwoAccounts.

	aTransfer := accounts mockTransfer.
	
	self assert: aTransfer equals: aTransfer deposit transfer.
	self assert: aTransfer equals: aTransfer withdraw transfer.! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/15/2020 21:34:11'!
test04ATransferCantBeDoneBetweenTheSameAccount

	| accounts |
	accounts := AccountTestUtility withTwoAccounts.
	
	self should: [Transfer register: 100 from: accounts account1 to: accounts account1]
		raise: Error
		withMessageText: Transfer senderIsRecipientErrorMessage.
! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/14/2020 21:19:07'!
test05ATransferCantBeDoneBeOf0Value

	self assertInvalidValue: 0.

! !

!TransferTest methodsFor: 'test' stamp: 'IO 11/14/2020 21:19:20'!
test06ATransferCantBeOfNegativeValue

	self assertInvalidValue: -1.

! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'IO 11/14/2020 18:26:57'!
hasRegistered: aTransaction

	self subclassResponsibility.
! !

!Account methodsFor: 'testing' stamp: 'IO 11/14/2020 18:27:04'!
isComposedBy: anAccount

	self subclassResponsibility.
! !


!Account methodsFor: 'name' stamp: 'LH 11/16/2020 13:18:47'!
name

	^name.! !


!Account methodsFor: 'balance' stamp: 'IO 11/14/2020 18:27:11'!
balance

	self subclassResponsibility.
! !


!Account methodsFor: 'transactions' stamp: 'IO 11/14/2020 18:26:41'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility.
! !

!Account methodsFor: 'transactions' stamp: 'IO 11/14/2020 18:26:49'!
transactions

	self subclassResponsibility.
! !


!Account methodsFor: 'composition' stamp: 'IO 11/14/2020 18:27:26'!
addedTo: aPortfolio

	self subclassResponsibility.
! !


!Account methodsFor: 'reports' stamp: 'IO 11/16/2020 15:15:31'!
reportAccountIn: aReport

	"add this account and it's childrent to a report"

	self subclassResponsibility.
! !


!Account methodsFor: 'initialization' stamp: 'IO 11/15/2020 22:02:35'!
initializeNamed: aName

	self initialize.
	name := aName.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: 'Portfolio-Solucion'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'as yet unclassified' stamp: 'IO 11/15/2020 22:02:41'!
named: aName

	^self basicNew initializeNamed: aName.
! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents string receptiveAccount receptiveAccount3'
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


!Portfolio methodsFor: 'reports' stamp: 'IO 11/16/2020 15:16:42'!
reportAccountIn: aReport

	"see superclass"
	
	accounts do: [ :anAccount | aReport addAccountToReport: anAccount ].
! !


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

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'IO 11/15/2020 22:25:40'!
with: anAccount with: anotherAccount

	^self new
		add: anAccount;
		add: anotherAccount;
		yourself
! !


!Portfolio class methodsFor: 'instance creation' stamp: 'IO 11/15/2020 22:27:20'!
named: aName with: anAccount with: anotherAccount

	| portfolio |
	portfolio := self basicNew initializeNamed: aName.
	portfolio add: anAccount.
	portfolio add: anotherAccount.
	^portfolio.
! !


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


!ReceptiveAccount methodsFor: 'report' stamp: 'IO 11/16/2020 15:20:50'!
reportAccountIn: aReport

	transactions do: [:aTransaction | aTransaction reportTransactionIn: aReport]
	! !


!classDefinition: #AccountReporter category: 'Portfolio-Solucion'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporter methodsFor: 'initialization' stamp: 'IO 11/14/2020 20:04:07'!
initializeFor: anAccount

	"initialize a report for an account"

	account := anAccount.
! !


!AccountReporter methodsFor: 'add to report' stamp: 'IO 11/16/2020 15:18:15'!
addAccountToReport: anAccount

	"
		add an account to this report
		implentation details: this method performs the double dispatch that needs to be done by any report kind.
			use super addAccountToReport: from children classes
	"

	anAccount reportAccountIn: self.! !

!AccountReporter methodsFor: 'add to report' stamp: 'IO 11/16/2020 15:09:31'!
addDepositToReport: aDeposit

	"
		add a Deposit to this report.
		implementation details: by default does nothing, each report should implement how transactions affect the report
	"! !

!AccountReporter methodsFor: 'add to report' stamp: 'IO 11/16/2020 15:09:45'!
addTransferDepositToReport: aTDeposit

	"
		add a Transfer Deposit to this report.
		implementation details: by default does nothing, each report should implement how transactions affect the report
	"! !

!AccountReporter methodsFor: 'add to report' stamp: 'IO 11/16/2020 15:10:11'!
addTransferWithdrawToReport: aTWithdraw

	"
		add a Transfer Withdraw to this report.
		implementation details: by default does nothing, each report should implement how transactions affect the report
	"! !

!AccountReporter methodsFor: 'add to report' stamp: 'IO 11/16/2020 15:10:21'!
addWithdrawToReport: aWithdraw

	"
		add a Withdraw to this report.
		implementation details: by default does nothing, each report should implement how transactions affect the report
	"! !


!AccountReporter methodsFor: 'emitting' stamp: 'LH 11/16/2020 13:58:01'!
emitReport

	"emit this report"
	
	self addAccountToReport: account.
	^report.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: 'Portfolio-Solucion'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'IO 11/14/2020 20:10:29'!
for: anAccount

	"create a report for an account"

	^self new initializeFor: anAccount! !


!classDefinition: #AccountSummaryReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #AccountSummaryReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReporter methodsFor: 'adding to report' stamp: 'IO 11/15/2020 22:35:18'!
addAccountSummaryTextWith: aPrefix for: aTransaction

	"add a transaction to the report given a prefix"

	report add: (aPrefix, aTransaction value asString, '.').
! !

!AccountSummaryReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 20:12:49'!
addDepositToReport: aDeposit

	"see superclass"

	self addAccountSummaryTextWith: 'Depóstio por ' for: aDeposit.! !

!AccountSummaryReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 20:12:52'!
addTransferDepositToReport: aTransferDeposit

	"see superclass"

	self addAccountSummaryTextWith: 'Entrada por transferencia de ' for: aTransferDeposit.

	! !

!AccountSummaryReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 20:12:55'!
addTransferWithdrawToReport: aTransferWithdraw

	"see superclass"

	self addAccountSummaryTextWith: 'Salida por transferencia de ' for: aTransferWithdraw.
! !

!AccountSummaryReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 20:12:58'!
addWithdrawToReport: aWithdraw

	"see superclass"

	self addAccountSummaryTextWith: 'Extracción por ' for: aWithdraw.
! !


!AccountSummaryReporter methodsFor: 'emitting' stamp: 'IO 11/14/2020 21:59:59'!
emitReport

	"see superclass"

	super emitReport add: ('Balance = ', account balance asString).
	^report.! !


!AccountSummaryReporter methodsFor: 'initialization' stamp: 'IO 11/15/2020 22:34:42'!
initializeFor: anAccount

	"see superclass"

	report := OrderedCollection new.
	super initializeFor: anAccount.
! !


!classDefinition: #AccountTreeReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #AccountTreeReporter
	instanceVariableNames: 'indentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTreeReporter methodsFor: 'adding to report' stamp: 'IO 11/16/2020 15:18:32'!
addAccountToReport: anAccount

	"adds the name of a Portfolio to the report"
	
	self addNameToReport: anAccount name.
	self beginHierarchy.
	super addAccountToReport: anAccount.
	self endHierarchy.
! !

!AccountTreeReporter methodsFor: 'adding to report' stamp: 'IO 11/16/2020 00:34:22'!
addNameToReport: aName
	report add: (indentation, aName).
! !

!AccountTreeReporter methodsFor: 'adding to report' stamp: 'IO 11/16/2020 00:31:05'!
beginHierarchy
	indentation := (indentation, '  ')
! !

!AccountTreeReporter methodsFor: 'adding to report' stamp: 'IO 11/16/2020 14:56:23'!
endHierarchy
	indentation := indentation copyFrom: 1 to: indentation size - 2.

! !


!AccountTreeReporter methodsFor: 'initialization' stamp: 'IO 11/16/2020 00:31:52'!
initializeFor: anAccount

	report := OrderedCollection new.
	indentation := ''.
	super initializeFor: anAccount.
! !


!classDefinition: #TransferNetReporter category: 'Portfolio-Solucion'!
AccountReporter subclass: #TransferNetReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 20:07:27'!
addTransferDepositToReport: aTransferDeposit

	"see superclass"

	self addTransferToReport: aTransferDeposit.
! !

!TransferNetReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 22:00:57'!
addTransferToReport: aTransfer

	"adds a given transfer to the report"

	report := aTransfer affectBalance: report.! !

!TransferNetReporter methodsFor: 'adding to report' stamp: 'IO 11/14/2020 20:07:33'!
addTransferWithdrawToReport: aTransferWithdraw

	"see superclass"

	self addTransferToReport: aTransferWithdraw.
! !


!TransferNetReporter methodsFor: 'initializaition' stamp: 'IO 11/14/2020 21:54:44'!
initializeFor: anAccount

	"initialize a transfer net report"

	report := 0.
	super initializeFor: anAccount.
! !


!classDefinition: #AccountTestUtility category: 'Portfolio-Solucion'!
Object subclass: #AccountTestUtility
	instanceVariableNames: 'account1 account2 portfolio1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:33:31'!
account1
	^account1.
! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:33:34'!
account2
	^account2.
! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:53:53'!
initializeWithEmptyPortfolio
	portfolio1 := Portfolio new.
! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:41:01'!
initializeWithOneAccount
	account1 := ReceptiveAccount new.! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:46:00'!
initializeWithPortfolioAndTwoAccounts
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio1 := Portfolio new.
	portfolio1 add: account1.! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:41:11'!
initializeWithTwoAccounts
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 21:31:51'!
mockAllTransactions

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer register: 20 from: account1 to: account2.
	Transfer register: 30 from: account2 to: account1.! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 21:17:45'!
mockTransfer

	^Transfer register: 100 from: account1 to: account2.
! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:51:48'!
mockedTransactionsAccountSummary

	^OrderedCollection
		with: 'Depóstio por 100.'
		with: 'Extracción por 50.'
		with: 'Salida por transferencia de 20.'
		with: 'Entrada por transferencia de 30.'.! !

!AccountTestUtility methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:45:43'!
portfolio1
	^portfolio1.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTestUtility class' category: 'Portfolio-Solucion'!
AccountTestUtility class
	instanceVariableNames: ''!

!AccountTestUtility class methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:53:37'!
withEmptyPortfolio
	^self basicNew initializeWithEmptyPortfolio.
	! !

!AccountTestUtility class methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:35:20'!
withOneAccount
	^self basicNew initializeWithOneAccount.
	! !

!AccountTestUtility class methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:44:42'!
withPortfolioAndTwoAccounts
	^self basicNew initializeWithPortfolioAndTwoAccounts.
	! !

!AccountTestUtility class methodsFor: 'as yet unclassified' stamp: 'IO 11/14/2020 20:41:11'!
withTwoAccounts
	^self basicNew initializeWithTwoAccounts.
	! !


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


!AccountTransaction methodsFor: 'reports' stamp: 'IO 11/16/2020 15:20:38'!
reportTransactionIn: aReport

	"adds this transaction to a report"
	
	self subclassResponsibility.
	! !

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


!Deposit methodsFor: 'reports' stamp: 'IO 11/16/2020 15:20:38'!
reportTransactionIn: aReport
	"see superclass"
	
	aReport addDepositToReport: self.! !


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


!classDefinition: #TransferComponent category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferComponent
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferComponent methodsFor: 'value' stamp: 'IO 11/14/2020 21:52:07'!
value

	"return the value of this transaction"

	^transfer value.! !


!TransferComponent methodsFor: 'balance' stamp: 'IO 11/14/2020 21:51:47'!
affectBalance: aBalance

	"includes the net value of this transaction in aBalance"

	self subclassResponsibility ! !


!TransferComponent methodsFor: 'initialization' stamp: 'IO 11/14/2020 21:53:04'!
initialize: aTransfer

	"initialize a new transfer component for a given transfer"

	transfer := aTransfer.
! !


!TransferComponent methodsFor: 'accessing' stamp: 'IO 11/14/2020 21:52:03'!
transfer

	"return the transfer from wich this transaction originates"

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferComponent class' category: 'Portfolio-Solucion'!
TransferComponent class
	instanceVariableNames: ''!

!TransferComponent class methodsFor: 'instance creation' stamp: 'IO 11/14/2020 21:51:39'!
for: aTransfer

	"create a transfer component for a given transfer"

	^self basicNew initialize: aTransfer.! !


!classDefinition: #TransferDeposit category: 'Portfolio-Solucion'!
TransferComponent subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'balance' stamp: 'IO 11/14/2020 21:52:15'!
affectBalance: aBalance

	"see superclass"

	^aBalance + self value.
! !


!TransferDeposit methodsFor: 'reports' stamp: 'IO 11/16/2020 15:20:38'!
reportTransactionIn: aReport
	"see superclass"
	
	aReport addTransferDepositToReport: self.! !


!classDefinition: #TransferWithdraw category: 'Portfolio-Solucion'!
TransferComponent subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'balance' stamp: 'IO 11/14/2020 21:53:18'!
affectBalance: aBalance

	"see superclass"

	^aBalance - self value.! !


!TransferWithdraw methodsFor: 'reports' stamp: 'IO 11/16/2020 15:20:38'!
reportTransactionIn: aReport
	"see superclass"

	aReport addTransferWithdrawToReport: self.! !


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


!Withdraw methodsFor: 'reports' stamp: 'IO 11/16/2020 15:20:38'!
reportTransactionIn: aReport
	"see superclass"
	
	aReport addWithdrawToReport: self.! !


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

!Transfer methodsFor: 'initialization' stamp: 'IO 11/14/2020 21:39:59'!
initializeFor: aValue from: aSenderAccount to: aRecipientAccount

	"initialize a transfer for a given sender, recipient and value"

	withdraw := aSenderAccount.
	deposit := aRecipientAccount.
	value := aValue.
! !


!Transfer methodsFor: 'accesing' stamp: 'IO 11/14/2020 21:38:14'!
deposit

	"return the deposit associated with this transfer"

	^deposit.! !

!Transfer methodsFor: 'accesing' stamp: 'IO 11/14/2020 21:40:42'!
value

	"returns the value of this transfer"

	^value.
! !

!Transfer methodsFor: 'accesing' stamp: 'IO 11/14/2020 21:40:53'!
withdraw

	"returns the withdrar associated with this transfer"

	^withdraw.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'IO 11/14/2020 21:40:18'!
register: aValue from: aSenderAccount to: aRecipientAccount

	"create a transaction and register the corresponding transfers to the accounts involved"

	|aTransfer aTransferDeposit aTransferWithdraw|

	(aSenderAccount = aRecipientAccount) ifTrue: [^self errorWith: #senderIsRecipientErrorMessage].
	(aValue <= 0) ifTrue: [^self errorWith: #invalidValueErrorMessage].

	aTransfer := Transfer new.
	aTransferDeposit := TransferDeposit register: aTransfer on: aRecipientAccount.
	aTransferWithdraw := TransferWithdraw register: aTransfer on: aSenderAccount.

	^aTransfer initializeFor: aValue from: aTransferWithdraw to: aTransferDeposit.
! !


!Transfer class methodsFor: 'errors' stamp: 'IO 11/14/2020 21:37:19'!
errorWith: anErrorMessageMessage

	"send an error given a message description message"

	^self error: (anErrorMessageMessage sendTo: self).
! !

!Transfer class methodsFor: 'errors' stamp: 'IO 11/14/2020 21:28:35'!
invalidValueErrorMessage
	^'Invalid value for a transfer'! !

!Transfer class methodsFor: 'errors' stamp: 'IO 11/14/2020 21:33:37'!
senderIsRecipientErrorMessage
	^'Can not make a transfer between the same account'! !
