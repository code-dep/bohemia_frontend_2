import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

T serviceMethodWrapper<T>(Function() func) {
  var uuid = const Uuid().v4();
  final stopwatch = Stopwatch();

  if (kDebugMode) {
    print("[SMW] $uuid: Starting method");
  }
  stopwatch.start();
  try {
    var result = func();
    return result;
  } on Exception catch (e) {
    if (kDebugMode) {
      print("[SMW] $uuid: Exception: $e");
    }
    rethrow;
  } finally {
    stopwatch.stop();
    if (kDebugMode) {
      print("[SMW] $uuid: Method took ${stopwatch.elapsedMilliseconds}ms");
    }
  }
}

T apiMethodWrapper<T>(Function() func) {
  var uuid = const Uuid().v4();
  final stopwatch = Stopwatch();

  if (kDebugMode) {
    print("[AMW] $uuid: Starting method");
  }
  stopwatch.start();
  try {
    var result = func();
    return result;
  } on Exception catch (e) {
    if (kDebugMode) {
      print("[AMW] $uuid: Exception: $e");
    }
    rethrow;
  } finally {
    stopwatch.stop();
    if (kDebugMode) {
      print("[AMW] $uuid: Method took ${stopwatch.elapsedMilliseconds}ms");
    }
  }
}
