!classDefinition: #TerniLapilliGameTest category: 'Terni Lapilli'!
TestCase subclass: #TerniLapilliGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'LH 11/1/2020 13:36:17'!
test01XCanPutAToken
	"x pone en 0@0"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.

	self assert: (aGame includesColorXAt: (0@0)).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'LH 11/1/2020 13:38:29'!
test02puttingDoesNotAffectOtherPositions
	"x pone en 0@0 pero no en 0@1"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.

	self deny: (aGame includesColorXAt: 0@1).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'LH 11/1/2020 13:38:10'!
test03XCanPutInOtherPositions
	"x pone en 0@1"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.

	self assert: (aGame includesColorXAt: 0@1).
! !

!TerniLapilliGameTest methodsFor: 'put tokens phase' stamp: 'LH 11/1/2020 13:38:39'!
test04OCanPut
	"o pone en 0@0"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@1.
	aGame oPutsOn: 0@0.

	self assert: (aGame includesColorOAt: (0@0)).
! !


!TerniLapilliGameTest methodsFor: 'move tokens phase' stamp: 'LH 11/1/2020 13:39:04'!
test05XCanMove
	"movimiento legal desp de haber jugado las tres fichas :D"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).

	self assert: (aGame includesColorXAt: (1@0)).
! !

!TerniLapilliGameTest methodsFor: 'move tokens phase' stamp: 'LH 11/1/2020 13:39:11'!
test06OCanMove
	"movimiento legal de O desp de haber jugado las tres fichas :D"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).
	aGame oMoves: (2@1) to: (1@1).

	self assert: (aGame includesColorOAt: (1@1)).
! !


!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:40:14'!
test07XWinsWithTheFirstColumn
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:41:25'!
test08XHasntWonYet
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:41:34'!
test09XWinsWithTheSecondColumn
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:41:42'!
test10XWinsWithTheThirdColumn
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:41:53'!
test11XWinsWithTheFirstRow
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:42:14'!
test12XWinsWithTheSecondRow
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:42:26'!
test13XWinsWithTheThirdRow
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:42:43'!
test14XWinsWithTheCrescentDiagonal
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:43:00'!
test15XWinsWithTheDescendantDiagonal
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

!TerniLapilliGameTest methodsFor: 'winning positions' stamp: 'LH 11/1/2020 13:43:07'!
test16OWnis
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


!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'LH 11/1/2020 13:53:30'!
test17OCantStartPutting
	"empieza poniendo X"
	| aGame |
	aGame := TerniLapilliGame new.
	
	self should: [aGame oPutsOn: (0@0)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'LH 11/1/2020 13:45:09'!
test18XCantPutTwiceInARow
	"despues de X pone Y"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: (0@0).
	self should: [aGame xPutsOn: (0@1)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'LH 11/1/2020 13:45:25'!
test19XCantMoveTwiceInARow
	"x no puede mover dos veces seguidas"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).
	self should: [aGame xMoves: (1@0) to: (2@0).] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'LH 11/1/2020 13:49:40'!
test20OCantPutTwiceInARow
	"despues de X pone Y"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: (0@0).	aGame oPutsOn:(0@1).

	self should: [aGame oPutsOn: (0@2)] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.


! !

!TerniLapilliGameTest methodsFor: 'ilegal turns' stamp: 'LH 11/1/2020 13:52:15'!
test21OCantMoveTwiceInARow
	"x no puede mover dos veces seguidas"
	| aGame |
	aGame := self createGameInMovePhase.
	
	aGame xMoves: (2@0) to: (1@0).	aGame oMoves: (2@1) to: (1@1).

	self should: [aGame oMoves: (1@1) to: (2@1).] raise: Error withMessageText: TerniLapilliGame wrongTurnErrorMessage.
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


!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:54:33'!
test22XCantMoveOnTheirFirstTurn
	"x no puede mover en su primer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	self should: [aGame xMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:55:06'!
test23XCantMoveOnTheirSecondTurn
	"x no puede mover en su segundo turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.

	self should: [aGame xMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:56:13'!
test24XCantMoveOnTheirThirdTurn
	"x no puede mover en su tercer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.
	aGame oPutsOn: 0@2.

	self should: [aGame xMoves: (1@0) to: (2@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.
! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:56:08'!
test25OCantMoveOnTheirFirstTurn
	"o no puede mover en su primer turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.

	self should: [aGame oMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:56:57'!
test26OCantMoveOnTheirSecondTurn
	"o no puede mover en su segundo turno"
	| aGame |
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 1@0.

	self should: [aGame oMoves: (0@0) to: (1@0).] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:57:09'!
test27OCantMoveOnTheirThirdTurn
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

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:57:36'!
test28XCantPutAfterTheirThirdTurn
	"x no puedo poner despues de su tercer turno"
	| aGame |
	aGame := self createGameInMovePhase.
	
	self should: [aGame xPutsOn: (1@1).] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:57:55'!
test29OCantPutAfterTheirThirdTurn
	"o no puede poner despues de su tercer turno"
	| aGame |
	aGame := self createGameInMovePhase.

	aGame xMoves: (0@1) to: (1@1).
	
	self should: [aGame oPutsOn: (0@1).] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage.

	! !

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:58:13'!
test30OCantPutAfterXWon
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

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:58:30'!
test31OCantMoveAfterXWon
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

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 13:58:53'!
test32XCantMoveAfterOWon
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

!TerniLapilliGameTest methodsFor: 'ilegal moves' stamp: 'LH 11/1/2020 14:00:32'!
test33XCantPutAfterOWon
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


!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:10:25'!
test34XCantPutInAnOccupiedSpace
	"X no puede poner en un lugar ocupado"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 2@0.

	self should: [	aGame xPutsOn: 0@0.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
	self should: [	aGame xPutsOn: 2@0.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:11:29'!
test35OCantPutInAnOccupiedSpace
	"O no puede poner en un lugar ocupado"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	aGame xPutsOn: 0@0.
	aGame oPutsOn: 0@1.
	aGame xPutsOn: 0@2.

	self should: [	aGame oPutsOn: 0@0.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
	self should: [	aGame oPutsOn: 0@1.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:06:05'!
test36XCantMoveToAnOccupiedSpace
	"X no puede mover en un lugar ocupado"
	

	| aGame |
	
	aGame := self createGameInMovePhase .
	
	self should: [	aGame xMoves: 1@2 to: 2@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:05:59'!
test37OCantMoveToAnOccupiedSpace
	"O no puede mover en un lugar ocupado"
	

	| aGame |
	
	aGame := self createGameInMovePhase .
	aGame xMoves: 0@1 to: 0@0.
	
	self should: [	aGame oMoves: 2@1 to: 1@2.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:06:47'!
test38XCantPutOutsideTheBoardUnderXAxis
	"X no puede poner afuera del tablero por x, por abajo"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	self should: [	aGame xPutsOn: -1@1.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:07:16'!
test39XCantPutOutsideTheBoardAboveXAxis
	"X no puede poner afuera del tablero por x, por arriba"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	self should: [	aGame xPutsOn: 3@1.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:08:01'!
test40XCantPutOutsideTheBoardUnderNorAboveTheYAxis
	"X no puede poner afuera del tablero por y"
	

	| aGame |
	
	aGame := TerniLapilliGame new.
	
	self should: [	aGame xPutsOn: 1@-1.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
	self should: [	aGame xPutsOn: 1@3.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage .
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:15:20'!
test41OCantPutOutsideTheBoard
	"O no puede mover hacía afuera del tablero"
	

	| aGame |

	aGame := TerniLapilliGame new.
	aGame xPutsOn: 0@0.
	
	self should: [	aGame oPutsOn: 0@3.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage. 
	self should: [	aGame oPutsOn: 0@-1.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage. 
	self should: [	aGame oPutsOn: 3@0.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage. 
	self should: [	aGame oPutsOn: -1@0.] raise: Error withMessageText: TerniLapilliGame cannotPutErrorMessage. 
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:17:37'!
test42XCantMoveToOutsideTheBoard
	"X no puede mover hacía afuera del tablero"
	

	| aGame |

	aGame := self createGameInMovePhase .
	
	self should: [	aGame xMoves: 0@1 to: -1@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	self should: [	aGame xMoves: 0@1 to: 3@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	self should: [	aGame xMoves: 0@1 to: 1@-1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	self should: [	aGame xMoves: 0@1 to: 1@3.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:18:35'!
test43OCantMoveToOutsideTheBoard
	"O no puede mover hacía afuera del tablero"
	

	| aGame |

	aGame := self createGameInMovePhase .
	aGame xMoves: 0@1 to: 0@0.
	
	self should: [	aGame oMoves: 0@2 to: -1@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	self should: [	aGame oMoves: 0@2 to: 3@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	self should: [	aGame oMoves: 0@2 to: 1@-1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	self should: [	aGame oMoves: 0@2 to: 1@3.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage. 
	
! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:21:09'!
test44XCantMoveTokensThatDontBelongToThem
	"X no puede mover fichas que no sea suyas"
	

	| aGame |

	aGame := self createGameInMovePhase .
	
	self should: [	aGame xMoves: 0@2 to: 1@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.
	self should: [	aGame xMoves: 3@2 to: 1@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:21:22'!
test45OCantMoveTokensThatDontBelongToThem
	"O no puede mover fichas que no sea suyas"
	

	| aGame |

	aGame := self createGameInMovePhase .
	aGame xMoves: 0@1 to: 1@1.
	
	self should: [	aGame oMoves: 1@1 to: 0@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.
	self should: [	aGame oMoves: 3@1 to: 0@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:20:11'!
test46XCantMoveaTokenOutsideItsNeighbors
	"X no puede mover fichas hacia más de 1 vecinidad"
	

	| aGame |

	aGame := self createGameInMovePhase .
	
	self should: [	aGame xMoves: 2@0 to: 0@0.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.! !

!TerniLapilliGameTest methodsFor: 'ilegal positions' stamp: 'LH 11/1/2020 14:20:35'!
test47OCantMoveATokenOutsideItsNeighbors
	"O no puede mover fichas hacia más de 1 vecinidad"
	

	| aGame |

	aGame := self createGameInMovePhase .
	aGame xMoves: 0@1 to: 0@0.
	
	self should: [	aGame oMoves: 2@1 to: 0@1.] raise: Error withMessageText: TerniLapilliGame cannotMoveErrorMessage.! !


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


!TerniLapilliGame methodsFor: 'testing' stamp: 'LH 10/31/2020 22:01:52'!
includesColorAt: aPosition	^(state includesColorOAt: aPosition) or: (state includesColorXAt: aPosition).! !

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


!TerniLapilliGame methodsFor: 'moves' stamp: 'LH 11/1/2020 11:34:29'!
oMoves: sourcePosition to: destinationPosition

	(self includesColorAt: destinationPosition ) ifTrue:[^self error: TerniLapilliGame cannotMoveErrorMessage ] .
	
	state := state oMoves: sourcePosition to: destinationPosition.
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'LH 11/1/2020 10:59:58'!
oPutsOn: aPosition

	(self includesColorAt: aPosition ) ifTrue:[^self error: TerniLapilliGame cannotPutErrorMessage ] .
	
	
	state := state oPutsOn: aPosition.
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'LH 11/1/2020 11:34:24'!
xMoves: sourcePosition to: destinationPosition

	(self includesColorAt: destinationPosition ) ifTrue:[^self error: TerniLapilliGame cannotMoveErrorMessage ] .

	state := state xMoves: sourcePosition to: destinationPosition.
	
	
! !

!TerniLapilliGame methodsFor: 'moves' stamp: 'LH 11/1/2020 10:59:53'!
xPutsOn: aPosition

	(self includesColorAt: aPosition ) ifTrue:[^self error: TerniLapilliGame cannotPutErrorMessage ] .
	
	
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

!TerniLapilliGameState class methodsFor: 'as yet unclassified' stamp: 'LH 10/31/2020 21:53:19'!
new
	^XIsPlacing new.
! !

!TerniLapilliGameState class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 18:17:46'!
withXTokens: nextXTokens oTokens: nextOTokens.
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #GameIsOver category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #GameIsOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!GameIsOver methodsFor: 'moves' stamp: 'IO 10/31/2020 21:39:00'!
oMoves: sourcePosition to: destinationPosition
	^self errorGameEnded.
! !

!GameIsOver methodsFor: 'moves' stamp: 'IO 10/31/2020 21:38:58'!
oPutsOn: aPosition
	^self errorGameEnded.
! !

!GameIsOver methodsFor: 'moves' stamp: 'IO 10/31/2020 21:38:54'!
xMoves: sourcePosition to: destinationPosition
	^self errorGameEnded.
! !

!GameIsOver methodsFor: 'moves' stamp: 'IO 10/31/2020 21:38:08'!
xPutsOn: aPosition
	^self errorGameEnded.
! !


!GameIsOver methodsFor: 'error signaling' stamp: 'IO 10/31/2020 21:38:25'!
errorGameEnded
	^self error: TerniLapilliGame gameEndedErrorMessage.
! !


!classDefinition: #OIsPlaying category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #OIsPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 20:49:23'!
oMoves: sourcePosition to: destinationPosition
	^self subclassResponsibility.
! !

!OIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 19:02:26'!
oPutsOn: aPosition
	oTokens add: aPosition.
	^self passTurn.

! !

!OIsPlaying methodsFor: 'moves' stamp: 'LH 10/31/2020 21:52:30'!
passTurn
	^XIsPlaying withXTokens: xTokens oTokens: oTokens.

! !

!OIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
xMoves: sourcePosition to: destinationPosition
	self errorIlegalTurn.

! !

!OIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
xPutsOn: aPosition
	self errorIlegalTurn.

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OIsPlaying class' category: 'Terni Lapilli'!
OIsPlaying class
	instanceVariableNames: ''!

!OIsPlaying class methodsFor: 'as yet unclassified' stamp: 'LH 11/1/2020 10:50:59'!
withXTokens: nextXTokens oTokens: nextOTokens
	(nextXTokens areInWinningPosition) ifTrue: [^GameIsOver withXTokens: nextXTokens oTokens: nextOTokens].
	(nextOTokens size < 3) ifTrue: [^OIsPlacing withXTokens: nextXTokens oTokens: nextOTokens].
	^OIsMoving withXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #OIsMoving category: 'Terni Lapilli'!
OIsPlaying subclass: #OIsMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OIsMoving methodsFor: 'moves' stamp: 'IO 10/31/2020 20:48:04'!
oMoves: sourcePosition to: destinationPosition
	oTokens move: sourcePosition to: destinationPosition.
	^self passTurn.

! !

!OIsMoving methodsFor: 'moves' stamp: 'IO 10/31/2020 21:34:35'!
oPutsOn: aPosition
	^self errorCannotPut.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OIsMoving class' category: 'Terni Lapilli'!
OIsMoving class
	instanceVariableNames: ''!

!OIsMoving class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:50:11'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.
! !


!classDefinition: #OIsPlacing category: 'Terni Lapilli'!
OIsPlaying subclass: #OIsPlacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!OIsPlacing methodsFor: 'moves' stamp: 'IO 10/31/2020 21:35:10'!
oMoves: sourcePosition to: destinationPosition
	^self errorCannotMove.! !

!OIsPlacing methodsFor: 'moves' stamp: 'IO 10/31/2020 21:11:33'!
oPutsOn: aPosition
	oTokens add: aPosition.
	^self passTurn.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OIsPlacing class' category: 'Terni Lapilli'!
OIsPlacing class
	instanceVariableNames: ''!

!OIsPlacing class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:49:55'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.! !


!classDefinition: #XIsPlaying category: 'Terni Lapilli'!
TerniLapilliGameState subclass: #XIsPlaying
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XIsPlaying methodsFor: 'initializtion' stamp: 'IO 10/31/2020 18:30:39'!
initialize
	xTokens := TerniLapilliPlayerTokens new.
	oTokens := TerniLapilliPlayerTokens new.
! !


!XIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
oMoves: sourcePosition to: destinationPosition
	self errorIlegalTurn.
! !

!XIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 19:56:20'!
oPutsOn: aPosition
	self errorIlegalTurn.

! !

!XIsPlaying methodsFor: 'moves' stamp: 'LH 10/31/2020 21:51:49'!
passTurn
	^OIsPlaying withXTokens: xTokens oTokens: oTokens.
! !

!XIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 21:36:24'!
xMoves: sourcePosition to: destinationPosition
	^self subclassResponsibility.


! !

!XIsPlaying methodsFor: 'moves' stamp: 'IO 10/31/2020 20:54:38'!
xPutsOn: aPosition
	^self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIsPlaying class' category: 'Terni Lapilli'!
XIsPlaying class
	instanceVariableNames: ''!

!XIsPlaying class methodsFor: 'instance creation' stamp: 'IO 10/31/2020 18:04:44'!
new
	^self basicNew initialize.
! !

!XIsPlaying class methodsFor: 'instance creation' stamp: 'LH 11/1/2020 12:44:26'!
withXTokens: nextXTokens oTokens: nextOTokens
	(nextOTokens areInWinningPosition) ifTrue: [^GameIsOver withXTokens: nextXTokens oTokens: nextOTokens].
	
	(nextXTokens size < 3) ifTrue: [^XIsPlacing withXTokens: nextXTokens oTokens: nextOTokens].
	
	^XIsMoving withXTokens: nextXTokens oTokens: nextOTokens.
	
! !


!classDefinition: #XIsMoving category: 'Terni Lapilli'!
XIsPlaying subclass: #XIsMoving
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XIsMoving methodsFor: 'moves' stamp: 'IO 10/31/2020 21:35:36'!
xMoves: sourcePosition to: destinationPosition
	xTokens move: sourcePosition to: destinationPosition.
	^self passTurn.

! !

!XIsMoving methodsFor: 'moves' stamp: 'IO 10/31/2020 21:35:46'!
xPutsOn: aPosition
	^self errorCannotPut.


! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIsMoving class' category: 'Terni Lapilli'!
XIsMoving class
	instanceVariableNames: ''!

!XIsMoving class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:30:34'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.! !


!classDefinition: #XIsPlacing category: 'Terni Lapilli'!
XIsPlaying subclass: #XIsPlacing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!XIsPlacing methodsFor: 'moves' stamp: 'IO 10/31/2020 21:35:57'!
xMoves: sourcePosition to: destinationPosition
	^self errorCannotMove.

! !

!XIsPlacing methodsFor: 'moves' stamp: 'IO 10/31/2020 20:54:04'!
xPutsOn: aPosition
	xTokens add: aPosition.
	^self passTurn.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XIsPlacing class' category: 'Terni Lapilli'!
XIsPlacing class
	instanceVariableNames: ''!

!XIsPlacing class methodsFor: 'as yet unclassified' stamp: 'IO 10/31/2020 20:30:51'!
withXTokens: nextXTokens oTokens: nextOTokens
	^self basicNew intializeWithXTokens: nextXTokens oTokens: nextOTokens.! !


!classDefinition: #TerniLapilliPlayerTokens category: 'Terni Lapilli'!
Object subclass: #TerniLapilliPlayerTokens
	instanceVariableNames: 'tokens'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Terni Lapilli'!

!TerniLapilliPlayerTokens methodsFor: 'moves' stamp: 'LH 11/1/2020 13:18:21'!
add: aPosition

	self validateIsInBoard: aPosition withErrorMessage: TerniLapilliGame cannotPutErrorMessage.

	tokens add: aPosition.! !

!TerniLapilliPlayerTokens methodsFor: 'moves' stamp: 'LH 11/1/2020 13:25:50'!
move: sourcePosition to: destinationPosition

	self validateIsLegalMoveFrom: sourcePosition to: destinationPosition.

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


!TerniLapilliPlayerTokens methodsFor: 'validations' stamp: 'LH 11/1/2020 13:17:19'!
validateIsInBoard: aPosition withErrorMessage: errorMessage

	aPosition x < 3 ifFalse:[^self error: errorMessage ].
	aPosition x >= 0 ifFalse:[^self error: errorMessage ].
	aPosition y < 3 ifFalse:[^self error: errorMessage ].
	aPosition y >= 0 ifFalse:[^self error: errorMessage ].! !

!TerniLapilliPlayerTokens methodsFor: 'validations' stamp: 'LH 11/1/2020 13:25:09'!
validateIsLegalMoveFrom: sourcePosition to: destinationPosition

	(self includes: sourcePosition ) ifFalse:[^self error: TerniLapilliGame cannotMoveErrorMessage ] .

	(sourcePosition eightNeighbors includes: destinationPosition) ifFalse: [^self error: TerniLapilliGame cannotMoveErrorMessage ] .
	
	
	self validateIsInBoard: destinationPosition withErrorMessage: TerniLapilliGame cannotMoveErrorMessage.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliPlayerTokens class' category: 'Terni Lapilli'!
TerniLapilliPlayerTokens class
	instanceVariableNames: ''!

!TerniLapilliPlayerTokens class methodsFor: 'instance creation' stamp: 'IO 10/31/2020 11:19:46'!
new
	^self basicNew initialize.
! !
