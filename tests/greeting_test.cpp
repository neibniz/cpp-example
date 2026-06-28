#include "app/greeting.hpp"

#include <gtest/gtest.h>

TEST(GreetingTest, FormatsName) {
  EXPECT_EQ("Hello, ChatGPT!", app::Greeting("ChatGPT"));
}
