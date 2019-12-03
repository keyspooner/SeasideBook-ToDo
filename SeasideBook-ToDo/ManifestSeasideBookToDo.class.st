"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestSeasideBookToDo,
	#superclass : #PackageManifest,
	#category : #'SeasideBook-ToDo-Manifest'
}

{ #category : #'code-critics' }
ManifestSeasideBookToDo class >> ruleRBMissingTranslationsInMenusRuleV1FalsePositive [
	^ #(#(#(#RGMetaclassDefinition #(#'ToDoList class' #ToDoList)) #'2019-12-02T20:26:04.595036-05:00') )
]
