Extension { #name : #RBMethodNode }

{ #category : #'*Sindarin' }
RBMethodNode >> firstPCOfStatement: arg1 [

	| tmp1 tmp2 tmp3 |
	tmp1 := self statements identityIndexOf: arg1.
	tmp1 == 1 ifTrue: [ ^ self compiledMethod initialPC ].
	tmp2 := self statements at: tmp1 - 1.
	tmp3 := self lastPcForNode: tmp2.
	^ self bcToASTCache bcToASTMap sorted detect: [ :arg2 | arg2 > tmp3 ]
]

{ #category : #'*Sindarin' }
RBMethodNode >> parentOfIdenticalSubtree: arg1 [

	^ self allChildren reversed
		  detect: [ :arg2 | arg2 == arg1 ]
		  ifFound: [ :arg3 | arg3 parent ]
		  ifNone: [  ]
]

{ #category : #'*Sindarin' }
RBMethodNode >> statementNodeContaining: arg1 [

	| tmp1 tmp2 |
	tmp1 := arg1.
	tmp2 := self parentOfIdenticalSubtree: tmp1.
	tmp2 ifNil: [ ^ NodeNotInASTError signal ].
	[ tmp2 isSequence ] whileFalse: [ 
		tmp1 := tmp2.
		tmp2 := tmp2 parent ].
	^ tmp1
]
