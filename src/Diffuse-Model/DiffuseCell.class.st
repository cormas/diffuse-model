"
I'm a Cell in Diffuse model
"
Class {
	#name : #DiffuseCell,
	#superclass : #CMSpatialEntityElement,
	#instVars : [
		'qty',
		'lostOrReceivedQty'
	],
	#classVars : [
		'CurrentId'
	],
	#classInstVars : [
		'minimunState',
		'diffusionRate',
		'evaporationRate',
		'scheduler'
	],
	#category : #'Diffuse-Model'
}

{ #category : #id }
DiffuseCell class >> CurrentId [
	^ CurrentId isNil
		ifTrue: [ 0 ]
		ifFalse: [ CurrentId ]
]

{ #category : #id }
DiffuseCell class >> CurrentId: arg1 [
	^ CurrentId := arg1
]

{ #category : #accessing }
DiffuseCell class >> diffusionRate [
	diffusionRate isNil
		ifTrue: [ diffusionRate := 0.5 ].
	^ diffusionRate
]

{ #category : #accessing }
DiffuseCell class >> diffusionRate: arg1 [
	diffusionRate := arg1
]

{ #category : #'default value' }
DiffuseCell class >> diffusionRate_default [
	^ 0.5
]

{ #category : #accessing }
DiffuseCell class >> entityName [

	^ 'Cell'
]

{ #category : #accessing }
DiffuseCell class >> evaporationRate [
	evaporationRate isNil
		ifTrue: [ evaporationRate := 0.1 ].
	^ evaporationRate
]

{ #category : #accessing }
DiffuseCell class >> evaporationRate: arg1 [
	evaporationRate := arg1
]

{ #category : #'default value' }
DiffuseCell class >> evaporationRate_default [
	^ 0.1
]

{ #category : #testing }
DiffuseCell class >> isAbstract [
	^ false
]

{ #category : #'default value' }
DiffuseCell class >> lostOrReceivedQty_default [
	^ 0
]

{ #category : #accessing }
DiffuseCell class >> minimunState [
	minimunState isNil
		ifTrue: [ minimunState := 1 ].
	^ minimunState
]

{ #category : #accessing }
DiffuseCell class >> minimunState: arg1 [
	minimunState := arg1
]

{ #category : #'default value' }
DiffuseCell class >> minimunState_default [
	^ 1
]

{ #category : #'default value' }
DiffuseCell class >> qty_default [
	^ 0
]

{ #category : #accessing }
DiffuseCell class >> scheduler [
	^ scheduler
]

{ #category : #accessing }
DiffuseCell class >> scheduler: arg1 [
	scheduler := arg1
]

{ #category : #'default value' }
DiffuseCell class >> scheduler_default [
	^ nil
]

{ #category : #control }
DiffuseCell >> connexity [
	self spaceModel nbNeighbours = 8
		ifTrue: [ ^ 8 ].
	self spaceModel nbNeighbours = 4
		ifTrue: [ ^ 4 ].
	self spaceModel nbNeighbours = 6
		ifTrue: [ ^ 6 ]
]

{ #category : #control }
DiffuseCell >> diffuse [
	| tmp1 tmp3 |
	self qty > 0
		ifTrue: [ tmp1 := self qty * DiffuseCell diffusionRate / self connexity.
			tmp3 := 0.
			self neighbourhood
				do: [ :arg1 | 
					tmp3 := tmp3 + tmp1.
					arg1 lostOrReceivedQty: arg1 lostOrReceivedQty + tmp1 ].
			self lostOrReceivedQty: self lostOrReceivedQty - tmp3 ]
]

{ #category : #control }
DiffuseCell >> diffuse2 [
	| tmp1 |
	self qty > 0
		ifTrue: [ tmp1 := self qty * DiffuseCell diffusionRate
				/ self neighbourhood size.
			self neighbourhood
				do: [ :arg1 | arg1 lostOrReceivedQty: arg1 lostOrReceivedQty + tmp1 ].
			self
				lostOrReceivedQty: self lostOrReceivedQty - (self qty * DiffuseCell diffusionRate) ]
]

{ #category : #control }
DiffuseCell >> evaporate [
	self
		qty: (self qty - (self qty * DiffuseCell evaporationRate) max: 0)
]

{ #category : #info }
DiffuseCell >> info_Qty [
	^ self qty
]

{ #category : #init }
DiffuseCell >> initEmpty [
	self
		qty: 0;
		lostOrReceivedQty: self qty
]

{ #category : #init }
DiffuseCell >> initId [
	self id: (self class CurrentId: self class CurrentId + 1)
]

{ #category : #accessing }
DiffuseCell >> lostOrReceivedQty [
	lostOrReceivedQty isNil
		ifTrue: [ lostOrReceivedQty := 0 ].
	^ lostOrReceivedQty
]

{ #category : #accessing }
DiffuseCell >> lostOrReceivedQty: arg1 [
	lostOrReceivedQty := arg1.
	DiffuseCell scheduler newActiveCells add: self
]

{ #category : #manipulation }
DiffuseCell >> methodsForManipulation [
	^ #('diffuse' 'evaporate' 'initEmpty')
]

{ #category : #pov }
DiffuseCell >> pov [
	^ self
		povAttribute: #qty
		min: 0
		max: 100
		color: Color green
]

{ #category : #accessing }
DiffuseCell >> qty [
	qty isNil
		ifTrue: [ qty := 0 ].
	^ qty
]

{ #category : #accessing }
DiffuseCell >> qty: aNumber [

	aNumber > 0
		ifTrue: [ DiffuseCell scheduler newActiveCells add: self ]
		ifFalse: [ DiffuseCell scheduler noMoreActiveCells add: self ].

]

{ #category : #control }
DiffuseCell >> updateState [
	self lostOrReceivedQty ~= 0
		ifTrue: [ self
				qty: (self qty + self lostOrReceivedQty) asFloat;
				lostOrReceivedQty: 0.
			self qty < DiffuseCell minimunState
				ifTrue: [ self qty: 0 ] ]
]
