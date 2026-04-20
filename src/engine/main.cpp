#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <algorithm>
#include <set>

using namespace std;

struct LottoSet {
    vector<int> numbers;
};

void print_json(const vector<LottoSet>& sets) {
    cout << "{\"games\": [" << endl;
    for (size_t i = 0; i < sets.size(); ++i) {
        cout << "  [";
        for (size_t j = 0; j < 6; ++j) {
            cout << sets[i].numbers[j] << (j == 5 ? "" : ", ");
        }
        cout << "]" << (i == sets.size() - 1 ? "" : ",") << endl;
    }
    cout << "]}" << endl;
}

void print_xml(const vector<LottoSet>& sets) {
    cout << "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" << endl;
    cout << "<LottoContainer>" << endl;
    for (const auto& set : sets) {
        cout << "  <Game>" << endl;
        for (int n : set.numbers) {
            cout << "    <Number>" << n << "</Number>" << endl;
        }
        cout << "  </Game>" << endl;
    }
    cout << "</LottoContainer>" << endl;
}

void print_text(const vector<LottoSet>& sets) {
    for (size_t i = 0; i < sets.size(); ++i) {
        cout << "[Set " << i + 1 << "] ";
        for (int n : sets[i].numbers) {
            printf("%02d ", n);
        }
        cout << endl;
    }
}

int main(int argc, char* argv[]) {
    string format = "text";
    for (int i = 1; i < argc; ++i) {
        if (string(argv[i]) == "--json") format = "json";
        else if (string(argv[i]) == "--xml") format = "xml";
    }

    vector<LottoSet> sets;
    string line;
    while (getline(cin, line)) {
        if (line.empty()) continue;
        stringstream ss(line);
        LottoSet current;
        int num;
        while (ss >> num) {
            current.numbers.push_back(num);
        }
        if (current.numbers.size() == 6) {
            sets.push_back(current);
        }
    }

    if (format == "json") print_json(sets);
    else if (format == "xml") print_xml(sets);
    else print_text(sets);

    return 0;
}
