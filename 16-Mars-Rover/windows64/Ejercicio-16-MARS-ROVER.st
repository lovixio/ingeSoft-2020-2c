!classDefinition: #MarsRoverTest category: 'Ejercicio-16-MARS-ROVER'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!MarsRoverTest methodsFor: 'test' stamp: 'LH 10/24/2020 21:42:44'!
test01
	|aMarsRover|
	aMarsRover := MarsRover at: 0@0 pointingTo: South new.
	aMarsRover do: 'f'.
	
	self assert: -1@0 equals: aMarsRover position.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'LH 10/24/2020 21:42:51'!
test02
	|aMarsRover|
	aMarsRover := MarsRover at: 0@0 pointingTo: South new.
	aMarsRover do: 'b'.
	
	self assert: 1@0 equals: aMarsRover position.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'LH 10/24/2020 21:42:59'!
test03
	|aMarsRover|
	aMarsRover := MarsRover at: 0@0 pointingTo: North new.
	aMarsRover do: 'f'.
	
	self assert: 1@0 equals: aMarsRover position.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'LH 10/24/2020 21:43:10'!
test04
	|aMarsRover|
	aMarsRover := MarsRover at: 0@0 pointingTo: East new.
	aMarsRover do: 'f'.
	
	self assert: 0@1 equals: aMarsRover position.
	! !

!MarsRoverTest methodsFor: 'test' stamp: 'LH 10/24/2020 21:43:15'!
test05
	|aMarsRover|
	aMarsRover := MarsRover at: 0@0 pointingTo: West new.
	aMarsRover do: 'f'.
	
	self assert: 0@-1 equals: aMarsRover position.
	! !


!classDefinition: #CardinalDirection category: 'Ejercicio-16-MARS-ROVER'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!CardinalDirection methodsFor: 'converters' stamp: 'LH 10/24/2020 21:30:44'!
asPoint
	
	self subclassResponsibility ! !


!classDefinition: #East category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!East methodsFor: 'converters' stamp: 'LH 10/24/2020 21:31:15'!
asPoint
	
	^0@1! !


!classDefinition: #North category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!North methodsFor: 'converters' stamp: 'LH 10/24/2020 21:31:53'!
asPoint

	^1@0! !


!classDefinition: #South category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!South methodsFor: 'converters' stamp: 'LH 10/24/2020 21:32:09'!
asPoint

	^-1@0! !


!classDefinition: #West category: 'Ejercicio-16-MARS-ROVER'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!West methodsFor: 'converters' stamp: 'LH 10/24/2020 21:32:33'!
asPoint

	^0@-1! !


!classDefinition: #MarsRover category: 'Ejercicio-16-MARS-ROVER'!
Object subclass: #MarsRover
	instanceVariableNames: 'position orientation point cardinalDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-16-MARS-ROVER'!

!MarsRover methodsFor: 'initialization' stamp: 'LH 10/24/2020 21:42:31'!
initializeAt: aPoint pointingTo: aCardinalDirection 

	position := aPoint.
	orientation := aCardinalDirection asPoint.! !


!MarsRover methodsFor: 'command receiving' stamp: 'LH 10/24/2020 21:16:52'!
do: aStringOfCommands 
	
	aStringOfCommands = 'f' ifTrue: [position := position + orientation].
	aStringOfCommands = 'b' ifTrue: [position := position - orientation].! !


!MarsRover methodsFor: 'accessing' stamp: 'LH 10/24/2020 21:14:41'!
position
	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Ejercicio-16-MARS-ROVER'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'LH 10/24/2020 21:07:31'!
at: aPoint pointingTo: aCardinalDirection

	^self new initializeAt: aPoint pointingTo: aCardinalDirection ! !
