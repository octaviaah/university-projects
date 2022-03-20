#include "SMMIterator.h"
#include "SortedMultiMap.h"

SMMIterator::SMMIterator(const SortedMultiMap& d) : map(d){
	this->current = d.head;
}//theta(1)

void SMMIterator::first(){
	this->current = this->map.head;
}//theta(1)

void SMMIterator::next(){
	if (this->current == NULL)
	    throw exception();
	else this->current = this->current->next;
}//theta(1)

bool SMMIterator::valid() const{
	if (this->current != NULL)
	    return true;
	return false;
}//theta(1)

TElem SMMIterator::getCurrent() const{
	if (this->current == NULL)
	    throw exception();
	TKey k = this->current->info.first;
	TValue v = this->current->info.second;
	return TElem(k, v);
}//theta(1)


