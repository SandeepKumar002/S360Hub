import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/common/async_value_widget.dart';
import '../repositories/medical_examinations_repository.dart';
import '../models/medical_examination_model.dart';

class ShieldMedicalExaminationDetailPage extends ConsumerWidget {
  final String id;
  const ShieldMedicalExaminationDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemAsync = ref.watch(shieldMedicalExaminationDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/shield/medical-examinations/$id/edit'),
          ),
        ],
      ),
      body: AsyncValueWidget<ShieldMedicalExamination>(
        value: itemAsync,
        data: (item) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ListTile(title: Text('EmployeeId'), subtitle: Text(item.employeeId.toString())),
              ListTile(title: Text('ExaminationType'), subtitle: Text(item.examinationType.toString())),
              ListTile(title: Text('ExaminationDate'), subtitle: Text(item.examinationDate.toString())),
              ListTile(title: Text('MedicalCenter'), subtitle: Text(item.medicalCenter.toString())),
              ListTile(title: Text('DoctorName'), subtitle: Text(item.doctorName.toString())),
              ListTile(title: Text('FitnessStatus'), subtitle: Text(item.fitnessStatus.toString())),
              ListTile(title: Text('Restrictions'), subtitle: Text(item.restrictions.toString())),
              ListTile(title: Text('ValidUntil'), subtitle: Text(item.validUntil.toString())),
              ListTile(title: Text('CertificateFileId'), subtitle: Text(item.certificateFileId.toString())),
              ListTile(title: Text('Remarks'), subtitle: Text(item.remarks.toString())),
              ListTile(title: Text('Metadata'), subtitle: Text(item.metadata.toString())),
              ListTile(title: Text('CreatedAt'), subtitle: Text(item.createdAt.toString())),
              ListTile(title: Text('CreatedBy'), subtitle: Text(item.createdBy.toString())),
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
