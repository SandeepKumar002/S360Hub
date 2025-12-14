import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/surveys_repository.dart';
import '../models/survey_model.dart';

class SurveySurveyDetailPage extends ConsumerWidget {
  final String id;
  const SurveySurveyDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(surveySurveyDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/survey/surveys/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<SurveySurvey>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('Title'), subtitle: Text(item.title.toString())),
              ListTile(title: Text('Description'), subtitle: Text(item.description.toString())),
              ListTile(title: Text('SurveyType'), subtitle: Text(item.surveyType.toString())),
              ListTile(title: Text('IsActive'), subtitle: Text(item.isActive.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
            ],
          );
        },
      ),
    );
  }
}
