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
    const geometrize::Bitmap bitmap(50, 50, geometrize::rgba{255, 255, 255, 255});
    geometrize::ImageRunner runner(bitmap, bitmap);

    const geometrize::ImageRunnerOptions options{};

    std::vector<geometrize::ShapeResult> results;
    const int stepCount{20};
    for(int i = 0; i < stepCount; i++) {
        const std::vector<geometrize::ShapeResult> shapes{runner.step(options)};
        std::move(shapes.begin(), shapes.end(), std::back_inserter(results));
    }

    std::vector<float> scores;
    REQUIRE(results.size() == stepCount);
    for(int i = 0; i < results.size(); i++) {
        const geometrize::ShapeResult& result{results[i]};
        REQUIRE(result.score >= 0.0f);
        REQUIRE(result.score <= 1.0f);
        scores.push_back(result.score);
    }

    REQUIRE(std::is_sorted(scores.begin(), scores.end(), std::less<float>()));
}
