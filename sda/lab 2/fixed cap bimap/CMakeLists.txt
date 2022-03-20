cmake_minimum_required(VERSION 3.17)
project(fixed_cap_bimap)

set(CMAKE_CXX_STANDARD 14)

include_directories(.)

add_executable(fixed_cap_bimap
        App.cpp
        ExtendedTest.cpp
        ExtendedTest.h
        FixedCapBiMap.cpp
        FixedCapBiMap.h
        FixedCapBiMapIterator.cpp
        FixedCapBiMapIterator.h
        ShortTest.cpp
        ShortTest.h)
