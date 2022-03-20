#pragma once
#include "SortedIteratedList.h"

//DO NOT CHANGE THIS PART
class ListIterator{
	friend class SortedIteratedList;
private:
	SortedIteratedList& list;
	ListIterator(SortedIteratedList& list);
    int current;
public:
	void first();
	void next();
	bool valid() const;
    TComp getCurrent() const;
    TComp remove();
};


