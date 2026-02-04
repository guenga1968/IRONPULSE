import 'package:intl/intl.dart';

enum ClassIntensity { low, medium, high }

class Category {
  final String id;
  final String name;
  final String? iconUrl;

  Category({required this.id, required this.name, this.iconUrl});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Category',
      iconUrl: json['icon_url'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon_url': iconUrl,
  };
}

class Instructor {
  final String id;
  final String name;
  final String? avatarUrl;
  final String? bio;
  final double rating;

  Instructor({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.bio,
    this.rating = 5.0,
  });

  factory Instructor.fromJson(Map<String, dynamic> json) {
    return Instructor(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Instructor',
      avatarUrl: json['avatar_url'],
      bio: json['bio'],
      rating: _parseDouble(json['rating'], defaultValue: 5.0),
    );
  }

  static double _parseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}

class GymClass {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String categoryId;
  final ClassIntensity intensity;
  final int durationMinutes;
  final double basePrice;

  GymClass({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.categoryId,
    required this.intensity,
    required this.durationMinutes,
    this.basePrice = 0.0,
  });

  factory GymClass.fromJson(Map<String, dynamic> json) {
    return GymClass(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Class',
      description: json['description'],
      imageUrl: json['image_url'],
      categoryId: json['category_id']?.toString() ?? '',
      intensity: _parseIntensity(json['intensity']),
      durationMinutes: _parseInt(json['duration_minutes']),
      basePrice: _parseDouble(json['base_price']),
    );
  }

  static double _parseDouble(dynamic value, {double defaultValue = 0.0}) {
    if (value == null) return defaultValue;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static int _parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  static ClassIntensity _parseIntensity(String? intensity) {
    switch (intensity) {
      case 'Low':
        return ClassIntensity.low;
      case 'High':
        return ClassIntensity.high;
      default:
        return ClassIntensity.medium;
    }
  }
}

class ClassSchedule {
  final String id;
  final String classId;
  final String? instructorId;
  final DateTime startTime;
  final DateTime endTime;
  final int capacity;
  final String? locationName;
  final bool isLive;

  // Joins
  final GymClass? gymClass;
  final Instructor? instructor;
  final int confirmedBookings;

  ClassSchedule({
    required this.id,
    required this.classId,
    this.instructorId,
    required this.startTime,
    required this.endTime,
    required this.capacity,
    this.locationName,
    this.isLive = false,
    this.gymClass,
    this.instructor,
    this.confirmedBookings = 0,
  });

  String get formattedTime => DateFormat('HH:mm').format(startTime);
  String get duration => '${endTime.difference(startTime).inMinutes} min';
  int get availableSpots => capacity - confirmedBookings;
  bool get isFull => availableSpots <= 0;

  factory ClassSchedule.fromJson(Map<String, dynamic> json) {
    return ClassSchedule(
      id: json['id']?.toString() ?? '',
      classId: json['class_id']?.toString() ?? '',
      instructorId: json['instructor_id'],
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : DateTime.now(),
      endTime: json['end_time'] != null
          ? DateTime.parse(json['end_time'])
          : DateTime.now().add(const Duration(hours: 1)),
      capacity: _parseInt(json['capacity']),
      locationName: json['location_name'],
      isLive: json['is_live'] ?? false,
      gymClass: json['classes'] != null
          ? GymClass.fromJson(json['classes'])
          : null,
      instructor: json['instructors'] != null
          ? Instructor.fromJson(json['instructors'])
          : null,
      confirmedBookings: _parseInt(json['confirmed_bookings']),
    );
  }

  static int _parseInt(dynamic value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }
}
