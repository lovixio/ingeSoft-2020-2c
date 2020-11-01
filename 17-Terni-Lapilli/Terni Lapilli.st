!classDefinition: #TerniLapilliGameTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 10/31/2020 11:22:21'!
test01
	"x pone en 0@0"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.

	self assert: (aGame includesColorXAt: (0@0)).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 10/31/2020 11:22:21'!
test02
	"x pone en 0@0 pero no en 0@1"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.

	self deny: (aGame includesColorXAt: 0@1).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 10/31/2020 11:22:21'!
test03
	"x pone en 0@1"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.

	self assert: (aGame includesColorXAt: 0@1).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'IO 10/31/2020 11:22:02'!
test04
	"o pone en 0@0"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.
	aGame oPutsOn: 0@0.

	self assert: (aGame includesColorOAt: (0@0)).
! !


!TerniLapilliGameTest methodsFor: 'move tokens phase' stamp: 'IO 10/31/2020 19:12:19'!
test05
	"movimiento legal desp de haber jugado las tres fichas :D"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).

	self assert: (aGame includesColorXAt: (1@0)).
! !

!TerniLapilliGameTest methodsFor: 'move tokens phase' stamp: 'IO 10/31/2020 19:12:37'!
test06
	"movimiento legal de O desp de haber jugado las tres fichas :D"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).
	aGame oMoves: (2@1) to: (1@1).

	self assert: (aGame includesColorOAt: (1@1)).
! !


!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 11:50:31'!
test07
	"primer posicion ganadora para X, la primer columna"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.
	aGame oPutsOn: 1@1.
	aGame xPutsOn: 2@0.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 11:43:59'!
test08
	"X todavia no gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.
	aGame oPutsOn: 1@1.
	aGame xPutsOn: 2@2.
	
	self deny: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 21:01:11'!
test09
	"X gana competando la segunda columna"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.
	aGame oPutsOn: 0@2.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 1@2.
	aGame xPutsOn: 2@1.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 12:43:19'!
test10
	"ahora X gana competando la tercer columna"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@2.
	aGame oPutsOn: 0@0.
	aGame xPutsOn: 1@2.
	aGame oPutsOn: 1@0.
	aGame xPutsOn: 2@2.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 16:38:52'!
test11
	"X gana completando la primer fila"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 1@0.
	aGame xPutsOn: 0@1.
	aGame oPutsOn: 1@1.
	aGame xPutsOn: 0@2.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 12:45:31'!
test12
	"X gana competando la segunda fila"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 1@0.
	aGame oPutsOn: 2@0.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 1@2.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 12:45:15'!
test13
	"X gana competando la tercer fila"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 2@0.
	aGame oPutsOn: 0@0.
	aGame xPutsOn: 2@1.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 2@2.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 13:06:25'!
test14
	"X gana competando la diagonal creciente"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 1@0.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 2@2.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 13:06:45'!
test15
	"X gana competando la diagonal decreciente"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 2@0.
	aGame oPutsOn: 1@0.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 0@2.
	
	self assert: aGame xHasWon.
! !

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'IO 10/31/2020 13:09:19'!
test16
	"ahora gana O!!"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 2@0.
	aGame oPutsOn: 1@1.
	aGame xPutsOn: 2@2.
	aGame oPutsOn: 2@1.
	
	self assert: aGame oHasWon.
! !


!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 10/31/2020 17:08:30'!
test17
	"empieza poniendo X"
	| aGame |
	aGame := TerniLapilliGame new.
	
	self should: [aGame oPutsOn: (0@0)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 10/31/2020 17:08:35'!
test18
	"despues de X pone Y"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: (0@0).
	self should: [aGame xPutsOn: (0@1)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'IO 10/31/2020 19:12:55'!
test19
	"x no puede mover dos veces seguidas"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).
	self should: [aGame xMoves: (1@0) to: (2@0).] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.
! !


!TerniLapilliGameTest methodsFor: 'utilities' stamp: 'IO 10/31/2020 19:12:19'!
createGameInMovePhase
	"revisar este metodo al usuarlo para usarlo correctamente en los tests ;)"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.
	aGame oPutsOn: 0@2.
	aGame xPutsOn: 1@2.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 2@0.
	aGame oPutsOn: 2@2.
	
	^aGame
! !


!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 19:37:15'!
test20
	"x no puede mover en su primer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	self should: [aGame xMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 19:35:57'!
test21
	"x no puede mover en su segundo turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.

	self should: [aGame xMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 19:37:27'!
test22
	"x no puede mover en su tercer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.
	aGame oPutsOn: 0@2.

	self should: [aGame xMoves: (1@0) to: (2@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 19:37:37'!
test23
	"o no puede mover en su primer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.

	self should: [aGame oMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 20:59:54'!
test24
	"o no puede mover en su segundo turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.

	self should: [aGame oMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 20:51:35'!
test25
	"o no puede mover en su tercer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.
	aGame oPutsOn: 2@2.
	aGame xPutsOn: 2@1.

	self should: [aGame oMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 21:00:09'!
test26
	"x no puedo poner despues de su tercer turno"
	| aGame |
	aGame := self createGameInMovePhase.
	
	self should: [aGame xPutsOn: (1@1).] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 21:00:17'!
test27
	"o no puede poner despues de su tercer turno"
	| aGame |
	aGame := self createGameInMovePhase.

	aGame xMoves: (0@1) to: (1@1).
	
	self should: [aGame oPutsOn: (0@1).] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 21:23:56'!
test28
	"O no puede poner despues de que X gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.
	aGame oPutsOn: 0@2.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 1@2.
	aGame xPutsOn: 2@1.
	
	self should: [aGame oPutsOn: (2@2).] raise: Error withMessageText: TerniLapilliGame gameEndedErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 21:24:02'!
test29
	"O no puede mover despues de que X gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 1@0.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 0@2.
	aGame oPutsOn: 2@2.
	
	aGame xMoves: (1@1) to: (0@1).
	
	self should: [aGame oMoves: (2@2) to: (1@2)] raise: Error withMessageText: TerniLapilliGame gameEndedErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 21:24:46'!
test30
	"X no puede mover despues de que O gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 2@0.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 0@2.
	aGame oPutsOn: 2@2.

	self should: [aGame xMoves: (1@1) to: (0@1).] raise: Error withMessageText: TerniLapilliGame gameEndedErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'IO 10/31/2020 21:24:52'!
test31
	"X no puede poner despues de que O gano"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 2@0.
	aGame xPutsOn: 1@1.
	aGame oPutsOn: 2@1.
	aGame xPutsOn: 0@2.
	aGame oPutsOn: 2@2.

	self should: [aGame xPutsOn: (0@1).] raise: Error withMessageText: TerniLapilliGame gameEndedErrorMessage.
! !


!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'IO 10/31/2020 21:28:11'!
test32
	"X no puede poner en un lugar ocupado"
	
	"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 2@0.

	self should: [	aGame xPutsOn: 0@0.] raise: Error withMessageText: TerniLapilliGame gameEndedErrorMessage.
	"
! !


!classDefinition: #TerniLapilliGame category: 'Terni Lapilli'!
Object subclass: #TerniLapilliGame
	instanceVariableNames: 'state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGame methodsFor: 'initialization' stamp: 'IO 10/31/2020 18:03:53'!
initialize
	state := TerniLapilliGameState new.
! !


!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 10/31/2020 18:07:48'!
includesColorOAt: aPosition 
	^state includesColorOAt: aPosition.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 10/31/2020 18:09:11'!
includesColorXAt: aPosition 
	^state includesColorXAt: aPosition.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 10/31/2020 18:19:39'!
oHasWon
	^state oHasWon.
! !

!TerniLapilliGame methodsFor: 'testing' stamp: 'IO 10/31/2020 18:10:05'!
xHasWon
	^state xHasWon.
! !


!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 10/31/2020 18:33:42'!
oMoves: sourcePosition to: destinationPosition
	state := state oMoves: sourcePosition to: destinationPosition.
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 10/31/2020 18:33:45'!
oPutsOn: aPosition
	state := state oPutsOn: aPosition.
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 10/31/2020 18:33:48'!
xMoves: sourcePosition to: destinationPosition
	state := state xMoves: sourcePosition to: destinationPosition.

! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'IO 10/31/2020 18:33:50'!
xPutsOn: aPosition
	state := state xPutsOn: aPosition.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGame class' category: 'Terni Lapilli'!
TerniLapilliGame class
	instanceVariableNames: ''!

!TerniLapilliGame class methodsFor: 'instance creation' stamp: 'IO 10/31/2020 10:06:00'!
new
	^self basicNew initialize.
! !


!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 10/31/2020 19:20:40'!
cannotMoveErrorMessage
	^'Cannot move'.! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 10/31/2020 20:53:23'!
cannotPutErrorMessage
	^'Cannot put'.! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 10/31/2020 21:04:28'!
gameEndedErrorMessage
	^'Game ended'.! !

!TerniLapilliGame class methodsFor: 'error messages' stamp: 'IO 10/31/2020 17:00:06'!
wrongTurnErrorMessage
	^'Playing in wrong turn'.! !


!classDefinition: #TerniLapilliGameState category: 'Terni Lapilli'!
Object subclass: #TerniLapilliGameState
	instanceVariableNames: 'xTokens oTokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 10/31/2020 18:21:03'!
oMoves: sourcePosition to: destinationPosition
	^self subclassResponsibility.

! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 10/31/2020 18:27:09'!
oPutsOn: aPosition
	^self subclassResponsibility.
! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 10/31/2020 19:01:46'!
passTurn
	^self subclassResponsibility.! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 10/31/2020 21:39:43'!
xMoves: sourcePosition to: destinationPosition 
	^self subclassResponsibility.

! !

!TerniLapilliGameState methodsFor: 'moves' stamp: 'IO 10/31/2020 18:27:33'!
xPutsOn: aPosition
	^self subclassResponsibility.
! !


!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 10/31/2020 18:13:09'!
includesColorOAt: aPosition 
	^oTokens includes: aPosition.

! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 10/31/2020 18:08:05'!
includesColorXAt: aPosition 
	^xTokens includes: aPosition.! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 10/31/2020 18:09:36'!
oHasWon
	^oTokens areInWinningPosition.
! !

!TerniLapilliGameState methodsFor: 'testing' stamp: 'IO 10/31/2020 18:09:41'!
xHasWon
	^xTokens areInWinningPosition.
! !


!TerniLapilliGameState methodsFor: 'initializtion' stamp: 'IO 10/31/2020 18:16:21'!
intializeWithXTokens: nextXTokens oTokens: nextOTokens.
	xTokens := nextXTokens.
	oTokens := nextOTokens.
! !


!TerniLapilliGameState methodsFor: 'error' stamp: 'IO 10/31/2020 21:35:24'!
errorCannotMove
	^self error: TerniLapilliGame cannotMoveErrorMessage
! !

!TerniLapilliGameState methodsFor: 'error' stamp: 'IO 10/31/2020 21:34:35'!
errorCannotPut
	^self error: TerniLapilliGame cannotPutErrorMessage.
! !

!TerniLapilliGameState methodsFor: 'error' stamp: 'IO 10/31/2020 21:40:06'!
errorIlegalTurn
	^self error: TerniLapilliGame wrongTurnErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameState class' category: 'Terni Lapilli'!
TerniLapilliGameState class
	instanceVariableNames: ''!

!TerniLapilliGameState class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:39:11'!
new
	^TerniLapilliGameStatePutsX new.
! !

!TerniLapilliGameState class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 18:17:46'!
withXTokens: nextXTokens oTokens: nextOTokens.
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #TerniLapilliGameStateOver category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #TerniLapilliGameStateOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:38:25'!
errorGameEnded
	^self error: TerniLapilliGame gameEndedErrorMessage.
! !

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:39:00'!
oMoves: sourcePosition to: destinationPosition
	^self errorGameEnded.
! !

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:38:58'!
oPutsOn: aPosition
	^self errorGameEnded.
! !

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:38:54'!
xMoves: sourcePosition to: destinationPosition
	^self errorGameEnded.
! !

!TerniLapilliGameStateOver methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:38:08'!
xPutsOn: aPosition
	^self errorGameEnded.
! !


!classDefinition: #TerniLapilliGameStatePlaysO category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #TerniLapilliGameStatePlaysO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStatePlaysO methodsFor: 'moves' stamp: 'IO 10/31/2020 20:49:23'!
oMoves: sourcePosition to: destinationPosition
	^self subclassResponsibility.
! !

!TerniLapilliGameStatePlaysO methodsFor: 'moves' stamp: 'IO 10/31/2020 19:02:26'!
oPutsOn: aPosition
	oTokens add: aPosition.
	^self passTurn.

! !

!TerniLapilliGameStatePlaysO methodsFor: 'moves' stamp: 'IO 10/31/2020 19:02:15'!
passTurn
	^TerniLapilliGameStatePlaysX withXTokens: xTokens oTokens: oTokens.

! !

!TerniLapilliGameStatePlaysO methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
xMoves: sourcePosition to: destinationPosition
	self errorIlegalTurn.

! !

!TerniLapilliGameStatePlaysO methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
xPutsOn: aPosition
	self errorIlegalTurn.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStatePlaysO class' category: 'Terni Lapilli'!
TerniLapilliGameStatePlaysO class
	instanceVariableNames: ''!

!TerniLapilliGameStatePlaysO class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:12:17'!
withXTokens: nextXTokens oTokens: nextOTokens
	(nextXTokens areInWinningPosition) ifTrue: [^TerniLapilliGameStateOver withXTokens: nextXTokens oTokens: nextOTokens].
	(nextOTokens size < 3) ifTrue: [^TerniLapilliGameStatePutsO withXTokens: nextXTokens oTokens: nextOTokens].
	^TerniLapilliGameStateMovesO withXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #TerniLapilliGameStateMovesO category: 'Terni Lapilli'!
TerniLapilliGameStatePlaysO subclass: #TerniLapilliGameStateMovesO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStateMovesO methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:48:04'!
oMoves: sourcePosition to: destinationPosition
	oTokens move: sourcePosition to: destinationPosition.
	^self passTurn.

! !

!TerniLapilliGameStateMovesO methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:34:35'!
oPutsOn: aPosition
	^self errorCannotPut.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStateMovesO class' category: 'Terni Lapilli'!
TerniLapilliGameStateMovesO class
	instanceVariableNames: ''!

!TerniLapilliGameStateMovesO class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:50:11'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #TerniLapilliGameStatePutsO category: 'Terni Lapilli'!
TerniLapilliGameStatePlaysO subclass: #TerniLapilliGameStatePutsO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStatePutsO methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:35:10'!
oMoves: sourcePosition to: destinationPosition
	^self errorCannotMove.! !

!TerniLapilliGameStatePutsO methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:11:33'!
oPutsOn: aPosition
	oTokens add: aPosition.
	^self passTurn.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStatePutsO class' category: 'Terni Lapilli'!
TerniLapilliGameStatePutsO class
	instanceVariableNames: ''!

!TerniLapilliGameStatePutsO class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:49:55'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.! !


!classDefinition: #TerniLapilliGameStatePlaysX category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #TerniLapilliGameStatePlaysX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStatePlaysX methodsFor: 'initializtion' stamp: 'IO 10/31/2020 18:30:39'!
initialize
	xTokens := TerniLapilliPlayerTokens new.
	oTokens := TerniLapilliPlayerTokens new.
! !


!TerniLapilliGameStatePlaysX methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
oMoves: sourcePosition to: destinationPosition
	self errorIlegalTurn.
! !

!TerniLapilliGameStatePlaysX methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
oPutsOn: aPosition
	self errorIlegalTurn.

! !

!TerniLapilliGameStatePlaysX methodsFor: 'moves' stamp: 'IO 10/31/2020 19:02:56'!
passTurn
	^TerniLapilliGameStatePlaysO withXTokens: xTokens oTokens: oTokens.
! !

!TerniLapilliGameStatePlaysX methodsFor: 'moves' stamp: 'IO 10/31/2020 21:36:24'!
xMoves: sourcePosition to: destinationPosition
	^self subclassResponsibility.


! !

!TerniLapilliGameStatePlaysX methodsFor: 'moves' stamp: 'IO 10/31/2020 20:54:38'!
xPutsOn: aPosition
	^self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStatePlaysX class' category: 'Terni Lapilli'!
TerniLapilliGameStatePlaysX class
	instanceVariableNames: ''!

!TerniLapilliGameStatePlaysX class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 18:04:44'!
new
	^self basicNew initialize.
! !

!TerniLapilliGameStatePlaysX class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:22:09'!
withXTokens: nextXTokens oTokens: nextOTokens
	(nextOTokens areInWinningPosition) ifTrue: [^TerniLapilliGameStateOver withXTokens: nextXTokens oTokens: nextOTokens].
	(nextXTokens size < 3) ifTrue: [^TerniLapilliGameStatePutsX withXTokens: nextXTokens oTokens: nextOTokens].
	^TerniLapilliGameStateMovesX withXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #TerniLapilliGameStateMovesX category: 'Terni Lapilli'!
TerniLapilliGameStatePlaysX subclass: #TerniLapilliGameStateMovesX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStateMovesX methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:35:36'!
xMoves: sourcePosition to: destinationPosition
	xTokens move: sourcePosition to: destinationPosition.
	^self passTurn.

! !

!TerniLapilliGameStateMovesX methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:35:46'!
xPutsOn: aPosition
	^self errorCannotPut.


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStateMovesX class' category: 'Terni Lapilli'!
TerniLapilliGameStateMovesX class
	instanceVariableNames: ''!

!TerniLapilliGameStateMovesX class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:30:34'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.! !


!classDefinition: #TerniLapilliGameStatePutsX category: 'Terni Lapilli'!
TerniLapilliGameStatePlaysX subclass: #TerniLapilliGameStatePutsX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameStatePutsX methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 21:35:57'!
xMoves: sourcePosition to: destinationPosition
	^self errorCannotMove.

! !

!TerniLapilliGameStatePutsX methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:54:04'!
xPutsOn: aPosition
	xTokens add: aPosition.
	^self passTurn.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliGameStatePutsX class' category: 'Terni Lapilli'!
TerniLapilliGameStatePutsX class
	instanceVariableNames: ''!

!TerniLapilliGameStatePutsX class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:30:51'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.! !


!classDefinition: #TerniLapilliPlayerTokens category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPlayerTokens
	instanceVariableNames: 'tokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPlayerTokens methodsFor: 'moves' stamp: 'IO 10/31/2020 11:34:15'!
add: aPosition

	tokens add: aPosition.! !

!TerniLapilliPlayerTokens methodsFor: 'moves' stamp: 'IO 10/31/2020 11:34:15'!
move: sourcePosition to: destinationPosition
	tokens remove: sourcePosition.
	tokens add: destinationPosition.! !


!TerniLapilliPlayerTokens methodsFor: 'testing' stamp: 'IO 10/31/2020 16:54:05'!
areInWinningPosition

	^(
		(
			(self areInWinningPositionByColumn: 0) or:
			(self areInWinningPositionByColumn: 1) or:
			(self areInWinningPositionByColumn: 2)
		) or: (
			(self areInWinningPositionByRow: 0) or:
			(self areInWinningPositionByRow: 1) or:
			(self areInWinningPositionByRow: 2)
		) or: (
			self areInWinningPositionByDiagonal
		)
	).
! !

!TerniLapilliPlayerTokens methodsFor: 'testing' stamp: 'IO 10/31/2020 13:17:38'!
areInWinningPositionByColumn: columnNumber

	^(tokens includes: (0@columnNumber)) and: (tokens includes: (1@columnNumber)) and: (tokens includes: (2@columnNumber))! !

!TerniLapilliPlayerTokens methodsFor: 'testing' stamp: 'IO 10/31/2020 16:43:21'!
areInWinningPositionByDiagonal

	^(tokens includes: (1@1)) and: (
		((tokens includes: (0@0)) and: (tokens includes: (2@2))) or: (
		(tokens includes: (2@0)) and: (tokens includes: (0@2))
	))! !

!TerniLapilliPlayerTokens methodsFor: 'testing' stamp: 'IO 10/31/2020 12:41:00'!
areInWinningPositionByRow: rowNumber

	^(tokens includes: (rowNumber@0)) and: (tokens includes: (rowNumber@1)) and: (tokens includes: (rowNumber@2))! !

!TerniLapilliPlayerTokens methodsFor: 'testing' stamp: 'IO 10/31/2020 11:34:15'!
includes: aPosition

	^tokens includes: aPosition.! !

!TerniLapilliPlayerTokens methodsFor: 'testing' stamp: 'IO 10/31/2020 19:31:43'!
size

	^tokens size.! !


!TerniLapilliPlayerTokens methodsFor: 'initializtion' stamp: 'IO 10/31/2020 11:34:15'!
initialize
	tokens := Set new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerTokens class' category: 'Terni Lapilli'!
TerniLapilliPlayerTokens class
	instanceVariableNames: ''!

!TerniLapilliPlayerTokens class methodsFor: 'instance creation' stamp: 'IO 10/31/2020 11:19:46'!
new
	^self basicNew initialize.
! !
