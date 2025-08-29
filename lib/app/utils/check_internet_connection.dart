// ignore_for_file: strict_raw_type, lines_longer_than_80_chars, inference_failure_on_instance_creation, inference_failure_on_function_invocation, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

enum ConnectionStatus {
  online,
  offline,
}

class CheckInternetConnection {
  CheckInternetConnection() {
    _checkInternetConnection();
  }
  final Connectivity _connectivity = Connectivity();

  /// We assume the initial status is Online
  final _controller = BehaviorSubject.seeded(ConnectionStatus.offline);
  StreamSubscription? _connectionSubscription;

  Stream<ConnectionStatus> internetStatus() {
    _connectionSubscription ??= _connectivity.onConnectivityChanged.listen((_) => _checkInternetConnection());
    return _controller.stream;
  }

  Future<void> _checkInternetConnection() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      if (await hasNetwork('pronabec.gob.pe')) {
        if (!_controller.isClosed) {
          _controller.sink.add(ConnectionStatus.online);
        }
      } else {
        if (!_controller.isClosed) {
          _controller.sink.add(ConnectionStatus.offline);
        }
      }
    } catch (e) {
      if (!_controller.isClosed) _controller.sink.add(ConnectionStatus.offline);
    }
  }

  Future<void> close() async {
    await _connectionSubscription?.cancel();
    await _controller.close();
  }

  Future<ConnectionStatus> checkInternetConnectionInitApp() async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      if (await hasNetwork('pronabec.gob.pe')) {
        return ConnectionStatus.online;
      } else {
        return ConnectionStatus.offline;
      }
    } catch (e) {
      return ConnectionStatus.offline;
    }
  }

  Future<bool> hasNetwork(String knownUrl) async {
    if (kIsWeb) {
      return _hasNetworkWeb(knownUrl);
    } else {
      return _hasNetworkMobile(knownUrl);
    }
  }

  Future<bool> _hasNetworkWeb(String knownUrl) async {
    try {
      final result = await http.get(Uri.parse(knownUrl));
      return result.statusCode == 200;
    } on SocketException catch (_) {}
    return false;
  }

  Future<bool> _hasNetworkMobile(String knownUrl) async {
    try {
      final result = await InternetAddress.lookup(knownUrl);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on Exception catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
    return false;
  }
}
