import unittest

from src.data_structure.data_structure import DataStructure, filter, gnome_sort


class TestDataStructure(unittest.TestCase):
    def test_data(self):
        mylist = DataStructure()
        # sets items
        mylist[0] = '4'
        mylist[1] = '5'
        mylist[2] = '6'
        self.assertEqual(len(mylist), 3)

        # deletes item
        mylist[3] = '7'
        del mylist[3]
        self.assertEqual(len(mylist), 3)

        # verifies if values have right value
        self.assertEqual(list(mylist.values()), ['4', '5', '6'])

        # iteration
        for index in mylist:
            self.assertEqual(mylist[index], str(index+4))

        # next element
        self.assertEqual(next(mylist), '5')
        self.assertEqual(next(mylist), '6')
        self.assertRaises(StopIteration, next, mylist)

    def test_filter(self):
        mylist = DataStructure()
        mylist[0] = 7
        mylist[1] = 25
        mylist[2] = 3

        l1 = list(filter(lambda a: a > 6, mylist.values()))
        self.assertEqual(l1, [7, 25])

        l2 = list(filter(lambda a: a < 4, mylist.values()))
        self.assertEqual(l2, [3])

    def test_gnome_sort(self):
        mylist = DataStructure()
        mylist[0] = 258
        mylist[1] = 658
        mylist[2] = 10021
        mylist[3] = 4
        mylist[4] = 365
        mylist[5] = 41
        mylist[6] = 230
        mylist = gnome_sort(mylist)
        for index in mylist:
            if index < 6:
                self.assertLessEqual(mylist[index], mylist[index+1])
