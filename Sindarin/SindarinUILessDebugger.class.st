Class {
	#name : #SindarinUILessDebugger,
	#superclass : #Object,
	#category : #'Sindarin-Base'
}

{ #category : #'debugger declaration' }
SindarinUILessDebugger class >> openOn: arg1 withFullView: arg2 andNotification: arg3 [

	arg1 keepAlive: self.
	Smalltalk tools inspector openOn: (SindarinDebugger attachTo: arg1)
]

{ #category : #'debugger declaration' }
SindarinUILessDebugger class >> rankDebugSession: arg1 [

	^ 25
]
