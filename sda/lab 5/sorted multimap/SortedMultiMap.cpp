#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>
#include <vector>
#include <exception>
using namespace std;

SortedMultiMap::SortedMultiMap(Relation r) {
	this->r = r;
	this->capacity = 30;
	this->value_capacity = 10;
	this->nrElements = 0;
	this->root = -1;
	this->firstEmpty = 0;
	this->elements = new TKey[this->capacity];
	this->left = new int[this->capacity];
	this->right = new int[this->capacity];
	this->value_list = new TValue*[this->capacity];
	this->nrValues = new int[this->capacity];
	for (int index = 0; index < this->capacity; index++) {
        this->left[index] = index + 1;
        this->value_list[index] = new TValue[this->value_capacity];
        this->nrValues[index] = 0;
    }
	this->left[this->capacity - 1] = -1;
}//theta(this->capacity)

int SortedMultiMap::add_rec(int pos, TKey c, TValue v)
{
    if (this->nrElements == 0)
        this->root = 0;
    if (pos == -1) {
        this->elements[this->firstEmpty] = c;
        this->value_list[this->firstEmpty][this->nrValues[this->firstEmpty]] = v;
        pos = this->firstEmpty;
        this->nrValues[firstEmpty]++;
        this->nrElements++;
        this->firstEmpty = this->left[this->firstEmpty];
        this->left[pos] = -1;
        this->right[pos] = -1;
    } else {
        TElem e;
        e.first = c;
        e.second = v;
        if (c == this->elements[pos]) {
            this->value_list[pos][this->nrValues[pos]] = v;
            this->nrValues[pos]++;
            this->nrElements++;
        }
        else if (this->r(e.first, this->elements[pos])) {
            this->left[pos] = this->add_rec(this->left[pos], c, v);
        }
        else {
            this->right[pos] = this->add_rec(this->right[pos], c, v);
        }
    }
    return pos;
}//O(n)

void SortedMultiMap::add(TKey c, TValue v) {
    if (this->nrElements == this->capacity)
        this->resize();
    this->add_rec(this->root, c, v);
}//O(n + this->capacity*2)

vector<TValue> SortedMultiMap::search(TKey c) const {
	int current = this->root;
	bool found = false;
	vector<TValue> vect;
	while (current != -1 && not found)
    {
	    if (this->elements[current] == c)
        {
	        int index;
	        for (index = 0; index < this->nrValues[current]; index++)
	            vect.push_back(this->value_list[current][index]);
	        found = true;
        }
	    else if (this->r(c, this->elements[current]))
	        current = this->left[current];
	    else current = this->right[current];
    }
	return vect;
}//O(n)

bool SortedMultiMap::remove(TKey c, TValue v) {
    int current = this->root;
    int prev = -1;
    while (current != -1 && this->elements[current] != c)
    {
        prev = current;
        if (this->r(c, this->elements[current]))
            current = this->left[current];
        else current = this->right[current];
    }
    if (current == -1)
        return false;
    if (this->nrValues[current] != 1)
    {
        int index;
        bool found = false;
        for (index = 0; index < this->nrValues[current]; index++)
            if (this->value_list[current][index] == v)
            {
                found = true;
                break;
            }
        if (found == true)
        {
            this->value_list[current][index] = this->value_list[current][this->nrValues[current]-1];
            this->nrValues[current]--;
            this->nrElements--;
            return true;
        }
        else return false;
    }
    else {
        if (this->value_list[current][0] == v) {
            if (this->left[current] == -1 || this->right[current] == -1) {
                int newc;
                if (this->left[current] == -1)
                    newc = this->right[current];
                else newc = this->left[current];
                if (prev == -1) {
                    if (this->left[current] != -1)
                        this->root = this->left[current];
                    else this->root = this->right[current];
                    this->nrValues[current] = 0;
                    this->nrElements--;
                    return true;
                }
                if (current == this->left[prev])
                    this->left[prev] = newc;
                else
                    this->right[prev] = newc;
                this->nrElements--;
                this->nrValues[current] = 0;
            } else {
                int p = -1;
                int temp;
                temp = this->right[current];
                while (this->left[temp] != -1) {
                    p = temp;
                    temp = this->left[temp];
                }
                if (p != -1)
                    this->left[p] = this->right[temp];
                else
                    this->right[current] = this->right[temp];

                this->elements[current] = this->elements[temp];
                this->nrValues[current] = this->nrValues[temp];
                this->nrElements--;
            }
        }
        else return false;
    }
    return true;
}//O(n)


int SortedMultiMap::size() const {
	return this->nrElements;
}//theta(1)

bool SortedMultiMap::isEmpty() const {
	if (this->nrElements == 0) return true;
	return false;
}//theta(1)

SMMIterator SortedMultiMap::iterator() const {
	return SMMIterator(*this);
}//theta(1)

SortedMultiMap::~SortedMultiMap() {
    delete [] this->elements;
    delete [] this->left;
    delete [] this->right;
    delete [] this->nrValues;
    for (int i = 0; i<this->capacity; i++)
        delete [] this->value_list[i];
    delete this->value_list;
}
//O(this->capacity)

void SortedMultiMap::display()
{
    cout << this->root << endl;
    for (int i =0; i<100; i++)
        cout << this->elements[i] << " ";
    cout << endl << "left" << endl;
    for (int i =0; i<100; i++)
        cout << this->left[i] << " ";
    cout << endl << "right" << endl;
    for (int i =0; i<100; i++)
        cout << this->right[i] << " ";
    cout << endl;
    cout << this->nrValues[0] << " ";
    cout << endl;
    for (int i=0; i<this->nrValues[0]; i++)
        cout << this->value_list[0][i] << " ";
    cout << endl;
}

void SortedMultiMap::resize(){
    TKey* newElems;
    int* newLeft;
    int* newRight;
    TValue** newValueList;
    int* newNrValues;
    newElems = new TKey[this->capacity*2];
    newLeft = new int[this->capacity*2];
    newRight = new int[this->capacity*2];
    newNrValues = new int[this->capacity*2];
    newValueList = new TValue*[this->capacity*2];
    for (int index = 0; index < this->capacity*2; index++)
        newValueList[index] = new TValue[this->value_capacity * 2];
    for (int index = 0; index < this->capacity; index++)
    {
        newElems[index] = this->elements[index];
        newLeft[index] = this->left[index];
        newRight[index] = this->right[index];
        newNrValues[index] = this->nrValues[index];
        for (int j = 0; j < this->value_capacity; j++)
            newValueList[index][j] = this->value_list[index][j];
    }
    for (int index = this->capacity; index < this->capacity*2 - 1; index ++) {
        newLeft[index] = index + 1;
        newNrValues[index] = 0;
    }
    newLeft[this->capacity*2 - 1] = -1;
    delete [] this->elements;
    this->firstEmpty = this->capacity;
    this->capacity *= 2;
    this->value_capacity *= 2;
    this->elements = newElems;
    this->left = newLeft;
    this->right = newRight;
    this->value_list = newValueList;
    this->nrValues = newNrValues;
}//O(this->capacity*2)

int SortedMultiMap::minimum() const{
    int current = this->root;
    if (current == -1) return NULL_TVALUE;
    else {
        while (this->left[current] != -1)
            current = this->left[current];
        return this->elements[current];
    }
}//O(n)

int SortedMultiMap::maximum() const{
    int current = this->root;
    if (current == -1) return NULL_TVALUE;
    else {
        while (this->right[current] != -1)
            current = this->right[current];
        return this->elements[current];
    }
}//O(n)

int SortedMultiMap::getKeyRange() const {
    if (this->size() == 0) return -1;
    int min = this->minimum();
    int max = this->maximum();
    return max-min;
}//O(n) because of the 2 O(n) iterations