Class {
	#name : #SindarinDebugSessionMock,
	#superclass : #Object,
	#instVars : [
		'isMessage',
		'selector',
		'receiver'
	],
	#category : #'Sindarin-Tests-Mocks'
}

{ #category : #accessing }
SindarinDebugSessionMock >> context [

	
]

{ #category : #accessing }
SindarinDebugSessionMock >> debugSession [

	
]

{ #category : #accessing }
SindarinDebugSessionMock >> interruptedContext [

	
]

{ #category : #accessing }
SindarinDebugSessionMock >> isMessage [

	^ isMessage ifNil: [ false ] ifNotNil: [ isMessage ]
]

{ #category : #accessing }
SindarinDebugSessionMock >> isMessage: arg1 [

	isMessage := arg1
]

{ #category : #accessing }
SindarinDebugSessionMock >> method [

	
]

{ #category : #accessing }
SindarinDebugSessionMock >> pc [

	
]

{ #category : #accessing }
SindarinDebugSessionMock >> receiver [

	^ receiver
]

{ #category : #accessing }
SindarinDebugSessionMock >> receiver: arg1 [

	receiver := arg1
]

{ #category : #accessing }
SindarinDebugSessionMock >> selector [

	^ selector
]

{ #category : #accessing }
SindarinDebugSessionMock >> selector: arg1 [

	selector := arg1
]

{ #category : #accessing }
SindarinDebugSessionMock >> sourceNodeExecuted [

	
]

{ #category : #accessing }
SindarinDebugSessionMock >> sourceNodeForPC: arg1 [

	
]
