#include "ExtendedTest.h"
#include "ShortTest.h"

#include "FixedCapBiMap.h"


#include <iostream>
using namespace std;


int main() {
	testAll();
	testAllExtended();

	FixedCapBiMap f(10);
	f.add(1, 5);
	f.add(8, 9);
	f.add(8, 3);
	cout << f.size() << endl;
	f.remove_key(7);
	cout << f.size() << endl;

	cout << "That's all!" << endl;
	system("pause");
	return 0;
}


