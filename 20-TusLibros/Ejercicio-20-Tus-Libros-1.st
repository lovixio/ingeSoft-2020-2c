!classDefinition: #ShoppingCartTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCartTest methodsFor: 'tests carrito' stamp: 'LH 11/16/2020 19:44:26'!
test01ANewCartIsEmpty
	|aCart|
	
	aCart := ShoppingCart new.
	
	self assert: Bag new equals: aCart listCart.! !

!ShoppingCartTest methodsFor: 'tests carrito' stamp: 'LH 11/16/2020 19:45:37'!
test02ABookCanBeAddedToTheCart
	|aCart bookBag|
	
	aCart := ShoppingCart new.
	bookBag := Bag new.
	aCart addToCart: 1 ofBook: '0-7645-2641-3'.
	bookBag add: '0-7645-2641-3'.
	
	self assert: bookBag equals: aCart listCart.   ! !

!ShoppingCartTest methodsFor: 'tests carrito' stamp: 'LH 11/16/2020 19:46:19'!
test03ManyBooksCanBeAddedToTheCart
	|aCart bookBag|
	
	aCart := ShoppingCart new.
	bookBag := Bag new.
	
	aCart addToCart: 1 ofBook: '0-7645-2641-3'.
	bookBag add: '0-7645-2641-3'.
	
	aCart addToCart: 1 ofBook: '0-7645-2641-4'.
	bookBag add: '0-7645-2641-4'.
	
	self assert: bookBag equals: aCart listCart.   ! !

!ShoppingCartTest methodsFor: 'tests carrito' stamp: 'LH 11/16/2020 19:46:58'!
test04CanAddMoreThanOneFromTheSameBook
	|aCart bookBag|
	
	aCart := ShoppingCart new.
	bookBag := Bag new.
	
	aCart addToCart: 2 ofBook: '0-7645-2641-3'.
	bookBag add: '0-7645-2641-3' withOccurrences:2.
	
	self assert: bookBag equals: aCart listCart.   ! !


!classDefinition: #ShoppingCart category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCart methodsFor: 'accessing' stamp: 'LH 11/16/2020 19:44:07'!
listCart
	
	^books copy.! !


!ShoppingCart methodsFor: 'initialization' stamp: 'LH 11/16/2020 19:43:11'!
initialize

	books := Bag new.! !


!ShoppingCart methodsFor: 'adding' stamp: 'LH 11/16/2020 19:43:50'!
addToCart: aQuantity ofBook: anISBN 

	^ books add: anISBN withOccurrences: aQuantity.! !


!classDefinition: #ShoppingCartBook category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #ShoppingCartBook
	instanceVariableNames: 'isbn quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!ShoppingCartBook methodsFor: 'adding to a list' stamp: 'LH 11/16/2020 19:30:01'!
addToList: aListOfBooks

	aListOfBooks add: isbn.
	aListOfBooks add: quantity.! !


!ShoppingCartBook methodsFor: 'initialization' stamp: 'LH 11/16/2020 19:30:51'!
initializeWith: anISBN and: aQuantity

	isbn := anISBN.
	quantity := aQuantity.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCartBook class' category: 'Ejercicio-20-Tus-Libros'!
ShoppingCartBook class
	instanceVariableNames: ''!

!ShoppingCartBook class methodsFor: 'instance creation' stamp: 'LH 11/16/2020 19:20:38'!
withISBN: anISBN andQuantity: aQuantity

	^self basicNew initializeWith: anISBN and: aQuantity.! !
