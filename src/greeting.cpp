#include "app/greeting.hpp"

#include <fmt/format.h>

#include <string>
#include <string_view>

namespace app {

std::string Greeting(std::string_view name) {
  return fmt::format("Hello, {}!", name);
}

}  // namespace app
