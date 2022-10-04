Class {
	#name : #SindarinDebugger,
	#superclass : #Object,
	#traits : 'TDebugger',
	#classTraits : 'TDebugger classTrait',
	#instVars : [
		'process',
		'stepHooks',
		'sindarinSession',
		'blockToDebug'
	],
	#category : #'Sindarin-Base'
}

{ #category : #start }
SindarinDebugger class >> attachTo: arg1 [

	^ self new attachTo: arg1
]

{ #category : #actions }
SindarinDebugger class >> closeAllDebuggers [

	<script>
	self allInstances do: [ :arg1 | arg1 terminate ]
]

{ #category : #start }
SindarinDebugger class >> debug: arg1 [

	^ self new debug: arg1
]

{ #category : #'instance creation' }
SindarinDebugger class >> debugSession: arg1 [

	| tmp1 tmp2 tmp3 |
	tmp1 := self attachTo: arg1.
	tmp2 := arg1 exception.
	tmp3 := Smalltalk at: #SindarinPointcutException ifAbsent: [  ].
	tmp2 class == tmp3 ifFalse: [ 
		arg1
			resume;
			clear.
		^ self ].
	tmp1
		step;
		step.
	tmp2 script executeWith: tmp1.
	arg1
		resume;
		clear;
		terminate
]

{ #category : #'graphical debugger' }
SindarinDebugger >> activateAutoRefreshOfAttachedGraphicalDebugger [

	sindarinSession activateEventTriggering.
	self refreshAttachedGraphicalDebugger
]

{ #category : #'step hook' }
SindarinDebugger >> addStepHook: arg1 [

	stepHooks add: arg1
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> arguments [

	^ self context arguments
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> assignmentValue [

	self node isAssignment ifFalse: [ ^ nil ].
	^ self context at: self currentContextStackSize
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> assignmentVariableName [

	self node isAssignment ifFalse: [ ^ nil ].
	^ self node variable name
]

{ #category : #start }
SindarinDebugger >> attachTo: arg1 [

	sindarinSession := arg1 asSindarinDebugSession.
	process := arg1 interruptedProcess.
	sindarinSession deactivateEventTriggering
]

{ #category : #astAndAstMapping }
SindarinDebugger >> bestNodeFor: arg1 [

	^ self node methodNode bestNodeFor: arg1
]

{ #category : #stackAccess }
SindarinDebugger >> context [

	^ self debugSession interruptedContext
]

{ #category : #private }
SindarinDebugger >> contextIsAboutToSignalException: arg1 [

	| tmp1 |
	tmp1 := arg1 method methodNode bcToASTCache nodeForPC: arg1 pc.
	tmp1 isMessage ifFalse: [ ^ false ].
	tmp1 selector = #signal ifFalse: [ ^ false ].
	arg1 basicSize >= 1 ifFalse: [ ^ false ].
	(Exception allSubclasses includes: (arg1 at: arg1 basicSize)) 
		ifTrue: [ ^ true ].
	(Exception allSubclasses includes: (arg1 at: arg1 basicSize) class) 
		ifTrue: [ ^ true ].
	^ false
]

{ #category : #'stepping -  auto' }
SindarinDebugger >> continue [

	| tmp1 tmp2 tmp4 |
	self flag: 'Sorry, this is shit :)'.
	tmp4 := [ 
	        VirtualBreakpoint all
		        detect: [ :arg1 | arg1 hitTest: self node ]
		        ifFound: [ :arg2 | 
			        self removeStepHook: tmp4.
			        ^ arg2 ] ].
	self addStepHook: tmp4.
	[ 
	self isExecutionFinished or: [ 
		self contextIsAboutToSignalException: self context ] ] whileFalse: [ 
		self step ].
	self isExecutionFinished ifTrue: [ ^ nil ].
	tmp1 := self node.
	tmp2 := self context at: self context size - tmp1 arguments size.
	tmp2 == Halt ifTrue: [ 
		self
			skip;
			removeStepHook: tmp4.
		^ #halt ].
	tmp2 == Break ifTrue: [ 
		self
			skip;
			removeStepHook: tmp4.
		^ #breakpoint ]
]

{ #category : #accessing }
SindarinDebugger >> currentBytecode [

	^ self context method symbolicBytecodes
]

{ #category : #private }
SindarinDebugger >> currentContextStackSize [

	^ self context basicSize
]

{ #category : #process }
SindarinDebugger >> currentProcess [

	^ process
]

{ #category : #'graphical debugger' }
SindarinDebugger >> deactivateAutoRefreshOfAttachedGraphicalDebugger [

	sindarinSession deactivateEventTriggering
]

{ #category : #start }
SindarinDebugger >> debug: arg1 [

	blockToDebug := arg1.
	process := arg1 newProcess name:
		           'ExecutionDebuggedByScriptableDebugger'.
	sindarinSession := SindarinDebugSession
		                   newWithName: 'ScriptableDebuggerDebugSession'
		                   forProcess: process.
	sindarinSession deactivateEventTriggering.
	[ self context closure == blockToDebug ] whileFalse: [ self step ]
]

{ #category : #accessing }
SindarinDebugger >> debugSession [

	^ sindarinSession debugSession
]

{ #category : #'as yet unclassified' }
SindarinDebugger >> firstPCOfStatement: arg1 [

	^ self methodNode firstPCOfStatement: arg1
]

{ #category : #private }
SindarinDebugger >> hasSignalledUnhandledException [

	^ (#( #defaultAction #signal ) includes: self selector) and: [ 
		  self receiver isKindOf: Exception ]
]

{ #category : #initialization }
SindarinDebugger >> initialize [

	stepHooks := OrderedCollection new
]

{ #category : #private }
SindarinDebugger >> instanceCreationPrimitives [

	^ #( 70 71 79 148 160 )
]

{ #category : #'execution predicates' }
SindarinDebugger >> isAboutToInstantiateClass [

	| tmp1 |
	self node isMessage ifFalse: [ ^ false ].
	tmp1 := self receiver class lookupSelector: self node selector.
	^ tmp1 notNil and: [ 
		  self instanceCreationPrimitives includes: tmp1 primitive ]
]

{ #category : #private }
SindarinDebugger >> isAboutToSignalException [

	^ self node isMessage and: [ 
		  self messageSelector = #unhandledErrorDefaultAction: and: [ 
			  self messageReceiver isKindOf: UIManager ] ]
]

{ #category : #stackAccess }
SindarinDebugger >> isExecutionFinished [

	^ process isTerminated
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> message: arg1 [

	| tmp1 |
	tmp1 := self node.
	tmp1 isMessage ifFalse: [ ^ false ].
	tmp1 selector = arg1 ifFalse: [ ^ false ].
	^ true
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> message: arg1 to: arg2 [

	| tmp1 |
	tmp1 := self node.
	tmp1 isMessage ifFalse: [ ^ false ].
	tmp1 selector = arg1 ifFalse: [ ^ false ].
	self messageReceiver == arg2 ifFalse: [ ^ false ].
	^ true
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> message: arg1 toInstanceOf: arg2 [

	| tmp1 |
	tmp1 := self node.
	tmp1 isMessage ifFalse: [ ^ false ].
	tmp1 selector = arg1 ifFalse: [ ^ false ].
	(self messageReceiver isKindOf: arg2) ifFalse: [ ^ false ].
	^ true
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> messageArguments [

	| tmp1 tmp2 tmp3 |
	self node isMessage ifFalse: [ 
		Error signal: 'Not about to send a message' ].
	tmp1 := self node arguments size.
	tmp2 := OrderedCollection new.
	tmp3 := 0.
	[ tmp3 = tmp1 ] whileFalse: [ 
		tmp2 add:
			(self context at: self currentContextStackSize - tmp1 + tmp3 + 1).
		tmp3 := tmp3 + 1 ].
	^ tmp2
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> messageReceiver [

	self node isMessage ifFalse: [ 
		Error signal: 'Not about to send a message' ].
	^ self context at:
		  self currentContextStackSize - self node arguments size
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> messageSelector [

	self node isMessage ifFalse: [ 
		Error signal: 'Not about to send a message' ].
	^ self node selector
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> method [

	^ self context method
]

{ #category : #'accessing - method' }
SindarinDebugger >> methodNode [

	^ self method ast
]

{ #category : #'accessing - bytes' }
SindarinDebugger >> nextBytecode [

	^ self currentBytecode detect: [ :arg1 | 
		  arg1 offset = self context pc ]
]

{ #category : #astAndAstMapping }
SindarinDebugger >> node [

	^ self context method sourceNodeForPC: self context pc
]

{ #category : #astAndAstMapping }
SindarinDebugger >> nodeForContext: arg1 [

	^ arg1 method sourceNodeForPC: arg1 pc
]

{ #category : #'graphical debugger' }
SindarinDebugger >> openInGraphicalDebugger [

	sindarinSession canBeTerminated: false.
	self flag:
		'Should be an extension of DebuggerSelector and handled by its sole instance'
]

{ #category : #'accessing - context' }
SindarinDebugger >> outerMostContextOf: arg1 [

	| tmp1 tmp2 |
	tmp1 := arg1.
	tmp2 := nil.
	[ tmp1 ~= tmp2 ] whileTrue: [ 
		tmp2 := tmp1.
		tmp1 := tmp1 outerMostContext ].
	^ tmp1
]

{ #category : #accessing }
SindarinDebugger >> pc [

	^ self context pc
]

{ #category : #accessing }
SindarinDebugger >> pc: arg1 [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	(arg1 < self method initialPC or: [ arg1 > self method endPC ]) 
		ifTrue: [ ^ NotValidPcError signal ].
	tmp4 := self methodNode.
	tmp2 := tmp4 sourceNodeForPC: arg1.
	tmp1 := self statementNodeContaining: tmp2.
	tmp5 := self firstPCOfStatement: tmp1.
	tmp3 := tmp1 allChildren last.
	[ self context stackPtr > self context numTemps ] whileTrue: [ 
		self context pop ].
	self context pc: self method initialPC.
	self debugSession stepToFirstInterestingBytecodeIn:
		self debugSession interruptedProcess.
	self skipUpToNode: tmp2
]

{ #category : #'stepping -  auto' }
SindarinDebugger >> proceed [

	^ self continue
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> receiver [

	^ self context receiver
]

{ #category : #'graphical debugger' }
SindarinDebugger >> refreshAttachedGraphicalDebugger [

	sindarinSession refreshAttachedDebugger
]

{ #category : #'step hook' }
SindarinDebugger >> removeStepHook: arg1 [

	stepHooks remove: arg1
]

{ #category : #stackAccess }
SindarinDebugger >> restart [

	self
		initialize;
		debug: blockToDebug
]

{ #category : #'stepping -  auto' }
SindarinDebugger >> resume [

	sindarinSession resumeAndClear
]

{ #category : #scripts }
SindarinDebugger >> run: arg1 [

	arg1 executeWith: self
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> selector [

	^ self context selector
]

{ #category : #breakpoints }
SindarinDebugger >> setBreakpoint [

	^ self setBreakpointOn: self node
]

{ #category : #breakpoints }
SindarinDebugger >> setBreakpointOn: arg1 [

	| tmp1 |
	tmp1 := arg1.
	(arg1 isKindOf: CompiledMethod) ifTrue: [ tmp1 := arg1 ast ].
	^ VirtualBreakpoint newOnNode: tmp1 setBy: self
]

{ #category : #asserting }
SindarinDebugger >> shouldStepIntoInMethod: arg1 [

	| tmp1 tmp2 |
	tmp1 := self node.
	tmp1 isMessage ifFalse: [ ^ false ].
	tmp2 := tmp1 children.
	tmp2 := tmp2
		        select: [ :arg2 | 
			        arg2 isBlock or: [ 
				        arg2 isVariable and: [ 
					        (arg2 variableValueInContext: self context) isBlock ] ] ]
		        thenCollect: [ :arg3 | 
			        arg3 isVariable ifTrue: [ 
				        (arg3 variableValueInContext: self context)
					        startpcOrOuterCode ast ] ].
	^ tmp2 anySatisfy: [ :arg4 | 
		  (RBBlockDefinitionSearchingVisitor newToSearch: arg4) visitNode:
			  arg1 ]
]

{ #category : #private }
SindarinDebugger >> signalExceptionIfDebuggedExecutionHasSignalledUnhandledException [

	| tmp1 |
	self hasSignalledUnhandledException ifTrue: [ 
		tmp1 := self receiver.
		UnhandledExceptionSignalledByADebuggedExecution 
			signalWithException: tmp1 ]
]

{ #category : #private }
SindarinDebugger >> signalExceptionIfDebuggedExecutionIsFinished [

	self isExecutionFinished ifTrue: [ 
		DebuggedExecutionIsFinished signal ]
]

{ #category : #accessing }
SindarinDebugger >> sindarinSession: arg1 [

	sindarinSession := arg1
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skip [

	| tmp1 |
	self node isAssignment ifTrue: [ ^ self skipAssignmentNodeCompletely ].
	self node isMessage ifTrue: [ ^ self skipMessageNode ].
	self node isMethod ifTrue: [ ^ self step ].
	self node isBlock ifTrue: [ self skipBlockNode ].
	tmp1 := self currentBytecode detect: [ :arg1 | arg1 offset = self pc ].
	(self node isReturn or: [ tmp1 bytes first between: 88 and: 94 ]) 
		ifTrue: [ ^ self skipReturnNode ].
	self node isSequence ifTrue: [ ^ self step ].
	self skipWith: nil
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipAssignmentNodeCompletely [

	| tmp1 |
	tmp1 := self currentBytecode detect: [ :arg1 | 
		        arg1 offset = self context pc ].
	self context pop.
	(#( 243 244 245 252 ) includes: tmp1 bytes first) ifTrue: [ 
		self context push:
			(self node variable variableValueInContext: self context) ].
	self context pc: self context pc + tmp1 bytes size.
	self debugSession stepToFirstInterestingBytecodeIn:
		self debugSession interruptedProcess
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipAssignmentNodeWith: arg1 [

	self context
		pop;
		push: arg1.
	self step.
	self debugSession stepToFirstInterestingBytecodeIn:
		self debugSession interruptedProcess
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipBlockNode [

	| tmp1 |
	tmp1 := self currentBytecode detect: [ :arg1 | arg1 offset = self pc ].
	self context
		pc: self pc + tmp1 bytes size;
		push: nil
]

{ #category : #'stepping - skip' }
SindarinDebugger >> skipMessageNode [

	self node arguments do: [ :arg1 | self context pop ].
	self context pc: self context pc + self nextBytecode bytes size.
	self debugSession stepToFirstInterestingBytecodeIn:
		self debugSession interruptedProcess
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipMessageNodeWith: arg1 [

	self node arguments do: [ :arg2 | self context pop ].
	self context
		pop;
		push: arg1;
		pc: self context pc + self nextBytecode bytes size.
	self debugSession stepToFirstInterestingBytecodeIn:
		self debugSession interruptedProcess
]

{ #category : #'stepping - skip' }
SindarinDebugger >> skipReturnNode [

	^ SindarinSkippingReturnWarning signal: 'Cannot skip a return node'
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipThroughNode: arg1 [

	self skipUpToNode: arg1 skipTargetNode: true
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipToPC: arg1 [

	[ self pc >= arg1 ] whileFalse: [ self skip ]
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipUpToNode: arg1 [

	self skipUpToNode: arg1 skipTargetNode: false
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipUpToNode: arg1 skipTargetNode: arg2 [

	[ [ self node == arg1 ] whileFalse: [ self skip ] ]
		on: SindarinSkippingReturnWarning
		do: [ ^ self ].
	arg1 isReturn ifTrue: [ ^ self ].
	arg2 ifTrue: [ self skip ]
]

{ #category : #'stepping -  skip' }
SindarinDebugger >> skipWith: arg1 [

	(self node isMessage not and: [ self node isAssignment not ]) 
		ifTrue: [ ^ self ].
	self node isMessage ifTrue: [ ^ self skipMessageNodeWith: arg1 ].
	self node isAssignment ifTrue: [ ^ self skipAssignmentNodeWith: arg1 ]
]

{ #category : #stackAccess }
SindarinDebugger >> stack [

	^ self debugSession stack
]

{ #category : #API }
SindarinDebugger >> statementNodeContaining: arg1 [

	^ self methodNode statementNodeContaining: arg1
]

{ #category : #'stepping - steps' }
SindarinDebugger >> step [

	self
		signalExceptionIfDebuggedExecutionHasSignalledUnhandledException;
		signalExceptionIfDebuggedExecutionIsFinished.
	self debugSession stepInto.
	stepHooks do: [ :arg1 | arg1 value ]
]

{ #category : #'stepping - steps' }
SindarinDebugger >> step: arg1 [

	arg1 timesRepeat: [ self step ]
]

{ #category : #'stepping - echo' }
SindarinDebugger >> stepBatchAndReturnNodeHashAndStackSize [

	| tmp1 tmp3 |
	tmp3 := 0.
	tmp1 := OrderedCollection new.
	[ 
	[ tmp3 <= 1000 ] whileTrue: [ 
		tmp3 := tmp3 + 1.
		tmp1 add: { 
				self node dictionaryRepresentation hash.
				self stack size }.
		self step ] ]
		on: DebuggedExecutionException
		do: [ ^ tmp1 ].
	^ tmp1
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepBytecode [

	self
		flag: 'Needs to be tested';
		signalExceptionIfDebuggedExecutionHasSignalledUnhandledException.
	process completeStep: self debugSession context.
	self debugSession updateContextTo: process suspendedContext
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepOver [

	| tmp1 |
	tmp1 := self context.
	self step.
	[ 
	self context == tmp1 or: [ 
		(tmp1 isDead or: [ self context isDead ]) or: [ 
			tmp1 hasSender: self context ] ] ] whileFalse: [ self step ]
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepOver: arg1 [

	arg1 timesRepeat: [ self stepOver ]
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepThrough [

	self signalExceptionIfDebuggedExecutionHasSignalledUnhandledException.
	self debugSession stepThrough.
	stepHooks do: [ :arg1 | arg1 value ]
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepToMethodEntry [

	self stepUntil: [ self context instructionStream willSend ].
	process step: self context.
	self debugSession updateContextTo: process suspendedContext
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepToReturn [

	| tmp1 tmp2 |
	tmp1 := self outerMostContextOf: self context.
	tmp2 := self context method ast.
	[ 
	((self outerMostContextOf: self context) = tmp1 and: [ 
		 self context instructionStream willReturn ]) or: [ 
		self hasSignalledUnhandledException ] ] whileFalse: [ 
		(self shouldStepIntoInMethod: tmp2)
			ifTrue: [ self debugSession stepInto ]
			ifFalse: [ self debugSession stepOver ] ]
]

{ #category : #'stepping - steps' }
SindarinDebugger >> stepUntil: arg1 [

	arg1 whileFalse: [ self step ]
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> temporaryNamed: arg1 [

	^ self context tempNamed: arg1
]

{ #category : #process }
SindarinDebugger >> terminate [

	sindarinSession terminate
]

{ #category : #stackAccessHelpers }
SindarinDebugger >> topStack [

	^ self context top
]
