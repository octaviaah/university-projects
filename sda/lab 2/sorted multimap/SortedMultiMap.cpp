#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>
#include <vector>
#include <exception>
using namespace std;

SortedMultiMap::SortedMultiMap(Relation r) {
    this->head = NULL;
    this->r = r;
    this->length = 0;
}//theta(1)

void SortedMultiMap::add(TKey c, TValue v) {
	Node* aux = this->head;
	Node* prev = NULL;
	if (this->head == NULL)
    {
	    Node* aux2 = new Node();
	    aux2->info.first = c;
	    aux2->info.second = v;
	    aux2->next = this->head;
	    this->head = aux2;
	    this->length++;
    }
	else {
        while (aux != NULL && this->r(aux->info.first, c)) {
            prev = aux;
            aux = aux->next;
        }
        Node *aux2 = new Node();
        aux2->info.first = c;
        aux2->info.second = v;
        if (aux == NULL) {
            aux2->next = NULL;
            prev->next = aux2;
            this->length++;
        }
        else
        {
            if (prev != NULL) {
                aux2->next = prev->next;
                prev->next = aux2;
                this->length++;
            }
            else {
                aux2->next = this->head;
                this->head = aux2;
                this->length++;
            }
        }
    }
}//O(n)

vector<TValue> SortedMultiMap::search(TKey c) const {
    Node* aux = this->head;
    vector<TValue> vect = vector<TValue>();
    while (aux != NULL && this->r(aux->info.first, c))
    {
        if (aux->info.first == c) {
            vect.push_back(aux->info.second);
        }
        aux = aux->next;
    }
	return vect;
}//O(n)

bool SortedMultiMap::remove(TKey c, TValue v) {
	Node* aux = this->head;
	Node *prev = NULL;
	while (aux != NULL && (aux->info.first != c || aux->info.second != v))
    {
	    prev = aux;
	    aux = aux->next;
    }
	if (aux != NULL && prev == NULL) {
        this->head = this->head->next;
        delete aux;
        this->length--;
        return true;
    }
	else if (aux != NULL)
    {
	    prev->next = aux->next;
	    aux->next = NULL;
	    delete aux;
	    this->length--;
	    return true;
    }
	delete aux;
    return false;
}//O(n)


int SortedMultiMap::size() const {
	return this->length;
}//theta(1)

bool SortedMultiMap::isEmpty() const {
	if (this->head == NULL)
	    return true;
	return false;
}//theta(1)

SMMIterator SortedMultiMap::iterator() const {
	return SMMIterator(*this);
}//theta(1)

SortedMultiMap::~SortedMultiMap() {
    Node * aux = this->head;
	while (aux != NULL)
    {
        Node* temp = aux->next;
        delete aux;
        aux = temp;
    }
	this->head = NULL;
	this->length = 0;
}//theta(n)

vector<TValue> SortedMultiMap::removeKey(TKey key){
    Node* prev = NULL;
    Node* aux = this->head;
    vector<TValue> vect;
    while (aux != NULL && aux->info.first != key)
    {
        prev = aux;
        aux = aux->next;
    }
    if (prev != NULL)
    {
        while (aux != NULL && aux->info.first == key) {
            vect.push_back(aux->info.second);
            prev->next = aux->next;
            aux->next = NULL;
            this->length--;
            delete aux;
            aux = prev->next;
        }
    }
    else{
        while (aux != NULL && aux->info.first == key) {
            vect.push_back(aux->info.second);
            this->head = this->head->next;
            this->length--;
            delete aux;
            aux = this->head;
        }
    }
    return vect;
}//O(n)
//best case - the key is the first and is remove - theta(1)
//worst case - the key is the last one or the smm has the same key all over - theta(n)
//worst case - the key is not in the smm - theta(n)
//average case - because the first while is continued by the second or third while where it left, there will always be n steps made - theta(n)
//total complexity - O(n)

