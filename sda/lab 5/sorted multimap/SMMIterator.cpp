#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>

using namespace std;

SMMIterator::SMMIterator(const SortedMultiMap& d) : map(d){
    this->stcap = 50;
    this->nrstack = 0;
    this->current_elems = 0;
	this->stack = new int[this->stcap];
	this->current_list = new int[this->map.nrElements];
    this->current = 0;
    this->current_value = 0;
    this->create();
}

void SMMIterator::first(){
    this->current = 0;
    this->current_value = 0;
}//theta(1)

void SMMIterator::next(){
    if (this->current == this->current_elems)
        throw exception();
    if (this->current_value != this->map.nrValues[this->current_list[this->current]] - 1)
        this->current_value++;
    else{
        this->current++;
        this->current_value = 0;
    }
}//theta(1)

bool SMMIterator::valid() const{
	if (this->current != this->current_elems) return true;
	return false;
}//theta(1)

TElem SMMIterator::getCurrent() const{
    if (this->current == this->current_elems)
        throw exception();
    TKey k = this->map.elements[this->current_list[this->current]];
    TValue v = this->map.value_list[this->current_list[this->current]][this->current_value];
	return TElem(k, v);
}//theta(1)

void SMMIterator::create() {
    int pos = this->map.root;
    while (pos != -1) {
        this->stack[nrstack] = pos;
        this->nrstack++;
        pos = this->map.left[pos];
    }
    while (this->nrstack != 0) {
        pos = this->stack[nrstack - 1];
        this->nrstack--;
        this->current_list[this->current_elems] = pos;
        this->current_elems++;
        pos = this->map.right[pos];
        while (pos != -1) {
            this->stack[nrstack] = pos;
            this->nrstack++;
            pos = this->map.left[pos];
        }
    }
}//O(n^2)
