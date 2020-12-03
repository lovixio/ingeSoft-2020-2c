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

!CashierTest methodsFor: 'tests' stamp: 'IO 12/1/2020 20:23:33'!
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


!classDefinition: #CreditCardTest category: 'TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCardTest methodsFor: 'test' stamp: 'IO 12/3/2020 00:31:40'!
assertInvalidCardNumberErrorWithNumber: aCCNumber 

    self
	should: [CreditCard withCcn: aCCNumber withCced: DateAndTime now + 31 days withCco: 'PEPE SANCHEZ'.]
        raise: Error
        withMessageText: CreditCard invalidCcn.! !

!CreditCardTest methodsFor: 'test' stamp: 'IO 12/3/2020 00:24:06'!
test01cannotCreateCreditCardWithInvalidCcn
	
	self assertInvalidCardNumberErrorWithNumber: '00000000000000000'.
	self assertInvalidCardNumberErrorWithNumber: '000000000000000'.
! !

!CreditCardTest methodsFor: 'test' stamp: 'IO 12/3/2020 00:25:39'!
test02cannotCreateCreditCardWithNotNumericCcn
	
	self assertInvalidCardNumberErrorWithNumber: '0000000000000000A'.
! !

!CreditCardTest methodsFor: 'test' stamp: 'IO 12/3/2020 00:35:09'!
test03cannotCreateCreditCardWithoutOwner
    self
	should: [CreditCard withCcn: '5400000000000001' withCced: DateAndTime now + 31 days withCco: ''.]
        raise: Error
        withMessageText: CreditCard invalidCco.
! !

!CreditCardTest methodsFor: 'test' stamp: 'IO 12/3/2020 00:38:32'!
test04storesCcnAndCco

	| creditCard |
	creditCard := CreditCard withCcn: '5400000000000002' withCced: DateAndTime now + 31 days withCco: 'PEPE GOMEZ'.

	self assert: '5400000000000002' equals: creditCard ccn.
	self assert: 'PEPE GOMEZ' equals: creditCard cco.! !


!classDefinition: #StoreInterfaceTest category: 'TusLibros'!
TestCase subclass: #StoreInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clock clientsBook timeLeap'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterfaceTest methodsFor: 'set up' stamp: 'IO 12/1/2020 18:48:29'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clock := [ DateAndTime now ].
	clientsBook := testObjectsFactory clients.
	timeLeap := 0 seconds.
! !


!StoreInterfaceTest methodsFor: 'clientsBook' stamp: 'LH 11/30/2020 20:20:38'!
validateUser: aUserID andPassword: aPassword

	(clientsBook keys includes: aUserID) ifFalse: [^self error: StoreInterface invalidClientId].
	((clientsBook at: aUserID) = aPassword) ifFalse: [^self error: StoreInterface invalidClientId].! !


!StoreInterfaceTest methodsFor: 'clock' stamp: 'IO 12/1/2020 19:00:11'!
leap: aTime

	timeLeap := timeLeap + aTime.! !

!StoreInterfaceTest methodsFor: 'clock' stamp: 'IO 12/1/2020 18:46:52'!
now
	^DateAndTime now + timeLeap.! !


!StoreInterfaceTest methodsFor: 'debit' stamp: 'LH 11/28/2020 21:32:52'!
debit: anAmmount from: aCreditCard 
	^debitBehavior value: anAmmount value: aCreditCard.! !


!StoreInterfaceTest methodsFor: 'tests cart usage' stamp: 'IO 12/1/2020 19:41:02'!
test01ANewStoreHasNoActiveCarts

	|aStoreInterface|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	
	self assert: 0 equals: aStoreInterface numberOfActiveCarts.! !

!StoreInterfaceTest methodsFor: 'tests cart usage' stamp: 'IO 12/1/2020 19:31:41'!
test02ACartCanBeCreatedInAStore
	|aStoreInterface|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	
	aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	self assert: 1 equals: aStoreInterface numberOfActiveCarts.! !

!StoreInterfaceTest methodsFor: 'tests cart usage' stamp: 'IO 12/1/2020 19:31:52'!
test03AStoreInterfaceCanCreateMultipleCarts
	|aStoreInterface|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.


	aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface createCartFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword.
	
	self assert: 2 equals: aStoreInterface numberOfActiveCarts.! !

!StoreInterfaceTest methodsFor: 'tests cart usage' stamp: 'IO 12/1/2020 19:32:03'!
test04ANewCartInAStoreIsEmpty
	| aCartId aStoreInterface|
	

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.


	
	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	self assert: (aStoreInterface listCart: aCartId) isEmpty.! !

!StoreInterfaceTest methodsFor: 'tests cart usage' stamp: 'IO 12/1/2020 19:32:11'!
test05AStoreCanAddItemsToMultipleCarts
	| aCartId1 aCartId2 aStoreInterface|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	aCartId1 := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	aCartId2 := aStoreInterface createCartFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword.
	
	aStoreInterface addToCart: aCartId1 book: (testObjectsFactory itemSellByTheStore) quantity: 2.
	aStoreInterface addToCart: aCartId2 book: (testObjectsFactory itemSellByTheStore) quantity: 1.
	
	self assert: 2 equals: ((aStoreInterface listCart: aCartId1) occurrencesOf: (testObjectsFactory itemSellByTheStore)).
	self assert: 1 equals: ((aStoreInterface listCart: aCartId2) occurrencesOf: (testObjectsFactory itemSellByTheStore)).! !

!StoreInterfaceTest methodsFor: 'tests cart usage' stamp: 'IO 12/3/2020 00:04:27'!
test06ACartWithItemsCanBeCheckedOut
	| aCartID aStoreInterface items |
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	aCartID := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: aCartID book: testObjectsFactory itemSellByTheStore quantity: 2.

	aStoreInterface checkOutCart: aCartID
		ccn: testObjectsFactory notExpiredCreditCard ccn
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.
	
	items := Bag new.
	items add: testObjectsFactory itemSellByTheStore withOccurrences: 2.
	
	self assert: (aStoreInterface hasMadeTheSale: (Sale of: testObjectsFactory itemSellByTheStorePrice *2 withItems: items) for: testObjectsFactory validClientId).! !


!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'LH 12/2/2020 11:47:28'!
test07CannotModifyACartFromOutsideStore
	| aCartID listedCart aStoreInterface|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	aCartID := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: aCartID book: testObjectsFactory itemSellByTheStore quantity: 2.
	
	listedCart := aStoreInterface listCart: aCartID.
	
	listedCart add: testObjectsFactory itemSellByTheStore withOccurrences: 2.

	self assert: 2 equals: ((aStoreInterface listCart: aCartID) occurrencesOf: testObjectsFactory itemSellByTheStore).! !

!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'IO 12/1/2020 19:32:27'!
test08CannotCreateCartWithInvalidClientId
	|aStoreInterface|

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	self
		should: [aStoreInterface createCartFor: testObjectsFactory invalidClientId password: testObjectsFactory validClientPassword]
		raise: Error
		withMessageText: StoreInterface invalidClientId.

	! !

!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'LH 12/2/2020 12:03:03'!
test09CannotCreateCartWithInvalidClientPassword
	|aStoreInterface|

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	self
		should: [aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory invalidClientPassword]
		raise: Error
		withExceptionDo:[:anError |
			self assert: anError messageText equals: StoreInterface invalidClientId.
			self assert: 0 equals: aStoreInterface numberOfActiveCarts.].

	! !

!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'LH 12/2/2020 12:04:24'!
test14CannotAddOnNotExistentCart
	|aStoreInterface|

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	self
		should: [aStoreInterface addToCart: 1 book: testObjectsFactory itemSellByTheStore quantity: 1]
		raise: Error
		withMessageText: StoreInterface invalidCartId.

	! !

!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'IO 12/1/2020 20:07:14'!
test15CannotListNotExistentCart
	|aStoreInterface|

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	self
		should: [aStoreInterface listCart: 1]
		raise: Error
		withMessageText: StoreInterface invalidCartId.

	! !

!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'LH 12/2/2020 12:06:32'!
test16CannotOperateAfterCheckout
	| aStoreInterface aCartId |

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 1.

	aStoreInterface checkOutCart: aCartId
		ccn: testObjectsFactory notExpiredCreditCard ccn
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.

	self
		should: [aStoreInterface listCart: aCartId]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: StoreInterface invalidCartId.
			self assert: 0 equals: aStoreInterface numberOfActiveCarts].

	! !

!StoreInterfaceTest methodsFor: 'tests bad cart usage' stamp: 'IO 12/3/2020 00:55:40'!
test20CannotUseInvalidCreditCard
	| aStoreInterface aCartId |

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 1.

	self
		should: [aStoreInterface checkOutCart: aCartId
		ccn: '5041'
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.]
		raise: Error
		withExceptionDo: [:anError |
			self assert: anError messageText equals: CreditCard invalidCcn.
			self assert: 1 equals: aStoreInterface numberOfActiveCarts.
			self assert: testObjectsFactory emptySale equals: (aStoreInterface listPurchasesFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword)
		].

	! !


!StoreInterfaceTest methodsFor: 'tests time invalidation' stamp: 'LH 12/2/2020 12:11:26'!
assertThatACart: aCartId fromTheStore: aStoreInterface IsNotValidAfter30MinutesWhenDoing: aStoreInterfaceAction
	
	self leap: 30 minutes.
	
	self should: aStoreInterfaceAction
		raise: Error
		withExceptionDo: [:anError |
				self assert: anError messageText equals: StoreInterface invalidCartOutOfTime.
				self deny: (aStoreInterface isActiveCart: aCartId).]
! !

!StoreInterfaceTest methodsFor: 'tests time invalidation' stamp: 'LH 12/2/2020 12:12:39'!
test10CannotAdd30MinutesAfterCreation
	|aStoreInterface aCartId|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
								
	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	self  assertThatACart: aCartId
		fromTheStore: aStoreInterface 
		IsNotValidAfter30MinutesWhenDoing: [aStoreInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 2].
	
! !

!StoreInterfaceTest methodsFor: 'tests time invalidation' stamp: 'LH 12/2/2020 12:13:40'!
test11CannotCheckout30MinutesAfterAdding
	|aStoreInterface aCartId|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self andClock: self.
								
	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	aStoreInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 2.

	self  assertThatACart: aCartId
	fromTheStore: aStoreInterface 
	IsNotValidAfter30MinutesWhenDoing: [
			aStoreInterface checkOutCart: aCartId
				ccn: testObjectsFactory notExpiredCreditCard ccn
				cced: testObjectsFactory notExpiredCreditCard cced
				cco: testObjectsFactory notExpiredCreditCard cco.].
! !

!StoreInterfaceTest methodsFor: 'tests time invalidation' stamp: 'LH 12/2/2020 12:14:47'!
test12CannotList30MinutesAfterLastOperation
	|aStoreInterface aCartId|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self andClock: self.
								
	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	self leap: 20 minutes.
	
	aStoreInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 2.

	self leap: 20 minutes.
	
	aStoreInterface listCart: aCartId.
	
	self  assertThatACart: aCartId
		fromTheStore: aStoreInterface 
		IsNotValidAfter30MinutesWhenDoing: [aStoreInterface listCart: aCartId].! !

!StoreInterfaceTest methodsFor: 'tests time invalidation' stamp: 'IO 12/1/2020 19:07:19'!
test13CanListDuring30MinutesAfterLastListing
	|aStoreInterface aCartId|
	
	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self andClock: self.
								
	aCartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	
	self leap: 20 minutes.
	
	aStoreInterface addToCart: aCartId book: testObjectsFactory itemSellByTheStore quantity: 2.

	self leap: 20 minutes.
	
	aStoreInterface listCart: aCartId.

	self leap: 20 minutes.
	
	aStoreInterface listCart: aCartId.
! !


!StoreInterfaceTest methodsFor: 'tests list purchases' stamp: 'IO 12/3/2020 00:53:25'!
test17clientHasInitialyNoPurchases

	|aStoreInterface |

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.

	self assert: (testObjectsFactory emptySale) equals: (
		aStoreInterface listPurchasesFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword)
! !

!StoreInterfaceTest methodsFor: 'tests list purchases' stamp: 'IO 12/3/2020 00:50:50'!
test18clientAfterCheckoutHasPurchasedBooks

	| aStoreInterface items itemsTotal cartId |

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	
	cartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 2.
	aStoreInterface addToCart: cartId book: testObjectsFactory anotherItemSellByTheStore quantity: 2.
	aStoreInterface checkOutCart: cartId
		ccn: testObjectsFactory notExpiredCreditCard ccn
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.
	
	cartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 4.
	aStoreInterface addToCart: cartId book: testObjectsFactory anotherItemSellByTheStore quantity: 4.
	aStoreInterface checkOutCart: cartId
		ccn: testObjectsFactory notExpiredCreditCard ccn
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.

	items := Bag new.
	items add: testObjectsFactory itemSellByTheStore withOccurrences: 6.
	items add: testObjectsFactory anotherItemSellByTheStore withOccurrences: 6.
	itemsTotal := (testObjectsFactory itemSellByTheStorePrice * 6) + (testObjectsFactory anotherItemSellByTheStorePrice * 6).

	self assert: (Sale of: itemsTotal withItems: items) equals: (
		aStoreInterface listPurchasesFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword
	)
! !

!StoreInterfaceTest methodsFor: 'tests list purchases' stamp: 'IO 12/3/2020 00:58:20'!
test19manyClientsCanAccessTheirPurchasesList

	| aStoreInterface items itemsTotal cartId |

	aStoreInterface := testObjectsFactory aStoreInterfaceWithSimulator: self.
	
	cartId := aStoreInterface createCartFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword.
	aStoreInterface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 2.
	aStoreInterface addToCart: cartId book: testObjectsFactory anotherItemSellByTheStore quantity: 2.
	aStoreInterface checkOutCart: cartId
		ccn: testObjectsFactory notExpiredCreditCard ccn
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.
	
	cartId := aStoreInterface createCartFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword.
	aStoreInterface addToCart: cartId book: testObjectsFactory itemSellByTheStore quantity: 4.
	aStoreInterface addToCart: cartId book: testObjectsFactory anotherItemSellByTheStore quantity: 4.
	aStoreInterface checkOutCart: cartId
		ccn: testObjectsFactory notExpiredCreditCard ccn
		cced: testObjectsFactory notExpiredCreditCard cced
		cco: testObjectsFactory notExpiredCreditCard cco.

	items := Bag new.
	items add: testObjectsFactory itemSellByTheStore withOccurrences: 2.
	items add: testObjectsFactory anotherItemSellByTheStore withOccurrences: 2.
	itemsTotal := (testObjectsFactory itemSellByTheStorePrice * 2) + (testObjectsFactory anotherItemSellByTheStorePrice * 2).

	self assert: (Sale of: itemsTotal withItems: items) equals: (
		aStoreInterface listPurchasesFor: testObjectsFactory validClientId password: testObjectsFactory validClientPassword
	).

	items := Bag new.
	items add: testObjectsFactory itemSellByTheStore withOccurrences: 4.
	items add: testObjectsFactory anotherItemSellByTheStore withOccurrences: 4.
	itemsTotal := (testObjectsFactory itemSellByTheStorePrice * 4) + (testObjectsFactory anotherItemSellByTheStorePrice * 4).

	self assert: (Sale of: itemsTotal withItems: items) equals: (
		aStoreInterface listPurchasesFor: testObjectsFactory anotherValidClientId password: testObjectsFactory anotherValidClientPassword
	)
! !


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


!Cart methodsFor: 'initialization' stamp: 'LH 12/2/2020 11:50:45'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


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

!Cart methodsFor: 'adding' stamp: 'LH 12/2/2020 11:51:18'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity.! !


!Cart methodsFor: 'copying' stamp: 'IO 12/2/2020 23:58:31'!
copy

	| cartCopy |
	
	cartCopy := Cart acceptingItemsOf: catalog.
	items do: [ :item | cartCopy add: 1 of: item].
	
	^cartCopy.
! !


!Cart methodsFor: 'accessing' stamp: 'LH 12/2/2020 11:48:50'!
listItems
	^ items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'cart lastAction client clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:19:45'!
add: aQuantity of: anItem
	self beforeOperation.
	cart add: aQuantity of: anItem.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:36:55'!
beforeOperation

	self setLastUsageTime.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:22:26'!
initializeWithCart: aCart withClock: aClock
	cart := aCart.
	clock := aClock.
	lastAction := clock now.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:24:35'!
isEmpty
	^cart isEmpty.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:15:24'!
isEmtpy
	^cart isEmpty.! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:36:46'!
isValid
	"validates if the cart associated with a cart ID is usable at this moment.
	In the case it is not, the cart is deleted from the list if necessary and an error is returned"

	^(clock now - lastAction < 30 minutes)
! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:20:31'!
listItems
	self beforeOperation.
	^cart listItems! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:31:49'!
setLastUsageTime
	
	lastAction := clock now.
! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:08:42'!
total
	^cart total! !

!CartSession methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:05:05'!
validate
	"validates if the cart associated with a cart ID is usable at this moment.
	In the case it is not, the cart is deleted from the list if necessary and an error is returned"

	(clock now - lastAction < 30 minutes) ifFalse: [
		^self error: StoreInterface invalidCartOutOfTime].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'IO 12/3/2020 01:12:18'!
withCart: aCart withClock: aClock
	^self basicNew initializeWithCart: aCart withClock: aClock.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'IO 12/2/2020 21:46:14'!
createSale

	^Sale of: total withItems: cart listItems.

! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'IO 12/2/2020 22:29:03'!
registerSale

	salesBook add: self createSale.! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'IO 12/2/2020 22:28:33'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.

! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'IO 12/2/2020 22:28:42'!
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
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'IO 12/3/2020 00:28:38'!
initializeWithCcn: aCCNumber withCced: aCCExpirationDate withCco: aCCOwner.

	number := aCCNumber.
	expiration := aCCExpirationDate.
	owner := aCCOwner.
 ! !


!CreditCard methodsFor: 'accessing' stamp: 'IO 12/1/2020 20:14:21'!
cced
	^expiration! !

!CreditCard methodsFor: 'accessing' stamp: 'IO 12/3/2020 00:38:55'!
ccn
	^number! !

!CreditCard methodsFor: 'accessing' stamp: 'IO 12/3/2020 00:39:06'!
cco
	^owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'IO 12/3/2020 00:34:21'!
withCcn: aCCNumber withCced: aCCExpirationDate withCco: aCCOwner

	(
		(aCCNumber allSatisfy: [ :aDigit | aDigit isDigit ]) and:
		aCCNumber size = 16
	) ifFalse: [^self error: CreditCard invalidCcn].
	
	(aCCOwner size > 0) ifFalse: [^self error: CreditCard invalidCco].

	^self basicNew initializeWithCcn: aCCNumber withCced: aCCExpirationDate withCco: aCCOwner.! !


!CreditCard class methodsFor: 'error messages' stamp: 'IO 12/3/2020 00:24:43'!
invalidCcn
	^'Invalid credit card number'.! !

!CreditCard class methodsFor: 'error messages' stamp: 'IO 12/3/2020 00:19:16'!
invalidCco
	^'Invalid credit card owner'.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total products items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'IO 12/1/2020 20:49:11'!
total

	^ total! !


!Sale methodsFor: 'queries' stamp: 'IO 12/3/2020 00:05:31'!
= aSale

	^(total = aSale total) and: items = aSale listItems.! !


!Sale methodsFor: 'initialization' stamp: 'IO 12/2/2020 21:43:30'!
initializeTotal: aTotal withItems: anItemsBag

	total := aTotal.
	items := anItemsBag.
! !


!Sale methodsFor: 'accessing' stamp: 'IO 12/2/2020 21:42:20'!
listItems
	^items copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'IO 12/2/2020 21:45:11'!
of: aTotal withItems: aBagOfItems

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withItems: aBagOfItems.
! !


!classDefinition: #StoreInterface category: 'TusLibros'!
Object subclass: #StoreInterface
	instanceVariableNames: 'catalogue carts salesBook clientDatabase merchantProccessor clock lastActionForCarts clientForCart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreInterface methodsFor: 'initialization' stamp: 'IO 12/3/2020 00:07:52'!
initializeWithCatalogue: aCatalgue withMerchantProccessor: aMerchantProccessor withClientDatabase: aClientDatabase withClock: aClock 
	
	catalogue := aCatalgue.
	merchantProccessor := aMerchantProccessor.
	clientDatabase := aClientDatabase.
	clock := aClock.
	
	carts := Dictionary new. "cartId -> Cart"
	salesBook := Dictionary new. "clientId -> Sale[]"
	lastActionForCarts := Dictionary new. "cartId -> DateAndTime"
	clientForCart := Dictionary new. "cartId -> clientId"


! !


!StoreInterface methodsFor: 'testing' stamp: 'IO 12/2/2020 22:41:48'!
hasMadeTheSale: aSale for: aClientId

	^(salesBook at: aClientId) includes: aSale.! !

!StoreInterface methodsFor: 'testing' stamp: 'LH 12/2/2020 12:17:13'!
isActiveCart: aCartID 
	"awnsers if there is a usable cart associated with a cart ID"
	^carts includesKey: aCartID.
! !

!StoreInterface methodsFor: 'testing' stamp: 'LH 12/2/2020 12:18:25'!
numberOfActiveCarts
	"awnsers the number of carts that exist in the store"
	^carts size.! !


!StoreInterface methodsFor: 'interface' stamp: 'IO 12/3/2020 01:41:08'!
addToCart: aCartId book: anItem quantity: aQuantity 
	"adds a quantity of an item to the cart associated with a cart ID"
	self do:[
		(carts at: aCartId) add: aQuantity of: anItem] onCart: aCartId.! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 12/3/2020 01:39:44'!
checkOutCart: aCartId ccn: aCCNumber cced: aCCExpirationDate cco: aCCOwner
	"checksout the cart associated with a cart ID and removes the cart after, debiting the credit card that matches the information.
	The sale is registered on the sales book"
	| total clientId |

	self do: [
		clientId := clientForCart at: aCartId.

		total := (Cashier
			toCheckout: (carts at: aCartId)
			charging: (CreditCard withCcn: aCCNumber withCced: aCCExpirationDate withCco: aCCOwner)
			throught: merchantProccessor
			on: DateAndTime now
			registeringOn: (salesBook at: clientId)) checkOut.
	] onCart: aCartId.

	carts removeKey: aCartId.

	^total
! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 12/2/2020 22:32:43'!
createCartFor: aClientId password: aPassword
	"creates a new cart for an user with a password"
	clientDatabase validateUser: aClientId andPassword: aPassword.

	^self createCartFor: aClientId.
! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 12/3/2020 01:38:51'!
listCart: aCartId
	"lists the contentes of the cart associated to a cart ID"
	^self do: [(carts at: aCartId) listItems] onCart: aCartId.! !

!StoreInterface methodsFor: 'interface' stamp: 'IO 12/3/2020 00:55:00'!
listPurchasesFor: aClientId password: aPassword
	"lists the purchases that have been made by carts associated with an user" 
	| items itemsTotal |

	items := Bag new.
	itemsTotal := 0.

	(salesBook at: aClientId ifAbsent: OrderedCollection new) do: [ :sale |
		items addAll: sale listItems.
		itemsTotal := itemsTotal + sale total.
	].

	^Sale of: itemsTotal withItems: items.
! !


!StoreInterface methodsFor: 'cart invalidation' stamp: 'LH 12/2/2020 12:24:51'!
setCartUsageTime: aCartId
	"registers the current Date and Time as the last usage of the cart associated with a cart ID"
	lastActionForCarts add: (Association key: aCartId value: clock now).
! !

!StoreInterface methodsFor: 'cart invalidation' stamp: 'LH 12/2/2020 12:26:29'!
validateCart: aCartId
	"validates if the cart associated with a cart ID is usable at this moment.
	In the case it is not, the cart is deleted from the list if necessary and an error is returned"
	(self isActiveCart: aCartId) ifFalse: [^self error: StoreInterface invalidCartId].
	(clock now - (lastActionForCarts at: aCartId) < 30 minutes) ifFalse: [
		carts removeKey: aCartId.
		^self error: StoreInterface invalidCartOutOfTime.].
! !


!StoreInterface methodsFor: 'private' stamp: 'IO 12/3/2020 01:16:57'!
createCartFor: aClientId
	"creates a new cart in this Store interface"
	|aCartId|

	aCartId := carts keys size + 1.
	carts at: aCartId put: (CartSession
		withCart: (Cart acceptingItemsOf: catalogue)
		withClock: clock).

	clientForCart at: aCartId put: aClientId.
	salesBook at: aClientId ifAbsentPut: OrderedCollection new.

	^aCartId.
! !

!StoreInterface methodsFor: 'private' stamp: 'IO 12/3/2020 01:41:32'!
do: anOperation onCart: aCartId
	"this method validates that we operate on a valid cart, then it sets the time of operation as the last known use of the cart and executes the operation"
	(carts at: aCartId ifAbsent: [^self error: StoreInterface invalidCartId]) isValid ifFalse: [
		carts removeKey: aCartId.
		^self error: StoreInterface invalidCartOutOfTime].

	^anOperation value.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreInterface class' category: 'TusLibros'!
StoreInterface class
	instanceVariableNames: ''!

!StoreInterface class methodsFor: 'instance creation' stamp: 'IO 12/1/2020 18:43:23'!
withCatalogue: aDictionary withMerchantProccessor: aMerchantProccessor withClientDatabase: aClientBook withClock: aClock 

	^self new initializeWithCatalogue: aDictionary withMerchantProccessor: aMerchantProccessor withClientDatabase: aClientBook withClock: aClock ! !


!StoreInterface class methodsFor: 'error descriptions' stamp: 'LH 11/28/2020 20:59:56'!
invalidCartId
	^'The Cart ID is not valid'! !

!StoreInterface class methodsFor: 'error descriptions' stamp: 'LH 11/30/2020 18:52:42'!
invalidCartOutOfTime
	^ 'The Cart has Expired due to no usage for more than 30 minutes'! !

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


!StoreTestObjectsFactory methodsFor: 'store' stamp: 'IO 12/1/2020 18:37:16'!
aStoreInterfaceWithSimulator: aSimulator

	^ StoreInterface withCatalogue: self defaultCatalog 
								withMerchantProccessor: aSimulator 
								withClientDatabase: aSimulator
								withClock: aSimulator. ! !

!StoreTestObjectsFactory methodsFor: 'store' stamp: 'IO 12/1/2020 18:38:51'!
aStoreInterfaceWithSimulator: aSimulator andClock: aClock

	^ StoreInterface withCatalogue: self defaultCatalog 
								withMerchantProccessor: aSimulator 
								withClientDatabase: aSimulator
								withClock: aClock. ! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'IO 11/29/2020 16:21:52'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'IO 12/3/2020 00:36:45'!
expiredCreditCard
	
	^CreditCard withCcn: '5400000000000001' withCced: (Month month: today monthIndex year: today yearNumber - 1) withCco: 'PEPE SANCHEZ'.
! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'IO 12/3/2020 00:36:29'!
notExpiredCreditCard
	
	^CreditCard withCcn: '5400000000000001' withCced: (Month month: today monthIndex year: today yearNumber + 1) withCco: 'PEPE SANCHEZ'.! !


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


!StoreTestObjectsFactory methodsFor: 'sale' stamp: 'IO 12/3/2020 00:55:28'!
emptySale
	^Sale of: 0 withItems: Bag new! !
