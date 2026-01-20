import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

/// Callback type for handling incoming data from the WebSocket.
typedef OnDataCallback = void Function(dynamic data);

/// A simple WebSocket server for communicating with a WebView-based map.
class Websocket {
  Websocket._(this._server, void Function(dynamic data) onData) {
    _server.transform(WebSocketTransformer()).listen((ws) {
      _ws?.close();
      _ws = ws;
      ws.listen(onData);
    });
  }

  final HttpServer _server;
  WebSocket? _ws;

  /// The port the WebSocket server is listening on.
  int get port => _server.port;

  /// Creates a WebSocket server listening on a random available port on
  /// localhost.
  static Future<Websocket> create({required OnDataCallback onData}) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    return Websocket._(server, onData);
  }

  /// Sends a message to the connected WebSocket client.
  void send(ByteData data) {
    final ws = _ws;
    if (ws == null || ws.readyState != WebSocket.open) {
      throw StateError('WebSocket is not connected.');
    }
    final bytes = data.buffer.asUint8List().toList(growable: false);
    print('WebSocket send: $bytes');
    ws.add(bytes);
  }

  /// Closes the WebSocket server and any active connections.
  void dispose() {
    _ws?.close();
    _server.close();
  }
}
