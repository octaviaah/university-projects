#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"
#include "SortedIteratedList.h"
#include "ListIterator.h"
#include <cassert>

using namespace std;

bool ascd(TComp c1, TComp c2) {
    if (c1 <= c2) {
        return true;
    } else {
        return false;
    }
}

int main(){
    testAll();
    testAllExtended();
    SortedIteratedList list = SortedIteratedList(ascd);
    list.add(5);
    list.add(9);
    list.add(7);
    list.add(10);
    list.add(2);
    assert(list.size() == 5);
    ListIterator it = list.first();
    assert(it.valid());
    assert(it.getCurrent() == 2);
    it.next();
    assert(it.getCurrent() == 5);
    TComp e = it.remove();
    assert(e == 5);
    assert(it.getCurrent() == 7);
    assert(list.size() == 4);
    it.next();
    it.next();
    e = it.remove();
    assert(e == 10);
    assert(!it.valid());

    std::cout<<"Finished IL Tests!"<<std::endl;
	system("pause");
}