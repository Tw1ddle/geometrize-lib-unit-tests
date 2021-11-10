#include "catch.hpp"

#include "geometrize/runner/imagerunner.h"

#include <algorithm>
#include <utility>
#include <vector>

#include "geometrize/bitmap/bitmap.h"
#include "geometrize/bitmap/rgba.h"
#include "geometrize/runner/imagerunneroptions.h"

TEST_CASE("Test default image runner shape scoring is sane", "[imagerunner]")
{
    const geometrize::Bitmap startBitmap(50, 50, geometrize::rgba{255, 255, 255, 255});
    const geometrize::Bitmap targetBitmap(50, 50, geometrize::rgba{0, 0, 0, 255});
    geometrize::ImageRunner runner(startBitmap, targetBitmap);

    const geometrize::ImageRunnerOptions options{};

    std::vector<geometrize::ShapeResult> results;
    const int stepCount{20};
    for(int i = 0; i < stepCount; i++) {
        const std::vector<geometrize::ShapeResult> shapes{runner.step(options)};
        std::move(shapes.begin(), shapes.end(), std::back_inserter(results));
    }

    std::vector<double> scores;
    REQUIRE(results.size() != 0); // NOTE: results.size() not necessarily equal to stepCount, because it is possible to match a single block of colour in less than stepCount iterations
    for(const auto& result : results) {
        REQUIRE(result.score >= 0.0);
        REQUIRE(result.score <= 1.0);
        scores.push_back(result.score);
    }

    REQUIRE(std::is_sorted(scores.begin(), scores.end(), std::greater<double>()));
}
