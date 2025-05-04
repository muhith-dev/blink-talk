import 'dart:async';

import 'package:async/src/stream_sink_transformer.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class _DummyWebSocketChannel implements WebSocketChannel {
  const _DummyWebSocketChannel();

  @override
  Stream get stream => const Stream.empty();

  @override
  WebSocketSink get sink => _DummySink();

  @override
  StreamChannel<S> cast<S>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  StreamChannel changeSink(StreamSink Function(StreamSink p1) change) {
    // TODO: implement changeSink
    throw UnimplementedError();
  }

  @override
  StreamChannel changeStream(Stream Function(Stream p1) change) {
    // TODO: implement changeStream
    throw UnimplementedError();
  }

  @override
  // TODO: implement closeCode
  int? get closeCode => throw UnimplementedError();

  @override
  // TODO: implement closeReason
  String? get closeReason => throw UnimplementedError();

  @override
  void pipe(StreamChannel other) {
    // TODO: implement pipe
  }

  @override
  // TODO: implement protocol
  String? get protocol => throw UnimplementedError();

  @override
  // TODO: implement ready
  Future<void> get ready => throw UnimplementedError();

  @override
  StreamChannel<S> transform<S>(
    StreamChannelTransformer<S, dynamic> transformer,
  ) {
    // TODO: implement transform
    throw UnimplementedError();
  }

  @override
  StreamChannel transformSink(StreamSinkTransformer transformer) {
    // TODO: implement transformSink
    throw UnimplementedError();
  }

  @override
  StreamChannel transformStream(StreamTransformer transformer) {
    // TODO: implement transformStream
    throw UnimplementedError();
  }
}

class _DummySink implements WebSocketSink {
  const _DummySink();

  @override
  void add(data) {
    print("[DUMMY WEBSOCKET] Ignored data: $data");
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {}

  @override
  Future close([int? closeCode, String? closeReason]) async {}

  @override
  Future get done => Future.value();

  @override
  Future addStream(Stream stream) {
    // TODO: implement addStream
    throw UnimplementedError();
  }
}
