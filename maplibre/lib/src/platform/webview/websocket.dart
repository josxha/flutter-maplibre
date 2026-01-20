import 'dart:convert';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

/// Callback type for handling incoming data from the WebSocket.
typedef OnDataCallback = void Function(dynamic data);

/// A simple WebSocket server for communicating with a WebView-based map.
class WebSocket {
  WebSocket._(this._server, void Function(dynamic data) onData) {
    _server.transform(io.WebSocketTransformer()).listen((ws) {
      _ws?.close();
      _ws = ws;
      ws.listen(onData);
    });
  }

  final io.HttpServer _server;
  io.WebSocket? _ws;

  /// The port the WebSocket server is listening on.
  int get port => _server.port;

  /// Creates a WebSocket server listening on a random available port on
  /// localhost.
  static Future<WebSocket> create({required OnDataCallback onData}) async {
    final server = await io.HttpServer.bind(io.InternetAddress.loopbackIPv4, 0);
    return WebSocket._(server, onData);
  }

  /// Sends a binary message to the connected WebSocket client.
  void sendBytes(ByteData data) {
    final ws = _ws;
    if (ws == null || ws.readyState != io.WebSocket.open) {
      throw StateError('WebSocket is not connected.');
    }
    final bytes = data.buffer.asUint8List().toList(growable: false);
    // debugPrint('WebSocket send: $bytes');
    ws.add(bytes);
  }

  /// Sends a JSON-encoded message to the connected WebSocket client.
  void sendJson(Map<String, Object?> json) {
    final ws = _ws;
    if (ws == null || ws.readyState != io.WebSocket.open) {
      throw StateError('WebSocket is not connected.');
    }
    // debugPrint('WebSocket send: $json');
    final data = jsonEncode(json);
    ws.add(data);
  }

  /// Closes the WebSocket server and any active connections.
  void dispose() {
    _ws?.close();
    _server.close();
  }
}
