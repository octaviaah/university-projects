//
// Created by Expert on 3/21/2021.
//

#ifndef A45_OCTAVIAAH_DYNAMIC_VECTOR_H
#define A45_OCTAVIAAH_DYNAMIC_VECTOR_H

#include "event.h"
template <class T>

class DynamicVector
{
private:
    T* elements;
    int length;
    int capacity;
    void resize(int factor);

public:
    DynamicVector(int capacity = 10);
    DynamicVector(const DynamicVector& vect);
    ~DynamicVector();
    DynamicVector& operator=(const DynamicVector& vect);
    DynamicVector& operator+(T& e);
    void add(T e);
    T& operator[](int position);
    int size() const;
    int vector_capacity() const;
    int search(string title);
    void remove(int position);
    T* get_elements() const;
    int verify_date(T e1, T e2);
    void sort();
};

template <class T>
DynamicVector<T>::DynamicVector(int capacity)
/**
 * constructor of a dynamic vector with given capacity
 * @tparam T -> elements of the vector are of type T
 * @param capacity -> given capacity(int)
 */
{
    this->length = 0;
    this->capacity = capacity;
    this->elements = new T[capacity];
}

template <class T>
DynamicVector<T>::DynamicVector(const DynamicVector& vect)
/**
 * copy constructor of a dynamic vector
 * @tparam T -> elements of the vector are of type T
 * @param vect -> the dynamic vector from which we will copy data to build the new dynamic vector
 */
{
    this->length = vect.length;
    this->capacity = vect.capacity;
    this->elements = new T[this->capacity];
    int index;
    for (index = 0; index < this->length; index++)
        this->elements[index] = vect.elements[index];
}

template <class T>
DynamicVector<T>::~DynamicVector()
/**
 * destructor of dynamic vector
 * @tparam T -> elements of the vector are of type T
 */
{
    delete[] this->elements;
}

template <class T>
DynamicVector<T>& DynamicVector<T>::operator=(const DynamicVector &vect)
/**
 * assignment operator is overloaded
 * @tparam T -> elements of the vector are of type T
 * @param vect -> the dynamic vector used for the overloading
 * @return -> pointer to dynamic vector which got overloaded
 */
{
    if (this == &vect)
        return *this;
    this->length = vect.length;
    this->capacity = vect.capacity;

    delete[] this->elements;
    this->elements = new T[this->capacity];
    int index;
    for (index = 0; index < this->length; index++)
        this->elements[index] = vect.elements[index];

    return *this;
}

template <class T>
DynamicVector<T>& DynamicVector<T>::operator+(T &e)
/**
 * + operator is overloaded
 * @tparam T -> elements of the vector are of type T
 * @param e -> reference to element of type T
 * @return -> pointer to the dynamic vector, now containing e
 */
{
    this->add(e);
    return *this;
}

template <class T>
void DynamicVector<T>::add(T e)
/**
 * add element to the dynamic vector
 * @tparam T -> elements of the vector are of type T
 * @param e -> element of type T
 */
{
    if (this->length == this->capacity)
        this->resize(2);
    this->elements[this->length] = e;
    this->length++;
}

template <class T>
void DynamicVector<T>::resize(int factor)
/**
 * resizes the dynamic vector when its capacity is full
 * @tparam T -> elements of the vector are of type T
 * @param factor -> factor of resizing
 */
{
    this->capacity*=factor;
    T* new_elements = new T[this->capacity];
    int index;
    for (index = 0; index < this->length; ++index)
        new_elements[index] = this->elements[index];

    delete[] this->elements;
    elements = new_elements;
}

template <class T>
T& DynamicVector<T>::operator[](int position)
/**
 * [] operator is overloaded
 * @tparam T -> elements of the vector are of type T
 * @param position -> the position of an element in the dynamic vetor
 * @return -> the reference to the element on that position(T&)
 */
{
    return this->elements[position];
}

template <class T>
int DynamicVector<T>::size() const
/**
 * gets the current size of the dynamic vector
 * @tparam T -> elements of the vector are of type T
 * @return -> the current size of the vector(int)
 */
{
    return this->length;
}

template <class T>
int DynamicVector<T>::vector_capacity() const
/**
 * gets teh capacity of the dynamic vector
 * @tparam T -> elements of the vector are of type T
 * @return -> the capacity of the dynamic vector(int)
 */
{
    return this->capacity;
}

template <class T>
int DynamicVector<T>::search(string title)
/**
 * searches for an element with a given title(unique identifier) in the dynamic vector
 * @tparam T -> elements of the vector are of type T
 * @param title -> the unique identifier of the elements(string)
 * @return -> the index of the element if it was found
 *            -1 if not
 */
{
    for (int index = 0; index < this->length; index++)
        if (this->elements[index].get_title() == title)
            return index;
    return -1;
}

template <class T>
void DynamicVector<T>::remove(int position)
/**
 * removes an element from a given position in dynamic vector
 * @tparam T -> elements of the vector are of type T
 * @param position -> the position of the element to be removed(int)
 */
{
    for(int index = position; index < this->length - 1; index++)
        this->elements[index] = this->elements[index + 1];
    this->length --;
}

template <class T>
T* DynamicVector<T>::get_elements() const
/**
 * returns the elements of the dymanic vector
 * @tparam T -> elements of the vector are of type T
 * @return -> pointer to the elements of the vector(T*)
 */
{
    return this->elements;
}

template <class T>
int DynamicVector<T>::verify_date(T e1, T e2)
/**
 * verifies if the dates are in ascending order(used for the sorting function)
 * @tparam T -> elements of the vector are of type T
 * @param e1 -> element of class T
 * @param e2 -> element of class T
 * @return 1 if the dates are in ascending order
 *        -1 otherwise
 */
{
    if (e1.get_date_time().tm_year > e2.get_date_time().tm_year)
        return 1;
    else if (e1.get_date_time().tm_year == e2.get_date_time().tm_year && e1.get_date_time().tm_mday > e2.get_date_time().tm_mday)
        return 1;
    else if (e1.get_date_time().tm_mday == e2.get_date_time().tm_mday && e1.get_date_time().tm_hour > e2.get_date_time().tm_hour)
        return 1;
    else if (e1.get_date_time().tm_hour == e2.get_date_time().tm_hour && e1.get_date_time().tm_min > e2.get_date_time().tm_min)
        return 1;
    else return -1;
}

template <class T>
void DynamicVector<T>::sort()
/**
 * sorts the dynamic vector ascending, after date, using bubble sort
 * @tparam T -> elements of the vector are of type T
 */
{
    int index, ok;
    T elem;
    ok = 7;
    do
    {
        ok = 9;
        for (index = 0; index < this->length - 1; index++)
            if (verify_date(this->elements[index], this->elements[index+1]) == 1)
            {
                elem = this->elements[index];
                this->elements[index] = this->elements[index+1];
                this->elements[index+1] = elem;
                ok = 7;
            }
    }while(ok == 7);
}



#endif //A45_OCTAVIAAH_DYNAMIC_VECTOR_H
