Class {
	#name : #HyperJumpEffect,
	#superclass : #BoxEffect,
	#instVars : [
		'posibleMoves',
		'parsecs',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJumpEffect class >> assertPosibleMovesAreValid: aCollectionOfPosiblesMoves [

	aCollectionOfPosiblesMoves size < 1 ifTrue: [ 
		Error signal: 'There are no posible moves' ].
]

{ #category : #'class initialization' }
HyperJumpEffect class >> with: aCollectionOfPosiblesMoves [
	self assertPosibleMovesAreValid:aCollectionOfPosiblesMoves.
	^ self new initializeWith: aCollectionOfPosiblesMoves
]

{ #category : #accessing }
HyperJumpEffect >> decreasingSort: aCollectionOfPosibleMoves [

	^aCollectionOfPosibleMoves sort: [ :distance1 :distance2 | 
		distance1 amountInParsecs >= distance2 amountInParsecs ].
]

{ #category : #initialization }
HyperJumpEffect >> initializeWith: aCollectionOfPosiblesMoves [
	index:=0.
	posibleMoves:= (self decreasingSort:aCollectionOfPosiblesMoves).
]

{ #category : #initialization }
HyperJumpEffect >> numberOfDistanceByHyperJump [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #action }
HyperJumpEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard 
		move: aSpaceship
		toFinalDistance: self numberOfDistanceByHyperJump
]
