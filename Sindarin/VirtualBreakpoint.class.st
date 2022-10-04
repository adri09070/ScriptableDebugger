Class {
	#name : #VirtualBreakpoint,
	#superclass : #Object,
	#instVars : [
		'node',
		'setter',
		'breakOnce',
		'whenHit'
	],
	#classVars : [
		'all'
	],
	#category : #'Sindarin-Utilities'
}

{ #category : #'instance creation' }
VirtualBreakpoint class >> all [

	all ifNil: [ all := OrderedCollection new ].
	^ all
]

{ #category : #actions }
VirtualBreakpoint class >> clearAll [

	<script>
	all := nil
]

{ #category : #'instance creation' }
VirtualBreakpoint class >> newOnNode: arg1 [

	| tmp2 |
	tmp2 := self new.
	tmp2 node: arg1.
	^ tmp2 yourself
]

{ #category : #'instance creation' }
VirtualBreakpoint class >> newOnNode: arg1 setBy: arg2 [

	| tmp1 tmp3 |
	tmp3 := self new.
	tmp3 node: arg1.
	tmp1 := tmp3 setter: arg2.
	self all add: tmp1.
	^ tmp1
]

{ #category : #accessing }
VirtualBreakpoint >> breakOnce [

	breakOnce ifNil: [ breakOnce := false ].
	^ breakOnce
]

{ #category : #accessing }
VirtualBreakpoint >> breakOnce: arg1 [

	breakOnce := arg1
]

{ #category : #hitTest }
VirtualBreakpoint >> hitTest: arg1 [

	self node == arg1 ifTrue: [ 
		self breakOnce ifTrue: [ self remove ].
		self whenHit do: [ :arg2 | arg2 value ].
		^ true ].
	^ false
]

{ #category : #accessing }
VirtualBreakpoint >> node [

	^ node
]

{ #category : #accessing }
VirtualBreakpoint >> node: arg1 [

	node := arg1
]

{ #category : #API }
VirtualBreakpoint >> once [

	breakOnce := true
]

{ #category : #API }
VirtualBreakpoint >> remove [

	all remove: self
]

{ #category : #accessing }
VirtualBreakpoint >> setter [

	^ setter
]

{ #category : #accessing }
VirtualBreakpoint >> setter: arg1 [

	setter := arg1
]

{ #category : #accessing }
VirtualBreakpoint >> whenHit [

	whenHit ifNil: [ whenHit := OrderedCollection new ].
	^ whenHit
]

{ #category : #API }
VirtualBreakpoint >> whenHit: arg1 [

	self whenHit add: arg1
]
