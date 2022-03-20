#include "ListIterator.h"
#include "SortedIteratedList.h"
#include <iostream>
using namespace std;
#include <exception>

SortedIteratedList::SortedIteratedList(Relation r) {
	this->r = r;
	this->capacity = 30;
	this->nrElements = 0;
	this->elements = new TComp[this->capacity];
	this->next = new int[this->capacity];
	this->head = -1;
	for (int index = 0; index < this->capacity - 1; index++)
        this->next[index] = index+1;
	this->next[this->capacity - 1] = -1;
	this->firstEmpty = 0;
}//theta(this->capacity-1)

int SortedIteratedList::size() const {
	return this->nrElements;
}//theta(1)

bool SortedIteratedList::isEmpty() const {
	if (this->nrElements == 0)
	    return true;
	return false;
}//theta(1)

ListIterator SortedIteratedList::first() {
	return ListIterator(*this);
}//theta(1)

TComp SortedIteratedList::getElement(ListIterator poz) const {
    if (!poz.valid())
        throw exception();
    return poz.getCurrent();
}//theta(1)

TComp SortedIteratedList::remove(ListIterator& poz) {
    if (!poz.valid())
        throw exception();
	int current = this->head;
	TComp prev = -1;
	while (current != -1 && this->elements[current] != poz.getCurrent())
    {
	    prev = current;
	    current = this->next[current];
    }
	TComp elem = poz.getCurrent();
	poz.next();
	if (current == this->head)
	    this->head = this->next[this->head];
	else
	    this->next[prev] = this->next[current];
	this->next[current] = this->firstEmpty;
	this->firstEmpty = current;
	this->nrElements--;
	return elem;
}//O(this->size)

ListIterator SortedIteratedList::search(TComp e) {
	int current = this->head;
	ListIterator it = this->first();
	while (current != -1 && this->elements[current] != e) {
        current = this->next[current];
        it.next();
    }
	return it;
}//O(this->size())

void SortedIteratedList::add(TComp e) {
    if (this->firstEmpty == -1)
        resize();
    this->elements[this->firstEmpty] = e;
    this->nrElements++;
    if (this->head == -1)
    {
        this->head = this->firstEmpty;
        this->firstEmpty = this->next[this->firstEmpty];
        this->next[this->head] = -1;
    }
    else{
        int current = this->head;
        TComp prev = -1;
        int found = 0;
        while(current != -1 && found == 0)
        {
            if(this->r(e, this->elements[current])) {
                found = 1;
                if (current == this->head) {
                    int newFirstEmpty = this->next[this->firstEmpty];
                    this->next[firstEmpty] = current;
                    this->head = this->firstEmpty;
                    this->firstEmpty = newFirstEmpty;
                }
                else {
                    int pos = this->next[prev];
                    this->next[prev] = this->firstEmpty;
                    int newFirstEmpty = this->next[this->firstEmpty];
                    this->next[firstEmpty] = pos;
                    this->firstEmpty = newFirstEmpty;
                }
            }
            prev = current;
            current = this->next[current];
        }
        if (found == 0)
        {
            this->next[prev] = this->firstEmpty;
            int newFirstEmpty = this->next[this->firstEmpty];
            this->next[firstEmpty] = -1;
            this->firstEmpty = newFirstEmpty;
        }
    }
}//O(this->capacity)(technically 2*this->capacity + 1)

SortedIteratedList::~SortedIteratedList() {
	delete [] this->elements;
	delete [] this->next;
}//theta(1)

void SortedIteratedList::resize(){
    TComp* newElems;
    int* newNext;
    newElems = new TComp[this->capacity*2];
    newNext = new int[this->capacity*2];
    for (int index = 0; index < this->capacity; index++)
    {
        newElems[index] = this->elements[index];
        newNext[index] = this->next[index];
    }
    for (int index = this->capacity; index < this->capacity*2 - 1; index ++)
        newNext[index] = index + 1;
    newNext[this->capacity*2 - 1] = -1;
    delete [] this->elements;
    //delete [] this->next;
    this->firstEmpty = this->capacity;
    this->capacity *= 2;
    this->elements = newElems;
    this->next = newNext;
}//theta(this->capacity)(technically 2*this->capacity)