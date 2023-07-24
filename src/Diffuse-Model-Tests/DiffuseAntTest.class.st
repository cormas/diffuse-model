Class {
	#name : #DiffuseAntTest,
	#superclass : #TestCase,
	#category : #'Diffuse-Model-Tests'
}

{ #category : #tests }
DiffuseAntTest >> testEntityName [

	self assert: DiffuseAnt entityName equals: 'Ant'
]
