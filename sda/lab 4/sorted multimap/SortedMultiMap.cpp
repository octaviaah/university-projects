#include "SMMIterator.h"
#include "SortedMultiMap.h"
#include <iostream>
#include <vector>
#include <exception>
using namespace std;

SortedMultiMap::SortedMultiMap(Relation r) {
    this->m = 19;
    this->r = r;
    this->nrPairs = 0;
    this->nrKeys = 0;
    this->t = new Node *[this->m];
    for (int i = 0; i < this->m; i++) {
        this->t[i] = NULL;
    }
}//theta(m)

void SortedMultiMap::add(TKey c, TValue v) {
    if (this->nrKeys/this->m > 0.7) {
        this->rehashing();
    }
	int index = hashFunction(c);
	Node* aux = this->t[index];
	Node* prev = NULL;
	int already = 0;
    if (this->t[index] == NULL)
    {
        Node* aux2 = new Node();
        aux2->key = c;
        aux2->capacity = 30;
        aux2->value_list = new TValue[aux2->capacity];
        aux2->value_list[0]= v;
        aux2->nrValues = 1;
        this->nrKeys++;
        aux2->next = this->t[index];
        this->t[index] = aux2;
        this->nrPairs++;
    }
    else {
        while (aux != NULL && this->r(aux->key, c)) {
            prev = aux;
            if (aux->key == c)
            {
                if (aux->capacity == aux->nrValues)
                    this->resize(aux);
                aux->value_list[aux->nrValues] = v;
                aux->nrValues++;
                this->nrPairs++;
                already = 1;
            }
            aux = aux->next;
        }
        if (aux != NULL && aux->key == c) {
            if (aux->capacity == aux->nrValues)
                this->resize(aux);
            aux->value_list[aux->nrValues] = v;
            aux->nrValues++;
            this->nrPairs++;
        }
        else if (already == 0){
            Node *aux2 = new Node();
            aux2->key = c;
            aux2->capacity = 30;
            aux2->value_list = new TValue[aux2->capacity];
            aux2->value_list[0] = v;
            aux2->nrValues = 1;
            this->nrKeys++;
            this->nrPairs++;
            if (aux == NULL) {
                aux2->next = NULL;
                prev->next = aux2;
            } else {
                if (prev != NULL) {
                    aux2->next = prev->next;
                    prev->next = aux2;
                } else {
                    aux2->next = this->t[index];
                    this->t[index] = aux2;
                }
            }
        }
    }
}//O(1) -> amortized
//O(m) in rare cases, were rehashing is needed
//worst case O(m+nrValues) -> needs rehashing and resizing

vector<TValue> SortedMultiMap::search(TKey c) {
	int index = this->hashFunction(c);
    Node* aux = this->t[index];
    vector<TValue> vect = vector<TValue>();
    while (aux !=NULL && aux->key != c)
    {
        aux = aux->next;
    }
    if (aux != NULL)
        for (int i=0; i<aux->nrValues; i++) {
            vect.push_back(aux->value_list[i]);
        }
	return vect;
}//O(nrValues) -> it needs to insert the values in the vector

bool SortedMultiMap::remove(TKey c, TValue v) {
    int index = this->hashFunction(c);
    Node* aux = this->t[index];
    Node *prev = NULL;
    while (aux != NULL && aux->key != c)
    {
        prev = aux;
        aux = aux->next;
    }
    if (aux != NULL && prev == NULL) {
        if (aux->nrValues != 1)
        {
            int i = 0;
            bool found = false;
            while (i < aux->nrValues && not found)
            {
                if (aux->value_list[i] == v)
                    found = true;
                else
                    i++;
            }
            if (not found)
                return false;
            else
            {
                aux->value_list[i] = aux->value_list[aux->nrValues - 1];
                aux->nrValues--;
                this->nrPairs--;
                return true;
            }
        }
        else
        {
            if (aux->value_list[0] == v) {
                this->t[index] = this->t[index]->next;
                delete aux;
                this->nrPairs--;
                this->nrKeys--;
                return true;
            }
            else return false;
        }
    }
    else if (aux != NULL)
    {
        if (aux->nrValues != 1)
        {
            int i = 0;
            bool found = false;
            while (i < aux->nrValues && not found)
            {
                if (aux->value_list[i] == v)
                    found = true;
                else
                    index++;
            }
            if (not found)
                return false;
            else
            {
                aux->value_list[i] = aux->value_list[aux->nrValues - 1];
                aux->nrValues--;
                this->nrPairs--;
                return true;
            }
        }
        else
        {
            if (aux->value_list[0] == v) {
                prev->next = aux->next;
                aux->next = NULL;
                delete aux;
                this->nrPairs--;
                this->nrKeys--;
                return true;
            }
            else return false;
        }
    }
    delete aux;
    return false;
}//O(nrValues) -> bc of the dynamic array of values, there is a high probability of needing to iterate through the vector(hence the nrValues)


int SortedMultiMap::size() const {
	return this->nrPairs;
}//theta(1)

bool SortedMultiMap::isEmpty() const {
	if (this->nrPairs == 0)
	    return true;
	return false;
}//theta(1)

SMMIterator SortedMultiMap::iterator(){
	return SMMIterator(*this);
}//theta(1)

SortedMultiMap::~SortedMultiMap() {
    for (int i=0; i<this->m; i++)
    {
        Node* aux = this->t[i];
        while (aux != NULL)
        {
            Node* temp = aux->next;
            delete [] aux->value_list;
            delete aux;
            aux = temp;
        }
        this->t[i] = NULL;
    }
    this->nrPairs = 0;
}//O(m)
//worst case O(m*n)

void SortedMultiMap::rehashing() {
    int oldm = this->m;
    this->m = this->m*2+1;
    Node** newt = new Node*[this->m];
    for (int i=0; i< this->m; i++)
        newt[i] = NULL;
    for (int i=0; i<oldm; i++)
    {
        Node* aux = this->t[i];
        while (aux != NULL)
        {
            Node* temp = aux;
            aux = aux->next;
            Node*& b = newt[this->hashFunction(temp->key)];
            temp->next = b;
            b = temp;
        }
    }
    delete [] this->t;
    this->t = newt;
}//O(m)
//worst case O(m*n)

void SortedMultiMap::resize(Node* aux)
{
    TValue* new_value_list;
    aux->capacity *= 2;
    new_value_list = new TValue[aux->capacity];
    int index;
    for (index = 0; index < aux->nrValues; index++)
        new_value_list[index] = aux->value_list[index];
    delete[] aux->value_list;
    aux->value_list = new_value_list;
}//O(nrValues)

void SortedMultiMap::display() {
    for (int i = 0; i < this->m; i++)
    {
        cout <<endl << "bucket" << i << endl;
        Node* aux = this->t[i];
        while (aux != NULL) {
            for (int j = 0; j < aux->nrValues; j++)
                cout << aux->key << " " << aux->value_list[j] << "     ";
            aux = aux->next;
        }
    }
}