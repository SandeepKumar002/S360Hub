import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/access_control_repository.dart';
import '../models/access_control_models.dart';

// --- Dashboard ---
class RolesDashboardPage extends ConsumerWidget {
  const RolesDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rolesAsync = ref.watch(moduleRolesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Roles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/roles/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ModuleRole>>(
        value: rolesAsync,
        data: (roles) {
          return SfDataGrid(
            source: RoleDataSource(roles, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Role Name'))),
              GridColumn(
                  columnName: 'code',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Code'))),
            ],
          );
        },
      ),
    );
  }
}

class RoleDataSource extends DataGridSource {
  RoleDataSource(List<ModuleRole> roles, this.context) {
    _dataGridRows = roles
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<ModuleRole>(columnName: 'obj', value: e),
              DataGridCell<String>(columnName: 'name', value: e.displayName),
              DataGridCell<String>(columnName: 'code', value: e.roleCode),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final role = row.getCells().first.value as ModuleRole;

    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/roles/${role.id}/edit'), // Direct to edit for simple tables
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              dataGridCell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }
}


// --- Form ---
class RoleFormPage extends ConsumerStatefulWidget {
  final String? roleId;
  const RoleFormPage({super.key, this.roleId});

  @override
  ConsumerState<RoleFormPage> createState() => _RoleFormPageState();
}

class _RoleFormPageState extends ConsumerState<RoleFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.roleId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final role = await ref.read(accessControlRepositoryProvider).getRoleById(widget.roleId!);
      _codeController.text = role.roleCode;
      _nameController.text = role.displayName;
      _descController.text = role.description ?? '';
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load role');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'role_code': _codeController.text,
      'display_name': _nameController.text,
      'description': _descController.text,
    };

    try {
      if (widget.roleId != null) {
        await ref.read(accessControlRepositoryProvider).updateRole(widget.roleId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'Role Updated');
      } else {
         await ref.read(accessControlRepositoryProvider).createRole(data);
         if(mounted) FeedbackService.showSuccess(context, 'Role Created');
      }
      
      if (mounted) {
         ref.invalidate(moduleRolesListProvider);
         context.pop();
      }
    } catch(e) {
      if(mounted) FeedbackService.showError(context, e.toString());
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _delete() async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Delete Role'), 
            content: const Text('Are you sure?'),
            actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
            ],
        ),
      );
      
      if (confirm == true) {
          try {
             await ref.read(accessControlRepositoryProvider).deleteRole(widget.roleId!);
             if (mounted) {
                 ref.invalidate(moduleRolesListProvider);
                 context.pop();
             }
          } catch(e) {
              if (mounted) FeedbackService.showError(context, e.toString());
          }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.roleId != null ? 'Edit Role' : 'New Role'),
          actions: [
              if (widget.roleId != null)
                 IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: _delete)
          ],
      ),
      body: _isLoading && widget.roleId != null
       ? const Center(child: CircularProgressIndicator())
       : Padding(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _codeController, decoration: const InputDecoration(labelText: 'Role Code (Unique)'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Display Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
