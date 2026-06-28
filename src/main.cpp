#include <iostream>

#include "app/greeting.hpp"

int main() {
  std::cout << app::Greeting("ChatGPT") << '\n';

  return 0;
}
