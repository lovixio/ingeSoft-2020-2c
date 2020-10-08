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

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LH 10/6/2020 20:56:51'!
test01anEmptyFinderReturnsNothing
	|aFinder aPrefix aStack|
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	aFinder := SentenceFinderByPrefix newIn: aStack.	
		
	self assert: OrderedCollection new equals: (aFinder find: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LH 10/6/2020 20:57:46'!
test02aFinderReturnsNothingWhenUsingWrongPrefix
	|aFinder aPrefix aSentence aStack|
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	aSentence := 'winter is Coming'.
	aStack push: aSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.	
	self assert: OrderedCollection new equals: (aFinder find: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LH 10/6/2020 20:59:04'!
test03aFinderReturnsOCollectionWithSentenceWhenUsingRightPrefix
	|aFinder aPrefix aSentence aStack|
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	aSentence := 'Winter is Coming'.
	aStack push: aSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.	
		
	self assert: (OrderedCollection with:aSentence) equals: (aFinder find: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IO 10/8/2020 16:33:30'!
test04AFinderReturnNothingWithMultipleSentencesThatDontMatch
	|aFinder aPrefix firstSentence secondSentece thirdSentence aStack|
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	firstSentence := 'winter is Coming'.
	aStack push: firstSentence.
	secondSentece := 'winter is Here'.
	aStack push: secondSentece.
	thirdSentence := 'winning for You'.
	aStack push: thirdSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.		
	
	self assert: OrderedCollection new equals: (aFinder find: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IO 10/8/2020 16:33:20'!
test05AFinderReturnAccurateWithMultipleSentencesThatMatch
	|aFinder aPrefix firstSentence secondSentece thirdSentence aStack correctCollection|
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	firstSentence := 'Winter is Coming'.
	aStack push: firstSentence.
	secondSentece := 'Winter is Here'.
	aStack push: secondSentece.
	thirdSentence := 'Winning for You'.
	aStack push: thirdSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.	
		
	correctCollection := OrderedCollection with: firstSentence with: secondSentece.
	
	self assert: correctCollection equals: (aFinder find: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LH 10/6/2020 20:08:19'!
test06PrefixCannotBeEmpty
	|aFinder aPrefix firstSentence aStack|
	
	aStack := OOStack new.
	aPrefix := ''.
	firstSentence := 'Winter is Coming'.
	aStack push: firstSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.	
		
	self
		should: [ aFinder find: aPrefix]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixIsEmptyErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LH 10/6/2020 20:08:25'!
test07PrefixCannotHaveEmptySpaces
	|aFinder aPrefix firstSentence aStack|
	
	aStack := OOStack new.
	aPrefix := 'Winter is'.
	firstSentence := 'Winter is Coming'.
	aStack push: firstSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.		
	
	self
		should: [ aFinder find: aPrefix]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixHasEmptySpaceErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'LH 10/7/2020 15:57:25'!
test08AFinderReturnAccurateWithMultipleSentencesWithMixedOrder
	|aFinder aPrefix firstSentence secondSentence thirdSentence fourthSentence aStack correctCollection|
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	firstSentence := 'Winter is Coming'.
	aStack push: firstSentence.
	secondSentence := 'Winning for You'.
	aStack push: secondSentence.
	thirdSentence := 'Winter is Here'.
	aStack push: thirdSentence.
	fourthSentence := 'Wind is Blowing'.
	aStack push: fourthSentence.
	aFinder := SentenceFinderByPrefix newIn: aStack.	
		
	correctCollection := OrderedCollection with: firstSentence with: thirdSentence.
	
	self assert: correctCollection equals: (aFinder find: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'IO 10/8/2020 16:36:06'!
test09AFinderWontChangeTheStack
	|aFinder aPrefix firstSentence secondSentence thirdSentence fourthSentence aStack theSentenceCollection|
	
	
	aStack := OOStack new.
	aPrefix := 'Wint'.
	
	firstSentence := 'Winter is Coming'.
	aStack push: firstSentence.
	secondSentence := 'Winning for You'.
	aStack push: secondSentence.
	thirdSentence := 'Winter is Here'.
	aStack push: thirdSentence.
	fourthSentence := 'Wind is Blowing'.
	aStack push: fourthSentence.
	
	aFinder := SentenceFinderByPrefix newIn: aStack.	
	aFinder find: aPrefix.

	"testeamos que sigan en el stack, y en el mismo orden. para eso armamos una coleccion de las oraciones epseradas"
	theSentenceCollection := OrderedCollection with: fourthSentence with: thirdSentence with: secondSentence with: firstSentence .

	self assert: aStack size equals: theSentenceCollection size.
	1 to: aStack size do:[:index| self assert: aStack pop equals: (theSentenceCollection at: index)].
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lastElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'storage operations' stamp: 'IO 10/6/2020 19:26:50'!
pop

	| last |

	last := lastElement value.
	lastElement := lastElement previous.
	^last.
! !

!OOStack methodsFor: 'storage operations' stamp: 'IO 10/6/2020 19:27:23'!
push: aValue

	lastElement := OOStackElementBody with: aValue andPredecessor: lastElement.

! !


!OOStack methodsFor: 'testing' stamp: 'IO 10/6/2020 19:26:19'!
isEmpty

	^lastElement predecessorsCount isZero.

! !


!OOStack methodsFor: 'initialization' stamp: 'LH 10/6/2020 20:06:21'!
initializeEmpty

	lastElement := OOStackElementBase new.

! !


!OOStack methodsFor: 'accessing' stamp: 'IO 10/6/2020 19:30:51'!
size

	^lastElement predecessorsCount.
! !

!OOStack methodsFor: 'accessing' stamp: 'IO 10/6/2020 19:27:35'!
top

	^lastElement value.
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

!OOStackElement methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:20:53'!
predecessorsCount
	self subclassResponsibility.
! !

!OOStackElement methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:20:38'!
previous
	self subclassResponsibility.
! !

!OOStackElement methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:20:33'!
value
	self subclassResponsibility.
! !


!classDefinition: #OOStackElementBase category: #'Stack-Exercise'!
OOStackElement subclass: #OOStackElementBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementBase methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:22:09'!
predecessorsCount
	^0.
! !

!OOStackElementBase methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:22:33'!
previous
	^self error: OOStack stackEmptyErrorDescription.
! !

!OOStackElementBase methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:22:28'!
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

!OOStackElementBody methodsFor: 'initialization' stamp: 'IO 10/6/2020 19:25:40'!
initializeWith: aValue andPredecessor: anElement
	value := aValue.
	previous := anElement.
! !


!OOStackElementBody methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:24:08'!
predecessorsCount
	^self previous predecessorsCount + 1.
! !

!OOStackElementBody methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:24:04'!
previous
	^previous.
! !

!OOStackElementBody methodsFor: 'accesing' stamp: 'IO 10/6/2020 19:23:18'!
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


!classDefinition: #SentecePrefix category: #'Stack-Exercise'!
Object subclass: #SentecePrefix
	instanceVariableNames: 'prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentecePrefix methodsFor: 'initialization' stamp: 'IO 10/8/2020 16:06:12'!
initializeWith: aString

	prefix := aString
! !


!SentecePrefix methodsFor: 'testing' stamp: 'IO 10/8/2020 15:54:44'!
isPrefixOf: aSentence
	^prefix = (aSentence copyFrom:1 to: prefix size).
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentecePrefix class' category: #'Stack-Exercise'!
SentecePrefix class
	instanceVariableNames: ''!

!SentecePrefix class methodsFor: 'as yet unclassified' stamp: 'IO 10/8/2020 16:06:21'!
newWith: aString
	"revisamos si aPrefix es vacio o si tiene espacios vacios. En tales casos, devolvemos un error"

	(aString = '') ifTrue: [^self error: SentenceFinderByPrefix prefixIsEmptyErrorDescription].
	((aString select: [:anASCIIVAlue | anASCIIVAlue = $ ]) = '') ifFalse: [^self error: SentenceFinderByPrefix prefixHasEmptySpaceErrorDescription].
	"validacion"

	^self basicNew initializeWith: aString.
! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'LH 10/6/2020 20:14:31'!
initializeNewIn: aStackToFindIn 

	stack := aStackToFindIn.! !


!SentenceFinderByPrefix methodsFor: 'prefix testing' stamp: 'IO 10/8/2020 15:51:12'!
validatePrefix: aPrefix
	
! !


!SentenceFinderByPrefix methodsFor: 'finding tools' stamp: 'IO 10/8/2020 15:55:34'!
find: aString
	^self findWithPrefix: (SentecePrefix newWith: aString).
! !

!SentenceFinderByPrefix methodsFor: 'finding tools' stamp: 'IO 10/8/2020 16:31:33'!
findWithPrefix: aPrefix
	(stack isEmpty)
		ifTrue: [^OrderedCollection new]
		ifFalse: [
			| anOrderedCollectionOfSentences aSentenceFromStack |
			aSentenceFromStack := stack pop.
			anOrderedCollectionOfSentences := self findWithPrefix: aPrefix. 
			stack push: aSentenceFromStack.

			(aPrefix isPrefixOf: stack top) ifTrue:[anOrderedCollectionOfSentences addLast: stack top].

			^anOrderedCollectionOfSentences].

	"no hicimos polimorfismo sobre isEmtpy porque deberiamos construir una nueva estrucutra de datos que copie todos
	 los elementos del stack en la incializacion. aun asi, en la inicializacion tendriamos un if o try/catch que viene de
	 comparar cuando se llega al ultimo elemento del stack"
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'LH 10/6/2020 20:12:37'!
newIn: aStackToFindIn

	^self basicNew initializeNewIn: aStackToFindIn ! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'LH 10/6/2020 21:21:02'!
prefixHasEmptySpaceErrorDescription

	^'Prefix cannot have Empty Spaces'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'LH 10/6/2020 21:20:30'!
prefixIsEmptyErrorDescription

	^'Prefix cannot be Empty'! !
