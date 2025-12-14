import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../../../../core/services/feedback_service.dart';
import '../repositories/access_control_repository.dart';
import '../models/access_control_models.dart';

// --- Dashboard ---
class TeamsDashboardPage extends ConsumerWidget {
  const TeamsDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamsAsync = ref.watch(moduleTeamsListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teams'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/nexus/teams/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<ModuleTeam>>(
        value: teamsAsync,
        data: (teams) {
          return SfDataGrid(
            source: TeamDataSource(teams, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(
                  columnName: 'name',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Team Name'))),
              GridColumn(
                  columnName: 'active',
                  label: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('Active'))),
            ],
          );
        },
      ),
    );
  }
}

class TeamDataSource extends DataGridSource {
  TeamDataSource(List<ModuleTeam> teams, this.context) {
    _dataGridRows = teams
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<ModuleTeam>(columnName: 'obj', value: e),
              DataGridCell<String>(columnName: 'name', value: e.teamName),
              DataGridCell<bool>(columnName: 'active', value: e.isActive),
            ]))
        .toList();
  }

  late List<DataGridRow> _dataGridRows;
  final BuildContext context;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final team = row.getCells().first.value as ModuleTeam;

    return DataGridRowAdapter(
      cells: row.getCells().skip(1).map<Widget>((dataGridCell) {
        return GestureDetector(
          onTap: () => context.push('/nexus/teams/${team.id}/edit'),
          behavior: HitTestBehavior.opaque,
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: dataGridCell.value is bool 
                ? Icon(dataGridCell.value ? Icons.check_circle : Icons.cancel, color: dataGridCell.value ? Colors.green : Colors.grey, size: 20)
                : Text(dataGridCell.value.toString(), overflow: TextOverflow.ellipsis),
          ),
        );
      }).toList(),
    );
  }
}

// --- Form ---
class TeamFormPage extends ConsumerStatefulWidget {
  final String? teamId;
  const TeamFormPage({super.key, this.teamId});

  @override
  ConsumerState<TeamFormPage> createState() => _TeamFormPageState();
}

class _TeamFormPageState extends ConsumerState<TeamFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  bool _isActive = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.teamId != null) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final team = await ref.read(accessControlRepositoryProvider).getTeamById(widget.teamId!);
      _nameController.text = team.teamName;
      _descController.text = team.description ?? '';
      _isActive = team.isActive;
    } catch (e) {
      if(mounted) FeedbackService.showError(context, 'Failed to load team');
    } finally {
      if(mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    
    final data = {
      'team_name': _nameController.text,
      'description': _descController.text,
      'is_active': _isActive,
    };

    try {
      if (widget.teamId != null) {
        await ref.read(accessControlRepositoryProvider).updateTeam(widget.teamId!, data);
         if(mounted) FeedbackService.showSuccess(context, 'Team Updated');
      } else {
         await ref.read(accessControlRepositoryProvider).createTeam(data);
         if(mounted) FeedbackService.showSuccess(context, 'Team Created');
      }
      
      if (mounted) {
         ref.invalidate(moduleTeamsListProvider);
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
            title: const Text('Delete Team'), 
            content: const Text('Are you sure?'),
            actions: [
                TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
            ],
        ),
      );
      
      if (confirm == true) {
          try {
             await ref.read(accessControlRepositoryProvider).deleteTeam(widget.teamId!);
             if (mounted) {
                 ref.invalidate(moduleTeamsListProvider);
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
          title: Text(widget.teamId != null ? 'Edit Team' : 'New Team'),
          actions: [
              if (widget.teamId != null)
                 IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: _delete)
          ],
      ),
      body: _isLoading && widget.teamId != null
       ? const Center(child: CircularProgressIndicator())
       : Padding(
         padding: const EdgeInsets.all(16),
         child: Form(
           key: _formKey,
           child: Column(
             children: [
               TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Team Name'), validator: (v) => v!.isEmpty ? 'Required' : null),
               const SizedBox(height: 16),
               TextFormField(controller: _descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
               const SizedBox(height: 16),
               CheckboxListTile(title: const Text('Is Active'), value: _isActive, onChanged: (v) => setState(() => _isActive = v ?? true)),
               const SizedBox(height: 32),
               ElevatedButton(onPressed: _isLoading ? null : _save, child: Text('Save')),
             ],
           ),
         ),
       ),
    );
  }
}
