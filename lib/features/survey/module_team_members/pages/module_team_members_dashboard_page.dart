import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/module_team_members_repository.dart';
import '../models/module_team_member_model.dart';

class SurveyModuleTeamMemberDashboardPage extends ConsumerWidget {
  const SurveyModuleTeamMemberDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAsync = ref.watch(surveyModuleTeamMemberListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ModuleTeamMembers (Survey)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/survey/module-team-members/new'),
          ),
        ],
      ),
      body: AsyncValueWidget<List<SurveyModuleTeamMember>>(
        value: listAsync,
        data: (list) {
          return SfDataGrid(
            source: SurveyModuleTeamMemberDataSource(list, context),
            columnWidthMode: ColumnWidthMode.fill,
            onQueryRowHeight: (details) => 60,
            columns: [
              GridColumn(columnName: 'teamId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('TeamId'))),
              GridColumn(columnName: 'personId', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('PersonId'))),
              GridColumn(columnName: 'roleCode', label: Container(padding: const EdgeInsets.all(8), alignment: Alignment.centerLeft, child: const Text('RoleCode'))),
            ],
          );
        },
      ),
    );
  }
}

class SurveyModuleTeamMemberDataSource extends DataGridSource {
  SurveyModuleTeamMemberDataSource(List<SurveyModuleTeamMember> data, this.context) {
    _dataGridRows = data.map<DataGridRow>((e) => DataGridRow(cells: [
      DataGridCell<SurveyModuleTeamMember>(columnName: 'obj', value: e),
      DataGridCell<String>(columnName: 'teamId', value: e.teamId ?? '-'),
      DataGridCell<String>(columnName: 'personId', value: e.personId ?? '-'),
      DataGridCell<String>(columnName: 'roleCode', value: e.roleCode ?? '-'),
    ])).toList();
  }
  
  late List<DataGridRow> _dataGridRows;
  final BuildContext context;
  
  @override
  List<DataGridRow> get rows => _dataGridRows;
  
  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final item = row.getCells().first.value as SurveyModuleTeamMember;
    return DataGridRowAdapter(cells: row.getCells().skip(1).map<Widget>((e) {
      return GestureDetector(
        onTap: () => context.push('/survey/module-team-members/${item.id}'),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8),
          child: Text(e.value.toString()),
        ),
      );
    }).toList());
  }
}
