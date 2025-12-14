import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/survey_responses_repository.dart';
import '../models/survey_response_model.dart';

class SurveySurveyResponseDetailPage extends ConsumerWidget {
  final String id;
  const SurveySurveyResponseDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(surveySurveyResponseDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/survey/survey-responses/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<SurveySurveyResponse>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('SurveyId'), subtitle: Text(item.surveyId.toString())),
              ListTile(title: Text('RespondentId'), subtitle: Text(item.respondentId.toString())),
              ListTile(title: Text('SubmittedAt'), subtitle: Text(item.submittedAt.toString())),
              ListTile(title: Text('Answers'), subtitle: Text(item.answers.toString())),
              ListTile(title: Text('Score'), subtitle: Text(item.score.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
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
