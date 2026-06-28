#pragma once

#include <string>
#include <string_view>

namespace app {

[[nodiscard]] std::string greeting(std::string_view name);

} // namespace app
