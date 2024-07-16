import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logging.dart';

final _logger = logging('LoggingProviderObserver.providerDidFail');

class LoggingProviderObserver extends ProviderObserver {
  const LoggingProviderObserver();

  @override
  void providerDidFail(
    ProviderBase provider,
    Object error,
    StackTrace stackTrace,
    ProviderContainer container,
  ) {
    _logger.severe(
      'provider "${provider.name ?? provider.runtimeType}" failed',
      error,
      stackTrace,
    );
  }
}
