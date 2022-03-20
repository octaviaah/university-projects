#include "ListIterator.h"
#include "SortedIteratedList.h"
#include <exception>
#include <iostream>

using namespace std;

ListIterator::ListIterator(SortedIteratedList& list) : list(list){
    this->current = list.head;
}//theta(1)

void ListIterator::first(){
	this->current = this->list.head;
}//theta(1)

void ListIterator::next(){
	if (this->current == -1)
	    throw exception();
	else{
	    this->current = this->list.next[this->current];
	}
}//theta(1)

bool ListIterator::valid() const{
	if (this->current != -1)
	    return true;
	return false;
}//theta(1)

TComp ListIterator::getCurrent() const{
	if (this->current == -1)
	    throw exception();
	else
	    return this->list.elements[this->current];
}//theta(1)

TComp ListIterator::remove()
{
    if (!this->valid())
        throw exception();
    int crt = this->list.head;
    TComp prev = -1;
    while (crt != -1 && this->list.elements[crt] != this->getCurrent())
    {
        prev = crt;
        crt = this->list.next[crt];
    }
    TComp elem = this->getCurrent();
    this->next();
    if (crt == this->list.head)
        this->list.head = this->list.next[this->list.head];
    else
        this->list.next[prev] = this->list.next[crt];
    this->list.next[crt] = this->list.firstEmpty;
    this->list.firstEmpty = crt;
    this->list.nrElements--;
    return elem;
}//O(this->list.size())
//best case - theta(1) - the iterator is invalid(an exception is thrown) or the element to be removed is the head of the list
//worst case - theta(this->list.size()) - the iterator points to the last element in the list
//average case - theta(this->list.size()) - the iterator points to an element in the middle of the list

