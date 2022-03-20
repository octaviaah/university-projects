#pragma once

#include "SortedMultiMap.h"


class SMMIterator{
	friend class SortedMultiMap;
private:
	//DO NOT CHANGE THIS PART
	SortedMultiMap& map;
	SMMIterator(SortedMultiMap& map);
	Node* currentNode;
	int currentValPos;
	Node* list;
	Node* prev;

public:
	void first();
	void next();
	bool valid() const;
   	TElem getCurrent() const;
   	void mergeLists();
   	Node* mergeTwo(Node *l, Node* t);
   	Node* copy(Node* l);
   	TElem remove();

};

