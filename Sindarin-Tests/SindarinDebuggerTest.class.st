Class {
	#name : #SindarinDebuggerTest,
	#superclass : #TestCase,
	#instVars : [
		'breakpointsBeforeTest',
		'testObjectPoint'
	],
	#classInstVars : [
		'helperMethod1'
	],
	#category : #'Sindarin-Tests-Base'
}

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod1 [

	| tmp1 |
	tmp1 := 1.
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod10 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod11 [

	| tmp1 |
	tmp1 := 5.
	self
		helperMethod12;
		helperMethod12.
	^ 3
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod12 [

	| tmp1 |
	tmp1 := 5.
	[ tmp1 = 0 ] whileFalse: [ tmp1 := tmp1 - 1 ]
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod13 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod14 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod15 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod16 [

	^ 1 + 1
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod17: arg1 [

	arg1 value: thisContext.
	Point x: 5 y: 7
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod18: arg1 with: arg2 [

	Point x: 5 y: 7
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod19 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod2 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod20 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod21 [

	self helperMethod22
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod22 [

	^ Point new
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod23 [

	testObjectPoint
		sign;
		extent: (Point x: 3 y: 4).
	Point new
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod24 [

	| tmp1 |
	tmp1 := Point new.
	tmp1 sign
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod3 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod4 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod5 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod6 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod7 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod8 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethod9 [

	| tmp1 |
	tmp1 := 5.
	^ Point x: 5 y: '3' asInteger
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethodNonLocalReturn [

	| tmp1 |
	tmp1 := [ ^ 42 ].
	tmp1 value.
	^ 43
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethodReturn: arg1 [

	| tmp1 |
	tmp1 := arg1.
	tmp1 ifTrue: [ ^ 1 ].
	^ 2
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethodReturnWithException [

	| tmp1 |
	tmp1 := 0.
	1 / 0.
	^ tmp1 + 1
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethodReturnWithHalt [

	<haltOrBreakpointForTesting>
	| tmp1 |
	tmp1 := 0.
	self halt.
	^ tmp1 + 1
]

{ #category : #helpers }
SindarinDebuggerTest >> helperMethodWithBlockWithNoReturn [

	| tmp1 tmp3 |
	tmp1 := [ tmp3 := 1 ].
	tmp1 value.
	^ 43
]

{ #category : #running }
SindarinDebuggerTest >> runCaseManaged [

	^ self runCase
]

{ #category : #running }
SindarinDebuggerTest >> setUp [

	super setUp.
	breakpointsBeforeTest := VirtualBreakpoint all.
	VirtualBreakpoint all removeAll.
	testObjectPoint := Point x: 1 y: 2
]

{ #category : #running }
SindarinDebuggerTest >> tearDown [

	VirtualBreakpoint all removeAll.
	breakpointsBeforeTest do: [ :arg1 | VirtualBreakpoint all add: arg1 ].
	super tearDown
]

{ #category : #tests }
SindarinDebuggerTest >> testAddStepHook [

	| tmp1 tmp2 tmp4 |
	tmp2 := SindarinDebugger debug: [ self helperMethod11 ].
	tmp4 := 0.
	tmp1 := [ tmp4 := tmp4 + 1 ].
	tmp2
		addStepHook: tmp1;
		step.
	self assert: tmp4 equals: 1.
	tmp2
		step;
		stepOver.
	self assert: tmp4 equals: 21.
	tmp2
		removeStepHook: tmp1;
		stepOver.
	self assert: tmp4 equals: 21
]

{ #category : #tests }
SindarinDebuggerTest >> testArguments [

	| tmp1 tmp2 |
	tmp1 := Point new.
	tmp2 := SindarinDebugger debug: [ self helperMethod18: 1 with: tmp1 ].
	tmp2 step.
	self
		assert: tmp2 arguments size equals: 2;
		assert: (tmp2 arguments at: 1) equals: 1;
		assert: (tmp2 arguments at: 2) equals: tmp1
]

{ #category : #tests }
SindarinDebuggerTest >> testAssignmentValue [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod2 ].
	tmp1 step.
	self assert: tmp1 assignmentValue equals: 5
]

{ #category : #tests }
SindarinDebuggerTest >> testAssignmentVariableName [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod3 ].
	tmp1 step.
	self assert: tmp1 assignmentVariableName equals: #a
]

{ #category : #tests }
SindarinDebuggerTest >> testChangingPcKeepsSameStateAndPushesCorrectElementsOnStack [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		stepOver.
	tmp3 := tmp1 node.
	tmp2 := tmp1 pc.
	tmp4 := tmp1 topStack.
	tmp1
		stepOver;
		stepOver.
	self assert: (tmp1 temporaryNamed: #a) equals: 5.
	tmp1 pc: tmp2.
	self
		assert: (tmp1 temporaryNamed: #a) equals: 5;
		assert: tmp1 node equals: tmp3;
		assert: tmp1 pc equals: tmp2;
		assert: tmp1 topStack equals: tmp4
]

{ #category : #tests }
SindarinDebuggerTest >> testChangingPcRaisesErrorWhenPcIsGreaterThanEndPC [

	| tmp1 tmp3 |
	tmp3 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp3
		step;
		stepOver;
		stepOver.
	tmp1 := tmp3 pc.
	self
		shouldnt: [ tmp3 pc: tmp3 method endPC ] raise: NotValidPcError;
		deny: tmp3 pc equals: tmp1.
	tmp3 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp3
		step;
		stepOver;
		stepOver.
	tmp1 := tmp3 pc.
	self
		assert: tmp3 pc equals: tmp1;
		should: [ tmp3 pc: tmp3 method endPC + 1 ] raise: NotValidPcError
]

{ #category : #tests }
SindarinDebuggerTest >> testChangingPcRaisesErrorWhenPcIsLowerThanInitialPC [

	| tmp1 tmp3 |
	tmp3 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp3
		step;
		stepOver;
		stepOver.
	tmp1 := tmp3 pc.
	self
		shouldnt: [ tmp3 pc: tmp3 method initialPC ] raise: NotValidPcError;
		deny: tmp3 pc equals: tmp1.
	tmp3 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp3
		step;
		stepOver;
		stepOver.
	tmp1 := tmp3 pc.
	self
		assert: tmp3 pc equals: tmp1;
		should: [ tmp3 pc: tmp3 method initialPC - 1 ]
		raise: NotValidPcError
]

{ #category : #tests }
SindarinDebuggerTest >> testContext [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod15 ].
	self
		assert: tmp1 context
		equals: tmp1 debugSession interruptedContext.
	tmp1 step.
	self
		assert: tmp1 context
		equals: tmp1 debugSession interruptedContext
]

{ #category : #tests }
SindarinDebuggerTest >> testContinue [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp1
		step;
		step.
	self
		assert: tmp1 node isMessage;
		assert: tmp1 node selector equals: #asInteger.
	tmp1 setBreakpoint.
	tmp1 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp1 continue.
	self
		assert: tmp1 node isMessage;
		assert: tmp1 node selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTest >> testContinueUntilTheEnd [

	| tmp1 tmp3 |
	self flag: 'What is "setup code for the timeout?'.
	tmp1 := Semaphore new.
	[ 
	tmp3 := SindarinDebugger debug: [ self helperMethod20 ].
	tmp3 continue.
	self assert: tmp3 isExecutionFinished.
	tmp1 signal ] fork.
	tmp1
		wait: 5 seconds
		onCompletion: [ 'success' ]
		onTimeout: [ self assert: false description: 'Test timed out' ]
]

{ #category : #'tests - execution predicates' }
SindarinDebuggerTest >> testIsAboutToInstantiateClass [

	| tmp1 tmp2 |
	tmp1 := SindarinDebugger new.
	tmp2 := SindarinDebugSessionMock new.
	tmp1 sindarinSession: tmp2.
	tmp2 isMessage: false.
	self deny: tmp1 isAboutToInstantiateClass.
	tmp2
		isMessage: true;
		receiver: Object new;
		selector: #yourself.
	self deny: tmp1 isAboutToInstantiateClass.
	tmp2
		receiver: Object new;
		selector: #toto.
	self deny: tmp1 isAboutToInstantiateClass.
	tmp2
		receiver: Behavior new;
		selector: #basicNew.
	self assert: tmp1 isAboutToInstantiateClass.
	tmp2 selector: #basicNew:.
	self assert: tmp1 isAboutToInstantiateClass.
	tmp2 selector: #adoptInstance:.
	self assert: tmp1 isAboutToInstantiateClass.
	tmp2
		receiver: Object new;
		selector: #clone.
	self assert: tmp1 isAboutToInstantiateClass.
	tmp2
		receiver: CompiledCode;
		selector: #newMethod:header:.
	self assert: tmp1 isAboutToInstantiateClass
]

{ #category : #tests }
SindarinDebuggerTest >> testIsExecutionFinished [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethod16 ].
	self deny: tmp1 isExecutionFinished.
	[ tmp1 isExecutionFinished ] whileFalse: [ tmp1 stepOver ].
	self assert: tmp1 currentProcess isTerminated
]

{ #category : #tests }
SindarinDebuggerTest >> testMessageArguments [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod4 ].
	tmp1
		step;
		step.
	self assert: tmp1 messageArguments isEmpty.
	tmp1 stepOver.
	self
		assert: (tmp1 messageArguments at: 1) equals: 5;
		assert: (tmp1 messageArguments at: 2) equals: 3
]

{ #category : #tests }
SindarinDebuggerTest >> testMessageReceiver [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod5 ].
	self assert: tmp1 messageReceiver equals: self.
	tmp1
		step;
		step.
	self assert: tmp1 messageReceiver equals: '3'
]

{ #category : #tests }
SindarinDebuggerTest >> testMessageSelector [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod6 ].
	self assert: tmp1 messageSelector equals: #helperMethod6.
	tmp1
		step;
		step.
	self assert: tmp1 messageSelector equals: #asInteger.
	tmp1 stepOver.
	self assert: tmp1 messageSelector equals: #x:y:
]

{ #category : #tests }
SindarinDebuggerTest >> testMessageTo [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod23 ].
	tmp1 step.
	self assert: (tmp1 message: #sign to: testObjectPoint).
	tmp1
		stepOver;
		stepOver.
	self
		assert: (tmp1 message: #extent: to: testObjectPoint);
		deny: (tmp1 message: #bogus to: testObjectPoint);
		deny: (tmp1 message: #extent: to: Point new)
]

{ #category : #tests }
SindarinDebuggerTest >> testMessageToInstanceOf [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod24 ].
	tmp1
		step;
		stepOver: 2.
	self
		assert: (tmp1 message: #sign toInstanceOf: Point);
		assert: (tmp1 message: #sign toInstanceOf: Object);
		deny: (tmp1 message: #sign toInstanceOf: Rectangle);
		deny: (tmp1 message: #bogus toInstanceOf: Point)
]

{ #category : #tests }
SindarinDebuggerTest >> testMethod [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod7 ].
	self assert: tmp1 method equals: [ self helperMethod7 ] method.
	tmp1 step.
	self
		assert: tmp1 method
		equals: SindarinDebuggerTest >> #helperMethod7.
	tmp1
		step;
		step.
	self assert: tmp1 method equals: String >> #asInteger
]

{ #category : #tests }
SindarinDebuggerTest >> testNode [

	| tmp1 tmp2 |
	tmp2 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1 := tmp2 node.
	self
		assert: tmp1 isMessage;
		assert: tmp1 selector equals: #helperMethod1.
	tmp2 step.
	tmp1 := tmp2 node.
	self
		assert: tmp1 isAssignment;
		assert: tmp1 variable name equals: #a.
	tmp2
		stepOver;
		stepOver.
	tmp1 := tmp2 node.
	self
		assert: tmp1 isMessage;
		assert: tmp1 selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTest >> testOnceBreakpoint [

	| tmp1 tmp2 |
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2
		step;
		step.
	self
		assert: tmp2 node isMessage;
		assert: tmp2 node selector equals: #asInteger.
	tmp1 := tmp2 setBreakpoint.
	tmp1 once.
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2 continue.
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2 continue.
	self assert: tmp2 isExecutionFinished
]

{ #category : #tests }
SindarinDebuggerTest >> testPc [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ 
		        | tmp2 tmp3 |
		        tmp2 := 2.
		        tmp3 := Point x: 2 y: 3 ].
	tmp1
		step;
		step;
		step.
	self assert: tmp1 pc equals: tmp1 context pc
]

{ #category : #tests }
SindarinDebuggerTest >> testReceiver [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod8 ].
	self assert: tmp1 receiver equals: self.
	tmp1 step.
	self assert: tmp1 receiver equals: self.
	tmp1
		step;
		step.
	self assert: tmp1 receiver equals: '3'
]

{ #category : #tests }
SindarinDebuggerTest >> testRemoveBreakpoint [

	| tmp1 tmp2 |
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2
		step;
		step.
	self
		assert: tmp2 node isMessage;
		assert: tmp2 node selector equals: #asInteger.
	tmp1 := tmp2 setBreakpoint.
	tmp1 remove.
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2 continue.
	self assert: tmp2 isExecutionFinished
]

{ #category : #tests }
SindarinDebuggerTest >> testSelector [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod9 ].
	self assert: tmp1 selector equals: #testSelector.
	tmp1 step.
	self assert: tmp1 selector equals: #helperMethod9.
	tmp1
		step;
		step.
	self assert: tmp1 selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTest >> testSetBreakpoint [

	self
		flag: 'What is this test?';
		testContinue
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testSkip [

	| tmp1 tmp3 tmp4 |
	tmp3 := 1.
	tmp1 := SindarinDebugger debug: [ 
		        tmp3 := 2.
		        tmp4 := Point x: 2 y: 3 ].
	tmp1 skip.
	self assert: tmp3 equals: 1.
	tmp1
		skip;
		step.
	self assert: tmp4 equals: Point
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testSkipAssignmentWithStoreIntoBytecodePushesReplacementValueButNotWithPopIntoBytecode [

	| tmp1 tmp2 tmp3 tmp5 tmp6 |
	tmp1 := SindarinDebugger debug: [ 
		        tmp6 := 1.
		        [ 
		        tmp5 := 2.
		        tmp5 := tmp6 := 3 + 4 ] value.
		        ^ 42 ].
	tmp1
		step;
		step;
		stepThrough;
		skip.
	self
		assert: tmp1 topStack equals: 4;
		assert: tmp5 equals: nil.
	tmp3 := tmp6.
	tmp1
		step;
		skip.
	self
		assert: tmp1 topStack equals: tmp3;
		assert: tmp6 equals: tmp3.
	tmp2 := tmp5.
	tmp1 skip.
	self
		assert: tmp1 topStack equals: tmp2;
		assert: tmp5 equals: tmp2
]

{ #category : #tests }
SindarinDebuggerTest >> testSkipBlockNode [

	| tmp1 tmp3 |
	tmp3 := SindarinDebugger debug: [ self helperMethodNonLocalReturn ].
	tmp3
		step;
		step.
	self assert: tmp3 topStack isBlock.
	tmp3 stepUntil: [ 
		tmp3 node isMessage and: [ tmp3 messageSelector = #value ] ].
	tmp1 := tmp3 context sender.
	tmp3 stepOver.
	self
		assert: tmp3 context identicalTo: tmp1;
		assert: tmp3 topStack equals: 42.
	tmp3 := SindarinDebugger debug: [ self helperMethodNonLocalReturn ].
	tmp3
		step;
		skip.
	self assert: tmp3 topStack isNil.
	tmp3 stepUntil: [ 
		tmp3 node isMessage and: [ tmp3 messageSelector = #value ] ].
	tmp1 := tmp3 context.
	tmp3 stepOver.
	self
		assert: tmp3 context identicalTo: tmp1;
		assert: tmp3 topStack equals: 43
]

{ #category : #tests }
SindarinDebuggerTest >> testSkipDoesNotSkipReturn [

	| tmp1 tmp3 |
	tmp1 := SindarinDebugger debug: [ 
		        tmp3 := 1.
		        ^ 42 ].
	self
		shouldnt: [ tmp1 skip ] raise: SindarinSkippingReturnWarning;
		should: [ tmp1 skip ] raise: SindarinSkippingReturnWarning
]

{ #category : #tests }
SindarinDebuggerTest >> testSkipSkipsMessagesByPuttingReceiverOnStack [

	| tmp1 tmp3 |
	tmp3 := 1.
	tmp1 := SindarinDebugger debug: [ tmp3 := tmp3 + 2 ].
	self assert: tmp3 equals: 1.
	tmp1
		skip;
		step.
	self assert: tmp3 equals: 1
]

{ #category : #tests }
SindarinDebuggerTest >> testSkipSkipsSuperSendBytecodesCorrectly [

	| tmp1 tmp2 tmp3 tmp5 |
	tmp5 := ScaledDecimal newFromNumber: 3 scale: 2.
	tmp1 := SindarinDebugger debug: [ tmp5 := tmp5 negated ].
	tmp2 := tmp5.
	tmp1
		step;
		stepOver;
		skip.
	tmp3 := tmp1 context.
	tmp1
		stepUntil: [ tmp1 context == tmp3 ];
		stepOver.
	self assert: tmp5 equals: tmp2
]

{ #category : #tests }
SindarinDebuggerTest >> testSkipStepsMethodNodes [

	| tmp1 tmp2 tmp3 tmp4 |
	tmp1 := SindarinDebugger debug: [ 
		        self helperMethodWithBlockWithNoReturn ].
	tmp1
		step;
		stepOver.
	tmp2 := tmp1 node.
	tmp3 := tmp1 pc.
	tmp4 := tmp1 topStack.
	tmp1 := SindarinDebugger debug: [ 
		        self helperMethodWithBlockWithNoReturn ].
	tmp1
		step;
		skip.
	self
		assert: tmp1 node identicalTo: tmp2;
		assert: tmp1 pc identicalTo: tmp3;
		assert: tmp1 topStack equals: tmp4
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testSkipThroughNode [

	| tmp1 tmp2 tmp3 tmp4 tmp5 tmp6 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		stepOver.
	tmp4 := tmp1 node.
	tmp3 := tmp1 temporaryNamed: #a.
	tmp1 stepOver.
	tmp6 := tmp1 node.
	tmp5 := tmp1 topStack.
	tmp2 := tmp1 pc.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		skipThroughNode: tmp4.
	self
		assert: tmp1 pc equals: tmp2;
		assert: tmp1 node identicalTo: tmp6;
		assert: tmp3 equals: 5;
		assert: (tmp1 temporaryNamed: #a) equals: 1;
		assert: tmp5 equals: 3;
		assert: tmp1 topStack equals: '3'
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testSkipToPC [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		stepOver.
	tmp2 := tmp1 pc.
	tmp4 := tmp1 node.
	tmp3 := tmp1 temporaryNamed: #a.
	tmp5 := tmp1 topStack.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		skipToPC: tmp2.
	self
		assert: tmp1 pc equals: tmp2;
		assert: tmp1 node equals: tmp4;
		assert: tmp3 equals: 5;
		assert: (tmp1 temporaryNamed: #a) equals: 1;
		assert: tmp1 topStack equals: tmp5
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testSkipUpToNode [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		stepOver.
	tmp2 := tmp1 pc.
	tmp4 := tmp1 node.
	tmp3 := tmp1 temporaryNamed: #a.
	tmp5 := tmp1 topStack.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		skipUpToNode: tmp4.
	self
		assert: tmp1 pc equals: tmp2;
		assert: tmp1 node identicalTo: tmp4;
		assert: tmp3 equals: 5;
		assert: (tmp1 temporaryNamed: #a) equals: 1;
		assert: tmp1 topStack equals: tmp5
]

{ #category : #helpers }
SindarinDebuggerTest >> testSkipUpToNodeStopsOnImplicitReturn [

	| tmp1 tmp2 tmp3 tmp4 tmp5 |
	tmp1 := SindarinDebugger debug: [ 
		        self helperMethodWithBlockWithNoReturn ].
	tmp1
		step;
		stepOver;
		stepOver;
		stepOver;
		stepThrough;
		stepOver.
	tmp2 := tmp1 pc.
	tmp3 := tmp1 node.
	tmp1 stepOver.
	tmp4 := tmp1 pc.
	tmp5 := tmp1 node.
	self assert: tmp4 ~= tmp2.
	tmp1 := SindarinDebugger debug: [ 
		        self helperMethodWithBlockWithNoReturn ].
	tmp1
		step;
		stepOver;
		stepOver;
		stepOver;
		stepThrough;
		skipUpToNode: tmp5.
	self
		assert: tmp1 pc equals: tmp2;
		assert: tmp1 node identicalTo: tmp3
]

{ #category : #helpers }
SindarinDebuggerTest >> testSkipUpToNodeStopsOnReturnNodes [

	| tmp1 tmp2 tmp3 |
	tmp1 := SindarinDebugger debug: [ self helperMethodNonLocalReturn ].
	tmp1
		step;
		stepOver;
		stepOver;
		stepThrough.
	tmp2 := tmp1 node.
	tmp3 := tmp1 node methodNode body statements last.
	self
		assert: tmp2 isReturn;
		assert: tmp3 isReturn.
	tmp1 := SindarinDebugger debug: [ self helperMethodNonLocalReturn ].
	tmp1
		step;
		stepOver;
		stepOver;
		stepThrough;
		skipUpToNode: tmp3.
	self assert: tmp1 node identicalTo: tmp2
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testSkipWith [

	| tmp1 tmp3 tmp4 |
	self skipOnPharoCITestingEnvironment.
	tmp3 := 1.
	tmp1 := SindarinDebugger debug: [ 
		        tmp3 := 2.
		        tmp4 := Point x: 2 y: 3 ].
	tmp1 skipWith: 3.
	self assert: tmp3 equals: 3.
	tmp1
		skipWith: 5;
		step.
	self assert: tmp4 equals: 5
]

{ #category : #tests }
SindarinDebuggerTest >> testStack [

	| tmp1 tmp2 tmp4 tmp5 |
	tmp1 := [ :arg1 | tmp5 := arg1 ].
	tmp2 := SindarinDebugger debug: [ 
		        tmp4 := thisContext.
		        self helperMethod17: tmp1 ].
	tmp2 step.
	self assert: tmp2 stack first equals: tmp4.
	tmp2
		step;
		stepOver.
	self
		assert: tmp2 stack first equals: tmp5;
		assert: (tmp2 stack at: 2) equals: tmp4
]

{ #category : #tests }
SindarinDebuggerTest >> testStatementNodeContaining [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1
		step;
		stepOver;
		stepOver;
		stepOver.
	self
		assert: (tmp1 statementNodeContaining: tmp1 node)
		identicalTo: tmp1 methodNode statements last
]

{ #category : #tests }
SindarinDebuggerTest >> testStatementNodeContainingReturnsStatementNodeThatContainsTheIdenticalSubtree [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1 step.
	self
		should: [ tmp1 statementNodeContaining: (RBLiteralNode value: 1) ]
		raise: NodeNotInASTError
]

{ #category : #tests }
SindarinDebuggerTest >> testStatementNodeContainingWhenNodeIsNotInAST [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp1 step.
	self
		should: [ tmp1 statementNodeContaining: (RBLiteralNode value: 2) ]
		raise: NodeNotInASTError
]

{ #category : #tests }
SindarinDebuggerTest >> testStep [

	| tmp1 tmp2 |
	tmp2 := SindarinDebugger debug: [ self helperMethod13 ].
	tmp2 step.
	tmp1 := tmp2 node.
	self
		assert: tmp1 isAssignment;
		assert: tmp1 variable name equals: #a.
	tmp2 step.
	tmp1 := tmp2 node.
	self
		assert: tmp1 isMessage;
		assert: tmp1 selector equals: #asInteger
]

{ #category : #tests }
SindarinDebuggerTest >> testStepOver [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod14 ].
	tmp1
		step;
		stepOver;
		stepOver.
	self
		assert: tmp1 node isMessage;
		assert: tmp1 node selector equals: #x:y:
]

{ #category : #tests }
SindarinDebuggerTest >> testStepOverReturnNode [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod21 ].
	tmp1
		step;
		step;
		stepOver.
	self
		shouldnt: [ tmp1 stepOver ] raise: SteppingATerminatingProcess;
		assert: tmp1 selector equals: #helperMethod21;
		assert: tmp1 node isMethod;
		flag: 'Why is the following commented? Should it be tested somehow?'
]

{ #category : #'tests - step return' }
SindarinDebuggerTest >> testStepToImplicitReturn [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethod23 ].
	tmp1
		stepToMethodEntry;
		stepToReturn.
	self assert: tmp1 node isMethod.
	tmp1 step.
	self assert: tmp1 topStack equals: self
]

{ #category : #'tests - step return' }
SindarinDebuggerTest >> testStepToMethodEntry [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethodReturn: true ].
	tmp1 stepToMethodEntry.
	self
		assert: tmp1 pc equals: tmp1 method initialPC;
		assert: tmp1 method identicalTo: self class >> #helperMethodReturn:
]

{ #category : #'tests - step return' }
SindarinDebuggerTest >> testStepToNonLocalReturn [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethodNonLocalReturn ].
	tmp1
		stepToMethodEntry;
		stepToReturn.
	self
		assert: tmp1 node isReturn;
		assert: tmp1 topStack equals: 42
]

{ #category : #'tests - step return' }
SindarinDebuggerTest >> testStepToReturn [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethodReturn: true ].
	tmp1
		stepToMethodEntry;
		stepToReturn.
	self
		assert: tmp1 node isReturn;
		assert: tmp1 topStack equals: 1.
	tmp1 := SindarinDebugger debug: [ self helperMethodReturn: false ].
	tmp1
		stepToMethodEntry;
		stepToReturn.
	self
		assert: tmp1 node isReturn;
		assert: tmp1 topStack equals: 2
]

{ #category : #'tests - step return' }
SindarinDebuggerTest >> testStepToReturnWithException [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ 
		        self helperMethodReturnWithException ].
	tmp1
		stepToMethodEntry;
		stepToReturn.
	self
		assert: tmp1 receiver class identicalTo: ZeroDivide;
		assert: tmp1 method equals: Exception >> #signal
]

{ #category : #'tests - step return' }
SindarinDebuggerTest >> testStepToReturnWithHalt [

	| tmp1 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethodReturnWithHalt ].
	tmp1
		stepToMethodEntry;
		stepToReturn.
	self
		assert: tmp1 context instructionStream willReturn;
		assert: tmp1 node isReturn;
		assert: tmp1 topStack equals: 1
]

{ #category : #tests }
SindarinDebuggerTest >> testStepUntil [

	| tmp1 tmp3 |
	tmp3 := 20.
	tmp1 := SindarinDebugger debug: [ 
		        [ tmp3 = 0 ] whileFalse: [ tmp3 := tmp3 - 1 ] ].
	tmp1 stepUntil: [ tmp3 = 12 ].
	self assert: tmp3 equals: 12
]

{ #category : #tests }
SindarinDebuggerTest >> testSteppingAnExecutionSignalingExceptions [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ 
		        1 / 0.
		        2 / 0.
		        3 / 0 ].
	self
		should: [ 
			tmp1
				stepOver;
				stepOver;
				stepOver ]
		raise: UnhandledExceptionSignalledByADebuggedExecution
]

{ #category : #tests }
SindarinDebuggerTest >> testTemporaryNamed [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod10 ].
	tmp1 step.
	self assert: (tmp1 temporaryNamed: #a) equals: nil.
	tmp1 step.
	self assert: (tmp1 temporaryNamed: #a) equals: 5
]

{ #category : #tests }
SindarinDebuggerTest >> testTerminate [

	| tmp1 |
	tmp1 := SindarinDebugger debug: [ self helperMethod13 ].
	self
		assert: tmp1 debugSession interruptedContext notNil;
		assert: tmp1 debugSession interruptedProcess notNil.
	tmp1 terminate.
	self
		assert: tmp1 debugSession interruptedContext isNil;
		assert: tmp1 debugSession interruptedProcess isNil
]

{ #category : #tests }
SindarinDebuggerTest >> testTopStack [

	| tmp1 tmp3 |
	tmp3 := 1.
	tmp1 := SindarinDebugger debug: [ tmp3 := 2 ].
	tmp1 step.
	self assert: tmp1 topStack equals: 2
]

{ #category : #tests }
SindarinDebuggerTest >> testWhenHitBreakpoint [

	| tmp1 tmp2 tmp4 |
	tmp4 := false.
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2
		step;
		step.
	self
		assert: tmp2 node isMessage;
		assert: tmp2 node selector equals: #asInteger.
	tmp1 := tmp2 setBreakpoint.
	tmp1 whenHit: [ tmp4 := true ].
	tmp2 := SindarinDebugger debug: [ self helperMethod19 ].
	tmp2 continue.
	self assert: tmp4
]

{ #category : #'tests - skipping' }
SindarinDebuggerTest >> testskipUpToNodeSkipTargetNode [

	| tmp1 tmp2 |
	self skipOnPharoCITestingEnvironment.
	tmp1 := SindarinDebugger debug: [ self helperMethod1 ].
	tmp2 := (self class >> #helperMethod1) ast statements last.
	tmp1
		step;
		skipThroughNode: tmp2.
	self
		assert: tmp1 node equals: tmp2;
		assert: tmp1 topStack equals: Point
]
