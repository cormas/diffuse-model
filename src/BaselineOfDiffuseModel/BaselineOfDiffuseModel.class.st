Class {
	#name : #BaselineOfDiffuseModel,
	#superclass : #BaselineOf,
	#category : #BaselineOfDiffuseModel
}

{ #category : #baselines }
BaselineOfDiffuseModel >> baseline: spec [

	<baseline>
	spec for: #common do: [
		"Dependencies"
		self loadCormas: spec.

		"Packages"
		spec
			package: 'Diffuse-Model' with: [ spec requires: #(Cormas) ];
			package: 'Diffuse-Model-Tests' with: [ spec requires: #( 'Diffuse-Model' ) ] ]
]

{ #category : #dependencies }
BaselineOfDiffuseModel >> loadCormas: spec [

	spec
		baseline: 'Cormas'
		with: [ spec loads: #(Core); repository: 'github://cormas/cormas' ]
]
