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

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'IO 11/8/2020 19:51:26'!
test35CanNotAddAPortfolioWithAccountsAlredyInTheParentsOfTheReceiver
	
	"
		no se pueden agregar un portfolio cuando tiene cuentas repetidas en los padres del receptor 
		p1 ->	p2 -> p4 -x p5 -> a3,a2,a1|
		     -> a1| -> a2|
			 p3 -> p3|
			      -> a3|
	"
	
	| portfolio1 portfolio2 portfolio3 portfolio4 portfolio5 portfolio6 account1 account2 account3 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	portfolio6 := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.	
	
	"
		p1 [a1] x> p4 [a1]
		p1 [a1] x> p3 -> p4 [a1]
		
	"

	portfolio1 addPortfolio: portfolio2.
	portfolio2 addPortfolio: portfolio4.
	portfolio3 addPortfolio: portfolio4.
	portfolio6 addPortfolio: portfolio5.
	portfolio1 addAccount: account1.
	portfolio2 addAccount: account2.
	portfolio3 addAccount: account3.
	portfolio5 addAccount: account1.
	portfolio5 addAccount: account2.
	portfolio5 addAccount: account3.

	self should: [	portfolio4 addPortfolio: portfolio6.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'IO 11/8/2020 19:55:02'!
test35CanNotAddAPortfolioWithAccountsInFirstLevelAlredyInTheParentsOfTheReceiver
	
	"
		no se pueden agregar un portfolio que tiene cuentas en si mismo repetidas en los padres del receptor 
		p1 [a1] x> p4 [a1]
	"
	
	| portfolio1 portfolio2 account1 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio2 addAccount: account1.

	self should: [	portfolio1 addPortfolio: portfolio2.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
! !

!PortfolioTest methodsFor: 'errors adding portfolios by parents' stamp: 'IO 11/8/2020 19:56:30'!
test36CanNotAddAPortfolioWithAccountsInDeeperLevelAlredyInTheParentsOfTheReceiver
	
	"
		no se pueden agregar un portfolio que tiene cuentas en sus portfolios repetidas en los padres del receptor 
		p1 [a1] x> p3 -> p4 [a1]
	"
	
	| portfolio1 portfolio2 portfolio3 account1 |
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addAccount: account1.
	portfolio2 addPortfolio: portfolio3.
	portfolio3 addAccount: account1.

	self should: [	portfolio1 addPortfolio: portfolio2.] raise: Error withMessageText: Portfolio errorMessageAccountAlreadyAdded.
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
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'balance operations' stamp: 'IO 11/8/2020 18:04:58'!
addToBalance: aBalance

	"returns the resulting balance after aplying the net value of this transaction"	

	self subclassResponsibility.
! !


!AccountTransaction methodsFor: 'accessing' stamp: 'IO 11/8/2020 18:08:05'!
value

	"returns the value of a transaction. it is always postitive, it is not the net value"

	^value.

! !


!AccountTransaction methodsFor: 'initialization' stamp: 'IO 11/8/2020 18:07:39'!
initializeFor: aValue

	"initialize a transaction with a given value"

	value := aValue.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'IO 11/8/2020 18:18:49'!
for: aValue

	"create a transaction. use register:on: to create it for an account"

	^self new initializeFor: aValue.
! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'IO 11/8/2020 18:17:29'!
register: aValue on: account

	"create a transaction and register it in an account"

	| transaction |

	transaction := self for: aValue.
	account register: transaction.

	^transaction.
! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'balance operations' stamp: 'IO 11/8/2020 18:09:12'!
addToBalance: aBalance

	"see superclass"

	^aBalance + value.
! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'balance operations' stamp: 'IO 11/8/2020 18:09:19'!
addToBalance: aBalance

	"see superclass"

	^aBalance - value.
! !


!classDefinition: #ParentPortfolios category: 'Portfolio-Ejercicio'!
Object subclass: #ParentPortfolios
	instanceVariableNames: 'childPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ParentPortfolios methodsFor: 'validations' stamp: 'IO 11/8/2020 19:07:58'!
validateAccountBeforeAdding: anAccount

	"validate that the given account is not in this portfolio, neither in children's portfolios, nor in parents' portfolios"

	^self subclassResponsibility ! !

!ParentPortfolios methodsFor: 'validations' stamp: 'IO 11/8/2020 19:08:29'!
validatePortfoliosBeforeAdding: anAccount

	"validate that the given portfolio is not in this portfolio, neither in children's portfolios, nor in parents' portfolios"

	^self subclassResponsibility ! !


!ParentPortfolios methodsFor: 'adding' stamp: 'IO 11/8/2020 19:05:01'!
addAsParent: aPortfolio

	"add a portfolio as parent of this parent portfolio"

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ParentPortfolios class' category: 'Portfolio-Ejercicio'!
ParentPortfolios class
	instanceVariableNames: ''!

!ParentPortfolios class methodsFor: 'instance creation' stamp: 'IO 11/8/2020 19:08:48'!
forPortfolio: aPortfolio

	"create a parent portfolio of a given portfolio"

	^Root new initialize: aPortfolio! !


!classDefinition: #Body category: 'Portfolio-Ejercicio'!
ParentPortfolios subclass: #Body
	instanceVariableNames: 'parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Body methodsFor: 'validations' stamp: 'IO 11/8/2020 19:14:25'!
parentPortfoliosDo: aBlock

	"perform an action over all the parent portfolios of this parent portfolio"
	
	parentPortfolios do: [ :aParentPortfolio | aBlock  value: aParentPortfolio ].
! !

!Body methodsFor: 'validations' stamp: 'IO 11/8/2020 19:14:34'!
validateAccountBeforeAdding: anAccount

	"see superclass"
	
	self parentPortfoliosDo: [ :aParentPortfolio | aParentPortfolio validateAccountBeforeAdding: anAccount].
! !

!Body methodsFor: 'validations' stamp: 'IO 11/8/2020 19:14:37'!
validatePortfoliosBeforeAdding: aPortfolioToAdd

	"see superclass"
	
	self parentPortfoliosDo: [ :aParentPortfolio | aParentPortfolio validatePortfolioBeforeAdding: aPortfolioToAdd].
! !


!Body methodsFor: 'intiliazing' stamp: 'IO 11/8/2020 19:13:18'!
initializeWith: aParentPortfolio for: aPortfolio

	"initialize the parents of a portfolio with a given parent portfolio"

	parentPortfolios := OrderedCollection with: aParentPortfolio.
	childPortfolio := aPortfolio.
! !


!Body methodsFor: 'adding' stamp: 'IO 11/8/2020 19:14:51'!
addAsParent: aPortfolio

	"see superclass"
	
	parentPortfolios add: aPortfolio.
	^self.  ! !

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

!Root methodsFor: 'initialization' stamp: 'IO 11/8/2020 19:18:42'!
initialize: aPortfolio

	"initialize the parent portfolios of a given portfolio"

	childPortfolio := aPortfolio.
! !


!Root methodsFor: 'validations' stamp: 'IO 11/8/2020 19:20:29'!
validateAccountBeforeAdding: anAccount

	"
		see superclass
		implementation details: this method will lookup the account in all the children portfolio's account. if the account
			is found in one of the chidlren, the given account cannot be added to the portfolio
	"

	(childPortfolio includesAccount: anAccount) ifTrue: [^self error: Portfolio errorMessageAccountAlreadyAdded].
! !

!Root methodsFor: 'validations' stamp: 'IO 11/8/2020 19:57:00'!
validatePortfoliosBeforeAdding: aPortfolioToAdd

	"
		see superclass
		implementation details: this method will search that the portfolio to be added is not in the portfolio's children,
			and will also validate that none of its children portfolios has one of the accounts of the portfolio to be added.
	"

	(childPortfolio = aPortfolioToAdd) ifTrue: [self error: Portfolio errorMessagePortfolioAlreadyAdded].
	(childPortfolio includesPortfolio: aPortfolioToAdd) ifTrue: [self error: Portfolio errorMessagePortfolioAlreadyAdded].
	aPortfolioToAdd accounts do: [ :anAccount | childPortfolio validateAccountBeforeAdding: anAccount].
! !


!Root methodsFor: 'adding' stamp: 'IO 11/8/2020 19:17:43'!
addAsParent: aPortfolio

	"
		see superclass
		implementation details: this parent portfolio has no parent portfolios. when the portfolio of this parent portfolios is
			added as a child of another portfolio, it will have parent portfolios. it is not a root anymore.
	"

	^Body newWith: aPortfolio for: childPortfolio.
! !


!classDefinition: #TransactionContainer category: 'Portfolio-Ejercicio'!
Object subclass: #TransactionContainer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!TransactionContainer methodsFor: 'accesing' stamp: 'IO 11/8/2020 18:36:35'!
balance

	"returns the balance of all transactions included in this entity"
	
	^self subclassResponsibility.
! !

!TransactionContainer methodsFor: 'accesing' stamp: 'IO 11/8/2020 18:36:46'!
transactions

	"returns all transactions registered in this entity"

	^self subclassResponsibility.
! !


!TransactionContainer methodsFor: 'testing' stamp: 'IO 11/8/2020 18:36:40'!
hasRegistered: aTransaction

	"returns true if a Transaction is registered in this entity"

	^self subclassResponsibility.
! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
TransactionContainer subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'IO 11/8/2020 18:16:51'!
initialize

	"create a portfolio with no accounts and no sub-portfolios"

	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	
	parentPortfolios := ParentPortfolios forPortfolio: self.
! !


!Portfolio methodsFor: 'validations' stamp: 'IO 11/8/2020 18:39:28'!
validateAccountBeforeAdding: anAccount

	"validate an account before adding it to this portfolio"

	parentPortfolios validateAccountBeforeAdding: anAccount.
! !

!Portfolio methodsFor: 'validations' stamp: 'IO 11/8/2020 19:00:51'!
validatePortfolioBeforeAdding: aPortfolio

	"validate a portfolio before adding it to this portfolio"

	parentPortfolios validatePortfoliosBeforeAdding: aPortfolio.
! !


!Portfolio methodsFor: 'accessing' stamp: 'IO 11/8/2020 19:02:35'!
accounts

	"return all the accounts in this Portfolio and it's portfolios"

	| allAccounts |

	allAccounts := accounts copy.
	self portfoliosDo: [ :portfolio | allAccounts addAll: portfolio accounts].

	^allAccounts.
! !

!Portfolio methodsFor: 'accessing' stamp: 'IO 11/8/2020 20:08:53'!
balance

	"
		see superclass
		implementation detials: return the balance of this portfolio. it will sum this portfolio accounts and the children
		portfolio's accounts balances
	"
	
	| balance |

	balance := 0.
	self accountsAndPortfoliosDo: [ :aTransactionContainer | balance := balance + aTransactionContainer balance].

	^balance.
! !

!Portfolio methodsFor: 'accessing' stamp: 'IO 11/8/2020 20:03:50'!
transactions

	"see superclass"

	| transactions |

	transactions := OrderedCollection new.
	self accountsAndPortfoliosDo: [ :account | transactions addAll: account transactions].

	^transactions.
! !


!Portfolio methodsFor: 'testing' stamp: 'IO 11/8/2020 19:58:51'!
hasRegistered: aTransaction

	"see superclass"

	^self transactions includes: aTransaction.
	
! !

!Portfolio methodsFor: 'testing' stamp: 'IO 11/8/2020 19:59:34'!
includesAccount: anAccount 

	"return true if this portfolio includes anAccount"

	^self accounts includes: anAccount.
! !

!Portfolio methodsFor: 'testing' stamp: 'IO 11/8/2020 19:59:50'!
includesPortfolio: aPortfolio

	"return true if this portfolio includes aPortfolio"

	self portfoliosDo: [ :portfolio | (portfolio includesPortfolio: aPortfolio) ifTrue: [^true]].
	^portfolios includes: aPortfolio.
! !


!Portfolio methodsFor: 'iterating' stamp: 'IO 11/8/2020 20:00:07'!
accountsAndPortfoliosDo: aBlock

	"perform a block over the child portfolios and accounts of this portfolio (not all the subportfolios)"

	self accountsDo: [ :account | aBlock value: account.].
	self portfoliosDo: [ :portfolio | aBlock value: portfolio.].
! !

!Portfolio methodsFor: 'iterating' stamp: 'IO 11/8/2020 19:25:34'!
accountsDo: aBlock

	"perform a block over the accounts of this portfolio (not all the subportfolios)"

	accounts do: [ :account | aBlock value: account.].
! !

!Portfolio methodsFor: 'iterating' stamp: 'IO 11/8/2020 19:25:12'!
portfoliosDo: aBlock

	"perform a block over the child portfolios of this portfolio (not all the subportfolios)"

	portfolios do: [ :portfolio | aBlock value: portfolio ].
! !


!Portfolio methodsFor: 'adding' stamp: 'IO 11/8/2020 18:22:41'!
addAccount: anAccount

	"add anAccount to this Portfolio"

	self validateAccountBeforeAdding: anAccount.
	accounts add: anAccount.
! !

!Portfolio methodsFor: 'adding' stamp: 'IO 11/8/2020 18:59:25'!
addPortfolio: aPortfolio

	"add aPortfolio to this Portfolio"

	self validatePortfolioBeforeAdding: aPortfolio.
	portfolios add: aPortfolio.
	aPortfolio addAsParent: self.
! !


!Portfolio methodsFor: 'private' stamp: 'IO 11/8/2020 18:59:25'!
addAsParent: aPortfolio

	"add a portfolio as this prtfolio's parent"
	
	parentPortfolios := parentPortfolios addAsParent: aPortfolio.
! !

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

!ReceptiveAccount methodsFor: 'initialization' stamp: 'IO 11/8/2020 18:12:17'!
initialize

	"create an account with no transactions regitered"

	transactions := OrderedCollection new.
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'IO 11/8/2020 18:12:38'!
register: aTransaction

	"register a transaction in this account"

	transactions add: aTransaction.
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'IO 11/8/2020 18:12:54'!
transactions

	"see superclass"

	^transactions copy.
! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'IO 11/8/2020 18:11:23'!
balance

	"see superclass"

	| aBalance |

	aBalance := 0.
	transactions do: [ :aTransaction | aBalance:= aTransaction addToBalance: aBalance].

	^aBalance.
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'IO 11/8/2020 18:11:47'!
hasRegistered: aTransaction

	"see superclass"

	^transactions includes: aTransaction.

! !
