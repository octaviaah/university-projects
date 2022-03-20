cmake_minimum_required(VERSION 3.17)
project(sorted_iterated_list)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(sorted_iterated_list
        App.cpp
        ExtendedTest.cpp
        ExtendedTest.h
        ListIterator.cpp
        ListIterator.h
        ShortTest.cpp
        ShortTest.h
        SortedIteratedList.cpp
        SortedIteratedList.h)
