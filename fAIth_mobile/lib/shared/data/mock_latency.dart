/// Default simulated network delay for Mock repositories.
const Duration kMockLatency = Duration(milliseconds: 400);

/// Waits [latency] (skipped when zero, so tests stay synchronous-friendly).
Future<void> simulateLatency(Duration latency) async {
  if (latency > Duration.zero) await Future<void>.delayed(latency);
}
