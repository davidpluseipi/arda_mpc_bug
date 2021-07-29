#include <iostream> 
#include <string>
#include "mex.hpp"
#include "mexAdapter.hpp"

using namespace std;
// using namespace matlab::data;
using matlab::mex::ArgumentList;

class MexFunction : public matlab::mex::Function {
    public:
        void operator()(ArgumentList outputs, matlab::mex::ArgumentList inputs){
            // Function implementation
            const char* str = "emergency.png";
            system(str);
        }
};
// Inputs and outputs to the MEX function are passed as elements in a 
// matlab::mex::ArgumentList. Each input or output argument is a matlab::data::Array 
// contained in the matlab::mex::ArgumentList.


void display_info(){
    const char* str = "emergency.png";
    system(str);
}


int main(){
    display_info();
    return 0;
} 