import 'dart:convert';

class VpnStatus {
  String? byteIn;
  String? byteOut;
  String? durationTime;
  String? lastPacketReceive;

  VpnStatus({
    this.byteIn,
    this.byteOut,
    this.durationTime,
    this.lastPacketReceive,
  });

  Map<String, dynamic> toMap() {
    return {
      'byte_in': byteIn,
      'byte_out': byteOut,
      'duration': durationTime,
      'last_packet_receive': lastPacketReceive,
    };
  }

  factory VpnStatus.fromMap(Map<String, dynamic> map) {
    return VpnStatus(
      byteIn: map['byte_in'],
      byteOut: map['byte_out'],
      durationTime: map['duration'],
      lastPacketReceive: map['last_packet_receive'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VpnStatus.fromJson(String source) =>
      VpnStatus.fromMap(json.decode(source));
}
