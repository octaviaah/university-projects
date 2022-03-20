cmake_minimum_required(VERSION 3.17)
project(testproject)

set(CMAKE_CXX_STANDARD 14)

add_executable(testproject ShortTest.cpp App.cpp SortedBag.cpp ExtendedTest.cpp ShortTest.cpp SortedBagIterator.cpp ShortTest.h SortedBag.h SortedBagIterator.h ExtendedTest.h)