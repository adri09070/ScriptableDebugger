Class {
	#name : #UnhandledExceptionSignalledByADebuggedExecution,
	#superclass : #DebuggedExecutionException,
	#instVars : [
		'unhandledException'
	],
	#category : #'Sindarin-Exceptions'
}

{ #category : #signalling }
UnhandledExceptionSignalledByADebuggedExecution class >> signalWithException: arg1 [

	| tmp2 |
	tmp2 := self new.
	tmp2
		unhandledException: arg1;
		signal:
			'An execution debugged by a scriptable debugger signalled an exception that it did not handle itself. You can find this exception is in the #unhandledException instance variable of this object.'
]

{ #category : #accessing }
UnhandledExceptionSignalledByADebuggedExecution >> unhandledException [

	^ unhandledException
]

{ #category : #accessing }
UnhandledExceptionSignalledByADebuggedExecution >> unhandledException: arg1 [

	unhandledException := arg1
]
