Class {
	#name : 'DifAnt',
	#superclass : 'CMAgent',
	#classInstVars : [
		'depositQty'
	],
	#category : 'Diffuse-Model',
	#package : 'Diffuse-Model'
}

{ #category : 'accessing' }
DifAnt class >> depositQty [
	<parameterIntegerMin: 0 max: 300 default: 150>
	^ depositQty
]

{ #category : 'accessing' }
DifAnt class >> depositQty: anObject [

	depositQty := anObject
]

{ #category : 'control' }
DifAnt >> depositPheromone [
	"The ant deposites 150 units of pheromones on the ground "

	self cell quantity: self cell quantity + self class depositQty
]

{ #category : 'accessing' }
DifAnt >> pov [

	<pov>
	^ (CMPointOfView shape: #star size: 0.8) color: Color red;
		  yourself
]

{ #category : 'control' }
DifAnt >> step [
	" the ant moves randomly and deposits pheromone."

	self randomWalk: 2.
	self depositPheromone
]

{ #category : 'control' }
DifAnt >> stepJump [
	" the ant moves randomly and deposits pheromone. But if the hormone qty is too elevated, it jumps randomly"

	self strongSmell
		ifTrue: [ self randomJump ]
		ifFalse: [ self randomWalk: 2 ].
	self depositPheromone
]

{ #category : 'testing' }
DifAnt >> strongSmell [
	"answer if the local pheromones are too strong (over 100 units)"

	^ self cell quantity > 100
]
