!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:48'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lastElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:26:06'!
initializeEmpty

	lastElement := OOStackElementBase new.

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:26:19'!
isEmpty

	^lastElement predecessorsCount isZero.

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:26:50'!
pop

	| last |

	last := lastElement value.
	lastElement := lastElement previous.
	^last.
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:27:23'!
push: aValue

	lastElement := OOStackElementBody with: aValue andPredecessor: lastElement.

! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:27:35'!
top

	^lastElement value.
! !


!OOStack methodsFor: 'accessing' stamp: 'IO 10/6/2020 19:30:51'!
size

	^lastElement predecessorsCount.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 10/1/2020 18:08:13'!
stackEmptyErrorDescription
	
	^ 'Stack is empty!!'! !


!OOStack class methodsFor: 'as yet unclassified' stamp: 'IO 10/5/2020 18:29:20'!
new

	^self basicNew initializeEmpty.! !


!classDefinition: #OOStackElement category: #'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:20:53'!
predecessorsCount
	self subclassResponsibility.
! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:20:38'!
previous
	self subclassResponsibility.
! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:20:33'!
value
	self subclassResponsibility.
! !


!classDefinition: #OOStackElementBase category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackElementBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementBase methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:22:09'!
predecessorsCount
	^0.
! !

!OOStackElementBase methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:22:33'!
previous
	^self error: OOStack stackEmptyErrorDescription.
! !

!OOStackElementBase methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:22:28'!
value
	^self error: OOStack stackEmptyErrorDescription.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementBase class' category: #'Stack-Exercise'!
OOStackElementBase class
	instanceVariableNames: ''!

!OOStackElementBase class methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:24:44'!
new
	^self basicNew.
! !


!classDefinition: #OOStackElementBody category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackElementBody
	instanceVariableNames: 'value previous'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementBody methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:25:40'!
initializeWith: aValue andPredecessor: anElement
	value := aValue.
	previous := anElement.
! !

!OOStackElementBody methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:24:08'!
predecessorsCount
	^self previous predecessorsCount + 1.
! !

!OOStackElementBody methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:24:04'!
previous
	^previous.
! !

!OOStackElementBody methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:23:18'!
value
	^value.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementBody class' category: #'Stack-Exercise'!
OOStackElementBody class
	instanceVariableNames: ''!

!OOStackElementBody class methodsFor: 'as yet unclassified' stamp: 'IO 10/6/2020 19:25:18'!
with: aValue andPredecessor: anElement
	^self basicNew initializeWith: aValue andPredecessor: anElement! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
