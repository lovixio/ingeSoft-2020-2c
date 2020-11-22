!classDefinition: #CreditCardTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!CreditCardTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:43:53'!
test01ACreditCardCanBeNotExpired

	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: (Date today + self daysThisMonth) month.
	
	self deny: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:41:27'!
test02ACreditCardWithExpirationDatingThisMonthAndYearIsExpired
	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: Date today month.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:41:27'!
test03ACreditCardWithExpirationDatingAPastMonthThisYearIsExpired
	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: (Date today - self daysThisMonth) month.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:41:27'!
test04ACreditCardWithExpirationDatingAFutureYearIsNotExpired
	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: (Date today + self daysInYear) month .
	
	self deny: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:41:27'!
test05ACreditCardWithExpirationDatingAPastYearIsExpired
	|aCreditCard|
	
	aCreditCard := self validCreditCardWithTheExpirationDate: (Date today - self daysInYear + self daysThisMonth) month.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/21/2020 18:40:19'!
test06CreditCarNumberCantHaveAnythingBut16Symbols
	
	self assertInvalidCardNumberErrorWithNumber: '00000000000000000'.
	self assertInvalidCardNumberErrorWithNumber: '000000000000000'.
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'LH 11/21/2020 18:40:48'!
test07CreditCarNumberCantHaveAnythingButNumbers
	
	self assertInvalidCardNumberErrorWithNumber: '000000000000000O'.
	
	! !

!CreditCardTest methodsFor: 'tests' stamp: 'IO 11/22/2020 17:17:47'!
test08TheNameOfACreditCardOwnerCanNotBeBlank
	
	self should: [CreditCard withNumber: '0000000000000000'
		expirationDate: (Date today - self daysInYear + self daysThisMonth) month
		belongingTo: ''.]
		raise: Error
		withMessageText: CreditCard invalidCreditCardOwnerName.
	
	! !


!CreditCardTest methodsFor: 'util' stamp: 'LH 11/21/2020 18:39:36'!
assertInvalidCardNumberErrorWithNumber: aCCNumber 
	
	self should: [CreditCard         withNumber: aCCNumber
							expirationDate: Date today month 
							belongingTo: 'Juan Pablo'.]
		raise: Error
		withMessageText: CreditCard invalidCreditCardNumber.
	
	! !

!CreditCardTest methodsFor: 'util' stamp: 'LH 11/21/2020 17:55:28'!
daysInYear
	
	^365 days 

	! !

!CreditCardTest methodsFor: 'util' stamp: 'LH 11/21/2020 17:53:12'!
daysThisMonth

	^Date today daysInMonth days.
	! !

!CreditCardTest methodsFor: 'util' stamp: 'IO 11/22/2020 16:41:27'!
validCreditCardWithTheExpirationDate: anExpirationDate
	
	 ^CreditCard  withNumber: '0000000000000000' 
				expirationDate: anExpirationDate 
				belongingTo: 'Juan Pablo'.
	


	! !


!classDefinition: #ShoppingCartTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:09'!
test01NewCartIsEmpty
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self assert: 0 equals: aCart listCart size.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:16'!
test02CanAddABookToACart
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
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

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:43'!
test04CanMoreThanOneFromTheSameBookToACart
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
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

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:51'!
test06CanNotAdd0Books
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: 0]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:47:58'!
test07CanNotAddMinusBooks
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: -1]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 16:48:02'!
test08CanNotAddNotWholeBooks
	|aCart|
	
	aCart := self newShoppingCartWithAProduct.
	
	self should: [aCart add: '0-7645-2641-3' withQuantity: 1.5]
		raise: Error
		withMessageText: ShoppingCart invalidQuantityErrorMessage.
	
! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'IO 11/22/2020 18:11:44'!
test09CannotEditCartList
	| aCart list |
	
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4').
	aCart add: '0-7645-2641-3'.

	
	list := aCart listCart.
	list add: '0-7645-2641-4'.

	self assert: 1 equals: aCart listCart size.

	self assert: (aCart listCart includes: '0-7645-2641-3').
	self deny: (aCart listCart includes: '0-7645-2641-4').! !


!ShoppingCartTest methodsFor: 'util' stamp: 'IO 11/22/2020 16:47:01'!
newShoppingCartWithAProduct
	
	^ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
! !


!classDefinition: #ShoppingCashierTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/21/2020 18:45:09'!
test01AnEmptyCartCannotBeCheckedOut
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: OrderedCollection new.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'. 
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary new).
	
	self should: [aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ShoppingCashier invalidCartErrorMessage.! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/21/2020 18:45:51'!
test02ACartWith1BookWillCheckOutCorrectly
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)) .
	
	self assert: 100 equals: (aCashier checkOut: aCart withCreditCard: aCreditCard).! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/21/2020 18:46:28'!
test03ACartWithManyBooksWillCheckOutCorrectly
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4').
	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 100)) .
	
	self assert: 300 equals: (aCashier checkOut: aCart withCreditCard: aCreditCard).! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'LH 11/21/2020 18:47:36'!
test04TheCardShouldNotBeExpired
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self invalidDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)) .
	
	self should:[ aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ShoppingCashier invalidCreditCard.
		! !

!ShoppingCashierTest methodsFor: 'tests' stamp: 'IO 11/22/2020 17:56:41'!
test05ACartShouldNotCheckoutIfMerchantProcessorFails

	|aCashier aCart aCreditCard aMerchantProcessor|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4').
	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aMerchantProcessor := ErroredMerchantProcessor new.

	aCashier := ShoppingCashier
		withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 100))
		andMerchantProcessor: aMerchantProcessor.
	
	
	self should: [aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ErroredMerchantProcessor dummyErrorMessage.
		
	
! !


!ShoppingCashierTest methodsFor: 'util' stamp: 'LH 11/19/2020 21:15:37'!
invalidDate

	^(Date today - (Date today daysInMonth days)) month
		! !

!ShoppingCashierTest methodsFor: 'util' stamp: 'LH 11/19/2020 21:15:08'!
validDate

	^(Date today + (Date today daysInMonth days)) month
		! !


!classDefinition: #CreditCard category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expirationDate nameOfOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!CreditCard methodsFor: 'initialization' stamp: 'IO 11/22/2020 16:26:39'!
initializeWithNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName 
	
	creditCardNumber := aCCNumber.
	expirationDate := anExpirationDate.
	nameOfOwner := aName.
! !


!CreditCard methodsFor: 'testing' stamp: 'IO 11/22/2020 17:51:37'!
isExpired
	"returns if this credit card is expired"
	|expirationDateYear currentMonth currentYear|
	
	expirationDateYear := expirationDate yearNumber.
	currentMonth := Date today monthIndex.
	currentYear := Date today yearNumber.
	
	
	^(
		expirationDate monthIndex <= currentMonth  and: expirationDateYear = currentYear
	) or: expirationDateYear < currentYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Ejercicio-20-Tus-Libros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'IO 11/22/2020 18:12:01'!
withNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName 
	
	(
		(aCCNumber allSatisfy: [ :aDigit | aDigit isDigit ]) and:
		aCCNumber size = 16
	) ifFalse: [^self error: CreditCard invalidCreditCardNumber].

	(aName notEmpty) ifFalse: [^self error: CreditCard invalidCreditCardOwnerName].

	^self new initializeWithNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName.
! !


!CreditCard class methodsFor: 'error description' stamp: 'LH 11/21/2020 18:05:13'!
invalidCreditCardNumber
	^'CreditCard number can only have exactly 16 numbers and nothing else'! !

!CreditCard class methodsFor: 'error description' stamp: 'LH 11/21/2020 18:25:03'!
invalidCreditCardOwnerName
	^'The Name of the Owner can not be blank'! !


!classDefinition: #MerchantProcessor category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'IO 11/22/2020 17:36:29'!
debitWith: aCreditCard for: anAmount
	^self subclassResponsibility.
! !


!classDefinition: #ErroredMerchantProcessor category: 'Ejercicio-20-Tus-Libros'!
MerchantProcessor subclass: #ErroredMerchantProcessor
	instanceVariableNames: 'failure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ErroredMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'IO 11/22/2020 17:38:46'!
debitWith: aCreditCard for: anAmount
	^self error: ErroredMerchantProcessor dummyErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErroredMerchantProcessor class' category: 'Ejercicio-20-Tus-Libros'!
ErroredMerchantProcessor class
	instanceVariableNames: ''!

!ErroredMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'IO 11/22/2020 17:33:01'!
dummyErrorMessage
	^'Merchant Processor error message'.
! !


!classDefinition: #NullMerchantProcessor category: 'Ejercicio-20-Tus-Libros'!
MerchantProcessor subclass: #NullMerchantProcessor
	instanceVariableNames: 'failure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!NullMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'IO 11/22/2020 17:36:29'!
debitWith: aCreditCard for: anAmount

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


!ShoppingCart methodsFor: 'accessing' stamp: 'IO 11/22/2020 16:51:08'!
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
	instanceVariableNames: 'priceCatalogue merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCashier methodsFor: 'checkOut' stamp: 'IO 11/22/2020 17:37:31'!
checkOut: aShoppingCart withCreditCard: aCreditCard

	| total |
	aShoppingCart listCart size = 0 ifTrue: [^self error: ShoppingCashier invalidCartErrorMessage].
	aCreditCard isExpired ifTrue: [^self error: ShoppingCashier invalidCreditCard].
	
	total := aShoppingCart listCart inject: 0 into: [:theSum :anISBN | theSum + priceCatalogue at: anISBN].
	merchantProcessor debitWith: aCreditCard for: total.
	^total.! !


!ShoppingCashier methodsFor: 'initialization' stamp: 'IO 11/22/2020 17:41:36'!
initializeWithPriceCatalogue: aPriceCatalogue 

	self initializeWithPriceCatalogue: aPriceCatalogue andMerchantProcessor: NullMerchantProcessor new.
! !

!ShoppingCashier methodsFor: 'initialization' stamp: 'IO 11/22/2020 17:30:08'!
initializeWithPriceCatalogue: aPriceCatalogue andMerchantProcessor: aMerchantProcessor 

	priceCatalogue := aPriceCatalogue.
	merchantProcessor := aMerchantProcessor.! !

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


!ShoppingCashier class methodsFor: 'instance creation' stamp: 'IO 11/22/2020 17:23:56'!
withPriceCatalogue: aPriceCatalogue 

	^self new initializeWithPriceCatalogue: aPriceCatalogue ! !

!ShoppingCashier class methodsFor: 'instance creation' stamp: 'IO 11/22/2020 17:26:48'!
withPriceCatalogue: aDictionary andMerchantProcessor: aClass 

	^self new initializeWithPriceCatalogue: aDictionary andMerchantProcessor: aClass ! !
