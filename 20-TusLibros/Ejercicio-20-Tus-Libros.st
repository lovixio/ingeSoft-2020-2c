!classDefinition: #TusLibrosTest category: 'Ejercicio-20-Tus-Libros'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!TusLibrosTest methodsFor: 'cart' stamp: 'IO 11/18/2020 19:08:46'!
test01NewCartIsEmpty

	| tusLibros cartId |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	
	self assert: 0 equals: (tusLibros listCart: cartId) size.
! !

!TusLibrosTest methodsFor: 'cart' stamp: 'IO 11/18/2020 19:08:46'!
test02CanAddABookToCart

	| tusLibros cartId cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 1.
	
	cart := Bag new.
	cart add: '0-7645-2641-3'.

	self assert: cart equals: (tusLibros listCart: cartId).

! !

!TusLibrosTest methodsFor: 'cart' stamp: 'IO 11/18/2020 19:08:46'!
test03CanAddDifferentBooksToCart

	| tusLibros cartId cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 1.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-4' bookQuantity: 1.

	cart := Bag new.
	cart add: '0-7645-2641-3'.
	cart add: '0-7645-2641-4'.

	self assert: cart equals: (tusLibros listCart: cartId).

! !

!TusLibrosTest methodsFor: 'cart' stamp: 'IO 11/18/2020 19:08:46'!
test04CanAddMoreThanOneBookToCart

	| tusLibros cartId cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 3.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-4' bookQuantity: 2.

	cart := Bag new.
	cart add: '0-7645-2641-3' withOccurrences: 3.
	cart add: '0-7645-2641-4' withOccurrences: 2.

	self assert: cart equals: (tusLibros listCart: cartId).

! !

!TusLibrosTest methodsFor: 'cart' stamp: 'IO 11/18/2020 19:08:46'!
test05CanAddMoreThanOneCart

	| tusLibros cartId cartId2 cart |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	cartId2 := tusLibros newCartForClientId: 'admin2' password: 'password'.

	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 3.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-4' bookQuantity: 2.
	
	tusLibros addToCart: cartId2 bookIsbn: '0-7645-2641-3' bookQuantity: 5.
	tusLibros addToCart: cartId2 bookIsbn: '0-7645-2641-4' bookQuantity: 3.

	cart := Bag new.
	cart add: '0-7645-2641-3' withOccurrences: 5.
	cart add: '0-7645-2641-4' withOccurrences: 3.

	self assert: cart equals: (tusLibros listCart: cartId2).

! !


!TusLibrosTest methodsFor: 'purchases' stamp: 'IO 11/18/2020 17:02:24'!
test06AClientInitialyHasNowPurchases

	| tusLibros purchases |

	tusLibros := self newTusLibros.

	purchases := tusLibros listPurchasesFor: 'admin' password: 'password'.

	self assert: (Bag new) equals: purchases.
	self assert: 0 equals: purchases size.

! !

!TusLibrosTest methodsFor: 'purchases' stamp: 'IO 11/18/2020 19:08:46'!
test07AClientCanCheckoutACart

	| tusLibros cartId purchases expectedPurchases |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 2.

	tusLibros checkoutCart: cartId ccn: 5500000000000004 cced: '20/2025' cco: 'Juan'.

	purchases := tusLibros listPurchasesFor: 'admin' password: 'password'.

	expectedPurchases := Bag new.
	expectedPurchases add: '0-7645-2641-3' withOccurrences: 2.

	self assert: expectedPurchases equals: purchases.
	self assert: 2 equals: purchases size.

! !

!TusLibrosTest methodsFor: 'purchases' stamp: 'IO 11/18/2020 19:08:46'!
test08AClientCanCheckoutManyTimes

	| tusLibros cartId purchases expectedPurchases |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 2.
	tusLibros checkoutCart: cartId ccn: 5500000000000004 cced: '20/2025' cco: 'Juan'.
	
	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 5.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-4' bookQuantity: 3.

	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.

	purchases := tusLibros listPurchasesFor: 'admin' password: 'password'.

	expectedPurchases := Bag new.
	expectedPurchases add: '0-7645-2641-3' withOccurrences: 7.
	expectedPurchases add: '0-7645-2641-4' withOccurrences: 3.

	self assert: expectedPurchases equals: purchases.
	self assert: 10 equals: purchases size.

! !

!TusLibrosTest methodsFor: 'purchases' stamp: 'IO 11/18/2020 19:08:46'!
test09ManyClientsCanCheckout

	| tusLibros cartId purchases expectedPurchases |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 2.
	tusLibros checkoutCart: cartId ccn: 5500000000000004 cced: '20/2025' cco: 'Juan'.
	
	cartId := tusLibros newCartForClientId: 'admin2' password: 'password'.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 5.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-4' bookQuantity: 3.

	tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan'.

	purchases := tusLibros listPurchasesFor: 'admin2' password: 'password'.

	expectedPurchases := Bag new.
	expectedPurchases add: '0-7645-2641-3' withOccurrences: 5.
	expectedPurchases add: '0-7645-2641-4' withOccurrences: 3.

	self assert: expectedPurchases equals: purchases.
	self assert: 8 equals: purchases size.

! !


!TusLibrosTest methodsFor: 'valid instances' stamp: 'IO 11/18/2020 18:20:03'!
newTusLibros

	| tusLibros users catalogue |
	
	catalogue := OrderedCollection with: '0-7645-2641-3' with: '0-7645-2641-4'.
	users := Dictionary newFromPairs: #('admin' 'password' 'admin2' 'password').
	tusLibros := TusLibros withCatalogue: catalogue withClients: users.

	^tusLibros.
! !


!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:46'!
test10CreateCartClientIdExists

	| tusLibros |

	tusLibros := self newTusLibros.
	
	self should: [tusLibros newCartForClientId: 'admin3' password: 'password'.]
		raise: Error
		withMessageText: TusLibros inexistentClientErrorMessage.
! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:46'!
test11CreateCartClientPasswordMatches

	| tusLibros |

	tusLibros := self newTusLibros.
	
	self should: [tusLibros newCartForClientId: 'admin' password: 'password2'.]
		raise: Error
		withMessageText: TusLibros invalidPasswordErrorMessage.
! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 18:26:04'!
test12AddToCartHasValidCartId

	| tusLibros |

	tusLibros := self newTusLibros.
	
	self should: [tusLibros addToCart: 1 bookIsbn: '0-7645-2641-3' bookQuantity: 1.]
		raise: Error
		withMessageText: TusLibros invalidCartIdErrorMessage.


! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:46'!
test13AddToCartHasValidISBN

	| tusLibros cartId |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	
	self should: [ tusLibros addToCart: cartId bookIsbn: 'bad isbn' bookQuantity: 1.]
		raise: Error
		withMessageText: TusLibros invalidIsbnErrorMessage.

! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:46'!
test14AddToCartHasValidQuantity

	| tusLibros cartId |

	tusLibros := self newTusLibros.

	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	
	self should: [ tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 0.]
		raise: Error
		withMessageText: TusLibros invalidQuantityErrorMessage.

! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 18:33:54'!
test15ListCartHasValidCartId

	| tusLibros |

	tusLibros := self newTusLibros.
	
	self should: [tusLibros listCart: 1]
		raise: Error
		withMessageText: TusLibros invalidCartIdErrorMessage.


! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:46'!
test16CheckoutHasValidCartId

	| tusLibros cartId |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.
	tusLibros addToCart: cartId bookIsbn: '0-7645-2641-3' bookQuantity: 2.

	self should: [tusLibros checkoutCart: 3 ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan']
		raise: Error
		withMessageText: TusLibros invalidCartIdErrorMessage.


! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:46'!
test17CheckoutHasCartWithBooks

	| tusLibros cartId |

	tusLibros := self newTusLibros.
	
	cartId := tusLibros newCartForClientId: 'admin' password: 'password'.

	self should: [tusLibros checkoutCart: cartId ccn: '5500 0000 0000 0004' cced: '20/2025' cco: 'Juan']
		raise: Error
		withMessageText: TusLibros emptyCartErrorMessage.


! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:07:20'!
test18ListPurchasesHasValidUser

	| tusLibros |

	tusLibros := self newTusLibros.

	self should: [tusLibros listPurchasesFor: 'admin3' password: 'password']
		raise: Error
		withMessageText: TusLibros inexistentClientErrorMessage.


! !

!TusLibrosTest methodsFor: 'validations' stamp: 'IO 11/18/2020 19:07:55'!
test19ListPurchasesHasMatchingPassword

	| tusLibros |

	tusLibros := self newTusLibros.

	self should: [tusLibros listPurchasesFor: 'admin' password: 'wrong password']
		raise: Error
		withMessageText: TusLibros invalidPasswordErrorMessage.


! !


!classDefinition: #TusLibros category: 'Ejercicio-20-Tus-Libros'!
Object subclass: #TusLibros
	instanceVariableNames: 'carts cartClients clientsPurchases clients catalogue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-20-Tus-Libros'!

!TusLibros methodsFor: 'initialization' stamp: 'IO 11/18/2020 18:29:32'!
initializeWithCatalogue: aCatalogue withClients: aClientList 

	catalogue := aCatalogue.
	clients := aClientList.

	carts := OrderedCollection new.
	cartClients := OrderedCollection new.
	clientsPurchases := Dictionary new.
! !


!TusLibros methodsFor: 'cart' stamp: 'IO 11/18/2020 18:53:15'!
addToCart: cartId bookIsbn: isbn bookQuantity: quantity

	| cart |

	self validateCartId: cartId.
	(catalogue includes: isbn) ifFalse: [^self error: TusLibros invalidIsbnErrorMessage].
	(quantity < 1) ifTrue: [^self error: TusLibros invalidQuantityErrorMessage].

	cart := carts at: cartId.
	cart add: isbn withOccurrences: quantity.
! !

!TusLibros methodsFor: 'cart' stamp: 'IO 11/18/2020 18:53:22'!
listCart: cartId

	self validateCartId: cartId.

	^carts at: cartId copy.
! !

!TusLibros methodsFor: 'cart' stamp: 'IO 11/18/2020 19:09:01'!
newCartForClientId: clientId password: password
	self validateClientId: clientId withPassword: password.

	carts add: Bag new.
	cartClients add: clientId.
	^carts size.
! !


!TusLibros methodsFor: 'purchases' stamp: 'IO 11/18/2020 19:04:51'!
checkoutCart: cartId ccn: ccn cced: cced cco: cco 
	| cart clientId checkout |

	self validateCartId: cartId.
	cart := carts at: cartId.
	(cart size = 0) ifTrue: [self error: TusLibros emptyCartErrorMessage].

	clientId := cartClients at: cartId.
	checkout := clientsPurchases at: clientId ifAbsent: [Bag new].
	checkout addAll: cart.
	clientsPurchases at: clientId put: checkout.
! !

!TusLibros methodsFor: 'purchases' stamp: 'IO 11/18/2020 19:09:13'!
listPurchasesFor: clientId password: password
	self validateClientId: clientId withPassword: password.

	^clientsPurchases at: clientId ifAbsent: [^Bag new] copy.
! !


!TusLibros methodsFor: 'validations' stamp: 'IO 11/18/2020 18:35:51'!
validateCartId: cartId
	(cartId > carts size) ifTrue: [^self error: TusLibros invalidCartIdErrorMessage].! !

!TusLibros methodsFor: 'validations' stamp: 'IO 11/18/2020 19:08:36'!
validateClientId: clientId withPassword: password
	(
		(clients at: clientId
				ifAbsent: [^self error: TusLibros inexistentClientErrorMessage]) = password
	) ifFalse: [^self error: TusLibros invalidPasswordErrorMessage].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibros class' category: 'Ejercicio-20-Tus-Libros'!
TusLibros class
	instanceVariableNames: ''!

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:48:48'!
emptyCartErrorMessage
	'The cart cannot be empty'.! !

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:12:32'!
inexistentClientErrorMessage
	^'Client id not existent'.
! !

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:26:25'!
invalidCartIdErrorMessage
	'Invalid cart id'.! !

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:55:17'!
invalidCcnErrorMessage
	^'Invalid credit card number'.! !

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:30:44'!
invalidIsbnErrorMessage
	^'Isbn not in catalogue'.
! !

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:16:09'!
invalidPasswordErrorMessage
	^'Invalid password'.
! !

!TusLibros class methodsFor: 'error messages' stamp: 'IO 11/18/2020 18:32:12'!
invalidQuantityErrorMessage
	^'Quantity added must be more than 0'.! !


!TusLibros class methodsFor: 'instance creation' stamp: 'IO 11/18/2020 18:10:56'!
withCatalogue: aCatalogue withClients: aClientList 

	^self new initializeWithCatalogue: aCatalogue withClients: aClientList.
 ! !
