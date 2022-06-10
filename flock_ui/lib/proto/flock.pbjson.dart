///
//  Generated code. Do not modify.
//  source: flock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use broadcastDescriptor instead')
const Broadcast$json = const {
  '1': 'Broadcast',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.messages.Broadcast.Type', '10': 'type'},
    const {'1': 'announce', '3': 2, '4': 1, '5': 11, '6': '.messages.Announce', '9': 0, '10': 'announce'},
    const {'1': 'announce_request', '3': 3, '4': 1, '5': 11, '6': '.messages.AnnounceRequest', '9': 0, '10': 'announceRequest'},
  ],
  '4': const [Broadcast_Type$json],
  '8': const [
    const {'1': 'message'},
  ],
};

@$core.Deprecated('Use broadcastDescriptor instead')
const Broadcast_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'ANNOUNCE', '2': 0},
    const {'1': 'ANNOUNCE_REQUEST', '2': 1},
  ],
};

/// Descriptor for `Broadcast`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List broadcastDescriptor = $convert.base64Decode('CglCcm9hZGNhc3QSLAoEdHlwZRgBIAEoDjIYLm1lc3NhZ2VzLkJyb2FkY2FzdC5UeXBlUgR0eXBlEjAKCGFubm91bmNlGAIgASgLMhIubWVzc2FnZXMuQW5ub3VuY2VIAFIIYW5ub3VuY2USRgoQYW5ub3VuY2VfcmVxdWVzdBgDIAEoCzIZLm1lc3NhZ2VzLkFubm91bmNlUmVxdWVzdEgAUg9hbm5vdW5jZVJlcXVlc3QiKgoEVHlwZRIMCghBTk5PVU5DRRAAEhQKEEFOTk9VTkNFX1JFUVVFU1QQAUIJCgdtZXNzYWdl');
@$core.Deprecated('Use announceDescriptor instead')
const Announce$json = const {
  '1': 'Announce',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'interface', '3': 2, '4': 1, '5': 9, '10': 'interface'},
    const {'1': 'hw_addr', '3': 3, '4': 1, '5': 9, '10': 'hwAddr'},
    const {'1': 'ip_addr', '3': 4, '4': 1, '5': 9, '10': 'ipAddr'},
    const {'1': 'netmask', '3': 5, '4': 1, '5': 9, '10': 'netmask'},
  ],
};

/// Descriptor for `Announce`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List announceDescriptor = $convert.base64Decode('CghBbm5vdW5jZRISCgRuYW1lGAEgASgJUgRuYW1lEhwKCWludGVyZmFjZRgCIAEoCVIJaW50ZXJmYWNlEhcKB2h3X2FkZHIYAyABKAlSBmh3QWRkchIXCgdpcF9hZGRyGAQgASgJUgZpcEFkZHISGAoHbmV0bWFzaxgFIAEoCVIHbmV0bWFzaw==');
@$core.Deprecated('Use announceRequestDescriptor instead')
const AnnounceRequest$json = const {
  '1': 'AnnounceRequest',
};

/// Descriptor for `AnnounceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List announceRequestDescriptor = $convert.base64Decode('Cg9Bbm5vdW5jZVJlcXVlc3Q=');
@$core.Deprecated('Use commandDescriptor instead')
const Command$json = const {
  '1': 'Command',
  '2': const [
    const {'1': 'shutdown', '3': 1, '4': 1, '5': 11, '6': '.messages.ShutdownCommand', '9': 0, '10': 'shutdown'},
  ],
  '8': const [
    const {'1': 'command'},
  ],
};

/// Descriptor for `Command`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List commandDescriptor = $convert.base64Decode('CgdDb21tYW5kEjcKCHNodXRkb3duGAEgASgLMhkubWVzc2FnZXMuU2h1dGRvd25Db21tYW5kSABSCHNodXRkb3duQgkKB2NvbW1hbmQ=');
@$core.Deprecated('Use shutdownCommandDescriptor instead')
const ShutdownCommand$json = const {
  '1': 'ShutdownCommand',
  '2': const [
    const {'1': 'mode', '3': 1, '4': 1, '5': 14, '6': '.messages.ShutdownCommand.Mode', '10': 'mode'},
  ],
  '4': const [ShutdownCommand_Mode$json],
};

@$core.Deprecated('Use shutdownCommandDescriptor instead')
const ShutdownCommand_Mode$json = const {
  '1': 'Mode',
  '2': const [
    const {'1': 'POWER_OFF', '2': 0},
    const {'1': 'SLEEP', '2': 1},
  ],
};

/// Descriptor for `ShutdownCommand`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shutdownCommandDescriptor = $convert.base64Decode('Cg9TaHV0ZG93bkNvbW1hbmQSMgoEbW9kZRgBIAEoDjIeLm1lc3NhZ2VzLlNodXRkb3duQ29tbWFuZC5Nb2RlUgRtb2RlIiAKBE1vZGUSDQoJUE9XRVJfT0ZGEAASCQoFU0xFRVAQAQ==');
