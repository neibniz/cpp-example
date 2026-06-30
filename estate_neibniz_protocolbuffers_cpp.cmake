include(FetchContent)
FetchContent_Declare(estate_neibniz_protocolbuffers_cpp
    URL https://buf.build/gen/cmake/estate/neibniz/protocolbuffers/cpp/v35.0-625cdcc0f5c2.1
    EXCLUDE_FROM_ALL
)
FetchContent_MakeAvailable(estate_neibniz_protocolbuffers_cpp)