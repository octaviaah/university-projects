#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>

using namespace std;

SMMIterator::SMMIterator(SortedMultiMap& d) : map(d){
    this->list = NULL;
    this->prev = NULL;
    this->mergeLists();
    this->currentNode = this->list;
    this->currentValPos = 0;
}

void SMMIterator::first(){
    this->currentNode = this->list;
    this->prev = NULL;
    this->currentValPos = 0;
}//theta(1)

void SMMIterator::next(){
    if (this->currentNode == NULL)
        throw exception();
    else
    {
        if (this->currentValPos >= this->currentNode->nrValues - 1) {
            if (this->currentNode->next != NULL)
                this->currentValPos = 0;
            this->prev = this->currentNode;
            this->currentNode = this->currentNode->next;
        }
        else this->currentValPos++;
    }
}//theta(1)

bool SMMIterator::valid() const{
    if (this->currentNode != NULL)
        return true;
    return false;
}//theta(1)

TElem SMMIterator::getCurrent() const{
    if (this->currentNode == NULL)
        throw exception();
    TKey k = this->currentNode->key;
    TValue v = this->currentNode->value_list[this->currentValPos];
    return TElem(k, v);
}//theta(1)

Node* SMMIterator::copy(Node *l) {
    if (l == NULL) return NULL;
    Node* result = new Node;
    result->key = l->key;
    result->capacity = l->capacity;
    result->nrValues = l->nrValues;
    result->value_list = l->value_list;
    result->next = copy(l->next);
    return result;
}//O(list length)

Node* SMMIterator::mergeTwo(Node *l, Node *t) {
    Node* result = new Node();
    Node* prev = result;
    while (l != NULL && t != NULL)
    {
        if (this->map.r(l->key, t->key))
        {
            prev->next = l;
            l = l->next;
        }
        else
        {
            prev->next = t;
            t = t->next;
        }
        prev = prev->next;
    }
    if (l == NULL)
        prev->next = t;
    if (t == NULL)
        prev->next = l;
    return result->next;
}//O(2*n/m)
//n/m -> load factor

void SMMIterator::mergeLists() {
    Node** cop = new Node*[this->map.m];
    for (int i = 0; i<this->map.m; i++)
    {
        cop[i] = copy(this->map.t[i]);
    }
    Node *res = NULL;
    for (int i = 0; i < this->map.m; i++) {
        Node* aux = cop[i];
        res = mergeTwo(res, aux);
    }
    this->list = res;
}//O(m*(n+1))

TElem SMMIterator::remove(){
    if (!this->valid())
        throw exception();
    TElem e = this->getCurrent();
    TKey k = e.first;
    TValue v = e.second;
    this->map.remove(k, v);
    this->prev->next = this->currentNode->next;
    this->next();
    return e;
}//O(nrValues) -> bc of the complexity of remove function from the multimap
