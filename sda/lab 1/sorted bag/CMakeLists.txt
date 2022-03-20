cmake_minimum_required(VERSION 3.16.3)
project(container)

set(CMAKE_CXX_STANDARD 14)

add_executable(container SortedBag.cpp SortedBagIterator.cpp ShortTest.cpp App.cpp ExtendedTest.cpp)