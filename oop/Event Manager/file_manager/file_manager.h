//
// Created by Expert on 4/18/2021.
//

#ifndef A67_OCTAVIAAH_FILE_MANAGER_H
#define A67_OCTAVIAAH_FILE_MANAGER_H

#include <fstream>
#include "event.h"
#include <vector>

class FileManager{
    public:
        FileManager() = default;
        virtual ~FileManager() = default;
        static void read_from_file(vector<Event> &vect, string file_name);
        virtual void write_to_file(const vector<Event>& vect, const string& file_name) = 0;
};

class FileManagerText : public FileManager {
    public:
        FileManagerText() = default;
        void write_to_file(const vector<Event>& vect, const string& file_name) override;
};

class FileManagerHTML : public FileManager {
    public:
        FileManagerHTML() = default;
        void write_to_file(const vector<Event>& vect, const string& file_name) override;
};

#endif //A67_OCTAVIAAH_FILE_MANAGER_H
