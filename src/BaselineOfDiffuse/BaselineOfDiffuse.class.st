Class {
	#name : 'BaselineOfDiffuse',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfDiffuse',
	#package : 'BaselineOfDiffuse'
}

{ #category : 'as yet unclassified' }
BaselineOfDiffuse >> baseline: spec [
	<baseline>
	spec for: #common do: [
		spec
			package: 'Diffuse-Model';
		
			package: 'Diffuse-Model-Tests'
			with: [ spec requires: #('Diffuse-Model') ] ].
]
