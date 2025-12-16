#pragma once

#include <opencv2/core.hpp>

namespace myproj
{
cv::Mat make_checkerboard(int rows, int cols, int block_size);
int count_white_pixels(const cv::Mat& img);
}
