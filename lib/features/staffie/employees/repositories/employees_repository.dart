import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/employee_model.dart';
import '../../../nexus/persons/models/person_model.dart'; // Fixed import path

class EmployeesRepository {
  final SupabaseClient _client;

  EmployeesRepository(this._client);

  Future<List<Employee>> getEmployees() async {
    final response = await _client
        .from('staffie.employees')
        .select()
        .filter('deleted_at', 'is', null) // Fixed: is_ -> filter
        .order('full_name');
    return (response as List).map((e) => Employee.fromJson(e)).toList();
  }

  Future<Employee> getEmployeeById(String id) async {
    final response = await _client
        .from('staffie.employees')
        .select()
        .eq('id', id)
        .single();
    return Employee.fromJson(response);
  }

  Future<void> createEmployee(Map<String, dynamic> data) async {
    await _client.from('staffie.employees').insert(data);
  }

  Future<void> updateEmployee(String id, Map<String, dynamic> data) async {
    await _client.from('staffie.employees').update(data).eq('id', id);
  }
  
  // Helper to find potential person linkage
  Future<List<Person>> searchPersons(String query) async {
    final response = await _client
        .from('nexus.persons')
        .select()
        .ilike('first_name', '%$query%')
        .limit(5);
    return (response as List).map((e) => Person.fromJson(e)).toList();
  }
}

final employeesRepositoryProvider = Provider<EmployeesRepository>((ref) {
  return EmployeesRepository(Supabase.instance.client);
});

final employeesListProvider = FutureProvider<List<Employee>>((ref) async {
  return ref.watch(employeesRepositoryProvider).getEmployees();
});

final employeeDetailProvider = FutureProvider.family<Employee, String>((ref, id) async {
  return ref.watch(employeesRepositoryProvider).getEmployeeById(id);
});
