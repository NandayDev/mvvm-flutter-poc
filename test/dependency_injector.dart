import 'package:flutter_simple_dependency_injection/injector.dart';

class DependencyInjector {

  bool _initialized = false;
  Injector injector;

  ///
  /// Initializes all the mappings for the D.I.
  ///
  void initialize() {
    injector = Injector();
    //injector.map<Logger>((i) => LoggerImpl());
  }

  ///
  /// Returns an instance of requested service
  ///
  T resolve<T>() {
    return injector.get<T>();
  }

  ///
  /// Static instance (singleton)
  ///
  static DependencyInjector _instance = DependencyInjector();

  ///
  /// Returns the singleton instance of the DependencyInjector, to be used for the D.I.
  ///
  static DependencyInjector getInstance() {
    if (!_instance._initialized) {
      _instance._initialized = true;
      _instance.initialize();
    }
    return _instance;
  }

}