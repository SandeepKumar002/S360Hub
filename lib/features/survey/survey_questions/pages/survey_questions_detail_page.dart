import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/survey_questions_repository.dart';
import '../models/survey_question_model.dart';

class SurveySurveyQuestionDetailPage extends ConsumerWidget {
  final String id;
  const SurveySurveyQuestionDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(surveySurveyQuestionDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/survey/survey-questions/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<SurveySurveyQuestion>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('SurveyId'), subtitle: Text(item.surveyId.toString())),
              ListTile(title: Text('QText'), subtitle: Text(item.qText.toString())),
              ListTile(title: Text('QType'), subtitle: Text(item.qType.toString())),
              ListTile(title: Text('Options'), subtitle: Text(item.options.toString())),
              ListTile(title: Text('Mandatory'), subtitle: Text(item.mandatory.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('UpdatedAt'), subtitle: Text(item.updatedAt.toString())),
              ListTile(title: Text('UpdatedBy'), subtitle: Text(item.updatedBy.toString())),
              ListTile(title: Text('ApprovedAt'), subtitle: Text(item.approvedAt.toString())),
              ListTile(title: Text('ApprovedBy'), subtitle: Text(item.approvedBy.toString())),
              ListTile(title: Text('DeletedAt'), subtitle: Text(item.deletedAt.toString())),
              ListTile(title: Text('DeletedBy'), subtitle: Text(item.deletedBy.toString())),
              ListTile(title: Text('DeleteType'), subtitle: Text(item.deleteType.toString())),
              ListTile(title: Text('IsDeleted'), subtitle: Text(item.isDeleted.toString())),
            ],
          );
        },
      ),
    );
  }
}
