//
// Created by Expert on 4/18/2021.
//

#include "file_manager.h"
#include "iostream"

void FileManager::read_from_file(vector<Event>& vect, string file_name)
{
    ifstream fin(file_name);
    Event ev;
    while (fin >> ev)
        vect.push_back(ev);
}

void FileManagerText::write_to_file(const vector<Event> &vect, const string& file_name) {
    ofstream fout(file_name);
    for (auto& event : vect)
    {
        string output;
        output += event.get_title() + ",";
        output += event.get_description() + ",";
        output += to_string(event.get_date_time().tm_mday) + "-";
        output += to_string(event.get_date_time().tm_mon) + "-";
        output += to_string(event.get_date_time().tm_year) + " ";
        output += to_string(event.get_date_time().tm_hour) + ":";
        output += to_string(event.get_date_time().tm_min) + ",";
        output += to_string(event.get_people()) + ",";
        output += event.get_link();

        fout << output << endl;
    }
}

void FileManagerHTML::write_to_file(const vector<Event> &vect, const string &file_name) {
    ofstream fout(file_name);
    fout << "<!DOCTYPE html>" << endl;
    fout << "<html>" << endl;
    fout << "<head><title>Event list</title></head>" << endl;
    fout << "<body style=\"background-color:burlywood;\"><table border=\"1\">" << endl;
    fout << "<tr>" << endl;
    fout << "<td>Title</td>" << endl;
    fout << "<td>Description</td>" << endl;
    fout << "<td>Date and time</td>" << endl;
    fout << "<td>Number of people</td>" << endl;
    fout << "<td>Link</td>" << endl;
    fout << "</tr>" << endl;
    for (auto& event: vect)
    {
        fout << "<tr>" << endl;
        fout << "<td>" << event.get_title() << "</td>" << endl;
        fout << "<td>" << event.get_description() << "</td>" << endl;
        fout << "<td>" << event.get_date_time().tm_mday << "-" << event.get_date_time().tm_mon << "-" << event.get_date_time().tm_year << " " << event.get_date_time().tm_hour << ":" << event.get_date_time().tm_min << "</td>" << endl;
        fout << "<td>" << event.get_people() << "</td>" << endl;
        fout << "<td><a href=" << "\"" <<  event.get_link() << "\">Link</a></td>" << endl;
        fout << "</tr>" << endl;
    }
    fout << "</table>" << endl << "</body>" << endl << "</html>" << endl;
}