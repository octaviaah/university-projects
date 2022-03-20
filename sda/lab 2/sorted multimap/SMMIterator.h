#pragma once

#include "SortedMultiMap.h"


class SMMIterator{
	friend class SortedMultiMap;
	friend class Node;
private:
	//DO NOT CHANGE THIS PART
	const SortedMultiMap& map;
	SMMIterator(const SortedMultiMap& map);
    Node* current;

public:
	void first();
	void next();
	bool valid() const;
   	TElem getCurrent() const;
};

