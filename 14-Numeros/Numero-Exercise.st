!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 5/7/2020 17:46:14'!
test27EnteroSubstractsEnteroCorrectly

	self assert: three - one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:16:43'!
* aMultiplier

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:16:51'!
+ anAdder

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:17:04'!
- aSubtrahend

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:17:18'!
/ aDivisor

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:17:27'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription.
! !

!Numero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:17:52'!
negated

	^self * (Entero with: -1).
! !


!Numero methodsFor: 'testing' stamp: 'IO 10/1/2020 15:18:26'!
isNegative

	self subclassResponsibility.
! !

!Numero methodsFor: 'testing' stamp: 'IO 10/1/2020 15:18:38'!
isOne

	self subclassResponsibility.
! !

!Numero methodsFor: 'testing' stamp: 'IO 10/1/2020 15:19:27'!
isZero

	self subclassResponsibility.
! !


!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:26:19'!
dividirConEntero: unEntero

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:26:32'!
dividirConFraccion: unaFraccion

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:26:16'!
multiplicarConEntero: unEntero

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:26:35'!
multiplicarConFraccion: unaFraccion

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:26:11'!
restarConEntero: unEntero

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:26:38'!
restarConFraccion: unaFraccion

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:18:06'!
sumarConEntero: unEntero

	self subclassResponsibility.
! !

!Numero methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:18:14'!
sumarConFraccion: unaFraccion

	self subclassResponsibility.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 9/24/2020 17:28:15'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 9/24/2020 04:33:41'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 15:25:31'!
dividirConEntero: unEntero

	^Fraccion with:unEntero over:self.
! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 16:09:52'!
dividirConFraccion: unaFraccion

	^Fraccion with: unaFraccion numerator over: self*unaFraccion denominator.
! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 16:16:00'!
multiplicarConEntero: unEntero

	^self class with: value * unEntero integerValue.
! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 16:14:34'!
multiplicarConFraccion: unaFraccion

	"Regla de conmutatividad"

	^unaFraccion multiplicarConEntero: self.

! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 9/28/2020 22:03:03'!
restarConEntero: unEntero
	
	^self class with: unEntero integerValue - value.
! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 15:58:46'!
restarConFraccion: unaFraccion
	| newNumerator |

	newNumerator  := unaFraccion numerator - (self* unaFraccion denominator).
				
	^ newNumerator / unaFraccion denominator 
! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 16:06:40'!
sumarConEntero: unEntero
	"Regla de conmutatividad"

	^self class with: value + unEntero integerValue
! !

!Entero methodsFor: 'arithmetic operations - adapted sublcass' stamp: 'IO 10/1/2020 15:57:59'!
sumarConFraccion: unaFraccion

	^unaFraccion sumarConEntero: self.
! !


!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:26:59'!
* aMultiplier

	^aMultiplier multiplicarConEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:27:05'!
+ anAdder

	^anAdder sumarConEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:27:14'!
- aSubtrahend

	^aSubtrahend restarConEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:27:21'!
/ aDivisor

	^aDivisor dividirConEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:27:33'!
// aDivisor

	^self class with: value // aDivisor integerValue.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:28:15'!
fibonacci

	| one two |

	one := Entero with: 1.
	two := Entero with: 2.

	self isNegative ifTrue: [self error: Entero negativeFibonacciErrorDescription ].	
	(self isZero or: [self isOne]) ifTrue: [^one].

	^ (self - one) fibonacci + (self - two) fibonacci.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:28:40'!
greatestCommonDivisorWith: anEntero

	^self class with: (value gcd: anEntero integerValue).
! !


!Entero methodsFor: 'comparing' stamp: 'IO 10/1/2020 15:28:55'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ].
! !

!Entero methodsFor: 'comparing' stamp: 'IO 10/1/2020 15:29:02'!
hash

	^value hash.
! !


!Entero methodsFor: 'initialization' stamp: 'IO 10/1/2020 15:29:09'!
initalizeWith: aValue

	value := aValue.
! !


!Entero methodsFor: 'value' stamp: 'IO 10/1/2020 15:29:22'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"

	^value.
! !


!Entero methodsFor: 'printing' stamp: 'IO 10/1/2020 15:29:36'!
printOn: aStream

	aStream print: value.
! !


!Entero methodsFor: 'testing' stamp: 'IO 10/1/2020 15:29:44'!
isNegative

	^value < 0.
! !

!Entero methodsFor: 'testing' stamp: 'IO 10/1/2020 15:29:49'!
isOne

	^value = 1.
! !

!Entero methodsFor: 'testing' stamp: 'IO 10/1/2020 15:29:59'!
isZero

	^value = 0.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'HernanWilkinson 5/7/2016 22:53'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	^self new initalizeWith: aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 16:02:29'!
dividirConEntero: unEntero
	
	^(self denominator * unEntero) / self numerator.

! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:31:10'!
dividirConFraccion: unaFraccion

	^(unaFraccion numerator * denominator) / (unaFraccion denominator * numerator).

! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:31:21'!
multiplicarConEntero: unEntero

	^ (self numerator * unEntero) / self denominator.
! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:31:40'!
multiplicarConFraccion: unaFraccion

	^(numerator * unaFraccion numerator) / (denominator * unaFraccion denominator).
! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:31:48'!
restarConEntero: unEntero

	^((unEntero*self denominator) - self numerator) / self denominator.
! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:32:15'!
restarConFraccion: unaFraccion

	^(denominator * unaFraccion numerator) - (numerator * unaFraccion denominator) / (denominator * unaFraccion denominator).
! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:32:49'!
sumarConEntero: unEntero

	^((unEntero * (self denominator)) + self numerator) / (self denominator).
! !

!Fraccion methodsFor: 'arithmetic operations - adapted subclass' stamp: 'IO 10/1/2020 15:32:56'!
sumarConFraccion: unaFraccion

	^(self numerator * unaFraccion denominator) + (self denominator * unaFraccion numerator) / (self denominator * unaFraccion denominator).
! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:33:10'!
* aMultiplier

	^aMultiplier multiplicarConFraccion: self.

! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:33:30'!
+ anAdder

	^anAdder sumarConFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:33:43'!
- aSubtrahend

	^aSubtrahend restarConFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'IO 10/1/2020 15:33:50'!
/ aDivisor

	^ aDivisor dividirConFraccion: self.
! !


!Fraccion methodsFor: 'comparing' stamp: 'IO 10/1/2020 15:34:13'!
= anObject

	^(anObject isKindOf: self class) and: [(numerator * anObject denominator) = (denominator * anObject numerator)].
! !

!Fraccion methodsFor: 'comparing' stamp: 'IO 10/1/2020 15:34:25'!
hash

	^(numerator hash / denominator hash) hash.
! !


!Fraccion methodsFor: 'accessing' stamp: 'IO 10/1/2020 15:35:02'!
denominator

	^ denominator.
! !

!Fraccion methodsFor: 'accessing' stamp: 'IO 10/1/2020 15:35:16'!
numerator

	^numerator.
! !


!Fraccion methodsFor: 'initialization' stamp: 'IO 10/1/2020 15:35:47'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"

	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].

	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator.
! !


!Fraccion methodsFor: 'testing' stamp: 'IO 10/1/2020 15:36:13'!
isNegative

	^numerator < 0.
! !

!Fraccion methodsFor: 'testing' stamp: 'IO 10/1/2020 15:36:20'!
isOne

	^false.
! !

!Fraccion methodsFor: 'testing' stamp: 'IO 10/1/2020 15:36:26'!
isZero

	^false.
! !


!Fraccion methodsFor: 'printing' stamp: 'IO 10/1/2020 15:37:23'!
printOn: aStream

	aStream

		print: numerator;

		nextPut: $/;

		print: denominator.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
