#include <cstdint>
#include <iostream>
#include <chrono>

#include "app/greeting.hpp"
#include <google/protobuf/timestamp.pb.h>
#include <google/protobuf/util/time_util.h>
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

    // 2. 使用 chrono 内部最高效的 duration_cast 拆分秒和纳秒
    auto seconds = std::chrono::duration_cast<std::chrono::seconds>(duration).count();
    auto nanos = std::chrono::duration_cast<std::chrono::nanoseconds>(duration).count() % 1000000000;

    // 3. 终极优化：原位更新内存，绝对零深拷贝
    // mutable_xxx() 在第一次调用时在堆上开辟空间，后续调用直接返回指针
    google::protobuf::Timestamp* c_time = user.mutable_create_time();
    c_time->set_seconds(seconds);
    c_time->set_nanos(static_cast<int32_t>(nanos));

    // 复用拆分好的数据，直接设置 update_time
    google::protobuf::Timestamp* u_time = user.mutable_update_time();
    u_time->set_seconds(seconds);
    u_time->set_nanos(static_cast<int32_t>(nanos));
    
  std::cout << app::Greeting("ChatGPT") << '\n';
  user.PrintDebugString();
  
  return 0;
}
