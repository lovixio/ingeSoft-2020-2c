!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreInterfaceTest category: 'TusLibros'!
TestCase subclass: #StoreInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior shopInterface'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterfaceTest methodsFor: 'set up' stamp: 'IO 11/30/2020 02:55:21'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].

	shopInterface := StoreInterface
		withCatalogue: testObjectsFactory defaultCatalog
		withMerchantProccessor: self
		withClients: testObjectsFactory clients.! !


!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:24:13'!
test01ANewStoreHasNoActiveCarts
	
	self setUp.
	
	self assert: 0 equals: shopInterface numberOfActiveCarts.! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:38:48'!
test02ACartCanBeCreatedInAStore

	self setUp.
	
	self createValidCart.
	
	self assert: 1 equals: shopInterface numberOfActiveCarts.! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:54:00'!
test03AStoreInterfaceCanCreateMultipleCarts
	
	self setUp.
	
	self createValidCart.
	shopInterface createCartFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword.
	
	self assert: 2 equals: shopInterface numberOfActiveCarts.! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:39:25'!
test04ANewCartInAStoreIsEmpty
	| aCartId |
	
	self setUp.
	
	aCartId := self createValidCart.
	
	self assert: (shopInterface listCart: aCartId) isEmpty.! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:39:31'!
test05AStoreCanAddAnItemToOneOfItsCarts
	| aCartId |
	
	self setUp.

	aCartId := self createValidCart.
	
	shopInterface addToCart: aCartId book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	
	self assert: (shopInterface listCart: aCartId) includes: (testObjectsFactory itemSellByTheStore).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:39:59'!
test06AStoreCanAddMoreThanOneOfAnItemToItsCarts
	| aCartId |
	
	self setUp.

	aCartId := self createValidCart.
	
	shopInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 2.
	
	self assert: 2 equals: ((shopInterface listCart: aCartId) occurrencesOf: testObjectsFactory itemSellByTheStore).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:40:15'!
test07AStoreCanAddDifferentItemsToItsCarts
	| aCartId listedCart |
	
	self setUp.

	aCartId := self createValidCart.

	shopInterface addToCart: aCartId book: (testObjectsFactory itemSellByTheStore) quantity: 2.
	shopInterface addToCart: aCartId book: (testObjectsFactory anotherItemSellByTheStore ) quantity: 3.
	
	listedCart := (shopInterface listCart: aCartId).
	self assert: 2 equals: (listedCart occurrencesOf: testObjectsFactory itemSellByTheStore).
	self assert: 3 equals: (listedCart occurrencesOf: testObjectsFactory anotherItemSellByTheStore).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:54:00'!
test08AStoreCanAddItemsToMultipleCarts
	| aCartId1 aCartId2 |
	
	self setUp.

	aCartId1 := self createValidCart.
	aCartId2 := shopInterface createCartFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword.
	
	shopInterface addToCart: aCartId1 book: (testObjectsFactory itemSellByTheStore) quantity: 2.
	shopInterface addToCart: aCartId2 book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	
	self assert: 2 equals: ((shopInterface listCart: aCartId1) occurrencesOf: (testObjectsFactory itemSellByTheStore)).
	self assert: 1 equals: ((shopInterface listCart: aCartId2) occurrencesOf: (testObjectsFactory itemSellByTheStore)).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:40:28'!
test09ACartWithItemsCanBeCheckedOut
	| aCartID |
	
	self setUp.

	aCartID := self createValidCart.
	shopInterface addToCart: aCartID book: testObjectsFactory itemSellByTheStore quantity: 2.

	shopInterface checkOutCart: aCartID with: (testObjectsFactory notExpiredCreditCard).
	
	self assert: (shopInterface hasMadeTheSale: (Sale of: testObjectsFactory itemSellByTheStorePrice *2)).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:54:00'!
test10ManyCartsCanBeCheckedOut
	| aCartID1 aCartID2 |
	
	self setUp.

	aCartID1 := self createValidCart.
	shopInterface addToCart: aCartID1 book: testObjectsFactory itemSellByTheStore quantity: 2.
	aCartID2 := shopInterface createCartFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword.
	shopInterface addToCart: aCartID2 book: testObjectsFactory itemSellByTheStore quantity: 10.
	
	shopInterface checkOutCart: aCartID1 with: (testObjectsFactory notExpiredCreditCard).
	shopInterface checkOutCart: aCartID2 with: (testObjectsFactory notExpiredCreditCard).
	
	self assert: (shopInterface hasMadeTheSale: (Sale of: testObjectsFactory itemSellByTheStorePrice *10)).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:40:50'!
test11CannotModifyACartFromOutsideStore
	| aCartID listedCart |
	
	self setUp.

	aCartID := self createValidCart.
	shopInterface addToCart: aCartID book: testObjectsFactory itemSellByTheStore quantity: 2.
	
	listedCart := shopInterface listCart: aCartID.
	
	listedCart add: 10 of: testObjectsFactory itemSellByTheStore.

	self assert: 2 equals: ((shopInterface listCart: aCartID) occurrencesOf: testObjectsFactory itemSellByTheStore).! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:57:48'!
test12CannotCreateCartWithInvalidClientId

	self setUp.

	self
		should: [shopInterface createCartFor: testObjectsFactory invalidClientId password: testObjectsFactory validClientPassword]
		raise: Error
		withMessageText: StoreInterface invalidClientId.

	! !

!StoreInterfaceTest methodsFor: 'test' stamp: 'IO 11/30/2020 02:57:48'!
test13CannotCreateCartWithInvalidClientPassword

	self setUp.

	self
		should: [shopInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory invalidClientPassword]
		raise: Error
		withMessageText: StoreInterface invalidClientId.

	! !


!StoreInterfaceTest methodsFor: 'debit' stamp: 'LH 11/28/2020 21:32:52'!
debit: anAmmount from: aCreditCard 
	^debitBehavior value: anAmmount value: aCreditCard.! !


!StoreInterfaceTest methodsFor: 'tools' stamp: 'IO 11/30/2020 02:54:58'!
createValidCart

	^shopInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'IO 11/30/2020 02:07:33'!
copy
	| cartCopy |
	
	cartCopy := Cart acceptingItemsOf: catalog.
	items do: [ :item | cartCopy add: 1 of: item].
	
	^cartCopy.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'queries' stamp: 'LH 11/28/2020 21:42:43'!
= aSale

	^ total = aSale total.! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreInterface category: 'TusLibros'!
Object subclass: #StoreInterface
	instanceVariableNames: 'catalogue carts merchantProcessor salesBook users'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterface methodsFor: 'initialization' stamp: 'IO 11/30/2020 02:17:02'!
initializeWithCatalogue: aCatalogue andMerchantProccessor: aMerchantProccessor  
	
	catalogue := aCatalogue.
	merchantProcessor := aMerchantProccessor.

	salesBook := OrderedCollection new.
	carts := OrderedCollection new.
! !

!StoreInterface methodsFor: 'initialization' stamp: 'IO 11/30/2020 02:55:49'!
initializeWithCatalogue: aCatalogue andMerchantProccessor: aMerchantProccessor withClients: aClientDictionary 
	
	catalogue := aCatalogue.
	merchantProcessor := aMerchantProccessor.

	salesBook := OrderedCollection new.
	carts := OrderedCollection new.
	
	users := aClientDictionary.

! !


!StoreInterface methodsFor: 'testing' stamp: 'IO 11/30/2020 02:16:13'!
hasMadeTheSale: aSale

	^salesBook includes: aSale.! !

!StoreInterface methodsFor: 'testing' stamp: 'IO 11/30/2020 02:16:56'!
numberOfActiveCarts
	
	^carts size.! !


!StoreInterface methodsFor: 'interface' stamp: 'IO 11/30/2020 02:15:20'!
addToCart: aCartId book: anISBN quantity: aQuantity 
	
	(carts at: aCartId) add: aQuantity of: anISBN.! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 11/30/2020 02:13:29'!
checkOutCart: aCartId with: aCreditCard
	
	^(Cashier
		toCheckout: (self listCart: aCartId)
		charging: aCreditCard
		throught: merchantProcessor
		on: DateAndTime now
		registeringOn: salesBook) checkOut.
	
! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 11/30/2020 03:02:09'!
createCartFor: aUserID password: aPassword

	(users keys includes: aUserID) ifFalse: [^self error: StoreInterface invalidClientId].
	((users at: aUserID) = aPassword) ifFalse: [^self error: StoreInterface invalidClientId].
	
	carts add: (Cart acceptingItemsOf: catalogue).
	^carts size.
! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 11/30/2020 02:04:01'!
listCart: aCartId 
	
	^(carts at: aCartId) copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreInterface class' category: 'TusLibros'!
StoreInterface class
	instanceVariableNames: ''!

!StoreInterface class methodsFor: 'instance creation' stamp: 'IO 11/30/2020 02:55:59'!
withCatalogue: aCatalogue withMerchantProccessor: aMerchantProccessor withClients: aClientDictionary 
	
	^self new initializeWithCatalogue: aCatalogue andMerchantProccessor: aMerchantProccessor withClients: aClientDictionary ! !


!StoreInterface class methodsFor: 'error descriptions' stamp: 'LH 11/28/2020 20:59:56'!
invalidCartId
	^'The Cart ID is not valid'! !

!StoreInterface class methodsFor: 'error descriptions' stamp: 'IO 11/30/2020 02:58:11'!
invalidClientId
	^'The client id is not valid'! !

!StoreInterface class methodsFor: 'error descriptions' stamp: 'IO 11/30/2020 02:58:04'!
invalidClientPassword
	^'The client password is not valid'! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'IO 11/29/2020 16:20:15'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'IO 11/29/2020 16:21:18'!
anotherItemSellByTheStorePrice
	
	^ 20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'IO 11/29/2020 16:21:52'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:53:47'!
anotherValidClientId
	^'admin2'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:54:00'!
anotherValidClientPassword
	^'password2'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:54:58'!
clients

	| userPasswordDictionary |
	
	userPasswordDictionary := Dictionary new.
	userPasswordDictionary add: (Association key: self validClientId value: self validClientPassword).
	userPasswordDictionary add: (Association key: self anotherValidClientId value: self anotherValidClientPassword).

	^userPasswordDictionary.
! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:54:10'!
invalidClientId
	^'bad-user'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:54:24'!
invalidClientPassword
	^'bad-pass'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:54:45'!
validClientId
	^'admin'.! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'IO 11/30/2020 02:54:58'!
validClientPassword
	^'password'.! !
