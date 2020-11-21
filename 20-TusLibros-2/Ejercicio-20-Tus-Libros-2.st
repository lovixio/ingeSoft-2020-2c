!classDefinition: #CreditCardTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:39:36'!
assertInvalidCardNumberErrorWithNumber: aCCNumber 
	
	self should: [CreditCard         withNumber: aCCNumber
							expirationDate: Date today month 
							belongingTo: 'Juan Pablo'.]
		raise: Error
		withMessageText: CreditCard invalidCreditCardNumber.
	
	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 17:55:28'!
daysInYear
	
	^365 days 

	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 17:53:12'!
daysThisMonth

	^Date today daysInMonth days.
	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:34:04'!
standardCreditCardWithTheExpirationDate: anExpirationDate
	
	 ^CreditCard  withNumber: '0000000000000000' 
				expirationDate: anExpirationDate 
				belongingTo: 'Juan Pablo'.
	


	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:34:39'!
test01ACreditCardCanBeNotExpired
	|aCreditCard|
	
	aCreditCard := self standardCreditCardWithTheExpirationDate: (Date today + self daysThisMonth) month.
	
	self deny: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:34:58'!
test02ACreditCardWithExpirationDatingThisMonthAndYearIsExpired
	|aCreditCard|
	
	aCreditCard := self standardCreditCardWithTheExpirationDate: Date today month.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:35:16'!
test03ACreditCardWithExpirationDatingAPastMonthThisYearIsExpired
	|aCreditCard|
	
	aCreditCard := self standardCreditCardWithTheExpirationDate: (Date today - self daysThisMonth) month.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:35:35'!
test04ACreditCardWithExpirationDatingAFutureYearIsNotExpired
	|aCreditCard|
	
	aCreditCard := self standardCreditCardWithTheExpirationDate: (Date today + self daysInYear) month .
	
	self deny: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:35:55'!
test05ACreditCardWithExpirationDatingAPastYearIsExpired
	|aCreditCard|
	
	aCreditCard := self standardCreditCardWithTheExpirationDate: (Date today - self daysInYear + self daysThisMonth) month.
	
	self assert: aCreditCard isExpired.

	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:40:19'!
test06CreditCarNumberCantHaveAnythingBut16Symbols
	
	self assertInvalidCardNumberErrorWithNumber: '00000000000000000'.
	self assertInvalidCardNumberErrorWithNumber: '000000000000000'.
	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:40:48'!
test07CreditCarNumberCantHaveAnythingButNumbers
	
	self assertInvalidCardNumberErrorWithNumber: '000000000000000O'.
	
	! !

!CreditCardTest methodsFor: 'test' stamp: 'LH 11/21/2020 18:21:18'!
test08TheNameOfACreditCardOwnerCanNotBeBlank
	
	self should: [CreditCard         withNumber: '0000000000000000' 
							expirationDate: (Date today - self daysInYear + self daysThisMonth) month 
							belongingTo: ''.]
		raise: Error
		withMessageText: CreditCard invalidCreditCardOwnerName.
	
	! !


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

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/21/2020 18:45:09'!
test01AnEmptyCartCannotBeCheckedOut
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: OrderedCollection new.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'. 
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary new).
	
	self should: [aCashier checkOut: aCart withCreditCard: aCreditCard]
		raise: Error
		withMessageText: ShoppingCashier invalidCartErrorMessage.! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/21/2020 18:45:51'!
test02ACartWith1BookWillCheckOutCorrectly
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3').
	aCart add: '0-7645-2641-3'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100)) .
	
	self assert: 100 equals: (aCashier checkOut: aCart withCreditCard: aCreditCard).! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/21/2020 18:46:28'!
test03ACartWithManyBooksWillCheckOutCorrectly
	|aCashier aCart aCreditCard|
	
	aCart := ShoppingCart withCatalogue: (OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4').
	aCart add: '0-7645-2641-3' withQuantity: 2.
	aCart add: '0-7645-2641-4'.
	aCreditCard := CreditCard withNumber: '0000000000000000' expirationDate: self validDate belongingTo: 'Juan Pablo'.
	
	aCashier := ShoppingCashier withPriceCatalogue: (Dictionary newFromPairs: #('0-7645-2641-3' 100 '0-7645-2641-4' 100)) .
	
	self assert: 300 equals: (aCashier checkOut: aCart withCreditCard: aCreditCard).! !

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/21/2020 18:47:36'!
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

!ShoppingCashierTest methodsFor: 'as yet unclassified' stamp: 'LH 11/19/2020 21:15:08'!
validDate

	^(Date today + (Date today daysInMonth days)) month
		! !


!classDefinition: #CreditCard category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #CreditCard
	instanceVariableNames: 'creditCardNumber expirationDate nameOfOwner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!CreditCard methodsFor: 'initialization' stamp: 'LH 11/21/2020 17:28:28'!
initializeWithNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName 
	
	creditCardNumber := aCCNumber.
	expirationDate := anExpirationDate.
	nameOfOwner := aName.! !


!CreditCard methodsFor: 'testing' stamp: 'LH 11/21/2020 18:24:29'!
isExpired
	"returns if this credit card is expired"
	|expirationDateYear currentMonth currentYear|
	
	expirationDateYear := expirationDate yearNumber.
	currentMonth := Date today monthIndex.
	currentYear := Date today yearNumber.
	
	
	^	(expirationDate monthIndex <= currentMonth 
			and: expirationDateYear = currentYear)
			
		or: expirationDateYear < currentYear.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'Ejercicio-20-Tus-Libros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'LH 11/21/2020 18:31:06'!
throwCardNumberErrorIfTheNextBlockIsFalse: aBlock
	
	aBlock value ifFalse:[^self error: CreditCard invalidCreditCardNumber].
	! !

!CreditCard class methodsFor: 'instance creation' stamp: 'LH 11/21/2020 18:32:06'!
withNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName 
	
	self throwCardNumberErrorIfTheNextBlockIsFalse: [aCCNumber allSatisfy: [:aDigit | aDigit isDigit]].
	self throwCardNumberErrorIfTheNextBlockIsFalse: [aCCNumber size = 16].
	
	aName isEmpty ifTrue:[^self error: CreditCard invalidCreditCardOwnerName].

	^self new initializeWithNumber: aCCNumber expirationDate: anExpirationDate belongingTo: aName ! !


!CreditCard class methodsFor: 'error description' stamp: 'LH 11/21/2020 18:05:13'!
invalidCreditCardNumber
	^'CreditCard number can only have exactly 16 numbers and nothing else'! !

!CreditCard class methodsFor: 'error description' stamp: 'LH 11/21/2020 18:25:03'!
invalidCreditCardOwnerName
	^'The Name of the Owner can not be blank'! !


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

!ShoppingCashier methodsFor: 'checkOut' stamp: 'LH 11/21/2020 18:42:58'!
checkOut: aShoppingCart withCreditCard: aCreditCard

	aShoppingCart listCart size = 0 ifTrue:[^self error: ShoppingCashier invalidCartErrorMessage].
	
	aCreditCard isExpired ifTrue:[ ^self error: ShoppingCashier invalidCreditCard].
	
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
