#include <iostream>

#include "ShortTest.h"
#include "ExtendedTest.h"
#include "SortedMultiMap.h"
#include <cassert>

bool ascd(TKey c1, TKey c2) {
    if (c1 <= c2) {
        return true;
    } else {
        return false;
    }
}


int main(){
    testAll();
	testAllExtended();

	SortedMultiMap smm(ascd);
	smm.add(1, 3);
	smm.add(7, 3);
	smm.add(1, 5);
	assert(smm.size() == 3);
	vector<TValue> vect = smm.removeKey(1);
	assert(smm.size() == 1);
	assert(vect.size() == 2);

	smm.add(3, 7);
	smm.add(3, 1);
	smm.add(4, 2);
	smm.add(4, 7);
	smm.add(7, 3);
	smm.add(4, 8);
    vect = smm.removeKey(4);
	assert(vect.size() == 3);
	assert(smm.size() == 4);
	vect = smm.removeKey(9);
	assert(vect.size() == 0);

    std::cout<<"Finished SMM Tests!"<<std::endl;
	system("pause");
}
