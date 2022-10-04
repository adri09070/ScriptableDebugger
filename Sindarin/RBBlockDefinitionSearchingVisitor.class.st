Class {
	#name : #RBBlockDefinitionSearchingVisitor,
	#superclass : #RBProgramNodeVisitor,
	#instVars : [
		'blockToSearch',
		'isBlockFound'
	],
	#category : #Sindarin
}

{ #category : #'instance creation' }
RBBlockDefinitionSearchingVisitor class >> newToSearch: arg1 [

	| tmp2 |
	tmp2 := self new.
	tmp2 blockToSearch: arg1.
	^ tmp2 yourself
]

{ #category : #accessing }
RBBlockDefinitionSearchingVisitor >> blockToSearch: arg1 [

	blockToSearch := arg1.
	isBlockFound := false
]

{ #category : #initialization }
RBBlockDefinitionSearchingVisitor >> initialize [

	isBlockFound := false
]

{ #category : #accessing }
RBBlockDefinitionSearchingVisitor >> isBlockFound [

	^ isBlockFound
]

{ #category : #visiting }
RBBlockDefinitionSearchingVisitor >> visitNode: arg1 [

	super visitNode: arg1.
	arg1 = blockToSearch ifTrue: [ isBlockFound := true ].
	^ isBlockFound
]
