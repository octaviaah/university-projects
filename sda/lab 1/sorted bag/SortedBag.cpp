#include "SortedBag.h"
#include "SortedBagIterator.h"
#include <exception>
#include <iostream>

using namespace std;

SortedBag::SortedBag(Relation r) {
    this->r = r;
    this->nrElements = 0;
    this->capacity = 30;
    this->elements = new TComp[this->capacity];
}//theta(1)

void SortedBag::add(TComp e) {
    if (this->nrElements == this->capacity)
        resize();
    int index = 0;
    bool added = false;
    if (this->nrElements == 0)
    {
        this->elements[0] = e;
        this->nrElements++;
    }
    else {
        while (index < this->nrElements && not added)
        {
            if (this->r(e, this->elements[index]))
            {
                int j = this->nrElements;
                this->nrElements++;
                while (j > index)
                {
                    this->elements[j] = this->elements[j - 1];
                    j--;
                }
                this->elements[index] = e;
                added = true;
            }
            index++;
        }
        if (not added)
        {
            this->elements[nrElements] = e;
            this->nrElements++;
        }
    }
}
//best case: if there are no elements at first - theta(1)
//worst case: element has to be added at the end and the bag has to be resized - theta(nrElements))
//avg case: element can be added in the middle - second while is done - theta(nrElements)
//total complexity - O(nrElements)
/**
 * cases:
i - nr = 0, add first
i - add element at pos 0
i - add element at pos 1
...
i - add element at pos n-1(last)
n+1 cases

p = 1/(n+1)

index = 0
	1 step
	n times 2nd
index = 1
	2 steps
	n-1 times 2nd

...
index = n-1
	n steps
	1 times

avg case = 1/(n+1) * n + 1/(n+1) * (n-1) + ... + 1/(n+1)
avg case = 1/(n+1) * (n + n-1 + ... 1) = n(n+1)/2*(n+1) => theta(n)
 */


bool SortedBag::remove(TComp e) {
	int index = 0;
	bool found = false;
	while (index < this->nrElements && not found)
    {
	    if (this->elements[index] == e)
	        found = true;
	    else
	        index++;
    }
	if (not found)
	    return false;
	else
    {
	    this->elements[index] = this->elements[this->nrElements - 1];
	    this->nrElements--;
	    return true;
    }
	return false;
}
//best case: first element has to be removed - theta(1)
//worst case: element not found at all - theta(nrElements)
//avg case: element is in the middle of the array - theta(nrElements)
//total complexity - O(nrElements)
/**
* cases:
i - remove element at pos 0
i - remove element at pos 1
...
i - remove element at pos n-1(last)
i - element not found
n+1 cases

p = 1/(n+1)

index = 0
	1 step
index = 1
	2 steps

...
index = n-1
	n steps

avg case = 1/(n+1) * 1 + 1/(n+1) * 2 + ... + 1/(n+1) * n
avg case = 1/(n+1) * (1 + 2 + .. + n) = n(n+1)/2*(n+1) => theta(n)
 */



bool SortedBag::search(TComp elem) const {
	int index = 0;
	while(index < this->nrElements)
    {
	    if (this->elements[index] == elem)
	        return true;
	    index++;
    }
	return false;
}
//best case: element found on first iteration- theta(1)
//worst case: element not found at all - theta(nrElements)
//avg case: element is in the middle of the array - theta(nrElements)
//total complexity - O(nrElements)
/**
* cases:
i - remove element at pos 0
i - remove element at pos 1
...
i - remove element at pos n-1(last)
i - element not found
n+1 cases

p = 1/(n+1)

index = 0
	1 step
index = 1
	2 steps

...
index = n-1
	n steps

avg case = 1/(n+1) * 1 + 1/(n+1) * 2 + ... + 1/(n+1) * n
avg case = 1/(n+1) * (1 + 2 + .. + n) = n(n+1)/2*(n+1) => theta(n)
 */


int SortedBag::nrOccurrences(TComp elem) const {
	int index = 0;
	int count = 0;
	while (index < this->nrElements)
    {
	    if (this->elements[index] == elem)
	        count++;
	    index++;
    }
	return count;
}//theta(nrElements)



int SortedBag::size() const {
	return this->nrElements;
}//theta(1)


bool SortedBag::isEmpty() const {
	if (this->nrElements == 0)
	    return true;
	return false;
}//theta(1)


SortedBagIterator SortedBag::iterator() const {
	return SortedBagIterator(*this);
}//theta(1)


SortedBag::~SortedBag() {
	delete[] this->elements;
}//theta(1)

void SortedBag::resize(){
    TComp* double_elements;
    this->capacity *= 2;
    double_elements = new TComp[this->capacity];
    int index;
    for (index = 0; index < this->nrElements; index++)
        double_elements[index] = this->elements[index];
    delete[] this->elements;
    this->elements = double_elements;
}//theta(nrElements)

void SortedBag::addOccurences(int nr, TComp elem)
{

    if (nr <= 0)
        throw exception();
    else {
        if (this->nrElements >= this->capacity-nr+1 && this->nrElements <= this->capacity)
            resize();
        int index = 0;
        bool added = false;
        if (this->nrElements == 0)
        {
            for (index = 0; index < nr; index++)
                this->elements[index] = elem;
            this->nrElements+=nr;
        }
        else {
            while (index < this->nrElements && not added)
            {
                if (this->r(elem, this->elements[index]))
                {
                    int j = this->nrElements+nr-1;
                    this->nrElements+=nr;
                    while (j > index)
                    {
                        this->elements[j] = this->elements[j - 1];
                        j--;
                    }
                    for (j = index; j < index+nr; j++)
                        this->elements[j] = elem;
                    added = true;
                }
                index+=nr;
            }
            if (not added)
            {
                for (index = this->nrElements; index < this->nrElements + nr; index++)
                    this->elements[index] = elem;
                this->nrElements+=nr;
            }
        }
    }
}
//best case - nr is 0 or negative, so the exception is thrown - theta(1)
//worst case - elements have to be added at the end and array has to be resized - theta(nrElements + nr)
//avg case - elements are added in the middle - theta(nrElements + nr)
//total complexity - O(nr+nrElements)
