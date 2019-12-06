Class {
	#name : #ToDoListView,
	#superclass : #WAComponent,
	#instVars : [
		'editor',
		'visible',
		'listId'
	],
	#category : #'SeasideBook-ToDo-View'
}

{ #category : #'class initialization' }
ToDoListView class >> initialize [
	"self initialize"

	| application |
	application := WAAdmin register: self asApplicationAt: 'todo'.
	application
		addLibrary: PTDevelopmentLibrary;
		addLibrary: SUDevelopmentLibrary;
		addLibrary: JQDeploymentLibrary;
		addLibrary: JQUiDeploymentLibrary
]

{ #category : #rendering }
ToDoListView >> add [
	editor := ToDoItemView new model: ToDoItem new.
	editor onAnswer: [ : value |
		value isNil 
			ifFalse: [ self model add: value ].
			editor := nil ]
]

{ #category : #accessing }
ToDoListView >> children [
	^ Array with: editor
]

{ #category : #rendering }
ToDoListView >> edit: anItem [
	|edited|
	edited := self call:  (ToDoItemView new model: anItem copy).
	edited isNil
		ifFalse: [ self model replace: anItem with: edited ]
]

{ #category : #accessing }
ToDoListView >> editor [
	^ editor
]

{ #category : #accessing }
ToDoListView >> editor: anObject [
	^ editor := anObject
]

{ #category : #initialization }
ToDoListView >> initialize [ 
	super initialize.
	visible := false
]

{ #category : #accessing }
ToDoListView >> listId [
	^ listId
]

{ #category : #accessing }
ToDoListView >> listId: anObject [
	listId := anObject
]

{ #category : #accessing }
ToDoListView >> model [ 
	^ ToDoList default
]

{ #category : #rendering }
ToDoListView >> remove: anItem [
	(self confirm: 'Are you sure you want to remove ' , anItem title printString , '?')
		ifTrue: [self model remove: anItem]
]

{ #category : #rendering }
ToDoListView >> renderContentOn: html [
	self renderHeadingOnJquery: html.
	self renderHeadingOnJQuery2: html.
	html
		form: [ 
			(html unorderedList)
				id: (listId := html nextId);
				script: ((html jQuery new sortable)
					onStop: (html jQuery ajax
						callback: [:items | self model items: items]
						passengers: (html jQuery this find: 'li'));
					axis: 'y');
				with: [ self renderItemsOn: html].
			"html submitButton
				text: 'Save'."
			html submitButton
				callback: [ self add ];
				text: 'Add' ].
	html render: editor
]

{ #category : #rendering }
ToDoListView >> renderHeadingOn2: html [
	|helpId|
	helpId := html nextId.
	(html heading)
		class: 'helplink';
		onClick: ((html jQuery id: helpId)
			slideToggle: 1 seconds);
"		onClick: ((html jQuery ajax)
			id: helpId;
			callback: [ visible := visible not ]);"
		with: self model title.
	(html div)
		id: helpId;
		class: 'help';
		style: 'display: none';
		with: 'The ToDo app enhanced with jQuery'
]

{ #category : #rendering }
ToDoListView >> renderHeadingOn: html [
  html heading
        onClick: ((html jQuery this effect) highlight; color: '#f00'); 
        with: self model title.
]

{ #category : #rendering }
ToDoListView >> renderHeadingOnBasic: html [
  html heading with: self model title.
]

{ #category : #rendering }
ToDoListView >> renderHeadingOnJQuery2: html [
	| helpId |
	helpId := html nextId.
	(html heading)
		class: 'helplink';
		onClick: ((html jQuery id: helpId)
			slideToggle: 1 seconds);
		onClick: ((html jQuery ajax)
			id: helpId;
			callback: [ visible := visible not ]);
		with: self model title.
	(html div)
		id: helpId;
		class: 'help';
		style: 'display: none';
		with: 'The todo application enhanced with jQuery'
]

{ #category : #rendering }
ToDoListView >> renderHeadingOnJquery: html [
  html heading 
	onClick: html jQuery this effect highlight;
	with: self model title.
]

{ #category : #rendering }
ToDoListView >> renderHeadingOnScripta2: html [
  html heading 
	onClick: (html scriptaculous effect highlight; startColor: Color blue);
	with: self model title.
]

{ #category : #rendering }
ToDoListView >> renderHeadingOnScripta3: html [
	| helpId |
	helpId := html nextId.
	html heading
		class: 'helplink';
		onClick: (html scriptaculous effect 
			id: helpId;
			toggleAppear);
		onClick: (html scriptaculous request 
			callback: [ visible := visible not ]);
		with: self model title.
	html div
		id: helpId;
		class: 'help';
		style: 'display: none';
		with: 'The todo application from the Seaside Book'
]

{ #category : #rendering }
ToDoListView >> renderHeadingOnScripta: html [
  html heading 
	onClick: html scriptaculous effect highlight;
	with: self model title.
]

{ #category : #rendering }
ToDoListView >> renderItem: anItem on: html [
	html listItem
		class: 'done' if: anItem isDone;
		class: 'overdue' if: anItem isOverdue;
		with: [
			html checkbox
				value: anItem done;
				callback: [ :value | anItem done: value ].
			html text: anItem title.
			html space.
			html anchor
				callback: [ self edit: anItem ];
				with: 'edit'.
			html space.
			html anchor 
				callback: [ self remove: anItem ];
				with: 'remove'
			]
]

{ #category : #rendering }
ToDoListView >> renderItemJQuery: anItem on: html [
	(html listItem)
		passenger: anItem;
		class: 'done' if: anItem isDone;
		class: 'overdue' if: anItem isOverdue;
		with: [
"			html checkbox
				value: anItem done;
				callback: [ :value | anItem done: value ]."
			(html checkbox)
				onChange: (((html jQuery id: listId) load)
					serializeForm;
					html: [ :ajaxHtml | self renderItemsOn: ajaxHtml ]);
					value: anItem done;
					callback: [ :value | anItem done: value ].
			"(html span)
                script: ((html scriptaculous inPlaceEditor)
                    cancelControl: #button;
                    triggerInPlaceEditor: [:value | anItem title: value];
                    callback: [:htmlAjax | htmlAjax render: anItem title]);
                with: anItem title."
			html text: anItem title.
			html space.
			(html anchor)
				callback: [ self edit: anItem ];
				with: 'edit'.
			html space.
			(html anchor) 
				callback: [ self remove: anItem ];
				with: 'remove'
			]
]

{ #category : #rendering }
ToDoListView >> renderItemScripta: anItem on: html [
	html listItem
		passenger: anItem;
		class: 'done' if: anItem isDone;
		class: 'overdue' if: anItem isOverdue;
		with: [
"			html checkbox
				value: anItem done;
				callback: [ :value | anItem done: value ]."
		html checkbox
				onChange: (html scriptaculous updater
					id: listId;
					triggerForm: (html scriptaculous element up: 'form');
					callback: [ :ajaxHtml | self renderItemsOn: ajaxHtml]);
				value: anItem done;
				callback: [ :value | anItem done: value ].
			html span
				script: (html scriptaculous inPlaceEditor 
					cancelControl: #button;
					triggerInPlaceEditor: [:value | anItem title: value];
					callback: [:htmlAjax | htmlAjax render: anItem title]);
				with: anItem title.
			html space.
			html anchor
				callback: [ self edit: anItem ];
				with: 'edit'.
			html space.
			html anchor 
				callback: [ self remove: anItem ];
				with: 'remove'
			]
]

{ #category : #rendering }
ToDoListView >> renderItemsOn: html [
	self model items 
		do: [ :each | 
			"self renderItem: each on: html"
			"self renderItemScripta: each on: html"
			self renderItemJQuery: each on: html 
			]
]

{ #category : #rendering }
ToDoListView >> style [
^ '
.help {
    padding: 1em;
    margin-bottom: 1em;
    border: 1px solid #008aff;
    background-color: #e6f4ff;
}
.helplink {
    cursor: help;
}

body {
    color: #222;
    font-size: 75%;
    font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
h1 {
    color: #111;
    font-size: 2em;
    font-weight: normal;
    margin-bottom: 0.5em;
}
ul {
    list-style: none;
    padding-left: 0;
    margin-bottom: 1em;
}
li.overdue {
    color: #8a1f11;
}
li.done {
    color: #264409;
}

li { cursor: move; }

li form {
    margin: 0;
    display: inline;
}'


]

{ #category : #accessing }
ToDoListView >> visible [
	^ visible
]

{ #category : #accessing }
ToDoListView >> visible: anObject [
	visible := anObject
]
