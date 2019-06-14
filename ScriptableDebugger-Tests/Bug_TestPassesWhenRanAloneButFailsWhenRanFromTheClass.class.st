Class {
	#name : #'Bug_TestPassesWhenRanAloneButFailsWhenRanFromTheClass',
	#superclass : #TestCase,
	#instVars : [
		'breakpointsBeforeTest'
	],
	#category : #'ScriptableDebugger-Tests'
}

{ #category : #tests }
Bug_TestPassesWhenRanAloneButFailsWhenRanFromTheClass >> helperMethod13 [
	| a |
	a := 5.
	^ Point x: 5 y: '3' asInteger.
]

{ #category : #running }
Bug_TestPassesWhenRanAloneButFailsWhenRanFromTheClass >> runCaseManaged [
	"This prevents the TestExecutionEnvironment from trying to kill processes created during the test. Without it, it adds on:do: contexts on the process, and this somehow makes the process answers true to isTerminating, triggering the protection against stepping terminating processes from DebugSessionPlus>>stepInto:
	It is not necessary to terminate processes created by ScriptableDebugger because these processes are not scheduled."
	self halt.
	^ self runCase.
]

{ #category : #running }
Bug_TestPassesWhenRanAloneButFailsWhenRanFromTheClass >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	breakpointsBeforeTest := VirtualBreakpoint all.
	VirtualBreakpoint all removeAll.
]

{ #category : #running }
Bug_TestPassesWhenRanAloneButFailsWhenRanFromTheClass >> tearDown [
	VirtualBreakpoint all removeAll.
	breakpointsBeforeTest do: [ :brkpt | VirtualBreakpoint all add: brkpt ].
]

{ #category : #tests }
Bug_TestPassesWhenRanAloneButFailsWhenRanFromTheClass >> testStep [
	| node scdbg |
	scdbg := ScriptableDebugger debug: [ self helperMethod13 ].
	scdbg step.
	self halt.
	node := scdbg currentNode.
	self assert: node isAssignment.
	self assert: node variable name equals: #a.
	scdbg step.
	node := scdbg currentNode.
	self assert: node isMessage.
	self assert: node selector equals: #asInteger.
]