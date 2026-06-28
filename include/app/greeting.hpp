#pragma once

#include <string>
#include <string_view>

namespace app {

[[nodiscard]] std::string Greeting(std::string_view name);

}  // namespace app
