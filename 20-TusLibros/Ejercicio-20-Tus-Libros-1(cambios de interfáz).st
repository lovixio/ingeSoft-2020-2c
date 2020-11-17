!classDefinition: #TusLibrosShopTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #TusLibrosShopTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!TusLibrosShopTest methodsFor: 'tests carrito' stamp: 'LH 11/17/2020 11:57:38'!
test01ANewCartIsEmpty
	|aShop aCatalog|
	aCatalog := Dictionary newFromPairs: #('admin', 'password').
	aShop := TusLibrosShop withCatalog: OrderedCollection new andUsers: aCatalog.
	aShop createCartFor: 'admin' withPassword: 'password'. 
	
	self assert: Bag new equals: (aShop listCart: 1).! !

!TusLibrosShopTest methodsFor: 'tests carrito' stamp: 'LH 11/17/2020 11:57:38'!
test02ABookCanBeAddedToTheCart
	|aShop bookBag aDictionaryOfUsers aCatalog|
	
	aDictionaryOfUsers := Dictionary newFromPairs: #('admin', 'password').
	aCatalog := OrderedCollection with: '0-7645-2641-3'.
	aShop := TusLibrosShop withCatalog: aCatalog andUsers: aDictionaryOfUsers.
	bookBag := Bag new.
	
	aShop createCartFor: 'admin' withPassword: 'password'. 
	aShop addToCart: 1 theBook: '0-7645-2641-3' times: 1.
	bookBag add: '0-7645-2641-3'.
	
	self assert: bookBag equals: (aShop listCart: 1).   ! !

!TusLibrosShopTest methodsFor: 'tests carrito' stamp: 'LH 11/17/2020 11:57:38'!
test03ManyBooksCanBeAddedToTheCart
	|aShop bookBag aDictionaryOfUsers aCatalog|
	
	aDictionaryOfUsers := Dictionary newFromPairs: #('admin', 'password').
	aCatalog := OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4'.
	aShop := TusLibrosShop withCatalog: aCatalog andUsers: aDictionaryOfUsers.
	bookBag := Bag new.
	
	aShop createCartFor: 'admin' withPassword: 'password'. 
	
	aShop addToCart: 1 theBook: '0-7645-2641-3' times: 1.
	bookBag add: '0-7645-2641-3'.
	aShop addToCart: 1 theBook: '0-7645-2641-4' times: 1.
	bookBag add: '0-7645-2641-4'.
	
	self assert: bookBag equals: (aShop listCart: 1).   
	! !

!TusLibrosShopTest methodsFor: 'tests carrito' stamp: 'LH 11/17/2020 11:57:38'!
test04CanAddMoreThanOneFromTheSameBook
	|aShop bookBag aDictionaryOfUsers aCatalog|
	
	aDictionaryOfUsers := Dictionary newFromPairs: #('admin', 'password').
	aCatalog := OrderedCollection with: '0-7645-2641-3'.
	aShop := TusLibrosShop withCatalog: aCatalog andUsers: aDictionaryOfUsers.
	bookBag := Bag new.
	
	aShop createCartFor: 'admin' withPassword: 'password'. 
	
	aShop addToCart: 1 theBook: '0-7645-2641-3' times: 2.
	bookBag add: '0-7645-2641-3' withOccurrences: 2.
	
	self assert: bookBag equals: (aShop listCart: 1).   ! !


!classDefinition: #TusLibrosShop category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #TusLibrosShop
	instanceVariableNames: 'books catalog usersAndPasswords carts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!TusLibrosShop methodsFor: 'initialization' stamp: 'LH 11/17/2020 11:40:30'!
initializeWithCatalog: aCatalog andUsers: aDictionaryOfUsersAndPasswords

	catalog := aCatalog.
	usersAndPasswords := aDictionaryOfUsersAndPasswords.
	carts := OrderedCollection new.! !


!TusLibrosShop methodsFor: 'Carts' stamp: 'LH 11/17/2020 11:48:02'!
addToCart: aCartID theBook: anISBN times: aQuantity 
	
	(carts at:1) add: anISBN withOccurrences: aQuantity.! !

!TusLibrosShop methodsFor: 'Carts' stamp: 'LH 11/17/2020 11:39:58'!
createCartFor: anUser withPassword: aPassword 
	"creates a new cart for a valid user"
	
	carts add: Bag new.! !

!TusLibrosShop methodsFor: 'Carts' stamp: 'LH 11/17/2020 11:41:35'!
listCart: aCartID 
	"returns the cart's contentes as a Bag"

	^carts at: aCartID! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosShop class' category: 'Ejercicio-20-Tus-Libros'!
TusLibrosShop class
	instanceVariableNames: ''!

!TusLibrosShop class methodsFor: 'instance creation' stamp: 'LH 11/17/2020 11:36:57'!
withCatalog: anOrderedCollection andUsers: aDictionary 

	^self new initializeWithCatalog: anOrderedCollection andUsers: aDictionary. ! !
