!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'adding accounts' stamp: 'IO 11/5/2020 14:37:14'!
test01AnAccountCanBeAddedToAPortfolio

	"una cuenta puede ser agregada a un prtfolio"

	|anAccount aPortfolio|
	
	anAccount :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount.
	
	self assert: (aPortfolio includesAccount: anAccount).
! !

!PortfolioTest methodsFor: 'adding accounts' stamp: 'IO 11/5/2020 14:37:27'!
test02APortfolioHasNoAccountsInitially

	"un portfolio no tiene cuentas inicialmente"

	|anAccount1 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	
	aPortfolio := Portfolio new.

	self deny: (aPortfolio includesAccount: anAccount1).
! !

!PortfolioTest methodsFor: 'adding accounts' stamp: 'IO 11/5/2020 14:40:07'!
test03APortfolioDoesNotHaveMoreAccountsThanAdded

	"una cuenta que no fue agregada a un portfolio no esta en un portfolio"

	|anAccount1 anAccount2 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	anAccount2 :=  ReceptiveAccount new.
	Deposit register: 200 on: anAccount2.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount1.

	self deny: (aPortfolio includesAccount: anAccount2).
! !

!PortfolioTest methodsFor: 'adding accounts' stamp: 'IO 11/5/2020 14:40:16'!
test04MoreThanOneAccountCanBeAddedToAPortfolio

	"se puede agregar mas de una cuenta a un portfolio"

	|anAccount1 anAccount2 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	anAccount2 :=  ReceptiveAccount new.
	Deposit register: 200 on: anAccount2.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount1.
	aPortfolio addAccount: anAccount2.
	
	self assert: (aPortfolio includesAccount: anAccount1).
	self assert: (aPortfolio includesAccount: anAccount2).
! !


!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/7/2020 21:11:48'!
test05APortfolioDoesNotHavePortfoliosInitialy
	
	"un portfolio no tiene portfolios inicialmente"
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	self deny: (portfolio1 includesPortfolio: portfolio2).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/7/2020 21:12:18'!
test06AnEmptyPortfolioCanBeAddedToAPortfolio
	
	"a un portfolio se le puede agregar un portfolio sin cuentas"
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	
	self assert: (portfolio1 includesPortfolio: portfolio2).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/7/2020 21:12:42'!
test07VariousEmptyPortfoliosCanBeAddedToAPortfolio
	
	"a un portfolio se le puede agregar mas de un portfolio sin cuentas"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	
	self assert: (portfolio1 includesPortfolio: portfolio2).
	self assert: (portfolio1 includesPortfolio: portfolio3).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/7/2020 21:13:24'!
test08PortfoliosCanBeAddedToAPortfolio
	
	"a un portfolio se le pueden agregar portfolios"
	
	| portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 account3 account4 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	account4 := ReceptiveAccount new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio4. "portfolio anidado"
	
	portfolio2 addAccount: account1.
	portfolio2 addAccount: account2.
	portfolio3 addAccount: account3.
	portfolio4 addAccount: account4.
	
	self assert: (portfolio1 includesAccount: account1).
	self assert: (portfolio1 includesAccount: account2).
	self assert: (portfolio1 includesAccount: account3).
	self assert: (portfolio1 includesAccount: account4).
! !

!PortfolioTest methodsFor: 'adding portfolios' stamp: 'LH 11/7/2020 21:16:23'!
test09APortfolioWithPortfoliosCanBeAddedToAportfolio
	
	"a un portfolio se le pueden agregar portfolios con portfolios"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self assert: (portfolio1 includesPortfolio: portfolio3).

! !


!PortfolioTest methodsFor: 'errors adding accounts by children' stamp: 'LH 11/7/2020 21:22:42'!
test10CanNotAddAnAccountToAPortfolioWhosePortfolioHasTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (padre) con un portfolio (hijo), cuando la cuenta ya estaba en el portfolio (hijo)"
	
	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio2 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.

	self should: [	portfolio1 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding accounts by children' stamp: 'LH 11/7/2020 21:23:19'!
test11CanNotAddAnAccountToAPortfolioWhoHasAPortfolioWithTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (padre) con un portfolio (hijo) con un portfolio (nieto), cuando la cuenta ya estaba en el portfolio (nieto)"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.	

	account1 := ReceptiveAccount new.
	
	portfolio3 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [	portfolio1 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !


!PortfolioTest methodsFor: 'errors adding portfolios by childern' stamp: 'LH 11/7/2020 21:20:31'!
test12APortfolioCantHaveRepeatedAccounts
	
	"no pueden haber cuentas repetidas en un portfolio"
	
	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addAccount: account1.

	
	self should: [portfolio1 addAccount: account1] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.

! !

!PortfolioTest methodsFor: 'errors adding portfolios by childern' stamp: 'LH 11/7/2020 21:20:56'!
test13APortfolioCanNotHaveRepeatedPortfolios
	
	"no pueden haber prtfolios repetidos en un portfolio"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [portfolio1 addPortfolio: portfolio3] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.

! !

!PortfolioTest methodsFor: 'errors adding portfolios by childern' stamp: 'LH 11/7/2020 22:13:32'!
test14APortffolioCantHaveItself
	"un portfolio no se puede tener a si mismo"
	
	| portfolio1 |
	
	portfolio1 := Portfolio new.
	
	self should: [portfolio1 addPortfolio: portfolio1] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !


!PortfolioTest methodsFor: 'errors adding accounts by parents' stamp: 'LH 11/7/2020 21:24:41'!
test15CanNotAddAnAccountToAPortfolioWithAParentThatHasTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (hijo) de un portfolio (padre), cuando la cuenta ya estaba en el portfolio (padre), con varios padres"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio2 addAccount: account1.
	portfolio2 addPortfolio: portfolio3.
	portfolio1 addPortfolio: portfolio3.

	self should: [	portfolio3 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding accounts by parents' stamp: 'LH 11/7/2020 22:16:09'!
test16CanNotAddAnAccountToAPortfolioWhoseParentHasTheAccount
	
	"no se pueden agregar una cueanta a un portfolio (hijo) de un portfolio (padre), cuando la cuenta ya estaba en el portfolio (padre)"
	
	| portfolio1 portfolio2 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.

	self should: [	portfolio2 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding accounts by parents' stamp: 'LH 11/7/2020 22:16:14'!
test17CanNotAddAnAccountToAPortfolioWithAPredecesorsThatHasTheAccount
	
	"no se pueden agregar una cueanta a un hijo si esa cuenta está en el padre de su padre"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [	portfolio3 addAccount: account1.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !


!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:16:21'!
test18CantAddAPortfolioWhenItIsAParent
	
	"
		no se pueden agregar un portfolio cuando el padre ya tiene ese portfolio
		p1 ->  p2 -> p1
	"
	
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.

	self should: [	portfolio2 addPortfolio: portfolio1.] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:18:37'!
test19CantAddAPortfolioWhenItIsAPredecesor
	
	"
		no se pueden agregar un portfolio cuando el padre del padre ya tiene ese portfolio
		p1 ->  p2 -> p3 -> p1
	"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio3.

	self should: [	portfolio3 addPortfolio: portfolio1.] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:18:32'!
test20CantAddAPortfolioWhenAPredecesorAlredyHasIt
	
	"
		no se pueden agregar un portfolio cuando el padre del padre ya tiene ese portfolio
		p1 ->  p2
		p1 ->  p3 -> p2
	"
	
	| portfolio1 portfolio2 portfolio3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.

	self should: [	portfolio3 addPortfolio: portfolio2.] raise: Error withMessageText: Portfolio errorMessagePortfolioAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'LH 11/7/2020 22:16:32'!
test35CanNotAddAPortfolioWithAccountsAlredyInTheParentsOfTheRevceiver
	
	"
		no se pueden agregar un portfolio cuando tiene cuentas repetidas en los padres del receptor 
		p1 ->	p2 -> p4 -x p5 -> a3,a2,a1|
		     -> a1| -> a2|
			 p3 -> p3|
			      -> a3|
	"
	
	| portfolio1 portfolio2 portfolio3 portfolio4 portfolio5 account1 account2 account3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.	
	
	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio4.
	portfolio3 addPortfolio: portfolio4.
	portfolio1 addAccount: account1.
	portfolio2 addAccount: account2.
	portfolio3 addAccount: account3.
	portfolio5 addAccount: account1.
	portfolio5 addAccount: account2.
	portfolio5 addAccount: account3.

	self should: [	portfolio4 addPortfolio: portfolio5.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !


!PortfolioTest methodsFor: 'accounts' stamp: 'LH 11/7/2020 22:18:22'!
test22APortfolioKnowsItsDirectAccounts
	
	"un portfolio expone sus cuentas"
	
	| portfolio1 account1 account2 |
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.	

	self assert: (portfolio1 accounts includesAllOf: (OrderedCollection with: account1 with: account2)).

	
! !

!PortfolioTest methodsFor: 'accounts' stamp: 'LH 11/7/2020 22:18:17'!
test22APortfolioKnowsTheAccountsOfHisPortfolios
	
	"un portfolio expone las cuentas de sus portfolios"
	
	| portfolio1 portfolio2 portfolio3 portfolio4 account1 account2 account3 account4 |

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.	
	account4 := ReceptiveAccount new.	

	portfolio2 addAccount: account1.
	portfolio2 addAccount: account2.	
	portfolio3 addAccount: account3.
	portfolio4 addAccount: account4.

	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	portfolio2 addPortfolio: portfolio4.

	self assert: (portfolio1 accounts includesAllOf: (OrderedCollection with: account1 with: account2 with: account3 with: account4)).

	
! !


!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:18:10'!
test23AnEmptyPortfolioHasABalanceOf0

	"un portfolio vacio responde balance 0"

	| portfolio1 |

	portfolio1 := Portfolio new.

	self assert: (portfolio1 balance) equals: 0.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:18:06'!
test24APortfolioWithOneAccountHasTheBalanceOfThatAccount

	"un portfolio reponde por el balance de su unico hijo"

	| portfolio1 account1 |
	
	account1 := ReceptiveAccount new.
	
	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.

	portfolio1 := Portfolio new.

	portfolio1 addAccount: account1.

	self assert: (portfolio1 balance) equals: 50.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:18:02'!
test25TheBalanceOfAPortfolioWithNoPortfoliosIsTheSumOfHisAccounts

	"un portfolio reponde por el balance de sus hijos"

	| portfolio1 account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 100 on: account2.

	portfolio1 := Portfolio new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.

	self assert: (portfolio1 balance) equals: 150.
! !

!PortfolioTest methodsFor: 'balance' stamp: 'LH 11/7/2020 22:17:55'!
test26TheBalanceOfAPortfolioIsTheSumOfHisAccountsAndPortfolios

	"un portfolio reponde por el balance de los hijos de sus portfolios"

	| portfolio1 portfolio2 account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Deposit register: 100 on: account2.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addPortfolio: portfolio2.

	portfolio2 addAccount: account1.
	portfolio2 addAccount: account2.

	self assert: (portfolio1 balance) equals: 150.
! !


!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:47'!
test27AnEmptyPortfolioHasNoRegisteredTransactions

	"un portfolio vacio no registro ninguna transaccion"
	
	| deposit withdraw portfolio1 |
	
	portfolio1 := Portfolio new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (portfolio1 hasRegistered: deposit).
	self deny: (portfolio1 hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:37'!
test28APortfolioWithOneAccountHasItsRegisteredTransactions

	"un portfolio con una cuenta registro sus transacciones"
	
	| deposit withdraw account1 portfolio1 |
	
	account1 := ReceptiveAccount new.
	deposit :=  Deposit register: 100 on: account1.
	withdraw := Withdraw register: 50 on: account1.
	
	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.

	self assert: (portfolio1 hasRegistered: deposit).
	self assert: (portfolio1 hasRegistered:withdraw).
! !

!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:29'!
test29APortfolioWithManyAccountsHasItsAccountsRegisteredTransactions

	"un portfolio con varias cuentas registro todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.

	self assert: (portfolio1 hasRegistered: deposit1).
	self assert: (portfolio1 hasRegistered:withdraw1).
	self assert: (portfolio1 hasRegistered: deposit2).
	self assert: (portfolio1 hasRegistered:withdraw2).
! !

!PortfolioTest methodsFor: 'has registered' stamp: 'LH 11/7/2020 22:17:22'!
test30APortfolioHasItsPortfoliosAndAccountsRegisteredTransactions

	"un portfolio con varias cuentas en sus portfolios registro todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 portfolio2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	
	portfolio2 addPortfolio: portfolio1.

	self assert: (portfolio2 hasRegistered: deposit1).
	self assert: (portfolio2 hasRegistered:withdraw1).
	self assert: (portfolio2 hasRegistered: deposit2).
	self assert: (portfolio2 hasRegistered:withdraw2).
! !


!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:17:11'!
test31AnEmptyPortfolioHasNoTransactions

	"un portfolio vacio no tiene transacciones"
	
	| portfolio1 |
	
	portfolio1 := Portfolio new.
		
	self assert: (portfolio1 transactions size) equals: 0.

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:17:01'!
test32APortfolioWithOneAccountHasItsTransactions

	"un portfolio con una cuenta retorna sus transacciones"
	
	| deposit withdraw account1 portfolio1 |
	
	account1 := ReceptiveAccount new.
	deposit :=  Deposit register: 100 on: account1.
	withdraw := Withdraw register: 50 on: account1.
	
	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.

	self assert: (portfolio1 transactions includesAllOf: (OrderedCollection with: deposit with: withdraw)).

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:16:55'!
test33APortfolioWithManyAccountsHasItsAccountsTransactions

	"un portfolio con varias cuentas retorna todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.

	self assert: (portfolio1 transactions includesAllOf: (OrderedCollection with: deposit1 with: withdraw1 with: deposit2 with: withdraw2)).

! !

!PortfolioTest methodsFor: 'transactions' stamp: 'LH 11/7/2020 22:16:38'!
test34APortfolioHasItsPortfoliosAndAccountsTransaction

	"un portfolio con varias cuentas en sus portfolios retorna todas sus transacciones"
	
	| deposit1 deposit2 withdraw1 withdraw2 account1 account2 portfolio1 portfolio2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.

	deposit1 :=  Deposit register: 100 on: account1.
	withdraw1 := Withdraw register: 50 on: account1.
	deposit2 :=  Deposit register: 30 on: account2.
	withdraw2 := Withdraw register: 20 on: account2.

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.

	portfolio1 addAccount: account1.
	portfolio1 addAccount: account2.
	
	portfolio2 addPortfolio: portfolio1.

	self assert: (portfolio2 transactions includesAllOf: (OrderedCollection with: deposit1 with: withdraw1 with: deposit2 with: withdraw2)).

! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:15'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance operations' stamp: 'LH 11/8/2020 15:48:59'!
addToBalance: aBalance 
	"returns the resulting balance after aplying the net value of this transaction"	

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance operations' stamp: 'LH 11/2/2020 20:39:54'!
addToBalance: aBalance
	"see superclass"

	^aBalance + value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance operations' stamp: 'LH 11/8/2020 15:49:50'!
addToBalance: aBalance
	"see superclass"

	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #ParentPortfolios category: 'Portfolio-Ejercicio'!
Object subclass: #ParentPortfolios
	instanceVariableNames: 'childPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ParentPortfolios methodsFor: 'validate' stamp: 'LH 11/8/2020 17:53:15'!
validateAccountBeforeAdding: anAccount

	^self subclassResponsibility ! !

!ParentPortfolios methodsFor: 'validate' stamp: 'LH 11/8/2020 17:53:25'!
validatePortfoliosBeforeAdding: anAccount

	^self subclassResponsibility ! !


!ParentPortfolios methodsFor: 'adding' stamp: 'LH 11/8/2020 17:52:41'!
addAsFather: aPortfolio

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParentPortfolios class' category: 'Portfolio-Ejercicio'!
ParentPortfolios class
	instanceVariableNames: ''!

!ParentPortfolios class methodsFor: 'instance creation' stamp: 'LH 11/8/2020 17:42:25'!
forPortfolio: aPortfolio

	^Root new initialize: aPortfolio! !

!ParentPortfolios class methodsFor: 'instance creation' stamp: 'LH 11/8/2020 17:40:12'!
newRoot

	^Root new! !


!classDefinition: #Body category: 'Portfolio-Ejercicio'!
ParentPortfolios subclass: #Body
	instanceVariableNames: 'parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Body methodsFor: 'validations' stamp: 'LH 11/8/2020 17:50:14'!
validateAccountBeforeAdding: anAccount
	
	parentPortfolios do: [:aParentPortfolio | aParentPortfolio validateAccountBeforeAdding: anAccount].  ! !

!Body methodsFor: 'validations' stamp: 'LH 11/8/2020 17:50:35'!
validatePortfoliosBeforeAdding: aPortfolioToAdd
	
	parentPortfolios do: [ :aParentPortfolio | (aParentPortfolio validatePortfolioBeforeAdding: aPortfolioToAdd)].  ! !


!Body methodsFor: 'intiliazing' stamp: 'LH 11/8/2020 17:48:49'!
initializeWith: aParentPortfolio for: aPortfolio

	parentPortfolios := OrderedCollection with: aParentPortfolio.
	
	childPortfolio := aPortfolio.! !


!Body methodsFor: 'adding' stamp: 'LH 11/8/2020 17:06:37'!
addAsFather: aPortfolio
	
	parentPortfolios add: aPortfolio.
	^ self.  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Body class' category: 'Portfolio-Ejercicio'!
Body class
	instanceVariableNames: ''!

!Body class methodsFor: 'instance creation' stamp: 'LH 11/8/2020 17:45:48'!
newWith: aParentPortfolio for: aPortfolio

	^self basicNew initializeWith: aParentPortfolio for: aPortfolio.! !


!classDefinition: #Root category: 'Portfolio-Ejercicio'!
ParentPortfolios subclass: #Root
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Root methodsFor: 'initialization' stamp: 'LH 11/8/2020 17:48:16'!
initialize: aPortfolio

	childPortfolio := aPortfolio.! !


!Root methodsFor: 'validations' stamp: 'LH 11/8/2020 17:50:53'!
validateAccountBeforeAdding: anAccount

	childPortfolio validateAccountNotAlredyAdded: anAccount.! !

!Root methodsFor: 'validations' stamp: 'LH 11/8/2020 17:51:08'!
validatePortfoliosBeforeAdding: aPortfolioToAdd

	childPortfolio validatePortfolioNotAlreadyAdded: aPortfolioToAdd.
	aPortfolioToAdd accounts do:[:anAccount | childPortfolio validateAccountBeforeAdding: anAccount] .! !


!Root methodsFor: 'adding' stamp: 'LH 11/8/2020 17:48:03'!
addAsFather: aPortfolio
	
	^ Body newWith: aPortfolio for: childPortfolio.! !


!classDefinition: #TransactionContainer category: 'Portfolio-Ejercicio'!
Object subclass: #TransactionContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionContainer methodsFor: 'accesing' stamp: 'LH 11/8/2020 15:53:50'!
balance
	"returns the balance of all transactions included in this entity"
	
	^self subclassResponsibility.
! !

!TransactionContainer methodsFor: 'accesing' stamp: 'LH 11/8/2020 15:54:12'!
transactions
	"returns all transactions included in this entity"

	^self subclassResponsibility.
! !


!TransactionContainer methodsFor: 'testing' stamp: 'LH 11/8/2020 15:59:05'!
hasRegistered: aTransaction
	"returns true if a Transaction is included in this entity"

	^self subclassResponsibility.
! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
TransactionContainer subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'LH 11/8/2020 17:41:29'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	
	parentPortfolios := ParentPortfolios forPortfolio: self.
	
	"fatherPortfolios := OrderedCollection new."! !


!Portfolio methodsFor: 'portfolios' stamp: 'LH 11/8/2020 16:02:44'!
addPortfolio: aPortfolio
	"Add aPortfolio to this Portfolio"

	self validatePortfolioBeforeAdding: aPortfolio.

	portfolios add: aPortfolio.
	aPortfolio addAsFather: self. 
! !


!Portfolio methodsFor: 'accounts' stamp: 'LH 11/8/2020 16:02:59'!
addAccount: anAccount
	"add anAccount to this Portfolio"

	self validateAccountBeforeAdding: anAccount.
	
	accounts add: anAccount.! !


!Portfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 17:37:04'!
ifItsARootPortfolioDo: rootClosure elseDo: normalPortfolioClosure
	"if this portfolio has no parents, do rootCLosure. else do normalPortfolioClosure"

	"fatherPortfolios size = 0
		ifTrue: [rootClosure value] 
			
		ifFalse:[normalPortfolioClosure value]."

	
	
	
! !

!Portfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 17:51:26'!
validateAccountBeforeAdding: anAccount
	"validate that anAccount is not alredy in this portfolio or it's parents"
	
	
	parentPortfolios validateAccountBeforeAdding: anAccount.
	
	"self ifItsARootPortfolioDo: [self validateAccountNotAlredyAdded: anAccount.] 
		elseDo: [fatherPortfolios do: [:aPortfolio | aPortfolio validateAccountBeforeAdding: anAccount]  ]."
	
	"fatherPortfolios size = 0
		ifTrue: [self validateAccountNotAlredyAdded: anAccount.] 
		ifFalse:[fatherPortfolios do: [:aPortfolio | aPortfolio validateAccountBeforeAdding: anAccount]  ]."

	! !

!Portfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 16:07:36'!
validateAccountNotAlredyAdded: anAccount
	"validate if an Account is this portfolio"

	(self includesAccount: anAccount) ifTrue: [^self error: Portfolio errorMessageAccountAlreadyAdded].
! !

!Portfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 17:51:38'!
validatePortfolioBeforeAdding: aPortfolio
	"validate that aPortfolio is not in this portfolio nor it's parents; and that the portfolio's accounts aren't in this portfolio not it's parents"

	parentPortfolios validatePortfoliosBeforeAdding: aPortfolio .
	
	
	"self ifItsARootPortfolioDo: [self validatePortfolioNotAlreadyAdded: aPortfolio.
							aPortfolio accounts do:[:anAccount | self validateAccountBeforeAdding: anAccount] .] 
						
			 elseDo: [fatherPortfolios do: [ :fatherPortfolio | (fatherPortfolio validatePortfolioBeforeAdding: aPortfolio)].  ]."




	"fatherPortfolios size = 0
		ifTrue: [self validatePortfolioNotAlreadyAdded: aPortfolio.
				aPortfolio accounts do:[:anAccount | self validateAccountBeforeAdding: anAccount] .] 
			
		ifFalse:[fatherPortfolios do: [ :fatherPortfolio | (fatherPortfolio validatePortfolioBeforeAdding: aPortfolio)].  ]."

	
	
	
! !

!Portfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 17:37:28'!
validatePortfolioNotAlreadyAdded: aPortfolio
	"validate if a Portfolio is this portfolio"
	
	(self includesPortfolio: aPortfolio) ifTrue: [self error: Portfolio errorMessagePortfolioAlreadyAdded].	(self = aPortfolio) ifTrue:[self error: Portfolio errorMessagePortfolioAlreadyAdded].

	"(self includesFatherPortfolio: aPortfolio) ifTrue: [self error: Portfolio errorMessagePortfolioAlreadyAdded]."
! !


!Portfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 16:01:57'!
accounts
	"Returns all the accounts of this Portfolio and it's portfolios"
	
	| allAccounts |
	allAccounts := accounts copy.
	portfolios do: [ :portfolio | allAccounts addAll: portfolio accounts ].
	^allAccounts.
! !

!Portfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 16:11:40'!
balance
	"return the balance of this portfolio's accounts's + portfolios's "
	
	| balance |
	balance := 0.
	self accountsAndPortfoliosDo: [ :aThing | balance := balance + aThing balance].
	^balance.
! !

!Portfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 16:11:46'!
transactions
	"return the transactions of this portfolio's accounts and portfolios"

	| transactions |
	transactions := OrderedCollection new.
	self accountsAndPortfoliosDo: [ :account | transactions addAll: account transactions].
	^transactions.
! !


!Portfolio methodsFor: 'testing' stamp: 'LH 11/8/2020 16:12:25'!
hasRegistered: aTransaction
	"return if this portfolio has aTransaction as a transaction"
	
	"self accountsAndPortfoliosDo: [ :aThing | (aThing hasRegistered: aDeposit) ifTrue: [^true]]
	^false.."
	
	^self transactions includes: aTransaction.
	
! !

!Portfolio methodsFor: 'testing' stamp: 'LH 11/8/2020 16:13:09'!
includesAccount: anAccount 
	"return if this portfolio has anAccount or not"

	^ self accounts includes: anAccount.

	"portfolios do: [ :portfolio | (portfolio includesAccount: anAccount) ifTrue: [^true]].
	^accounts includes: anAccount."! !

!Portfolio methodsFor: 'testing' stamp: 'LH 11/8/2020 16:13:14'!
includesPortfolio: aPortfolio 
	"return if this portfolio has aPortfolio or not"

	portfolios do: [ :portfolio | (portfolio includesPortfolio: aPortfolio) ifTrue: [^true]].
	
	^portfolios includes: aPortfolio.
! !


!Portfolio methodsFor: 'private' stamp: 'LH 11/7/2020 21:48:56'!
accountsAndPortfoliosDo: anAction
	"A method for doing anAction to a Portfolio's accounts and portfolios"

	accounts do: [ :account | anAction value: account.].
	portfolios do: [ :portfolio | anAction value: portfolio.].
! !

!Portfolio methodsFor: 'private' stamp: 'LH 11/8/2020 17:38:27'!
addAsFather: aPortfolio 
	"Set aPortfolio as a father"

	"fatherPortfolios add: aPortfolio."
	
	parentPortfolios := parentPortfolios addAsFather: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'IO 11/5/2020 15:06:47'!
errorMessageAccountAlreadyAdded
	^'This protfolio already includes this account.'! !

!Portfolio class methodsFor: 'error messages' stamp: 'IO 11/7/2020 17:46:04'!
errorMessageAccountInPortfolioAlreadyAdded
	^'An account in the protfolio to be added is already included in this portfolio.'! !

!Portfolio class methodsFor: 'error messages' stamp: 'IO 11/5/2020 15:10:35'!
errorMessagePortfolioAlreadyAdded
	^'This protfolio already includes the given portfolio.'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
TransactionContainer subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'IO 11/5/2020 14:33:02'!
balance
	|aBalance|
	aBalance := 0.
	transactions do: [ :aTransaction |aBalance:= aTransaction addToBalance: aBalance].
	^aBalance
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #TransactionPortfolio category: 'Portfolio-Ejercicio'!
TransactionContainer subclass: #TransactionPortfolio
	instanceVariableNames: 'accounts portfolios fatherPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionPortfolio methodsFor: 'initialization' stamp: 'LH 11/8/2020 16:40:46'!
initialize

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	
	fatherPortfolios := OrderedCollection new.
	! !


!TransactionPortfolio methodsFor: 'portfolios' stamp: 'LH 11/8/2020 16:40:47'!
addPortfolio: aPortfolio
	"Add aPortfolio to this Portfolio"

	self validatePortfolioBeforeAdding: aPortfolio.

	portfolios add: aPortfolio.
	aPortfolio addAsFather: self. 
! !


!TransactionPortfolio methodsFor: 'accounts' stamp: 'LH 11/8/2020 16:40:47'!
addAccount: anAccount
	"add anAccount to this Portfolio"

	self validateAccountBeforeAdding: anAccount.
	
	accounts add: anAccount.! !


!TransactionPortfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 16:40:47'!
ifItsARootPortfolioDo: rootClosure elseDo: normalPortfolioClosure
	"if this portfolio has no parents, do rootCLosure. else do normalPortfolioClosure"

	fatherPortfolios size = 0
		ifTrue: [rootClosure value] 
			
		ifFalse:[normalPortfolioClosure value].

	
	
	
! !

!TransactionPortfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 16:40:47'!
validateAccountBeforeAdding: anAccount
	"validate that anAccount is not alredy in this portfolio or it's parents"
	
	
	self ifItsARootPortfolioDo: [self validateAccountNotAlredyAdded: anAccount.] 
		elseDo: [fatherPortfolios do: [:aPortfolio | aPortfolio validateAccountBeforeAdding: anAccount]  ].
	
	"fatherPortfolios size = 0
		ifTrue: [self validateAccountNotAlredyAdded: anAccount.] 
		ifFalse:[fatherPortfolios do: [:aPortfolio | aPortfolio validateAccountBeforeAdding: anAccount]  ]."

	! !

!TransactionPortfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 16:40:47'!
validateAccountNotAlredyAdded: anAccount
	"validate if an Account is this portfolio"

	(self includesAccount: anAccount) ifTrue: [^self error: Portfolio errorMessageAccountAlreadyAdded].
! !

!TransactionPortfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 16:40:47'!
validatePortfolioBeforeAdding: aPortfolio
	"validate that aPortfolio is not in this portfolio nor it's parents; and that the portfolio's accounts aren't in this portfolio not it's parents"


	self ifItsARootPortfolioDo: [self validatePortfolioNotAlreadyAdded: aPortfolio.
							aPortfolio accounts do:[:anAccount | self validateAccountBeforeAdding: anAccount] .] 
						
			 elseDo: [fatherPortfolios do: [ :fatherPortfolio | (fatherPortfolio validatePortfolioBeforeAdding: aPortfolio)].  ].




	"fatherPortfolios size = 0
		ifTrue: [self validatePortfolioNotAlreadyAdded: aPortfolio.
				aPortfolio accounts do:[:anAccount | self validateAccountBeforeAdding: anAccount] .] 
			
		ifFalse:[fatherPortfolios do: [ :fatherPortfolio | (fatherPortfolio validatePortfolioBeforeAdding: aPortfolio)].  ]."

	
	
	
! !

!TransactionPortfolio methodsFor: 'validations' stamp: 'LH 11/8/2020 16:40:47'!
validatePortfolioNotAlreadyAdded: aPortfolio
	"validate if a Portfolio is this portfolio"

	(self includesPortfolio: aPortfolio) ifTrue: [self error: Portfolio errorMessagePortfolioAlreadyAdded].	(self = aPortfolio) ifTrue:[self error: Portfolio errorMessagePortfolioAlreadyAdded].

	"(self includesFatherPortfolio: aPortfolio) ifTrue: [self error: Portfolio errorMessagePortfolioAlreadyAdded]."
! !


!TransactionPortfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 16:40:47'!
accounts
	"Returns all the accounts of this Portfolio and it's portfolios"
	
	| allAccounts |
	allAccounts := accounts copy.
	portfolios do: [ :portfolio | allAccounts addAll: portfolio accounts ].
	^allAccounts.
! !

!TransactionPortfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 16:40:47'!
balance
	"return the balance of this portfolio's accounts's + portfolios's "
	
	| balance |
	balance := 0.
	self accountsAndPortfoliosDo: [ :aThing | balance := balance + aThing balance].
	^balance.
! !

!TransactionPortfolio methodsFor: 'accessing' stamp: 'LH 11/8/2020 16:40:47'!
transactions
	"return the transactions of this portfolio's accounts and portfolios"

	| transactions |
	transactions := OrderedCollection new.
	self accountsAndPortfoliosDo: [ :account | transactions addAll: account transactions].
	^transactions.
! !


!TransactionPortfolio methodsFor: 'testing' stamp: 'LH 11/8/2020 16:40:47'!
hasRegistered: aTransaction
	"return if this portfolio has aTransaction as a transaction"
	
	"self accountsAndPortfoliosDo: [ :aThing | (aThing hasRegistered: aDeposit) ifTrue: [^true]]
	^false.."
	
	^self transactions includes: aTransaction.
	
! !

!TransactionPortfolio methodsFor: 'testing' stamp: 'LH 11/8/2020 16:40:47'!
includesAccount: anAccount 
	"return if this portfolio has anAccount or not"

	^ self accounts includes: anAccount.

	"portfolios do: [ :portfolio | (portfolio includesAccount: anAccount) ifTrue: [^true]].
	^accounts includes: anAccount."! !

!TransactionPortfolio methodsFor: 'testing' stamp: 'LH 11/8/2020 16:40:47'!
includesPortfolio: aPortfolio 
	"return if this portfolio has aPortfolio or not"

	portfolios do: [ :portfolio | (portfolio includesPortfolio: aPortfolio) ifTrue: [^true]].
	
	^portfolios includes: aPortfolio.
! !


!TransactionPortfolio methodsFor: 'private' stamp: 'LH 11/8/2020 16:40:47'!
accountsAndPortfoliosDo: anAction
	"A method for doing anAction to a Portfolio's accounts and portfolios"

	accounts do: [ :account | anAction value: account.].
	portfolios do: [ :portfolio | anAction value: portfolio.].
! !

!TransactionPortfolio methodsFor: 'private' stamp: 'LH 11/8/2020 16:40:47'!
addAsFather: aPortfolio 
	"Set aPortfolio as a father"

	fatherPortfolios add: aPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransactionPortfolio class' category: 'Portfolio-Ejercicio'!
TransactionPortfolio class
	instanceVariableNames: ''!

!TransactionPortfolio class methodsFor: 'error messages' stamp: 'LH 11/8/2020 16:40:48'!
errorMessageAccountAlreadyAdded
	^'This protfolio already includes this account.'! !

!TransactionPortfolio class methodsFor: 'error messages' stamp: 'LH 11/8/2020 16:40:48'!
errorMessageAccountInPortfolioAlreadyAdded
	^'An account in the protfolio to be added is already included in this portfolio.'! !

!TransactionPortfolio class methodsFor: 'error messages' stamp: 'LH 11/8/2020 16:40:48'!
errorMessagePortfolioAlreadyAdded
	^'This protfolio already includes the given portfolio.'! !
