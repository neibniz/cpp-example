#include "app/greeting.hpp"

#include <benchmark/benchmark.h>

static void benchmarkGreeting(benchmark::State &state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(app::greeting("ChatGPT"));
  }
}

BENCHMARK(benchmarkGreeting);
BENCHMARK_MAIN();
