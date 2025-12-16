#include <catch2/catch_test_macros.hpp>
#include "myproj/vision.hpp"

TEST_CASE("checkerboard has expected number of white pixels")
{
    // 8x8, block_size=1 => exakt abwechselnd, Start weiß (0,0)
    auto img = myproj::make_checkerboard(8, 8, 1);
    // Bei 8x8 sind 32 Felder weiß, 32 schwarz
    REQUIRE(myproj::count_white_pixels(img) == 32);
}

TEST_CASE("checkerboard bigger blocks still sane")
{
    auto img = myproj::make_checkerboard(16, 16, 4);
    REQUIRE(myproj::count_white_pixels(img) > 0);
    REQUIRE(myproj::count_white_pixels(img) < 16 * 16);
}
