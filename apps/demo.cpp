#include <iostream>
#include "myproj/vision.hpp"

int main()
{
    auto img = myproj::make_checkerboard(32, 32, 4);
    std::cout << "white pixels: " << myproj::count_white_pixels(img) << "\n";
    return 0;
}
