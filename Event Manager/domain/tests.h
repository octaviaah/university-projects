//
// Created by Expert on 3/20/2021.
//

#ifndef A45_OCTAVIAAH_TESTS_H
#define A45_OCTAVIAAH_TESTS_H

#include "event.h"
#include <ctime>
#include "validator.h"

class RunTestsDomain{
public:
    static void testEvent();
    static void testValidatorEvent();
    static void testValidatorTitle();
    static void testValidatorDescription();
    static void testValidatorDateTime();
    static void testValidatorPeople();
    static void testValidatorLink();
    static void run_tests_domain();
    static void test_read_from_file();
    static void test_write_to_console();
};

#endif //A45_OCTAVIAAH_TESTS_H
