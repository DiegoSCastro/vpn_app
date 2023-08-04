import 'dart:convert';

class IpInfo {
  final String countryName;
  final String regionName;
  final String cityName;
  final String zipCode;
  final String timezone;
  final String internetServiceProvider;
  final String query;

  IpInfo({
    required this.countryName,
    required this.regionName,
    required this.cityName,
    required this.zipCode,
    required this.timezone,
    required this.internetServiceProvider,
    required this.query,
  });

  Map<String, dynamic> toMap() {
    return {
      'country': countryName,
      'regionName': regionName,
      'city': cityName,
      'zip': zipCode,
      'timezone': timezone,
      'isp': internetServiceProvider,
      'query': query,
    };
  }

  factory IpInfo.fromMap(Map<String, dynamic> map) {
    return IpInfo(
      countryName: map['country'] ?? '',
      regionName: map['regionName'] ?? '',
      cityName: map['city'] ?? '',
      zipCode: map['zip'] ?? '',
      timezone: map['timezone'] ?? 'Unknown',
      internetServiceProvider: map['isp'] ?? 'Unknown',
      query: map['query'] ?? 'Not available',
    );
  }

  String toJson() => json.encode(toMap());

  factory IpInfo.fromJson(String source) => IpInfo.fromMap(json.decode(source));
}
