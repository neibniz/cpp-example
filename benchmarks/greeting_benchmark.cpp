#include <benchmark/benchmark.h>

#include "app/greeting.hpp"

static void BenchmarkGreeting(benchmark::State& state) {
  // NOLINTNEXTLINE(clang-analyzer-deadcode.DeadStores)
  for (auto _ : state) {
    benchmark::DoNotOptimize(app::Greeting("ChatGPT"));
  }
}

BENCHMARK(BenchmarkGreeting);
BENCHMARK_MAIN();
