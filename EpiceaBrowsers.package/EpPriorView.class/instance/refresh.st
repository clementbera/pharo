refreshing
refresh
	| currentHeadReference currentFilter |
	currentHeadReference := self log headReference.
	currentFilter := self andFilter.
	entryItemByEntryReferenceCache := Dictionary new.

	"FIX FIX FIX"
	(lastRefreshedHeadReference ~= currentHeadReference
		or: [ lastRefreshedFilter ~= currentFilter ])
		ifFalse: [ ^ self ].
	rootItems := self
		next: desiredNumberOfItems
		from: currentHeadReference.
	lastRefreshedHeadReference := currentHeadReference.
	lastRefreshedFilter := currentFilter