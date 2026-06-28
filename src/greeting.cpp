#include "app/greeting.hpp"

#include <fmt/format.h>

namespace app {

std::string greeting(std::string_view name) {
  return fmt::format("Hello, {}!", name);
}

} // namespace app
