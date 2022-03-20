#include "FixedCapBiMap.h"
#include "FixedCapBiMapIterator.h"
#include <exception>

using namespace std;

FixedCapBiMap::FixedCapBiMap(int capacity) {
	if (capacity <= 0)
        throw exception();
	this->capacity = capacity;
	this->nrElements = 0;
	this->elements = new TElem[this->capacity];
}

FixedCapBiMap::~FixedCapBiMap() {
	//TODO - Implementation
}

bool FixedCapBiMap::add(TKey c, TValue v){
	if (this->capacity == this->nrElements)
	    throw exception();
	int index, count;
	index = count = 0;
	while (count <  2 && index < this->nrElements)
    {
	    if (this->elements[index].first == c)
	        count ++;
	    index ++;
    }
	if (count == 2)
	    return false;
	else
    {
	    this->elements[this->nrElements].first = c;
	    this->elements[this->nrElements].second = v;
	    this->nrElements++;
	    return true;
    }
	return false;
}

ValuePair FixedCapBiMap::search(TKey c) const{
	//TODO - Implementation
	return std::pair<TValue, TValue>(NULL_TVALUE, NULL_TVALUE);
}

ValuePair FixedCapBiMap::remove_key(TKey k) {
    int index, count, fi, si;
    index = count = 0;
    fi = si = -1;
    TValue value1, value2;
    value1 = value2 = NULL_TVALUE;
    while (index < this->nrElements && count < 2)
    {
        if (this->elements[index].first == k) {
            if (value1 == NULL_TVALUE) {
                value1 = this->elements[index].second;
                fi = index;
            }
            else if (value2 == NULL_TVALUE) {
                value2 = this->elements[index].second;
                si = index;
            }
            count ++;
        }
        index ++;
    }
    if (count > 0)
    {
        if (fi != -1)
        {
            this->elements[fi] = this->elements[this->nrElements - 1];
            this->nrElements--;
        }
        if (si != -1)
        {
            this->elements[si] = this->elements[this->nrElements - 1];
            this->nrElements--;
        }
    }
    return ValuePair(value1, value2);
}

bool FixedCapBiMap::remove(TKey c, TValue v){
	//TODO - Implementation
	return false;
}


int FixedCapBiMap::size() const {
    if (this->capacity <= 0)
        return 0;
	return this->nrElements;
}

bool FixedCapBiMap::isEmpty() const{
	if (this->nrElements == 0)
	    return true;
	return false;
}

bool FixedCapBiMap::isFull() const {
	//TODO - Implementation
	return false;
}

FixedCapBiMapIterator FixedCapBiMap::iterator() const {
	return FixedCapBiMapIterator(*this);
}



