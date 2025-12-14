import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/services/feedback_service.dart';
import '../../../../core/widgets/common/log_history_widget.dart';
import '../repositories/access_control_repository.dart';
import '../models/access_control_models.dart';

// --- Dashboard ---
class UsersDashboardPage extends ConsumerWidget {
  const UsersDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(moduleUsersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/users/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ModuleUser>>(
        value: usersAsync,
        data: (users) {
          return SfDataGrid(
            source: UserDataSource(users, context),
            columnWidthMode: ColumnWidthMode.fill,
             onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(
                  columnName: 'username',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Username'))),
              GridColumn(
                  columnName: 'display_name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Name'))),
               GridColumn(
                  columnName: 'status',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Status'))),
            ],
          );
        },
      ),
    );
  }
}

class UserDataSource extends DataGridSource {
  UserDataSource(List<ModuleUser> users, this.context) {
    _dataGridRows = users
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<ModuleUser>(columnName: 'obj', value: e),
              DataGridCell<String>(columnName: 'username', value: e.username ?? '-'),
              DataGridCell<String>(columnName: 'display_name', value: e.displayName ?? '-'),
              DataGridCell<String>(columnName: 'status', value: e.isDeleted ? 'Deleted' : 'Active'),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final user = row.getCells().first.value as ModuleUser;

    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/users/${user.id}'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
              style: user.isDeleted ? const TextStyle(color: Colors.red) : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// --- Detail ---
class UserDetailPage extends ConsumerWidget {
  final String userId;
  const UserDetailPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(moduleUserDetailProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/nexus/users/$userId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
               final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete User'),
                  content: const Text('Are you sure? This is a soft delete.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );

              if (confirm == true) {
                await ref.read(accessControlRepositoryProvider).deleteUser(userId);
                if (context.mounted) {
                  context.pop(); 
                }
              }
            },
          ),
        ],
      ),
      body: AsyncValueWidget<ModuleUser>(
        value: userAsync,
        data: (user) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.displayName ?? 'Unknown', style: Theme.of(context).textTheme.headlineSmall),
                        Text('@${user.username ?? "no_username"}', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey)),
                        const SizedBox(height: 16),
                        const Divider(),
                        Text('Roles', style: Theme.of(context).textTheme.titleMedium),
                        Wrap(
                            spacing: 8,
                            children: user.roles.map((r) => Chip(label: Text(r))).toList(),
                        ),
                        if (user.isDeleted) 
                             Container(
                                 margin: const EdgeInsets.only(top: 16),
                                 padding: const EdgeInsets.all(8),
                                 color: Colors.red[50],
                                 child: const Text('This user is DELETED', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                             ),
                      ],
                    ),
                  ),
                ),
                 const SizedBox(height: 24),
                 LogHistoryWidget(tableName: 'nexus.module_users', recordId: userId),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- Form ---
class UserFormPage extends ConsumerStatefulWidget {
  final String? userId;
  const UserFormPage({super.key, this.userId});

  @override
  ConsumerState<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends ConsumerState<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.userId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final user = await ref.read(accessControlRepositoryProvider).getUserById(widget.userId!);
      _usernameController.text = user.username ?? '';
      _nameController.text = user.displayName ?? '';
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load user');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'username': _usernameController.text,
      'display_name': _nameController.text,
      // roles would be handled by a separate assignment UI or multi-select here
    };

    try {
      if (widget.userId != null) {
        await ref.read(accessControlRepositoryProvider).updateUser(widget.userId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'User Updated');
      } else {
         await ref.read(accessControlRepositoryProvider).createUser(data);
         if(mounted) FeedbackService.showSuccess(context, 'User Created');
      }
      
      if (mounted) {
         ref.invalidate(moduleUsersListProvider);
         context.pop();
      }
    } catch(e) {
      if(mounted) FeedbackService.showError(context, e.toString());
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.userId != null ? 'Edit User' : 'New User')),
      body: _isLoading && widget.userId != null
       ? const Center(child: CircularProgressIndicator())
       : Padding(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _usernameController, decoration: const InputDecoration(labelText: 'Username'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Display Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
