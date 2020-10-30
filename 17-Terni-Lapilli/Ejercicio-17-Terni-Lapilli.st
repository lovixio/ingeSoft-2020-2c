!classDefinition: #TLGameTest category: 'Ejercicio-Terni-Lapilli'!
TestCase subclass: #TLGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Terni-Lapilli'!

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 18:32:41'!
test01aNewGameIsNotOverNorTiedItisInPlay 
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	
	self deny: aGame isOver.
	self deny: aGame isTied.
	self assert: aGame isInPlay.! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 18:33:22'!
test02XStartsPlayingInaNewGame 
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	
	self assert: aGame isPlayingX.! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 19:44:26'!
test03OPlaysAfterX 
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	aGame putTokenAt: 1@1.
	
	self assert: aGame isPlayingO.
	self deny: aGame isPlayingX.! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 19:45:03'!
test04XPlaysAfterO
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	aGame putTokenAt: 1@1.
	aGame putTokenAt: 0@1.
	
	self assert: aGame isPlayingX.
	self deny: aGame isPlayingO.! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 19:45:24'!
test05
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	
	self deny: (aGame hasTokenAt: 1@1).
	
	aGame putTokenAt: 1@1.
	
	self assert: (aGame hasTokenAt: 1@1).
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 19:45:40'!
test06
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	
	aGame putTokenAt: 1@1.
	aGame putTokenAt: 1@2.
	
	self assert: (aGame hasTokenAt: 1@2).
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 19:47:40'!
test07
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	
	aGame putTokenAt: 1@1.
	
	self should:[aGame putTokenAt: 1@1.]
		raise: Error
		withMessageText: aGame class cantPlaceTokenInOccupiedSpace.
			
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 19:46:15'!
test08
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	
	aGame putTokenAt: 1@1.
	aGame putTokenAt: 1@2.
	
	self should:[aGame putTokenAt: 1@1.]
		raise: Error
		withMessageText: aGame class cantPlaceTokenInOccupiedSpace.
			
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 20:42:57'!
test09
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	(1@1) eightNeighbors from: 1 to: 6 do:[:aTokenLocation | aGame putTokenAt: aTokenLocation].
	
	self should:[aGame putTokenAt: 1@1.]
		raise: Error
		withMessageText: aGame class cantPlaceMoreThanSixTokens.
			
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 20:54:01'!
test10
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	aGame putTokenAt:0@0.
	aGame putTokenAt:1@0.
	aGame putTokenAt:0@1.
	aGame putTokenAt:1@1.
	aGame putTokenAt:0@2.
	
	self assert: aGame playerXHasWon.
	self deny: aGame playerOHasWon.
	self assert: aGame isOver.
	
			
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 21:13:44'!
test11
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	aGame putTokenAt:0@0.
	aGame putTokenAt:0@1.
	aGame putTokenAt:1@0.
	aGame putTokenAt:1@1.
	aGame putTokenAt:2@0.
	
	self assert: aGame playerXHasWon.
	self deny: aGame playerOHasWon.
	self assert: aGame isOver.
	
			
	! !

!TLGameTest methodsFor: 'testing' stamp: 'LH 10/29/2020 21:20:41'!
test12
	|aGame|
	
	"iniciar"
	aGame := TLGame new.
	"hacer algo"
	aGame putTokenAt:0@0.
	aGame putTokenAt:0@1.
	aGame putTokenAt:1@1.
	aGame putTokenAt:1@2.
	aGame putTokenAt:2@2.
	
	self assert: aGame playerXHasWon.
	self deny: aGame playerOHasWon.
	self assert: aGame isOver.
	
			
	! !


!classDefinition: #TLGame category: 'Ejercicio-Terni-Lapilli'!
Object subclass: #TLGame
	instanceVariableNames: 'turn tokensX tokensO'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Terni-Lapilli'!

!TLGame methodsFor: 'initialization' stamp: 'LH 10/29/2020 19:42:43'!
initializeNewGame 
	
	tokensX := OrderedCollection new.
	tokensO := OrderedCollection new.
	turn := TurnX new.! !


!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 18:57:40'!
hasTokenAt: aTokenLocation 

	^(tokensX includes: aTokenLocation) or:[tokensO includes: aTokenLocation].! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 18:19:57'!
isInPlay
	^true.! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 21:29:40'!
isOver
	|theGameIsOver|
	
	tokensX size >= 3
		 ifTrue:[
			theGameIsOver := ((tokensX at:1 )x = (tokensX at:2 )x and:[(tokensX at:1 )x = (tokensX at:3 )x]).
			theGameIsOver ifFalse:[theGameIsOver := ((tokensX at:1 )y = (tokensX at:2 )y and:[(tokensX at:1 )y = (tokensX at:3 )y])].
			theGameIsOver ifFalse:[theGameIsOver := tokensX allSatisfy:[:aTokLocation | aTokLocation x = aTokLocation y].]]
			
		ifFalse:[theGameIsOver := false].
	
	^theGameIsOver. 
	
	
	"
	theGameIsOver := (tokensX size + tokensO size) > 4.
	theGameIsOver ifFalse:[
			tokensX	 size = 3 ifTrue:[ 
						theGameIsOver := ((tokensX at:1 )x = (tokensX at:2 )x and:[(tokensX at:1 )x = (tokensX at:3 )x]).
						theGameIsOver := theGameIsOver or:[((tokensX at:1 )y = (tokensX at:2 )y and:[(tokensX at:1 )y = (tokensX at:3 )y])].
						theGameIsOver := theGameIsOver or:[|diagonalMatch|
															tokensX do:[:aTokenLoc| diagonalMatch := ]].
					]
		].
	
	
	^self playerXHasWon.
	"! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 20:26:16'!
isPlayingO
	^turn isPlayingO.! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 20:26:24'!
isPlayingX
	^turn isPlayingX.! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 18:19:36'!
isTied
	^false.! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 20:55:17'!
playerOHasWon
	^false.! !

!TLGame methodsFor: 'testing' stamp: 'LH 10/29/2020 20:54:49'!
playerXHasWon
	^true.! !


!TLGame methodsFor: 'plays' stamp: 'LH 10/29/2020 19:42:57'!
putOAt: aTokenLocation 
	
	tokensO add: aTokenLocation. 
	turn := TurnX new.! !

!TLGame methodsFor: 'plays' stamp: 'LH 10/29/2020 20:45:50'!
putTokenAt: aTokenLocation 

	(tokensX size + tokensO size) = 6 ifTrue: [self error: TLGame cantPlaceMoreThanSixTokens ].
	(self hasTokenAt: aTokenLocation) ifTrue:[^ self error: TLGame cantPlaceTokenInOccupiedSpace ].
	
	turn putTokenAt: aTokenLocation in: self.! !

!TLGame methodsFor: 'plays' stamp: 'LH 10/29/2020 19:43:17'!
putXAt: aTokenLocation 
	
	tokensX add: aTokenLocation. 
	turn := TurnO new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TLGame class' category: 'Ejercicio-Terni-Lapilli'!
TLGame class
	instanceVariableNames: ''!

!TLGame class methodsFor: 'instance creation' stamp: 'LH 10/29/2020 18:31:44'!
new

	^self basicNew initializeNewGame ! !


!TLGame class methodsFor: 'error description' stamp: 'LH 10/29/2020 20:44:24'!
cantPlaceMoreThanSixTokens
	^'Alredy Placed All The Tokens on The Board'! !

!TLGame class methodsFor: 'error description' stamp: 'LH 10/29/2020 19:04:55'!
cantPlaceTokenInOccupiedSpace
	^'That Space Alredy Has a Token in It'! !


!classDefinition: #TLGameTurnSate category: 'Ejercicio-Terni-Lapilli'!
Object subclass: #TLGameTurnSate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Terni-Lapilli'!

!TLGameTurnSate methodsFor: 'testing' stamp: 'LH 10/29/2020 20:29:25'!
isPlayingO
	"checks if the current turn is for the player O"
	self subclassResponsibility ! !

!TLGameTurnSate methodsFor: 'testing' stamp: 'LH 10/29/2020 20:29:32'!
isPlayingX
	"checks if the current turn is for the player X"
	self subclassResponsibility ! !


!TLGameTurnSate methodsFor: 'plays' stamp: 'LH 10/29/2020 19:32:24'!
putTokenAt: aTokenLocation in: aGame

	"adds a Token to the Game"

	self subclassResponsibility. ! !


!classDefinition: #TurnO category: 'Ejercicio-Terni-Lapilli'!
TLGameTurnSate subclass: #TurnO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Terni-Lapilli'!

!TurnO methodsFor: 'testing' stamp: 'LH 10/29/2020 20:27:36'!
isPlayingO

	^true.! !

!TurnO methodsFor: 'testing' stamp: 'LH 10/29/2020 20:27:43'!
isPlayingX

	^false.! !


!TurnO methodsFor: 'plays' stamp: 'LH 10/29/2020 20:25:01'!
putTokenAt: aTokenLocation in: aGame

	aGame putOAt: aTokenLocation.! !


!classDefinition: #TurnX category: 'Ejercicio-Terni-Lapilli'!
TLGameTurnSate subclass: #TurnX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio-Terni-Lapilli'!

!TurnX methodsFor: 'testing' stamp: 'LH 10/29/2020 20:28:06'!
isPlayingO

	^false.! !

!TurnX methodsFor: 'testing' stamp: 'LH 10/29/2020 20:28:12'!
isPlayingX

	^true.! !


!TurnX methodsFor: 'plays' stamp: 'LH 10/29/2020 20:24:51'!
putTokenAt: aTokenLocation in: aGame

	aGame putXAt: aTokenLocation.

	! !
