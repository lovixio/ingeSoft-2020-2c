!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:39:58'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |

	customerBook := CustomerBook new.	
	
	self assert: [customerBook addCustomerNamed: 'John Lennon'] takesLessThan: (50*millisecond).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:40:20'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |

	paulMcCartney := 'Paul McCartney'.
	
	customerBook := CustomerBook newWithCustomerNamed: paulMcCartney.

	self assert: [customerBook removeCustomerNamed: paulMcCartney] takesLessThan: 100*millisecond.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:40:39'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |

	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.

	self fail ]

		on: Error 

		do: [ :anError | 
			
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			
			self assert: customerBook isEmpty ].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:41:14'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook johnLennon |


	johnLennon := 'John Lennon'.

	customerBook := CustomerBook newWithCustomerNamed: johnLennon .

	[ customerBook removeCustomerNamed: 'Paul McCartney'.

	self fail ]

		on: NotFound 

		do: [ :anError | 

			self assert: customerBook numberOfCustomers = 1.

			self assert: (customerBook includesCustomerNamed: johnLennon) ]

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:41:31'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney |

	paulMcCartney := 'Paul McCartney'.

	customerBook := CustomerBook newWithSuspendedCostumerNamed: paulMcCartney.

	self assert: customerBook hasNumberOfActiveCustomers: 0 suspendedCustomers: 1 andATotalOf: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:41:58'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney |

	paulMcCartney := 'Paul McCartney'.

	customerBook := CustomerBook newWithSuspendedCostumerNamed: paulMcCartney .

	customerBook removeCustomerNamed: paulMcCartney.

	self assert: customerBook hasNumberOfActiveCustomers: 0 suspendedCustomers: 0 andATotalOf: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:42:10'!
test07CanNotSuspendAnInvalidCustomer

	| customerBook johnLennon |

	johnLennon := 'John Lennon'.

	customerBook := CustomerBook newWithCustomerNamed: johnLennon .
	
	self assert: customerBook cannotSuspendACustomerNamed: 'George Harrison' andStillIncludesACustomerNamed: johnLennon.	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'IO 9/21/2020 20:42:30'!
test08CanNotSuspendAnAlreadySuspendedCustomer

	| customerBook johnLennon |

	johnLennon := 'John Lennon'.

	customerBook := CustomerBook newWithSuspendedCostumerNamed: johnLennon.

	self assert: customerBook cannotSuspendACustomerNamed: johnLennon andStillIncludesACustomerNamed: johnLennon.	
! !


!CustomerBookTest methodsFor: 'testing tools' stamp: 'IO 9/21/2020 20:43:24'!
assert: aCustomerBook cannotSuspendACustomerNamed: aName andStillIncludesACustomerNamed: anotherName 
	| bookSizePreviousToAction |
	
	bookSizePreviousToAction  := aCustomerBook numberOfCustomers.
	[ aCustomerBook suspendCustomerNamed: aName. self fail. ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = bookSizePreviousToAction.
			self assert: (aCustomerBook includesCustomerNamed: anotherName )		].
! !

!CustomerBookTest methodsFor: 'testing tools' stamp: 'IO 9/21/2020 20:43:33'!
assert: aCustomerBook hasNumberOfActiveCustomers: numberOfActiveCustomers suspendedCustomers: numberOfSuspendedCustomers andATotalOf: totalCustomers

	self assert: numberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aCustomerBook numberOfCustomers.
! !

!CustomerBookTest methodsFor: 'testing tools' stamp: 'IO 9/21/2020 20:43:47'!
assert: aBlock takesLessThan: time

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.

	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < time.
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'IO 9/21/2020 20:37:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ].
! !

!CustomerBook methodsFor: 'testing' stamp: 'IO 9/21/2020 20:37:29'!
isEmpty

	^active isEmpty and: [ suspended isEmpty ].
! !


!CustomerBook methodsFor: 'initialization' stamp: 'IO 9/21/2020 20:37:39'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.
! !


!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:37:47'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].

	active add: aName.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:37:21'!
numberOfActiveCustomers

	^active size.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:38:00'!
numberOfCustomers

	^self numberOfActiveCustomers + self numberOfSuspendedCustomers.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:38:08'!
numberOfSuspendedCustomers

	^suspended size.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:38:24'!
removeCustomerNamed: aName 

	"if the customer is removed from active, return their name"
	((self removeCustomerNamed: aName from:	active ) == aName) ifTrue: [^aName].	

	"if the customer is removed from suspended, return their name"
	((self removeCustomerNamed: aName from:	suspended) == aName) ifTrue: [^aName].

	"else send an error signal"
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:38:29'!
removeCustomerNamed: aName from: aCategory

	1 to: aCategory size do: 
	[ :index |
		aName = (aCategory at: index)
			ifTrue: [
				aCategory removeAt: index.
				^ aName. 
			] 
	].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:38:50'!
signalCustomerAlreadyExists

	self error: self class customerAlreadyExistsErrorMessage.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:38:59'!
signalCustomerNameCannotBeEmpty

	self error: self class customerCanNotBeEmptyErrorMessage.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'IO 9/21/2020 20:39:37'!
suspendCustomerNamed: aName

	(active includes: aName) ifFalse: [^CantSuspend signal].

	active remove: aName.
	suspended add: aName.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:01:49'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/17/2020 06:02:05'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!'! !


!CustomerBook class methodsFor: 'instance creation' stamp: 'LH 9/20/2020 17:47:00'!
newWithCustomerNamed: aName
	|newCustomerBook|
	
	newCustomerBook  := self new.
	newCustomerBook addCustomerNamed: aName.
	^newCustomerBook.! !

!CustomerBook class methodsFor: 'instance creation' stamp: 'LH 9/20/2020 17:50:33'!
newWithSuspendedCostumerNamed: aName
	|newCustomerBook|
	
	
	newCustomerBook := self newWithCustomerNamed: aName.
	
	newCustomerBook suspendCustomerNamed: aName.
	
	^newCustomerBook ! !
