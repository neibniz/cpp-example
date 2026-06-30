#include <iostream>

#include "app/greeting.hpp"
#include <neibniz/user/v1/user.pb.h>

int main() {

  neibniz::user::v1::User user;
    // 2. 填充基础字段
    user.set_id("user_987654321");
    user.set_display_name("张三");
    user.set_email("zhangsan@example.com");
    user.set_state(neibniz::user::v1::USER_STATE_ACTIVE);

    // 3. 获取当前时间并填充时间戳字段 (create_time 和 update_time)
    auto now = std::chrono::system_clock::now();
    auto duration = now.time_since_epoch();
    auto seconds = std::chrono::duration_cast<std::chrono::seconds>(duration).count();
    auto nanos = std::chrono::duration_cast<std::chrono::nanoseconds>(duration).count() % 1000000000;

    // 填充 create_time
    user.mutable_create_time()->set_seconds(seconds);
    user.mutable_create_time()->set_nanos(nanos);

    // 填充 update_time
    user.mutable_update_time()->set_seconds(seconds);
    user.mutable_update_time()->set_nanos(nanos);

  
  std::cout << app::Greeting("ChatGPT") << '\n';
  user.PrintDebugString();
  
  return 0;
}
