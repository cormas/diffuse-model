Class {
	#name : 'DifCell',
	#superclass : 'CMCell',
	#instVars : [
		'quantity',
		'lostOrReceivedQuantity'
	],
	#classInstVars : [
		'minimunQty',
		'diffusionRate',
		'evaporationRate'
	],
	#category : 'Diffuse-Model',
	#package : 'Diffuse-Model'
}

{ #category : 'accessing' }
DifCell class >> diffusionRate [
	<parameterFloatMin: 0 max: 1 default: 0.5>
	^ diffusionRate
]

{ #category : 'accessing' }
DifCell class >> diffusionRate: anObject [

	diffusionRate := anObject
]

{ #category : 'accessing' }
DifCell class >> evaporationRate [
	<parameterFloatMin: 0 max: 1 default: 0.1>
	^ evaporationRate
]

{ #category : 'accessing' }
DifCell class >> evaporationRate: anObject [

	evaporationRate := anObject
]

{ #category : 'accessing' }
DifCell class >> minimunQty [
	<parameterFloatMin: 0 max: 10 default: 1>
	^ minimunQty
]

{ #category : 'accessing' }
DifCell class >> minimunQty: anObject [

	minimunQty := anObject
]

{ #category : 'control' }
DifCell >> diffuse [
	"Diffusion of hormons around the cell.
	Each neighbours will receive a quantity equals to qty*diffusionRate/connexity.
	diffusionRate is the % of hormon I should give to my neigbourhood.
	If I am at the edge, I will give less hormons"
	
	| quantityToGiveToEachCell givenQuantity |
	self quantity > 0 ifFalse: [ ^ self ].
	
	quantityToGiveToEachCell := self quantity * self class diffusionRate / self neighbourhood size.
	givenQuantity := 0.
	
	self neighbourhood do: [ :neighbour |
		givenQuantity := givenQuantity + quantityToGiveToEachCell.
		neighbour lostOrReceivedQuantity: neighbour lostOrReceivedQuantity + quantityToGiveToEachCell ].
	
	self lostOrReceivedQuantity: self lostOrReceivedQuantity - givenQuantity
	
]

{ #category : 'control' }
DifCell >> evaporate [
	"A part of the hormon evaporates"
	self quantity: ((self quantity - (self quantity * self class evaporationRate)) max: 0)

	
]

{ #category : 'initialization' }
DifCell >> initialize [

	super initialize.
	quantity := 0.
	lostOrReceivedQuantity := 0
]

{ #category : 'accessing' }
DifCell >> lostOrReceivedQuantity [

	^ lostOrReceivedQuantity
]

{ #category : 'accessing' }
DifCell >> lostOrReceivedQuantity: aQty [

	lostOrReceivedQuantity := aQty
]

{ #category : 'as yet unclassified' }
DifCell >> povHormones [

	<pov>
	^ CMPointOfView color: (CMColor
		colorValue: quantity
		min: 0
		max: 100
		color: Color green)
]

{ #category : 'accessing' }
DifCell >> quantity [

	^ quantity
]

{ #category : 'accessing' }
DifCell >> quantity: aNumber [

	quantity := aNumber
]

{ #category : 'control' }
DifCell >> updateQuantity [
	"lostOrReceivedQuantity is the buffer state for synchronous diffusion"
	self lostOrReceivedQuantity = 0 ifTrue: [ ^ self ].
	
	self quantity: (self quantity + self lostOrReceivedQuantity) asFloat.
	self lostOrReceivedQuantity: 0.
	
	self quantity < self class minimunQty ifTrue: [ self quantity: 0 ]

	
]
