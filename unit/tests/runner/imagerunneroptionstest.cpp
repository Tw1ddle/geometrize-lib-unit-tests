#include "catch.hpp"

#include "geometrize/runner/imagerunneroptions.h"

TEST_CASE("Test default image runner options are sensible", "[imagerunneroptions]")
{
    geometrize::ImageRunnerOptions options;

    const bool saneOptions = options.shapeBounds.xMinPercent >= 0 && options.shapeBounds.xMaxPercent <= 100
            && options.shapeBounds.yMinPercent >= 0 && options.shapeBounds.yMaxPercent <= 100;

    REQUIRE(saneOptions);
}
