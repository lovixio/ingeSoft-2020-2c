!classDefinition: #I category: #'Ejercicio 1'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Ejercicio 1'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operaciones' stamp: 'LH 9/15/2020 19:05:21'!
* num

	^num.! !

!I class methodsFor: 'operaciones' stamp: 'LH 9/14/2020 20:54:05'!
+ num 
	^num next.! !

!I class methodsFor: 'operaciones' stamp: 'IO 9/16/2020 19:29:22'!
- num
	^Error signal: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'operaciones' stamp: 'IO 9/16/2020 19:48:12'!
/ num
	^(num isDescendantOf: self) ifTrue: [Error signal: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor] ifFalse: [(self = num) ifTrue: [I] ifFalse: [I + ((self-num)/num)]]! !

!I class methodsFor: 'operaciones' stamp: 'LH 9/14/2020 22:14:46'!
next

	^self  createChildNamed: self name, 'I'.! !


!I class methodsFor: 'descripciones de numeros no soportados' stamp: 'IO 9/16/2020 19:16:54'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'Division por mayores no soportada'! !

!I class methodsFor: 'descripciones de numeros no soportados' stamp: 'IO 9/16/2020 19:15:26'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'! !


!classDefinition: #II category: #'Ejercicio 1'!
I subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Ejercicio 1'!
II class
	instanceVariableNames: ''!

!II class methodsFor: 'operaciones' stamp: 'IO 9/16/2020 17:04:12'!
* num
	^num + (num * self previous)! !

!II class methodsFor: 'operaciones' stamp: 'LH 9/15/2020 19:05:50'!
+ num

	^self previous + num next.! !

!II class methodsFor: 'operaciones' stamp: 'LH 9/15/2020 19:07:53'!
- num
	^(num=I) ifTrue: [self previous] ifFalse: [self previous - num previous]. ! !

!II class methodsFor: 'operaciones' stamp: 'LH 9/15/2020 01:15:01'!
previous
	
	^self parent. ! !


!classDefinition: #III category: #'Ejercicio 1'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIII category: #'Ejercicio 1'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIII category: #'Ejercicio 1'!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIII category: #'Ejercicio 1'!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIIII category: #'Ejercicio 1'!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIIIII category: #'Ejercicio 1'!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIIIIII category: #'Ejercicio 1'!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIIIIIII category: #'Ejercicio 1'!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIIIIIIII category: #'Ejercicio 1'!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #IIIIIIIIIIII category: #'Ejercicio 1'!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!


!classDefinition: #testsDePeano category: #'Ejercicio 1'!
DenotativeObject subclass: #testsDePeano
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'testsDePeano class' category: #'Ejercicio 1'!
testsDePeano class
	instanceVariableNames: ''!

!testsDePeano class methodsFor: 'Tests Next' stamp: 'IO 9/16/2020 17:11:39'!
test01siguienteDeUnoEsDos
	Assert that: I next isEqualTo: II.
! !

!testsDePeano class methodsFor: 'Tests Next' stamp: 'IO 9/16/2020 17:22:27'!
test02siguienteDeDosEsTres
	Assert that: II next isEqualTo: III.
! !


!testsDePeano class methodsFor: 'Test Previous' stamp: 'IO 9/16/2020 17:15:28'!
test03anteriorDeDosEsUno
	Assert that: II previous isEqualTo: I.! !

!testsDePeano class methodsFor: 'Test Previous' stamp: 'IO 9/16/2020 17:24:26'!
test04anteriorDeTresesDos
	Assert that: III previous isEqualTo: II. ! !


!testsDePeano class methodsFor: 'Test +' stamp: 'IO 9/16/2020 17:24:35'!
test05unoMasUnoEsDos
	Assert that: I+I isEqualTo: II.
 ! !

!testsDePeano class methodsFor: 'Test +' stamp: 'IO 9/16/2020 17:24:46'!
test06tresMásCicnoEsOcho
	Assert that: III+IIIII isEqualTo: IIIIIIII.! !


!testsDePeano class methodsFor: 'Test -' stamp: 'IO 9/16/2020 17:24:55'!
test07dosMenosUnoEsUno

	Assert that: II-I isEqualTo: I.
! !

!testsDePeano class methodsFor: 'Test -' stamp: 'IO 9/16/2020 17:25:06'!
test08cincoMenosTresEsDos
	Assert that: IIIII-III isEqualTo: II. ! !


!testsDePeano class methodsFor: 'Test /' stamp: 'IO 9/16/2020 17:30:06'!
test09unoDivididoUnoEsUno
	
	Assert that: I/I isEqualTo: I.! !

!testsDePeano class methodsFor: 'Test /' stamp: 'IO 9/16/2020 17:25:29'!
test10seisDivididoDosEsTres
	
	Assert that: IIIIII/II isEqualTo: III.! !

!testsDePeano class methodsFor: 'Test /' stamp: 'IO 9/16/2020 17:25:33'!
test11dosDivididoDosEsUno
	Assert that: II/II isEqualTo: I
! !


!testsDePeano class methodsFor: 'Test *' stamp: 'IO 9/16/2020 17:29:45'!
test12unoPortUnoEsUno
	
	Assert that: I*I isEqualTo: I.
 ! !

!testsDePeano class methodsFor: 'Test *' stamp: 'IO 9/16/2020 17:29:54'!
test13dosPorTresEsSeis
	
	Assert that: II*III isEqualTo: IIIIII. ! !

!testsDePeano class methodsFor: 'Test *' stamp: 'IO 9/16/2020 17:25:44'!
test14unoPorTresEsTres
	Assert that: I*III isEqualTo: III.

! !

!testsDePeano class methodsFor: 'Test *' stamp: 'IO 9/16/2020 17:25:41'!
test15tresPorUnoEsTres
	Assert that: III*I isEqualTo: III.

! !


!testsDePeano class methodsFor: 'Test operaciones no soportadas' stamp: 'IO 9/16/2020 19:30:21'!
test16restaNoSoportaNumerosNegativos

	" tomado de los tests de la catedra "
	Assert should: [ I - II ] signal: Error withDescription: I descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!testsDePeano class methodsFor: 'Test operaciones no soportadas' stamp: 'IO 9/16/2020 19:30:55'!
test17divisionNoSoportaDividirPorUnNumeroMayor

	Assert should: [ III /  IIII ] signal: Error withDescription: II descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	
	Assert should: [ I /  II] signal: Error withDescription: I descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
! !
