Class {
	#name : #DiffuseCellTest,
	#superclass : #TestCase,
	#category : #'Diffuse-Model-Tests'
}

{ #category : #tests }
DiffuseCellTest >> testEntityName [

	self assert: DiffuseCell entityName equals: 'Cell'
]
