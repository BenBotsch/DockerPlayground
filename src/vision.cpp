#include "myproj/vision.hpp"
#include <opencv2/imgproc.hpp>
#include <stdexcept>

namespace myproj
{

cv::Mat make_checkerboard(int rows, int cols, int block_size)
{
    if (rows <= 0 || cols <= 0 || block_size <= 0) {
        throw std::invalid_argument("rows/cols/block_size must be > 0");
    }

    cv::Mat img(rows, cols, CV_8UC1, cv::Scalar(0));

    for (int r = 0; r < rows; ++r) {
        for (int c = 0; c < cols; ++c) {
            int br = r / block_size;
            int bc = c / block_size;
            bool white = ((br + bc) % 2) == 0;
            img.at<unsigned char>(r, c) = white ? 255 : 0;
        }
    }
    return img;
}

int count_white_pixels(const cv::Mat& img)
{
    if (img.empty()) return 0;
    if (img.type() != CV_8UC1) {
        throw std::invalid_argument("count_white_pixels expects CV_8UC1 image");
    }
    // countNonZero zählt != 0, bei unserem Bild ist das 255
    return cv::countNonZero(img);
}

} // namespace myproj
