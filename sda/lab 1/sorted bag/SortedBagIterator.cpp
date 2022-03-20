#include "SortedBagIterator.h"
#include "SortedBag.h"
#include <exception>
#include <iostream>

using namespace std;

SortedBagIterator::SortedBagIterator(const SortedBag& b) : bag(b) {
	this->current = 0;
}//theta(1)

TComp SortedBagIterator::getCurrent() {
	if (this->current >= this->bag.nrElements) {
        throw exception();
    }
	else
    {
        return this->bag.elements[this->current];
    }
}//theta(1)

bool SortedBagIterator::valid() const {
	if (this->current < this->bag.nrElements)
	    return true;
	return false;
}//theta(1)

void SortedBagIterator::next() {
	if (this->current == this->bag.nrElements) {
        throw exception();
    }
	else
	    this->current++;
}//theta(1)

void SortedBagIterator::first() {
	this->current = 0;
}//theta(1)

