Class {
	#name : #ToDoList,
	#superclass : #Object,
	#instVars : [
		'title',
		'items'
	],
	#classVars : [
		'Default'
	],
	#category : #'SeasideBook-ToDo-Model'
}

{ #category : #singleton }
ToDoList class >> default [ 
	^ Default ifNil: [ Default := self new ]
]

{ #category : #demos }
ToDoList class >> initializeExamples [
	"self initializeExamples"
	self default 
		title: 'Seaside ToDo';
		add: (ToDoItem new 
			title: 'Finish todo app chapter';
			due: '12/15/2019' asDate;
			done: false);
		add: (ToDoItem new 
			title: 'Annotate first chapter';
			due: '12/16/2019' asDate;
			done: false);
		add: (ToDoItem new 
			title: 'Finish seaside book';
			due: '12/20/2019' asDate;
			done: false)
]

{ #category : #'instance creation' }
ToDoList class >> new [
	^ self basicNew initialize
]

{ #category : #singleton }
ToDoList class >> reset [ 
	Default := nil
]

{ #category : #actions }
ToDoList >> add: aToDoItem [
	self items add: aToDoItem
]

{ #category : #initialize }
ToDoList >> initialize [
	self items: OrderedCollection new
]

{ #category : #accessing }
ToDoList >> items [
	^ items
]

{ #category : #accessing }
ToDoList >> items: anObject [
	items := anObject
]

{ #category : #actions }
ToDoList >> remove: aToDoItem [
	^ self items remove: aToDoItem
]

{ #category : #actions }
ToDoList >> replace: anItem with: anotherItem [
	self items at: (self items indexOf: anItem) put: anotherItem
]

{ #category : #accessing }
ToDoList >> title [
	^ title
]

{ #category : #accessing }
ToDoList >> title: anObject [
	title := anObject
]
