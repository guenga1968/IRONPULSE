import 'package:supabase_flutter/supabase_flutter.dart';
import 'models.dart';

class DataService {
  final _supabase = Supabase.instance.client;

  // -- CATEGORIES --
  Future<List<Category>> fetchCategories() async {
    final response = await _supabase.from('categories').select().order('name');
    return (response as List).map((json) => Category.fromJson(json)).toList();
  }

  // -- CLASSES & SCHEDULES --
  Future<List<ClassSchedule>> fetchFeaturedSchedules() async {
    // Current time for filtering upcoming classes
    final now = DateTime.now().toUtc().toIso8601String();

    final response = await _supabase
        .from('class_schedules')
        .select('''
          *,
          classes (*),
          instructors (*)
        ''')
        .gt('start_time', now)
        .order('start_time')
        .limit(5);

    return (response as List).map((json) {
      // Note: Supabase nested joins come back as objects/maps
      return ClassSchedule.fromJson(json);
    }).toList();
  }

  Future<List<ClassSchedule>> fetchUpcomingSchedules({
    String? categoryId,
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();

    var query = _supabase
        .from('class_schedules')
        .select('''
          *,
          classes (*),
          instructors (*)
        ''')
        .gt('start_time', now);

    if (categoryId != null) {
      query = query.eq('classes.category_id', categoryId);
    }

    final response = await query.order('start_time').limit(10);
    return (response as List)
        .map((json) => ClassSchedule.fromJson(json))
        .toList();
  }

  // -- BOOKINGS --
  Future<void> createBooking(String scheduleId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) throw Exception('User not logged in');

    await _supabase.from('bookings').insert({
      'user_id': userId,
      'schedule_id': scheduleId,
      'status': 'confirmed',
    });
  }

  Future<List<ClassSchedule>> fetchUserBookings() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _supabase
        .from('bookings')
        .select('''
          schedule_id,
          class_schedules (
            *,
            classes (*),
            instructors (*)
          )
        ''')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((json) {
      final scheduleJson = json['class_schedules'];
      return ClassSchedule.fromJson(scheduleJson);
    }).toList();
  }
}
