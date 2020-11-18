!classDefinition: #TusLibrosShopTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #TusLibrosShopTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 16:48:22'!
newTusLibros

	| tusLibros users catalogue |
	
	catalogue := OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4'.
	users := Dictionary newFromPairs: #('admin', 'password', 'admin2', 'password').
	tusLibros := TusLibrosShop fromCatalogue: catalogue users: users.

	^tusLibros.
! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 16:33:06'!
test01NewCartIsEmpty

	| tusLibros cartId |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	
	self assert: 0 equals: (tusLibros listCart: cartId) size.
! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 16:40:33'!
test02CanAddABookToCart

	| tusLibros cartId cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 1.
	
	cart := Bag new.
	cart add: '0-7645-2641-3'.

	self assert: cart equals: (tusLibros listCart: cartId).

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 16:41:44'!
test03CanAddDifferentBooksToCart

	| tusLibros cartId cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 1.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-4' bookQuantity: 1.

	cart := Bag new.
	cart add: '0-7645-2641-3'.
	cart add: '0-7645-2641-4'.

	self assert: cart equals: (tusLibros listCart: cartId).

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 16:46:33'!
test04CanAddMoreThanOneBookToCart

	| tusLibros cartId cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 3.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-4' bookQuantity: 2.

	cart := Bag new.
	cart add: '0-7645-2641-3' withOccurrences: 3.
	cart add: '0-7645-2641-4' withOccurrences: 2.

	self assert: cart equals: (tusLibros listCart: cartId).

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 16:52:40'!
test05CanAddMoreThanOneCart

	| tusLibros cartId cartId2 cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	cartId2 := tusLibros newCartForUser: 'admin2' Password: 'password'.

	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 3.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-4' bookQuantity: 2.
	
	tusLibros addToCart: cartId2 booksIsbn: '0-7645-2641-3' bookQuantity: 5.
	tusLibros addToCart: cartId2 booksIsbn: '0-7645-2641-4' bookQuantity: 3.

	cart := Bag new.
	cart add: '0-7645-2641-3' withOccurrences: 5.
	cart add: '0-7645-2641-4' withOccurrences: 3.

	self assert: cart equals: (tusLibros listCart: cartId2).

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 17:02:24'!
test06AClientInitialyHasNowPurchases

	| tusLibros purchases |

	tusLibros := self newTusLibros.

	purchases := tusLibros listPurchasesFor: 'admin' password: 'password'.

	self assert: (Bag new) equals: purchases.
	self assert: 0 equals: purchases size.

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 17:10:45'!
test07AClientCanCheckoutACart

	| tusLibros cartId purchases expectedPurchases |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 2.

	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.

	purchases := tusLibros listPurchasesFor: 'admin' password: 'password'.

	expectedPurchases := Bag new.
	expectedPurchases add: '0-7645-2641-3' withOccurrences: 2.

	self assert: expectedPurchases equals: purchases.
	self assert: 2 equals: purchases size.

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 17:12:59'!
test08AClientCanCheckoutManyTimes

	| tusLibros cartId purchases expectedPurchases |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 2.
	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.
	
	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 5.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-4' bookQuantity: 3.

	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.

	purchases := tusLibros listPurchasesFor: 'admin' password: 'password'.

	expectedPurchases := Bag new.
	expectedPurchases add: '0-7645-2641-3' withOccurrences: 7.
	expectedPurchases add: '0-7645-2641-4' withOccurrences: 3.

	self assert: expectedPurchases equals: purchases.
	self assert: 10 equals: purchases size.

! !

!TusLibrosShopTest methodsFor: 'as yet unclassified' stamp: 'IO 11/18/2020 17:31:39'!
test09ManyClientsCanCheckout

	| tusLibros cartId purchases expectedPurchases |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForUser: 'admin' Password: 'password'.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 2.
	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.
	
	cartId := tusLibros newCartForUser: 'admin2' Password: 'password'.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-3' bookQuantity: 5.
	tusLibros addToCart: cartId booksIsbn: '0-7645-2641-4' bookQuantity: 3.

	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.

	purchases := tusLibros listPurchasesFor: 'admin2' password: 'password'.

	expectedPurchases := Bag new.
	expectedPurchases add: '0-7645-2641-3' withOccurrences: 5.
	expectedPurchases add: '0-7645-2641-4' withOccurrences: 3.

	self assert: expectedPurchases equals: purchases.
	self assert: 8 equals: purchases size.

! !


!classDefinition: #TusLibrosShop category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #TusLibrosShop
	instanceVariableNames: 'carts cartClients checkouts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!TusLibrosShop methodsFor: 'initialization' stamp: 'IO 11/18/2020 17:19:16'!
initializeFromCatalogue: aCatalogue users: users 

	carts := OrderedCollection new.
	cartClients := OrderedCollection new.
	checkouts := Dictionary new.
! !


!TusLibrosShop methodsFor: 'cart' stamp: 'IO 11/18/2020 16:50:18'!
addToCart: cartId booksIsbn: isbn bookQuantity: quantity
	| cart |
	cart := carts at: cartId.
	cart add: isbn withOccurrences: quantity.! !

!TusLibrosShop methodsFor: 'cart' stamp: 'IO 11/18/2020 16:51:32'!
listCart: cartId 
	^(carts at: cartId) copy.! !

!TusLibrosShop methodsFor: 'cart' stamp: 'IO 11/18/2020 17:18:25'!
newCartForUser: user Password: password 
	carts add: Bag new.
	cartClients add: user.
	^carts size.
! !


!TusLibrosShop methodsFor: 'purchases' stamp: 'IO 11/18/2020 17:30:48'!
checkoutCart: cartId ccn: ccn cced: cced cco: cco 
	| cart clientId checkout |
	cart := carts at: cartId.
	clientId := cartClients at: cartId.
	checkout := checkouts at: clientId ifAbsent: [Bag new].
	checkout addAll: cart.
	checkouts at: clientId put: checkout.

	
! !

!TusLibrosShop methodsFor: 'purchases' stamp: 'IO 11/18/2020 17:27:48'!
listPurchasesFor: user password: password
	
	^checkouts at: user ifAbsent: [^Bag new] copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosShop class' category: 'Ejercicio-20-Tus-Libros'!
TusLibrosShop class
	instanceVariableNames: ''!

!TusLibrosShop class methodsFor: 'instance creation' stamp: 'IO 11/18/2020 16:27:21'!
fromCatalogue: anOrderedCollection users: aDictionary 
	"DO NOT FORGET TO RENAME COLLABORATORS AND REMOVE THIS COMMENT!!!!"

	^self new initializeFromCatalogue: anOrderedCollection users: aDictionary ! !
