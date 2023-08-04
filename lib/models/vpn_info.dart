import 'dart:convert';

class VpnInfo {
  final String hostName;
  final String ip;
  final int ping;
  final int speed;
  final String countryLongName;
  final String countryShortName;
  final int vpnSessionsNum;
  final String base64OpenVPNConfigurationsData;

  VpnInfo({
    required this.hostName,
    required this.ip,
    required this.ping,
    required this.speed,
    required this.countryLongName,
    required this.countryShortName,
    required this.vpnSessionsNum,
    required this.base64OpenVPNConfigurationsData,
  });

  Map<String, dynamic> toMap() {
    return {
      'HostName': hostName,
      'IP': ip,
      'Ping': ping,
      'Speed': speed,
      'CountryLong': countryLongName,
      'CountryShort': countryShortName,
      'NumVpnSessions': vpnSessionsNum,
      'OpenVPN_ConfigData_Base64': base64OpenVPNConfigurationsData,
    };
  }

  factory VpnInfo.fromMap(Map<String, dynamic> map) {
    return VpnInfo(
      hostName: map['HostName'] ?? '',
      ip: map['IP'] ?? '',
      ping: map['Ping'] ?? 0,
      speed: map['Speed']?.toInt() ?? 0,
      countryLongName: map['CountryLong'] ?? '',
      countryShortName: map['CountryShort'] ?? '',
      vpnSessionsNum: map['NumVpnSessions']?.toInt() ?? 0,
      base64OpenVPNConfigurationsData: map['OpenVPN_ConfigData_Base64'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VpnInfo.fromJson(String source) => VpnInfo.fromMap(json.decode(source));
}
