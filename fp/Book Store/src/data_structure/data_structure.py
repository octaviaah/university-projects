def filter(condition, mylist):
    for i in mylist:
        if condition(i):
            yield i


def gnome_sort(mylist, comparator=lambda x, y: x < y):
    index = 0
    while index < len(mylist):
        if index == 0 or comparator(mylist[index-1], mylist[index]):
            index += 1
        else:
            mylist[index], mylist[index-1] = mylist[index-1], mylist[index]
            index -= 1
    return mylist


class DataStructure:
    def __init__(self):
        self.data = {}
        self._index = 0

    def values(self):
        return self.data.values()

    def __setitem__(self, key, value):
        self.data[key] = value

    def __getitem__(self, item):
        return self.data[item]

    def __delitem__(self, key):
        del self.data[key]

    def __iter__(self):
        self._index = 0
        return iter(self.data)

    def __next__(self):
        if self._index < len(self.data.keys()) - 1:
            self._index += 1
            return self.data[list(self.data.keys())[self._index]]
        else:
            raise StopIteration

    def __len__(self):
        return len(self.data)