#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"
#include "SortedMultiMap.h"
#include <cassert>
#include "SMMIterator.h"

bool a(TKey c1, TKey c2) {
    if (c1 <= c2) {
        return true;
    } else {
        return false;
    }
}

int main(){
    testAll();
	testAllExtended();
    SortedMultiMap m(a);
    assert (m.size() == 0);

    m.add(2, 5);
    m.add(7, 3);
    m.add(2, 1);
    m.add(1, 12);
    m.add(4, 9);
    assert (m.size() == 5);

    SMMIterator it = m.iterator();
    it.next();
    TElem e = it.remove();
    assert (e.first == 2);
    assert(e.second == 5);
    assert(it.getCurrent().first == 2);
    assert(it.getCurrent().second == 1);
    assert(m.size() == 4);

    e = it.remove();
    assert (e.first == 2);
    assert (e.second == 1);
    assert(it.getCurrent().first == 4);
    assert(it.getCurrent().second == 9);
    assert(m.size() == 3);

    it.next();
    e = it.remove();
    assert(e.first == 7);
    assert(e.second == 3);
    assert(m.size() == 2);

    assert(!it.valid());
    try {
        it.next();
        assert(false);
    }
    catch (exception& ex) {
        assert(true);
    }
    std::cout<<"Finished SMM Tests!"<<std::endl;
	system("pause");
}
