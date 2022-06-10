///
//  Generated code. Do not modify.
//  source: flock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Broadcast_Type extends $pb.ProtobufEnum {
  static const Broadcast_Type ANNOUNCE = Broadcast_Type._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ANNOUNCE');
  static const Broadcast_Type ANNOUNCE_REQUEST = Broadcast_Type._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ANNOUNCE_REQUEST');

  static const $core.List<Broadcast_Type> values = <Broadcast_Type> [
    ANNOUNCE,
    ANNOUNCE_REQUEST,
  ];

  static final $core.Map<$core.int, Broadcast_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Broadcast_Type? valueOf($core.int value) => _byValue[value];

  const Broadcast_Type._($core.int v, $core.String n) : super(v, n);
}

class ShutdownCommand_Mode extends $pb.ProtobufEnum {
  static const ShutdownCommand_Mode POWER_OFF = ShutdownCommand_Mode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'POWER_OFF');
  static const ShutdownCommand_Mode SLEEP = ShutdownCommand_Mode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SLEEP');

  static const $core.List<ShutdownCommand_Mode> values = <ShutdownCommand_Mode> [
    POWER_OFF,
    SLEEP,
  ];

  static final $core.Map<$core.int, ShutdownCommand_Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ShutdownCommand_Mode? valueOf($core.int value) => _byValue[value];

  const ShutdownCommand_Mode._($core.int v, $core.String n) : super(v, n);
}

