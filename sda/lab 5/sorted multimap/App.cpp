#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"
#include <cassert>
#include "SortedMultiMap.h"

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
	SortedMultiMap smm(a);
	int range = smm.getKeyRange();
	assert(range == -1);

	smm.add(5, 3);
	smm.add(2, 3);
	smm.add(5, 8);
	smm.add(1, 9);
	smm.add(1, 5);
	smm.add(5, 6);
	smm.add(7, 6);
	smm.add(9, 1);
	smm.add(8, 4);
	smm.add(9, 7);
	assert(smm.size() == 10);

	range = smm.getKeyRange();
	assert(range == 8);
	assert(smm.minimum() == 1);
	assert(smm.maximum() == 9);

    smm.remove(9, 1);
    assert(smm.size() == 9);
    range = smm.getKeyRange();
    assert(range == 8);

    smm.remove(9, 7);
    assert(smm.size() == 8);
    range = smm.getKeyRange();
    assert(range == 7);
    assert(smm.maximum() == 8);

    std::cout<<"Finished SMM Tests!"<<std::endl;
	system("pause");
}
