Class {
	#name : #SindarinDebugSessionTest,
	#superclass : #TestCase,
	#instVars : [
		'debugSession',
		'sindarinSession'
	],
	#category : #'Sindarin-Tests-Base'
}

{ #category : #running }
SindarinDebugSessionTest >> setUp [

	super setUp.
	debugSession := DebugSession new.
	sindarinSession := debugSession asSindarinDebugSession
]

{ #category : #tests }
SindarinDebugSessionTest >> testDebugSessionAsSindarinDebugSession [

	self assert: sindarinSession debugSession identicalTo: debugSession
]

{ #category : #tests }
SindarinDebugSessionTest >> testSindarinSessionAsSindarinDebugSession [

	self
		assert: sindarinSession asSindarinDebugSession
		identicalTo: sindarinSession
]

{ #category : #tests }
SindarinDebugSessionTest >> testSindarinSessionInstantiation [

	| tmp1 tmp2 |
	tmp1 := 'TestSDS'.
	tmp2 := [  ] newProcess.
	sindarinSession := SindarinDebugSession
		                   newWithName: tmp1
		                   forProcess: tmp2.
	self
		assert: sindarinSession debugSession notNil;
		assert: sindarinSession debugSession name equals: tmp1;
		assert: sindarinSession debugSession process identicalTo: tmp2
]
