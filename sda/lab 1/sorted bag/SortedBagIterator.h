#pragma once
#include "SortedBag.h"

class SortedBag;

class SortedBagIterator
{
	friend class SortedBag;

private:
	const SortedBag& bag;
	int current; //the position of the current element from the elements array from the bag
    SortedBagIterator(const SortedBag& b);

public:
	TComp getCurrent();
	bool valid() const;
	void next();
	void first();
};

