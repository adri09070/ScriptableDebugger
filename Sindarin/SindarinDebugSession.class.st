Class {
	#name : #SindarinDebugSession,
	#superclass : #Object,
	#instVars : [
		'triggerEventOn',
		'canBeTerminated',
		'debugSession'
	],
	#category : #'Sindarin-Base'
}

{ #category : #'instance creation' }
SindarinDebugSession class >> newWithName: arg1 forProcess: arg2 [

	| tmp2 |
	tmp2 := DebugSession new.
	tmp2
		name: arg1;
		process: arg2 context: arg2 suspendedContext.
	^ tmp2 asSindarinDebugSession
]

{ #category : #initialization }
SindarinDebugSession >> activateEventTriggering [

	triggerEventOn := true.
	self flag: 'Why not refreshing?'
]

{ #category : #converting }
SindarinDebugSession >> asSindarinDebugSession [

	
]

{ #category : #accessing }
SindarinDebugSession >> canBeTerminated [

	^ canBeTerminated
]

{ #category : #accessing }
SindarinDebugSession >> canBeTerminated: arg1 [

	canBeTerminated := arg1
]

{ #category : #initialization }
SindarinDebugSession >> deactivateEventTriggering [

	triggerEventOn := false
]

{ #category : #accessing }
SindarinDebugSession >> debugSession [

	^ debugSession
]

{ #category : #accessing }
SindarinDebugSession >> debugSession: arg1 [

	debugSession := arg1
]

{ #category : #initialization }
SindarinDebugSession >> initialize [

	super initialize.
	triggerEventOn := true.
	canBeTerminated := true
]

{ #category : #initialization }
SindarinDebugSession >> refreshAttachedDebugger [

	self debugSession triggerEvent: #contextChanged
]

{ #category : #'debugging actions' }
SindarinDebugSession >> resumeAndClear [

	| tmp2 |
	tmp2 := self debugSession.
	tmp2
		resume;
		clear
]

{ #category : #'debugging actions' }
SindarinDebugSession >> stepInto: arg1 [

	self flag: 'Why the image gets locked? Please investigate.'.
	self debugSession interruptedProcess isTerminating ifTrue: [ 
		SteppingATerminatingProcess signal ].
	^ self debugSession stepInto: arg1
]

{ #category : #'debugging actions' }
SindarinDebugSession >> stepOver: arg1 [

	self flag: 'Why the image gets locked? Please investigate.'.
	self debugSession interruptedProcess isTerminating ifTrue: [ 
		SteppingATerminatingProcess signal ].
	^ self debugSession stepOver: arg1
]

{ #category : #'debugging actions' }
SindarinDebugSession >> terminate [

	canBeTerminated ifTrue: [ ^ self debugSession terminate ]
]

{ #category : #'debugging actions' }
SindarinDebugSession >> triggerEvent: arg1 [

	triggerEventOn ifTrue: [ ^ self debugSession triggerEvent: arg1 ]
]
