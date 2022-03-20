#include "SortedBag.h"
#include "SortedBagIterator.h"
#include <iostream>
#include "ShortTest.h"
#include "ExtendedTest.h"
#include <cassert>

using namespace std;

bool relation(TComp e1, TComp e2) {
    return e1 <= e2;
}

int main() {
	testAll();
	testAllExtended();

	SortedBag b(relation);
	b.add(5);
	b.add(3);
	assert(b.size() == 2);
	int nr = 4;
    b.addOccurences(nr, 4);
    assert(b.size() == 6);
    assert(b.search(4) == true);
    assert(b.nrOccurrences(4) == nr);

    int t = b.nrOccurrences(5);
    assert(t == 1);
    b.addOccurences(nr, 5);
    assert(b.size() == 10);
    assert(b.nrOccurrences(5) == nr + t);

    nr = -5;
    try
    {
        b.addOccurences(nr, 3);
        assert(false);
    }
    catch (exception&)
    {
        assert(true);
    }
    cout << "add occurrences test passed" << endl;

    SortedBag bb(relation);
    bb.add(3);
    bb.add(8);
    bb.add(4);
    bb.add(12);
    SortedBagIterator it = bb.iterator();
    cout << it.getCurrent();
    it.next();
    cout << it.getCurrent();
    it.next();
    cout << it.getCurrent();
    it.next();
    cout << it.getCurrent();
    cout << endl;
    bb.remove(4);
    it.first();
    cout << it.getCurrent();
    it.next();
    cout << it.getCurrent();
    it.next();
    cout <<it.getCurrent();

	
	cout << "Test over" << endl;
	system("pause");
}
