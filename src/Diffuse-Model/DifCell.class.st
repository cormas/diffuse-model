Class {
	#name : 'DifCell',
	#superclass : 'CMCell',
	#instVars : [
		'qty',
		'lostOrReceivedQty'
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
	
	| qtyToGiveToEachCell givenQty |
	self qty > 0
		ifTrue:
			[qtyToGiveToEachCell := self qty * self class diffusionRate / self neighbourhood size.
			givenQty := 0.
			self neighbourhood do:
					[: neigh | givenQty := givenQty + qtyToGiveToEachCell.
					neigh lostOrReceivedQty: neigh lostOrReceivedQty + qtyToGiveToEachCell].
			self lostOrReceivedQty: self lostOrReceivedQty - givenQty]
	
]

{ #category : 'control' }
DifCell >> evaporate [
"A part of the hormon evaporates"
	self qty: ((self qty - (self qty * self class evaporationRate)) max: 0 )

	
]

{ #category : 'initialization' }
DifCell >> initialize [

	super initialize.
	qty := 0.
	lostOrReceivedQty := 0
]

{ #category : 'accessing' }
DifCell >> lostOrReceivedQty [

	^ lostOrReceivedQty
]

{ #category : 'accessing' }
DifCell >> lostOrReceivedQty: aQty [

	lostOrReceivedQty := aQty
]

{ #category : 'as yet unclassified' }
DifCell >> povHormones [

	<pov>
	^ CMPointOfView color: (self
			   colorAttribute: #qty
			   min: 0
			   max: 100
			   color: Color green)
]

{ #category : 'accessing' }
DifCell >> qty [

	^ qty
]

{ #category : 'accessing' }
DifCell >> qty: aNumber [

	qty := aNumber
]

{ #category : 'control' }
DifCell >> updateQty [
"lostOrReceivedQty is the buffer state for synchronous diffusion"
	self lostOrReceivedQty ~= 0 
		ifTrue: 
			[self qty: (self qty + self lostOrReceivedQty) asFloat.
			self lostOrReceivedQty: 0.
			self qty < self class minimunQty ifTrue: [self qty: 0]]

	
]
