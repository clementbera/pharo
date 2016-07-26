methods generation
lookupInitMethodForCurrentPlatform
	"This method searches an autogenerated init method for the current platform. The lookup basically means checking the selectors in a specific protocol and search for the one (if exists) with the pragma matching the #platformName and #wordSize of the current platform. If found, it answers the selector. If not found, it answers nil. "
	| selectors |
	selectors := self allAutogeneratedMethodSelectors. 
	^ selectors detect: [ :each | 
		| method arguments |
		method := self class compiledMethodAt: each. 
		arguments := (method pragmaAt: #platformName:wordSize:) arguments.
		(arguments first = self currentPlatformName) 
			and: [ (arguments second = self currentWordSize) ]
	] ifNone: [ 
		"IMPORTANT: Here we cannot throw an error becasue this method is called from the startup code (from startUp: -> initializeVariablesIfNeeded) and if we throw an error during statup, the image shutsdown and doesn't start anymore."
		Transcript show: 'There is no autogenerated init method for platform name ', self currentPlatformName, ' and word size ', self currentWordSize asString; cr.
		nil ]