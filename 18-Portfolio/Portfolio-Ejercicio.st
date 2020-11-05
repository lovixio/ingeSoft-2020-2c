!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'LH 11/2/2020 20:58:28'!
test01AnAccountCanBeAddedToAPortfolio
	|anAccount aPortfolio|
	
	anAccount :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount.
	
	self assert: (aPortfolio includesAccount: anAccount).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LH 11/2/2020 20:58:52'!
test02APortfolioDoesNotHaveMoreAccountsThanAdded
	|anAccount1 anAccount2 aPortfolio|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	anAccount2 :=  ReceptiveAccount new.
	Deposit register: 200 on: anAccount2.
	
	aPortfolio := Portfolio new.
	aPortfolio addAccount: anAccount1.
	
	self assert: (aPortfolio includesAccount: anAccount1).
	self deny: (aPortfolio includesAccount: anAccount2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LH 11/2/2020 20:59:00'!
test03MoreThanOneAccountCanBeAddedToAPortfolio
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

!PortfolioTest methodsFor: 'tests' stamp: 'LH 11/2/2020 20:52:15'!
test04AnEmptyPortfolioHasABalanceOf0
	|aPortfolio|
	
	aPortfolio := Portfolio new.
	
	self assert: 0 equals: aPortfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LH 11/2/2020 20:58:07'!
test05APortfolioWithOneAccountShouldHaveABalanceEqualToThatOfTheAccount
	|aPortfolio anAccount|
	
	anAccount :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	aPortfolio := Portfolio new.
	
	aPortfolio addAccount: anAccount.
	
	self assert: anAccount balance equals: aPortfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'LH 11/2/2020 21:14:26'!
test06APortfolioWithManyAccountsShouldHaveABalanceEqualToTheSumOfItsAccounts
	|aPortfolio anAccount1 anAccount2|
	
	anAccount1 :=  ReceptiveAccount new.
	Deposit register: 100 on: anAccount1.
	anAccount2 :=  ReceptiveAccount new.
	Deposit register: 200 on: anAccount2.
	aPortfolio := Portfolio new.
	
	aPortfolio addAccount: anAccount1.
	aPortfolio addAccount: anAccount2.
	
	self 
		assert: (anAccount1 balance + anAccount2 balance)
		equals: aPortfolio balance.
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

!AccountTransaction methodsFor: 'value' stamp: 'LH 11/2/2020 19:27:17'!
balanceValue
	"returns the value as how it impacts the balance of an account"
	
	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance operations' stamp: 'LH 11/2/2020 20:37:15'!
addToBalance: aBalance 
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


!Deposit methodsFor: 'value' stamp: 'LH 11/2/2020 19:27:39'!
balanceValue
	"see superclass"

	^ value.! !

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


!Withdraw methodsFor: 'value' stamp: 'LH 11/2/2020 19:27:46'!
balanceValue
	"see superclass"
	
	^value negated.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance operations' stamp: 'LH 11/2/2020 20:38:33'!
addToBalance: aBalance

	^aBalance - value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'adding' stamp: 'LH 11/2/2020 20:47:27'!
addAccount: anAccount

	accounts add: anAccount.! !


!Portfolio methodsFor: 'testing' stamp: 'LH 11/2/2020 20:49:20'!
includesAccount: anAccount 

	^accounts includes: anAccount.! !


!Portfolio methodsFor: 'initialization' stamp: 'LH 11/2/2020 20:48:50'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'accesing' stamp: 'LH 11/2/2020 21:15:50'!
balance
	|aBalance|
	aBalance := 0.
	accounts do: [:anAccount | aBalance:= aBalance + anAccount balance].
	^aBalance.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'LH 11/2/2020 20:40:03'!
balance
	|aBalance|
	aBalance := 0.
	transactions do: [ :aTransaction |aBalance:= aTransaction addToBalance: aBalance].
	^aBalance
	
	"
	^transactions sum: [ :aTransaction | aTransaction balanceValue] ifEmpty: [ 0 ]
	"! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
