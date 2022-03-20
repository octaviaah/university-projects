#pragma once

#include "SortedMultiMap.h"


class SMMIterator{
	friend class SortedMultiMap;
private:
	//DO NOT CHANGE THIS PART
	const SortedMultiMap& map;
	SMMIterator(const SortedMultiMap& map);
	int current;
	int current_value;
	int* stack;
	int stcap;
	int nrstack;
	int* current_list;
	int current_elems;

public:
	void first();
	void next();
	bool valid() const;
   	TElem getCurrent() const;
   	void create();
};

