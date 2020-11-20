!classDefinition: #ShoppingCartTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:06:58'!
test01NewCartIsEmpty
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	
	self assert: 0 equals: aCart listCart size.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:07:02'!
test02CanAddABookToACart
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3'.
	
	self assert: 1 equals: aCart listCart size.
	self assert: (aCart listCart includes: '0-7645-2641-3').! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:07:21'!
test03CanAddManyBooksToACart
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4').
	aCart add: '0-7645-2641-3'.
	aCart add: '0-7645-2641-4'.
	
	self assert: 2 equals: aCart listCart size.
	self assert: (aCart listCart includes: '0-7645-2641-3').
	self assert: (aCart listCart includes: '0-7645-2641-4').! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:07:10'!
test04CanMoreThanOneFromTheSameBookToACart
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3' withQuantity: 2.
	
	self assert: 2 equals: aCart listCart size.
	
	aCart add: '0-7645-2641-3'.
	
	self assert: 3 equals: aCart listCart size.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:07:47'!
test05CanNotAddABookWithInvalidISBN
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection new).
	
	self should: [aCart add: '0-7645-2641-3']
		raise: Error
		withMessageText: ShoppingCart invalidISBNErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:11:25'!
test06CanNotAdd0Books
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: 0]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:13:34'!
test07CanNotAddMinusBooks
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: -1]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'LH 11/19/2020 18:14:40'!
test08CanNotAddNotWholeBooks
	|aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: 1.5]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !


!classDefinition: #ShoppingCashierTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 21:15:37'!
invalidDate

	^(Date today - (Date today daysInMonth days)) month
		! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 20:16:34'!
test01AnEmptyCartCannotBeCheckedOut
	|aCashier aCart|
	
	aCart := ShoppingCart withCatalogue: OrderedCollection new.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary new).
	
	self should: [aCashier checkOut: aCart withCardNumber: '0000000000000000' ExpirationDate: self validDate andCardOwner: 'Juan Pablo']
		raise: Error
		withMessageText: ShoppingCashier invalidCartErrorMessage.! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 20:16:42'!
test02ACartWith1BookWillCheckOutCorrectly
	|aCashier aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)) .
	
	self assert: 100 equals: (aCashier checkOut: aCart withCardNumber: '0000000000000000' ExpirationDate: self validDate andCardOwner: 'Juan Pablo').! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 20:16:46'!
test03ACartWithManyBooksWillCheckOutCorrectly
	|aCashier aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4').
	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 100)) .
	
	self assert: 300 equals: (aCashier checkOut: aCart withCardNumber: '0000000000000000' ExpirationDate: self validDate andCardOwner: 'Juan Pablo').! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 20:53:31'!
test04TheCardShouldNotBeExpired
	|aCashier aCart|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)) .
	
	self should:[ (aCashier checkOut: aCart withCardNumber: '0000000000000000' ExpirationDate: self invalidDate andCardOwner: 'Juan Pablo')]
		raise: Error
		withMessageText: ShoppingCashier invalidCreditCard.
		! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 21:15:08'!
validDate

	^(Date today + (Date today daysInMonth days)) month
		! !


!classDefinition: #ShoppingCart category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books catalgue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCart methodsFor: 'initialization' stamp: 'LH 11/19/2020 19:06:56'!
initializeWithCatalogue: aCatalgue 

	catalgue := aCatalgue.
	books := Bag new.! !


!ShoppingCart methodsFor: 'accessing' stamp: 'LH 11/19/2020 17:53:12'!
listCart
	^books copy.! !


!ShoppingCart methodsFor: 'adding' stamp: 'LH 11/19/2020 18:06:37'!
add: anISBN 
	
	(catalgue includes: anISBN) ifFalse:[^self error: ShoppingCart invalidISBNErrorMessage].
	
	books add: anISBN.! !

!ShoppingCart methodsFor: 'adding' stamp: 'LH 11/19/2020 18:16:50'!
add: anISBN withQuantity: aQuantity 
	
	(aQuantity isInteger and: aQuantity > 0) ifFalse:[^self error: ShoppingCart invalidQuantityErrorMessage ].
	
	books add: anISBN withOccurrences: aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: 'Ejercicio-20-Tus-Libros'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'instance creation' stamp: 'LH 11/19/2020 18:04:15'!
withCatalogue: anOrderedCollection 

	^self new initializeWithCatalogue: anOrderedCollection ! !


!ShoppingCart class methodsFor: 'Error Description' stamp: 'LH 11/19/2020 18:05:22'!
invalidISBNErrorMessage
	^'ISBN is no in the Catalogue'! !

!ShoppingCart class methodsFor: 'Error Description' stamp: 'LH 11/19/2020 18:12:19'!
invalidQuantityErrorMessage
	^'Should only add a positive whole number of books'! !


!classDefinition: #ShoppingCashier category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #ShoppingCashier
	instanceVariableNames: 'priceCatalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCashier methodsFor: 'checkOut' stamp: 'LH 11/19/2020 21:14:20'!
checkOut: aShoppingCart withCardNumber: aCreditCardNumber ExpirationDate: anExpirationDate andCardOwner: aName 

	aShoppingCart listCart size = 0 ifTrue:[^self error: ShoppingCashier invalidCartErrorMessage].
	
	(anExpirationDate yearNumber < Date today yearNumber)
			ifTrue:[ ^self error: ShoppingCashier invalidCreditCard].  
	(anExpirationDate yearNumber = Date today yearNumber and: anExpirationDate monthIndex <= Date today monthIndex) 
			ifTrue: [^self error: ShoppingCashier invalidCreditCard ].
	
	^ aShoppingCart listCart inject: 0 into: [:theSum :anISBN | theSum + priceCatalogue at: anISBN].! !


!ShoppingCashier methodsFor: 'initialization' stamp: 'LH 11/19/2020 19:09:18'!
initializeWithPriceCatalogue: aPriceCatalogue 

	priceCatalogue := aPriceCatalogue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCashier class' category: 'Ejercicio-20-Tus-Libros'!
ShoppingCashier class
	instanceVariableNames: ''!

!ShoppingCashier class methodsFor: 'error Description' stamp: 'LH 11/19/2020 18:54:33'!
invalidCartErrorMessage
	^'The Cart Has no Books'! !

!ShoppingCashier class methodsFor: 'error Description' stamp: 'LH 11/19/2020 20:52:32'!
invalidCreditCard
	^'invalid credit card information'! !


!ShoppingCashier class methodsFor: 'instance creation' stamp: 'LH 11/19/2020 19:08:45'!
withPriceCatalogue: aPriceCatalogue 

	^self new initializeWithPriceCatalogue: aPriceCatalogue ! !
