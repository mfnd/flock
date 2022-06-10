///
//  Generated code. Do not modify.
//  source: flock.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'flock.pbenum.dart';

export 'flock.pbenum.dart';

enum Broadcast_Message {
  announce, 
  announceRequest, 
  notSet
}

class Broadcast extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Broadcast_Message> _Broadcast_MessageByTag = {
    2 : Broadcast_Message.announce,
    3 : Broadcast_Message.announceRequest,
    0 : Broadcast_Message.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Broadcast', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'messages'), createEmptyInstance: create)
    ..oo(0, [2, 3])
    ..e<Broadcast_Type>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Broadcast_Type.ANNOUNCE, valueOf: Broadcast_Type.valueOf, enumValues: Broadcast_Type.values)
    ..aOM<Announce>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'announce', subBuilder: Announce.create)
    ..aOM<AnnounceRequest>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'announceRequest', subBuilder: AnnounceRequest.create)
    ..hasRequiredFields = false
  ;

  Broadcast._() : super();
  factory Broadcast({
    Broadcast_Type? type,
    Announce? announce,
    AnnounceRequest? announceRequest,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (announce != null) {
      _result.announce = announce;
    }
    if (announceRequest != null) {
      _result.announceRequest = announceRequest;
    }
    return _result;
  }
  factory Broadcast.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Broadcast.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Broadcast clone() => Broadcast()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Broadcast copyWith(void Function(Broadcast) updates) => super.copyWith((message) => updates(message as Broadcast)) as Broadcast; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Broadcast create() => Broadcast._();
  Broadcast createEmptyInstance() => create();
  static $pb.PbList<Broadcast> createRepeated() => $pb.PbList<Broadcast>();
  @$core.pragma('dart2js:noInline')
  static Broadcast getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Broadcast>(create);
  static Broadcast? _defaultInstance;

  Broadcast_Message whichMessage() => _Broadcast_MessageByTag[$_whichOneof(0)]!;
  void clearMessage() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Broadcast_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Broadcast_Type v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  Announce get announce => $_getN(1);
  @$pb.TagNumber(2)
  set announce(Announce v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasAnnounce() => $_has(1);
  @$pb.TagNumber(2)
  void clearAnnounce() => clearField(2);
  @$pb.TagNumber(2)
  Announce ensureAnnounce() => $_ensure(1);

  @$pb.TagNumber(3)
  AnnounceRequest get announceRequest => $_getN(2);
  @$pb.TagNumber(3)
  set announceRequest(AnnounceRequest v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasAnnounceRequest() => $_has(2);
  @$pb.TagNumber(3)
  void clearAnnounceRequest() => clearField(3);
  @$pb.TagNumber(3)
  AnnounceRequest ensureAnnounceRequest() => $_ensure(2);
}

class Announce extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Announce', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'messages'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interface')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'hwAddr')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ipAddr')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'netmask')
    ..hasRequiredFields = false
  ;

  Announce._() : super();
  factory Announce({
    $core.String? name,
    $core.String? interface,
    $core.String? hwAddr,
    $core.String? ipAddr,
    $core.String? netmask,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (interface != null) {
      _result.interface = interface;
    }
    if (hwAddr != null) {
      _result.hwAddr = hwAddr;
    }
    if (ipAddr != null) {
      _result.ipAddr = ipAddr;
    }
    if (netmask != null) {
      _result.netmask = netmask;
    }
    return _result;
  }
  factory Announce.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Announce.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Announce clone() => Announce()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Announce copyWith(void Function(Announce) updates) => super.copyWith((message) => updates(message as Announce)) as Announce; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Announce create() => Announce._();
  Announce createEmptyInstance() => create();
  static $pb.PbList<Announce> createRepeated() => $pb.PbList<Announce>();
  @$core.pragma('dart2js:noInline')
  static Announce getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Announce>(create);
  static Announce? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get interface => $_getSZ(1);
  @$pb.TagNumber(2)
  set interface($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInterface() => $_has(1);
  @$pb.TagNumber(2)
  void clearInterface() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get hwAddr => $_getSZ(2);
  @$pb.TagNumber(3)
  set hwAddr($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasHwAddr() => $_has(2);
  @$pb.TagNumber(3)
  void clearHwAddr() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get ipAddr => $_getSZ(3);
  @$pb.TagNumber(4)
  set ipAddr($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasIpAddr() => $_has(3);
  @$pb.TagNumber(4)
  void clearIpAddr() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get netmask => $_getSZ(4);
  @$pb.TagNumber(5)
  set netmask($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasNetmask() => $_has(4);
  @$pb.TagNumber(5)
  void clearNetmask() => clearField(5);
}

class AnnounceRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'AnnounceRequest', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'messages'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  AnnounceRequest._() : super();
  factory AnnounceRequest() => create();
  factory AnnounceRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AnnounceRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AnnounceRequest clone() => AnnounceRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AnnounceRequest copyWith(void Function(AnnounceRequest) updates) => super.copyWith((message) => updates(message as AnnounceRequest)) as AnnounceRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static AnnounceRequest create() => AnnounceRequest._();
  AnnounceRequest createEmptyInstance() => create();
  static $pb.PbList<AnnounceRequest> createRepeated() => $pb.PbList<AnnounceRequest>();
  @$core.pragma('dart2js:noInline')
  static AnnounceRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AnnounceRequest>(create);
  static AnnounceRequest? _defaultInstance;
}

enum Command_Command {
  shutdown, 
  notSet
}

class Command extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Command_Command> _Command_CommandByTag = {
    1 : Command_Command.shutdown,
    0 : Command_Command.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Command', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'messages'), createEmptyInstance: create)
    ..oo(0, [1])
    ..aOM<ShutdownCommand>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'shutdown', subBuilder: ShutdownCommand.create)
    ..hasRequiredFields = false
  ;

  Command._() : super();
  factory Command({
    ShutdownCommand? shutdown,
  }) {
    final _result = create();
    if (shutdown != null) {
      _result.shutdown = shutdown;
    }
    return _result;
  }
  factory Command.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Command.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Command clone() => Command()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Command copyWith(void Function(Command) updates) => super.copyWith((message) => updates(message as Command)) as Command; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Command create() => Command._();
  Command createEmptyInstance() => create();
  static $pb.PbList<Command> createRepeated() => $pb.PbList<Command>();
  @$core.pragma('dart2js:noInline')
  static Command getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Command>(create);
  static Command? _defaultInstance;

  Command_Command whichCommand() => _Command_CommandByTag[$_whichOneof(0)]!;
  void clearCommand() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  ShutdownCommand get shutdown => $_getN(0);
  @$pb.TagNumber(1)
  set shutdown(ShutdownCommand v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasShutdown() => $_has(0);
  @$pb.TagNumber(1)
  void clearShutdown() => clearField(1);
  @$pb.TagNumber(1)
  ShutdownCommand ensureShutdown() => $_ensure(0);
}

class ShutdownCommand extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'ShutdownCommand', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'messages'), createEmptyInstance: create)
    ..e<ShutdownCommand_Mode>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mode', $pb.PbFieldType.OE, defaultOrMaker: ShutdownCommand_Mode.POWER_OFF, valueOf: ShutdownCommand_Mode.valueOf, enumValues: ShutdownCommand_Mode.values)
    ..hasRequiredFields = false
  ;

  ShutdownCommand._() : super();
  factory ShutdownCommand({
    ShutdownCommand_Mode? mode,
  }) {
    final _result = create();
    if (mode != null) {
      _result.mode = mode;
    }
    return _result;
  }
  factory ShutdownCommand.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ShutdownCommand.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ShutdownCommand clone() => ShutdownCommand()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ShutdownCommand copyWith(void Function(ShutdownCommand) updates) => super.copyWith((message) => updates(message as ShutdownCommand)) as ShutdownCommand; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ShutdownCommand create() => ShutdownCommand._();
  ShutdownCommand createEmptyInstance() => create();
  static $pb.PbList<ShutdownCommand> createRepeated() => $pb.PbList<ShutdownCommand>();
  @$core.pragma('dart2js:noInline')
  static ShutdownCommand getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ShutdownCommand>(create);
  static ShutdownCommand? _defaultInstance;

  @$pb.TagNumber(1)
  ShutdownCommand_Mode get mode => $_getN(0);
  @$pb.TagNumber(1)
  set mode(ShutdownCommand_Mode v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasMode() => $_has(0);
  @$pb.TagNumber(1)
  void clearMode() => clearField(1);
}

