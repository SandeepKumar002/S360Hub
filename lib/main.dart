import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme/app_theme.dart';
import 'core/providers/auth_state.dart';
import 'features/auth/login_page.dart';
import 'features/auth/otp_verify_page.dart';
import 'features/home/module_selection_page.dart';
// Nexus Imports
import 'features/nexus/persons/pages/persons_dashboard_page.dart';
import 'features/nexus/persons/pages/person_detail_page.dart';
import 'features/nexus/persons/pages/person_form_page.dart';
import 'features/nexus/lookups/pages/lookup_groups_dashboard.dart';
import 'features/nexus/lookups/pages/lookup_group_detail_page.dart';
import 'features/nexus/lookups/pages/lookup_forms.dart';
import 'features/nexus/addresses/pages/addresses_dashboard_page.dart';
import 'features/nexus/addresses/pages/address_detail_page.dart';
import 'features/nexus/addresses/pages/address_form_page.dart';
import 'features/nexus/contacts/pages/contacts_dashboard_page.dart';
import 'features/nexus/contacts/pages/contact_detail_page.dart';
import 'features/nexus/contacts/pages/contact_form_page.dart';
// Nexus Access Control
import 'features/nexus/access_control/pages/user_pages.dart';
import 'features/nexus/access_control/pages/role_pages.dart';
import 'features/nexus/access_control/pages/team_pages.dart';
// Nexus Support & System
import 'features/nexus/support/pages/files_dashboard_page.dart';
import 'features/nexus/support/pages/comments_dashboard_page.dart';
import 'features/nexus/system/pages/activity_log_page.dart';
// Pulse Imports
import 'features/pulse/organizations/pages/organizations_dashboard_page.dart';
import 'features/pulse/organizations/pages/organization_detail_page.dart';
import 'features/pulse/organizations/pages/organization_form_page.dart';
import 'features/pulse/plans/pages/plans_dashboard_page.dart';
import 'features/pulse/plans/pages/plan_form_page.dart';
// Staffie Imports
import 'features/staffie/employees/pages/employees_dashboard_page.dart';
import 'features/staffie/employees/pages/employee_detail_page.dart';
import 'features/staffie/employees/pages/employee_form_page.dart';
import 'features/staffie/contracts/pages/contracts_dashboard_page.dart';
import 'features/staffie/attendance/pages/attendance_dashboard_page.dart';
import 'features/staffie/expenses/pages/expenses_dashboard_page.dart';
// Recruit Imports
import 'features/recruit/jobs/pages/jobs_dashboard_page.dart';
import 'features/recruit/applications/pages/applications_dashboard_page.dart';
// Performance Imports
import 'features/performance/goals/pages/goals_dashboard_page.dart';
import 'features/performance/reviews/pages/reviews_dashboard_page.dart';
// Shield Imports
import 'features/shield/files/pages/files_dashboard_page.dart';
import 'features/shield/files/pages/files_detail_page.dart';
import 'features/shield/files/pages/files_form_page.dart';
import 'features/shield/grievance_complaints/pages/grievance_complaints_dashboard_page.dart';
import 'features/shield/grievance_complaints/pages/grievance_complaints_detail_page.dart';
import 'features/shield/grievance_complaints/pages/grievance_complaints_form_page.dart';
import 'features/shield/log_history/pages/log_history_dashboard_page.dart';
import 'features/shield/log_history/pages/log_history_detail_page.dart';
import 'features/shield/log_history/pages/log_history_form_page.dart';
import 'features/shield/medical_examinations/pages/medical_examinations_dashboard_page.dart';
import 'features/shield/medical_examinations/pages/medical_examinations_detail_page.dart';
import 'features/shield/medical_examinations/pages/medical_examinations_form_page.dart';
import 'features/shield/posh_complaints/pages/posh_complaints_dashboard_page.dart';
import 'features/shield/posh_complaints/pages/posh_complaints_detail_page.dart';
import 'features/shield/posh_complaints/pages/posh_complaints_form_page.dart';
import 'features/shield/ppe_issued/pages/ppe_issued_dashboard_page.dart';
import 'features/shield/ppe_issued/pages/ppe_issued_detail_page.dart';
import 'features/shield/ppe_issued/pages/ppe_issued_form_page.dart';
import 'features/shield/ppe_returned/pages/ppe_returned_dashboard_page.dart';
import 'features/shield/ppe_returned/pages/ppe_returned_detail_page.dart';
import 'features/shield/ppe_returned/pages/ppe_returned_form_page.dart';
import 'features/shield/safety_incidents/pages/safety_incidents_dashboard_page.dart';
import 'features/shield/safety_incidents/pages/safety_incidents_detail_page.dart';
import 'features/shield/safety_incidents/pages/safety_incidents_form_page.dart';

import 'ui_gallery_page.dart';
import '../../features/comm/channel_members/pages/channel_members_dashboard_page.dart';
import '../../features/comm/channel_members/pages/channel_members_detail_page.dart';
import '../../features/comm/channel_members/pages/channel_members_form_page.dart';
import '../../features/comm/channels/pages/channels_dashboard_page.dart';
import '../../features/comm/channels/pages/channels_detail_page.dart';
import '../../features/comm/channels/pages/channels_form_page.dart';
import '../../features/comm/files/pages/files_dashboard_page.dart';
import '../../features/comm/files/pages/files_detail_page.dart';
import '../../features/comm/files/pages/files_form_page.dart';
import '../../features/comm/log_history/pages/log_history_dashboard_page.dart';
import '../../features/comm/log_history/pages/log_history_detail_page.dart';
import '../../features/comm/log_history/pages/log_history_form_page.dart';
import '../../features/comm/messages/pages/messages_dashboard_page.dart';
import '../../features/comm/messages/pages/messages_detail_page.dart';
import '../../features/comm/messages/pages/messages_form_page.dart';
import '../../features/comm/module_role_assignments/pages/module_role_assignments_dashboard_page.dart';
import '../../features/comm/module_role_assignments/pages/module_role_assignments_detail_page.dart';
import '../../features/comm/module_role_assignments/pages/module_role_assignments_form_page.dart';
import '../../features/comm/module_team_members/pages/module_team_members_dashboard_page.dart';
import '../../features/comm/module_team_members/pages/module_team_members_detail_page.dart';
import '../../features/comm/module_team_members/pages/module_team_members_form_page.dart';
import '../../features/comm/notifications/pages/notifications_dashboard_page.dart';
import '../../features/comm/notifications/pages/notifications_detail_page.dart';
import '../../features/comm/notifications/pages/notifications_form_page.dart';
import '../../features/committee/committee_meeting_records/pages/committee_meeting_records_dashboard_page.dart';
import '../../features/committee/committee_meeting_records/pages/committee_meeting_records_detail_page.dart';
import '../../features/committee/committee_meeting_records/pages/committee_meeting_records_form_page.dart';
import '../../features/committee/committee_meetings/pages/committee_meetings_dashboard_page.dart';
import '../../features/committee/committee_meetings/pages/committee_meetings_detail_page.dart';
import '../../features/committee/committee_meetings/pages/committee_meetings_form_page.dart';
import '../../features/committee/committee_members/pages/committee_members_dashboard_page.dart';
import '../../features/committee/committee_members/pages/committee_members_detail_page.dart';
import '../../features/committee/committee_members/pages/committee_members_form_page.dart';
import '../../features/committee/committees/pages/committees_dashboard_page.dart';
import '../../features/committee/committees/pages/committees_detail_page.dart';
import '../../features/committee/committees/pages/committees_form_page.dart';
import '../../features/committee/files/pages/files_dashboard_page.dart';
import '../../features/committee/files/pages/files_detail_page.dart';
import '../../features/committee/files/pages/files_form_page.dart';
import '../../features/committee/log_history/pages/log_history_dashboard_page.dart';
import '../../features/committee/log_history/pages/log_history_detail_page.dart';
import '../../features/committee/log_history/pages/log_history_form_page.dart';
import '../../features/contracforce/contract_payments/pages/contract_payments_dashboard_page.dart';
import '../../features/contracforce/contract_payments/pages/contract_payments_detail_page.dart';
import '../../features/contracforce/contract_payments/pages/contract_payments_form_page.dart';
import '../../features/contracforce/contractor_compliance_documents/pages/contractor_compliance_documents_dashboard_page.dart';
import '../../features/contracforce/contractor_compliance_documents/pages/contractor_compliance_documents_detail_page.dart';
import '../../features/contracforce/contractor_compliance_documents/pages/contractor_compliance_documents_form_page.dart';
import '../../features/contracforce/contractor_staff/pages/contractor_staff_dashboard_page.dart';
import '../../features/contracforce/contractor_staff/pages/contractor_staff_detail_page.dart';
import '../../features/contracforce/contractor_staff/pages/contractor_staff_form_page.dart';
import '../../features/contracforce/contractor_staff_documents/pages/contractor_staff_documents_dashboard_page.dart';
import '../../features/contracforce/contractor_staff_documents/pages/contractor_staff_documents_detail_page.dart';
import '../../features/contracforce/contractor_staff_documents/pages/contractor_staff_documents_form_page.dart';
import '../../features/contracforce/contractors/pages/contractors_dashboard_page.dart';
import '../../features/contracforce/contractors/pages/contractors_detail_page.dart';
import '../../features/contracforce/contractors/pages/contractors_form_page.dart';
import '../../features/contracforce/contracts/pages/contracts_dashboard_page.dart';
import '../../features/contracforce/contracts/pages/contracts_detail_page.dart';
import '../../features/contracforce/contracts/pages/contracts_form_page.dart';
import '../../features/contracforce/files/pages/files_dashboard_page.dart';
import '../../features/contracforce/files/pages/files_detail_page.dart';
import '../../features/contracforce/files/pages/files_form_page.dart';
import '../../features/contracforce/log_history/pages/log_history_dashboard_page.dart';
import '../../features/contracforce/log_history/pages/log_history_detail_page.dart';
import '../../features/contracforce/log_history/pages/log_history_form_page.dart';
import '../../features/finac/bank_accounts/pages/bank_accounts_dashboard_page.dart';
import '../../features/finac/bank_accounts/pages/bank_accounts_detail_page.dart';
import '../../features/finac/bank_accounts/pages/bank_accounts_form_page.dart';
import '../../features/finac/bank_transactions/pages/bank_transactions_dashboard_page.dart';
import '../../features/finac/bank_transactions/pages/bank_transactions_detail_page.dart';
import '../../features/finac/bank_transactions/pages/bank_transactions_form_page.dart';
import '../../features/finac/expense_categories/pages/expense_categories_dashboard_page.dart';
import '../../features/finac/expense_categories/pages/expense_categories_detail_page.dart';
import '../../features/finac/expense_categories/pages/expense_categories_form_page.dart';
import '../../features/finac/expense_claim_details/pages/expense_claim_details_dashboard_page.dart';
import '../../features/finac/expense_claim_details/pages/expense_claim_details_detail_page.dart';
import '../../features/finac/expense_claim_details/pages/expense_claim_details_form_page.dart';
import '../../features/finac/expense_claim_summary/pages/expense_claim_summary_dashboard_page.dart';
import '../../features/finac/expense_claim_summary/pages/expense_claim_summary_detail_page.dart';
import '../../features/finac/expense_claim_summary/pages/expense_claim_summary_form_page.dart';
import '../../features/finac/files/pages/files_dashboard_page.dart';
import '../../features/finac/files/pages/files_detail_page.dart';
import '../../features/finac/files/pages/files_form_page.dart';
import '../../features/finac/journal_entries/pages/journal_entries_dashboard_page.dart';
import '../../features/finac/journal_entries/pages/journal_entries_detail_page.dart';
import '../../features/finac/journal_entries/pages/journal_entries_form_page.dart';
import '../../features/finac/journal_entry_lines/pages/journal_entry_lines_dashboard_page.dart';
import '../../features/finac/journal_entry_lines/pages/journal_entry_lines_detail_page.dart';
import '../../features/finac/journal_entry_lines/pages/journal_entry_lines_form_page.dart';
import '../../features/finac/log_history/pages/log_history_dashboard_page.dart';
import '../../features/finac/log_history/pages/log_history_detail_page.dart';
import '../../features/finac/log_history/pages/log_history_form_page.dart';
import '../../features/finac/module_role_assignments/pages/module_role_assignments_dashboard_page.dart';
import '../../features/finac/module_role_assignments/pages/module_role_assignments_detail_page.dart';
import '../../features/finac/module_role_assignments/pages/module_role_assignments_form_page.dart';
import '../../features/finac/module_roles/pages/module_roles_dashboard_page.dart';
import '../../features/finac/module_roles/pages/module_roles_detail_page.dart';
import '../../features/finac/module_roles/pages/module_roles_form_page.dart';
import '../../features/finac/module_team_members/pages/module_team_members_dashboard_page.dart';
import '../../features/finac/module_team_members/pages/module_team_members_detail_page.dart';
import '../../features/finac/module_team_members/pages/module_team_members_form_page.dart';
import '../../features/finac/module_teams/pages/module_teams_dashboard_page.dart';
import '../../features/finac/module_teams/pages/module_teams_detail_page.dart';
import '../../features/finac/module_teams/pages/module_teams_form_page.dart';
import '../../features/finac/module_users/pages/module_users_dashboard_page.dart';
import '../../features/finac/module_users/pages/module_users_detail_page.dart';
import '../../features/finac/module_users/pages/module_users_form_page.dart';
import '../../features/knowledge/doc_access_control/pages/doc_access_control_dashboard_page.dart';
import '../../features/knowledge/doc_access_control/pages/doc_access_control_detail_page.dart';
import '../../features/knowledge/doc_access_control/pages/doc_access_control_form_page.dart';
import '../../features/knowledge/doc_feedback/pages/doc_feedback_dashboard_page.dart';
import '../../features/knowledge/doc_feedback/pages/doc_feedback_detail_page.dart';
import '../../features/knowledge/doc_feedback/pages/doc_feedback_form_page.dart';
import '../../features/knowledge/doc_tag_map/pages/doc_tag_map_dashboard_page.dart';
import '../../features/knowledge/doc_tag_map/pages/doc_tag_map_detail_page.dart';
import '../../features/knowledge/doc_tag_map/pages/doc_tag_map_form_page.dart';
import '../../features/knowledge/doc_tags/pages/doc_tags_dashboard_page.dart';
import '../../features/knowledge/doc_tags/pages/doc_tags_detail_page.dart';
import '../../features/knowledge/doc_tags/pages/doc_tags_form_page.dart';
import '../../features/knowledge/doc_versions/pages/doc_versions_dashboard_page.dart';
import '../../features/knowledge/doc_versions/pages/doc_versions_detail_page.dart';
import '../../features/knowledge/doc_versions/pages/doc_versions_form_page.dart';
import '../../features/knowledge/docs/pages/docs_dashboard_page.dart';
import '../../features/knowledge/docs/pages/docs_detail_page.dart';
import '../../features/knowledge/docs/pages/docs_form_page.dart';
import '../../features/knowledge/files/pages/files_dashboard_page.dart';
import '../../features/knowledge/files/pages/files_detail_page.dart';
import '../../features/knowledge/files/pages/files_form_page.dart';
import '../../features/knowledge/log_history/pages/log_history_dashboard_page.dart';
import '../../features/knowledge/log_history/pages/log_history_detail_page.dart';
import '../../features/knowledge/log_history/pages/log_history_form_page.dart';
import '../../features/knowledge/module_role_assignments/pages/module_role_assignments_dashboard_page.dart';
import '../../features/knowledge/module_role_assignments/pages/module_role_assignments_detail_page.dart';
import '../../features/knowledge/module_role_assignments/pages/module_role_assignments_form_page.dart';
import '../../features/knowledge/module_team_members/pages/module_team_members_dashboard_page.dart';
import '../../features/knowledge/module_team_members/pages/module_team_members_detail_page.dart';
import '../../features/knowledge/module_team_members/pages/module_team_members_form_page.dart';
import '../../features/training/assessment_attempts/pages/assessment_attempts_dashboard_page.dart';
import '../../features/training/assessment_attempts/pages/assessment_attempts_detail_page.dart';
import '../../features/training/assessment_attempts/pages/assessment_attempts_form_page.dart';
import '../../features/training/assessment_questions/pages/assessment_questions_dashboard_page.dart';
import '../../features/training/assessment_questions/pages/assessment_questions_detail_page.dart';
import '../../features/training/assessment_questions/pages/assessment_questions_form_page.dart';
import '../../features/training/assessments/pages/assessments_dashboard_page.dart';
import '../../features/training/assessments/pages/assessments_detail_page.dart';
import '../../features/training/assessments/pages/assessments_form_page.dart';
import '../../features/training/certifications/pages/certifications_dashboard_page.dart';
import '../../features/training/certifications/pages/certifications_detail_page.dart';
import '../../features/training/certifications/pages/certifications_form_page.dart';
import '../../features/training/course_units/pages/course_units_dashboard_page.dart';
import '../../features/training/course_units/pages/course_units_detail_page.dart';
import '../../features/training/course_units/pages/course_units_form_page.dart';
import '../../features/training/courses/pages/courses_dashboard_page.dart';
import '../../features/training/courses/pages/courses_detail_page.dart';
import '../../features/training/courses/pages/courses_form_page.dart';
import '../../features/training/enrollments/pages/enrollments_dashboard_page.dart';
import '../../features/training/enrollments/pages/enrollments_detail_page.dart';
import '../../features/training/enrollments/pages/enrollments_form_page.dart';
import '../../features/training/files/pages/files_dashboard_page.dart';
import '../../features/training/files/pages/files_detail_page.dart';
import '../../features/training/files/pages/files_form_page.dart';
import '../../features/training/lms_settings/pages/lms_settings_dashboard_page.dart';
import '../../features/training/lms_settings/pages/lms_settings_detail_page.dart';
import '../../features/training/lms_settings/pages/lms_settings_form_page.dart';
import '../../features/training/log_history/pages/log_history_dashboard_page.dart';
import '../../features/training/log_history/pages/log_history_detail_page.dart';
import '../../features/training/log_history/pages/log_history_form_page.dart';
import '../../features/training/module_role_assignments/pages/module_role_assignments_dashboard_page.dart';
import '../../features/training/module_role_assignments/pages/module_role_assignments_detail_page.dart';
import '../../features/training/module_role_assignments/pages/module_role_assignments_form_page.dart';
import '../../features/training/module_team_members/pages/module_team_members_dashboard_page.dart';
import '../../features/training/module_team_members/pages/module_team_members_detail_page.dart';
import '../../features/training/module_team_members/pages/module_team_members_form_page.dart';
import '../../features/training/sessions/pages/sessions_dashboard_page.dart';
import '../../features/training/sessions/pages/sessions_detail_page.dart';
import '../../features/training/sessions/pages/sessions_form_page.dart';
import '../../features/training/training_materials/pages/training_materials_dashboard_page.dart';
import '../../features/training/training_materials/pages/training_materials_detail_page.dart';
import '../../features/training/training_materials/pages/training_materials_form_page.dart';
import '../../features/ledgie/active_customers/pages/active_customers_dashboard_page.dart';
import '../../features/ledgie/active_customers/pages/active_customers_detail_page.dart';
import '../../features/ledgie/active_customers/pages/active_customers_form_page.dart';
import '../../features/ledgie/active_prospects/pages/active_prospects_dashboard_page.dart';
import '../../features/ledgie/active_prospects/pages/active_prospects_detail_page.dart';
import '../../features/ledgie/active_prospects/pages/active_prospects_form_page.dart';
import '../../features/ledgie/agreements/pages/agreements_dashboard_page.dart';
import '../../features/ledgie/agreements/pages/agreements_detail_page.dart';
import '../../features/ledgie/agreements/pages/agreements_form_page.dart';
import '../../features/ledgie/entities/pages/entities_dashboard_page.dart';
import '../../features/ledgie/entities/pages/entities_detail_page.dart';
import '../../features/ledgie/entities/pages/entities_form_page.dart';
import '../../features/ledgie/entity_contacts/pages/entity_contacts_dashboard_page.dart';
import '../../features/ledgie/entity_contacts/pages/entity_contacts_detail_page.dart';
import '../../features/ledgie/entity_contacts/pages/entity_contacts_form_page.dart';
import '../../features/ledgie/entity_files/pages/entity_files_dashboard_page.dart';
import '../../features/ledgie/entity_files/pages/entity_files_detail_page.dart';
import '../../features/ledgie/entity_files/pages/entity_files_form_page.dart';
import '../../features/ledgie/estimates/pages/estimates_dashboard_page.dart';
import '../../features/ledgie/estimates/pages/estimates_detail_page.dart';
import '../../features/ledgie/estimates/pages/estimates_form_page.dart';
import '../../features/ledgie/files/pages/files_dashboard_page.dart';
import '../../features/ledgie/files/pages/files_detail_page.dart';
import '../../features/ledgie/files/pages/files_form_page.dart';
import '../../features/ledgie/hot_prospects/pages/hot_prospects_dashboard_page.dart';
import '../../features/ledgie/hot_prospects/pages/hot_prospects_detail_page.dart';
import '../../features/ledgie/hot_prospects/pages/hot_prospects_form_page.dart';
import '../../features/ledgie/log_history/pages/log_history_dashboard_page.dart';
import '../../features/ledgie/log_history/pages/log_history_detail_page.dart';
import '../../features/ledgie/log_history/pages/log_history_form_page.dart';
import '../../features/ledgie/module_role_assignments/pages/module_role_assignments_dashboard_page.dart';
import '../../features/ledgie/module_role_assignments/pages/module_role_assignments_detail_page.dart';
import '../../features/ledgie/module_role_assignments/pages/module_role_assignments_form_page.dart';
import '../../features/ledgie/module_roles/pages/module_roles_dashboard_page.dart';
import '../../features/ledgie/module_roles/pages/module_roles_detail_page.dart';
import '../../features/ledgie/module_roles/pages/module_roles_form_page.dart';
import '../../features/ledgie/module_team_members/pages/module_team_members_dashboard_page.dart';
import '../../features/ledgie/module_team_members/pages/module_team_members_detail_page.dart';
import '../../features/ledgie/module_team_members/pages/module_team_members_form_page.dart';
import '../../features/ledgie/module_teams/pages/module_teams_dashboard_page.dart';
import '../../features/ledgie/module_teams/pages/module_teams_detail_page.dart';
import '../../features/ledgie/module_teams/pages/module_teams_form_page.dart';
import '../../features/ledgie/module_users/pages/module_users_dashboard_page.dart';
import '../../features/ledgie/module_users/pages/module_users_detail_page.dart';
import '../../features/ledgie/module_users/pages/module_users_form_page.dart';
import '../../features/ledgie/proforma_invoices/pages/proforma_invoices_dashboard_page.dart';
import '../../features/ledgie/proforma_invoices/pages/proforma_invoices_detail_page.dart';
import '../../features/ledgie/proforma_invoices/pages/proforma_invoices_form_page.dart';
import '../../features/ledgie/proposals/pages/proposals_dashboard_page.dart';
import '../../features/ledgie/proposals/pages/proposals_detail_page.dart';
import '../../features/ledgie/proposals/pages/proposals_form_page.dart';
import '../../features/ledgie/tax_invoices/pages/tax_invoices_dashboard_page.dart';
import '../../features/ledgie/tax_invoices/pages/tax_invoices_detail_page.dart';
import '../../features/ledgie/tax_invoices/pages/tax_invoices_form_page.dart';
import '../../features/survey/files/pages/files_dashboard_page.dart';
import '../../features/survey/files/pages/files_detail_page.dart';
import '../../features/survey/files/pages/files_form_page.dart';
import '../../features/survey/log_history/pages/log_history_dashboard_page.dart';
import '../../features/survey/log_history/pages/log_history_detail_page.dart';
import '../../features/survey/log_history/pages/log_history_form_page.dart';
import '../../features/survey/module_role_assignments/pages/module_role_assignments_dashboard_page.dart';
import '../../features/survey/module_role_assignments/pages/module_role_assignments_detail_page.dart';
import '../../features/survey/module_role_assignments/pages/module_role_assignments_form_page.dart';
import '../../features/survey/module_team_members/pages/module_team_members_dashboard_page.dart';
import '../../features/survey/module_team_members/pages/module_team_members_detail_page.dart';
import '../../features/survey/module_team_members/pages/module_team_members_form_page.dart';
import '../../features/survey/survey_pulse/pages/survey_pulse_dashboard_page.dart';
import '../../features/survey/survey_pulse/pages/survey_pulse_detail_page.dart';
import '../../features/survey/survey_pulse/pages/survey_pulse_form_page.dart';
import '../../features/survey/survey_questions/pages/survey_questions_dashboard_page.dart';
import '../../features/survey/survey_questions/pages/survey_questions_detail_page.dart';
import '../../features/survey/survey_questions/pages/survey_questions_form_page.dart';
import '../../features/survey/survey_responses/pages/survey_responses_dashboard_page.dart';
import '../../features/survey/survey_responses/pages/survey_responses_detail_page.dart';
import '../../features/survey/survey_responses/pages/survey_responses_form_page.dart';
import '../../features/survey/surveys/pages/surveys_dashboard_page.dart';
import '../../features/survey/surveys/pages/surveys_detail_page.dart';
import '../../features/survey/surveys/pages/surveys_form_page.dart';
import '../../features/taxforge/files/pages/files_dashboard_page.dart';
import '../../features/taxforge/files/pages/files_detail_page.dart';
import '../../features/taxforge/files/pages/files_form_page.dart';
import '../../features/taxforge/gst_details/pages/gst_details_dashboard_page.dart';
import '../../features/taxforge/gst_details/pages/gst_details_detail_page.dart';
import '../../features/taxforge/gst_details/pages/gst_details_form_page.dart';
import '../../features/taxforge/gst_transactions/pages/gst_transactions_dashboard_page.dart';
import '../../features/taxforge/gst_transactions/pages/gst_transactions_detail_page.dart';
import '../../features/taxforge/gst_transactions/pages/gst_transactions_form_page.dart';
import '../../features/taxforge/hsn_sac_codes/pages/hsn_sac_codes_dashboard_page.dart';
import '../../features/taxforge/hsn_sac_codes/pages/hsn_sac_codes_detail_page.dart';
import '../../features/taxforge/hsn_sac_codes/pages/hsn_sac_codes_form_page.dart';
import '../../features/taxforge/log_history/pages/log_history_dashboard_page.dart';
import '../../features/taxforge/log_history/pages/log_history_detail_page.dart';
import '../../features/taxforge/log_history/pages/log_history_form_page.dart';
import '../../features/taxforge/tds_details/pages/tds_details_dashboard_page.dart';
import '../../features/taxforge/tds_details/pages/tds_details_detail_page.dart';
import '../../features/taxforge/tds_details/pages/tds_details_form_page.dart';
import '../../features/taxforge/tds_transactions/pages/tds_transactions_dashboard_page.dart';
import '../../features/taxforge/tds_transactions/pages/tds_transactions_detail_page.dart';
import '../../features/taxforge/tds_transactions/pages/tds_transactions_form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    // TODO: REPLACE WITH ACTUAL KEYS
    url: 'https://abkpbchwimfebfjiujav.supabase.co',
    anonKey: 'YOUR_ANON_KEY_HERE', 
  );
  
  runApp(const ProviderScope(child: MyApp()));
}

final _routerProvider = Provider<GoRouter>((ref) {
  final authStream = ref.watch(authServiceProvider).authStateChanges;
  
  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(authStream),
    redirect: (context, state) {
      final isLoggedIn = ref.read(currentUserProvider) != null;
      final isLoggingIn = state.uri.path == '/login' || state.uri.path == '/otp-verify';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/modules';
      
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/otp-verify',
        builder: (context, state) => OtpVerifyPage(args: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: '/modules',
        builder: (context, state) => const ModuleSelectionPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardShell(),
      ),
      GoRoute(
        path: '/gallery',
        builder: (context, state) => const UiGalleryPage(),
      ),
      // Nexus Routes
      GoRoute(
        path: '/nexus',
        builder: (context, state) => const NexusDashboardShell(),
        routes: [
          // Persons
          GoRoute(
            path: 'persons',
            builder: (context, state) => const PersonsDashboardPage(),
            routes: [
              GoRoute(
                path: 'new',
                builder: (context, state) => const PersonFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => PersonDetailPage(personId: state.pathParameters['id']!),
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (context, state) => PersonFormPage(personId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          // Lookups
          GoRoute(
            path: 'lookups',
            builder: (context, state) => const LookupGroupsDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const LookupGroupFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => LookupGroupDetailPage(groupId: state.pathParameters['id']!),
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => LookupGroupFormPage(groupId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          // Addresses
          GoRoute(
            path: 'addresses',
            builder: (context, state) => const AddressesDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const AddressFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => AddressDetailPage(addressId: state.pathParameters['id']!),
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => AddressFormPage(addressId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          // Contacts
          GoRoute(
            path: 'contacts',
            builder: (context, state) => const ContactsDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const ContactFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => ContactDetailPage(contactId: state.pathParameters['id']!),
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => ContactFormPage(contactId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          // Access Control
          GoRoute(
            path: 'users',
            builder: (context, state) => const UsersDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const UserFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => UserDetailPage(userId: state.pathParameters['id']!),
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => UserFormPage(userId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'roles',
            builder: (context, state) => const RolesDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const RoleFormPage(),
              ),
              GoRoute(
                path: ':id',
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => RoleFormPage(roleId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
             path: 'teams',
             builder: (context, state) => const TeamsDashboardPage(),
             routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const TeamFormPage(),
              ),
              GoRoute(
                path: ':id',
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => TeamFormPage(teamId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          // Support & System
          GoRoute(
             path: 'files',
             builder: (context, state) => const FilesDashboardPage(),
          ),
          GoRoute(
             path: 'comments',
             builder: (context, state) => const CommentsDashboardPage(),
          ),
           GoRoute(
             path: 'activity-log',
             builder: (context, state) => const ActivityLogPage(),
          ),
        ],
      ),
      // Pulse Routes
      GoRoute(
        path: '/pulse',
        builder: (context, state) => const PulseDashboardShell(),
        routes: [
           GoRoute(
            path: 'organizations',
            builder: (context, state) => const OrganizationsDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const OrganizationFormPage(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => OrganizationDetailPage(orgId: state.pathParameters['id']!),
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => OrganizationFormPage(orgId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'plans',
            builder: (context, state) => const PlansDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const PlanFormPage(),
              ),
               GoRoute(
                path: ':id',
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => PlanFormPage(planId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // Staffie Routes
      GoRoute(
        path: '/staffie',
        builder: (context, state) => const StaffieDashboardShell(),
        routes: [
          GoRoute(
            path: 'employees',
            builder: (context, state) => const EmployeesDashboardPage(),
            routes: [
               GoRoute(
                path: 'new',
                builder: (context, state) => const EmployeeFormPage(),
              ),
               GoRoute(
                path: ':id',
                builder: (context, state) => EmployeeDetailPage(empId: state.pathParameters['id']!),
                routes: [
                   GoRoute(
                    path: 'edit',
                    builder: (context, state) => EmployeeFormPage(empId: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
           GoRoute(
             path: 'contracts',
             builder: (context, state) => const ContractsDashboardPage(),
          ),
           GoRoute(
             path: 'attendance',
             builder: (context, state) => const AttendanceDashboardPage(),
          ),
           GoRoute(
             path: 'expenses',
             builder: (context, state) => const ExpensesDashboardPage(),
          ),
        ],
      ),
      // Recruit Routes
      GoRoute(
        path: '/recruit',
        builder: (context, state) => const RecruitDashboardShell(),
        routes: [
           GoRoute(
             path: 'jobs',
             builder: (context, state) => const JobsDashboardPage(),
          ),
           GoRoute(
             path: 'applications',
             builder: (context, state) => const ApplicationsDashboardPage(),
          ),
        ],
      ),
      // Performance Routes
      GoRoute(
        path: '/performance',
        builder: (context, state) => const PerformanceDashboardShell(),
        routes: [
           GoRoute(
             path: 'goals',
             builder: (context, state) => const GoalsDashboardPage(),
          ),
           GoRoute(
             path: 'reviews',
             builder: (context, state) => const ReviewsDashboardPage(),
          ),
        ],
      ),
      // Shield Routes
      GoRoute(
        path: '/shield',
        builder: (context, state) => const ShieldDashboardShell(),
        routes: [
          GoRoute(
            path: 'files',
            builder: (context, state) => const ShieldFileDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldFileFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldFileDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldFileFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'grievance-complaints',
            builder: (context, state) => const ShieldGrievanceComplaintDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldGrievanceComplaintFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldGrievanceComplaintDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldGrievanceComplaintFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'log-history',
            builder: (context, state) => const ShieldLogHistoryDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldLogHistoryFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldLogHistoryDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldLogHistoryFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'medical-examinations',
            builder: (context, state) => const ShieldMedicalExaminationDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldMedicalExaminationFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldMedicalExaminationDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldMedicalExaminationFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'posh-complaints',
            builder: (context, state) => const ShieldPoshComplaintDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldPoshComplaintFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldPoshComplaintDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldPoshComplaintFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'ppe-issued',
            builder: (context, state) => const ShieldPpeIssuedDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldPpeIssuedFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldPpeIssuedDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldPpeIssuedFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'ppe-returned',
            builder: (context, state) => const ShieldPpeReturnedDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldPpeReturnedFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldPpeReturnedDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldPpeReturnedFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'safety-incidents',
            builder: (context, state) => const ShieldSafetyIncidentDashboardPage(),
            routes: [
              GoRoute(path: 'new', builder: (context, state) => const ShieldSafetyIncidentFormPage()),
              GoRoute(
                path: ':id',
                builder: (context, state) => ShieldSafetyIncidentDetailPage(id: state.pathParameters['id']!),
                routes: [
                  GoRoute(path: 'edit', builder: (context, state) => ShieldSafetyIncidentFormPage(id: state.pathParameters['id'])),
                ],
              ),
            ],
          ),
        ],
      ),
GoRoute(
  path: '/committee',
  builder: (context, state) => const CommitteeDashboardShell(),
  routes: [
    GoRoute(
      path: 'committee-meeting-records',
      builder: (context, state) => const CommitteeCommitteeMeetingRecordDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeMeetingRecordFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeMeetingRecordDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeMeetingRecordFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'committee-meetings',
      builder: (context, state) => const CommitteeCommitteeMeetingDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeMeetingFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeMeetingDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeMeetingFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'committee-members',
      builder: (context, state) => const CommitteeCommitteeMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'committees',
      builder: (context, state) => const CommitteeCommitteeDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const CommitteeFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const CommitteeLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/finac',
  builder: (context, state) => const FinacDashboardShell(),
  routes: [
    GoRoute(
      path: 'bank-accounts',
      builder: (context, state) => const FinacBankAccountDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacBankAccountFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacBankAccountDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacBankAccountFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'bank-transactions',
      builder: (context, state) => const FinacBankTransactionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacBankTransactionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacBankTransactionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacBankTransactionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'expense-categories',
      builder: (context, state) => const FinacExpenseCategorieDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacExpenseCategorieFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacExpenseCategorieDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacExpenseCategorieFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'expense-claim-details',
      builder: (context, state) => const FinacExpenseClaimDetailDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacExpenseClaimDetailFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacExpenseClaimDetailDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacExpenseClaimDetailFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'expense-claim-summary',
      builder: (context, state) => const FinacExpenseClaimSummaryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacExpenseClaimSummaryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacExpenseClaimSummaryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacExpenseClaimSummaryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const FinacFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'journal-entries',
      builder: (context, state) => const FinacJournalEntrieDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacJournalEntrieFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacJournalEntrieDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacJournalEntrieFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'journal-entry-lines',
      builder: (context, state) => const FinacJournalEntryLineDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacJournalEntryLineFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacJournalEntryLineDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacJournalEntryLineFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const FinacLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const FinacModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-roles',
      builder: (context, state) => const FinacModuleRoleDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleRoleFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleRoleDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleRoleFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const FinacModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-teams',
      builder: (context, state) => const FinacModuleTeamDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleTeamFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleTeamDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleTeamFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-users',
      builder: (context, state) => const FinacModuleUserDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleUserFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleUserDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleUserFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/taxforge',
  builder: (context, state) => const TaxforgeDashboardShell(),
  routes: [
    GoRoute(
      path: 'files',
      builder: (context, state) => const TaxforgeFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'gst-details',
      builder: (context, state) => const TaxforgeGstDetailDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeGstDetailFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeGstDetailDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeGstDetailFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'gst-transactions',
      builder: (context, state) => const TaxforgeGstTransactionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeGstTransactionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeGstTransactionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeGstTransactionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'hsn-sac-codes',
      builder: (context, state) => const TaxforgeHsnSacCodeDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeHsnSacCodeFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeHsnSacCodeDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeHsnSacCodeFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const TaxforgeLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'tds-details',
      builder: (context, state) => const TaxforgeTdsDetailDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeTdsDetailFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeTdsDetailDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeTdsDetailFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'tds-transactions',
      builder: (context, state) => const TaxforgeTdsTransactionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeTdsTransactionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeTdsTransactionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeTdsTransactionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/ledgie',
  builder: (context, state) => const LedgieDashboardShell(),
  routes: [
    GoRoute(
      path: 'active-customers',
      builder: (context, state) => const LedgieActiveCustomerDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieActiveCustomerFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieActiveCustomerDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieActiveCustomerFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'active-prospects',
      builder: (context, state) => const LedgieActiveProspectDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieActiveProspectFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieActiveProspectDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieActiveProspectFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'agreements',
      builder: (context, state) => const LedgieAgreementDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieAgreementFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieAgreementDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieAgreementFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'entities',
      builder: (context, state) => const LedgieEntitieDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEntitieFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEntitieDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEntitieFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'entity-contacts',
      builder: (context, state) => const LedgieEntityContactDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEntityContactFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEntityContactDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEntityContactFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'entity-files',
      builder: (context, state) => const LedgieEntityFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEntityFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEntityFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEntityFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'estimates',
      builder: (context, state) => const LedgieEstimateDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEstimateFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEstimateDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEstimateFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const LedgieFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'hot-prospects',
      builder: (context, state) => const LedgieHotProspectDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieHotProspectFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieHotProspectDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieHotProspectFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const LedgieLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const LedgieModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-roles',
      builder: (context, state) => const LedgieModuleRoleDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleRoleFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleRoleDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleRoleFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const LedgieModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-teams',
      builder: (context, state) => const LedgieModuleTeamDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleTeamFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleTeamDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleTeamFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-users',
      builder: (context, state) => const LedgieModuleUserDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleUserFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleUserDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleUserFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'proforma-invoices',
      builder: (context, state) => const LedgieProformaInvoiceDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieProformaInvoiceFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieProformaInvoiceDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieProformaInvoiceFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'proposals',
      builder: (context, state) => const LedgieProposalDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieProposalFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieProposalDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieProposalFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'tax-invoices',
      builder: (context, state) => const LedgieTaxInvoiceDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieTaxInvoiceFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieTaxInvoiceDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieTaxInvoiceFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/contracforce',
  builder: (context, state) => const ContracforceDashboardShell(),
  routes: [
    GoRoute(
      path: 'contract-payments',
      builder: (context, state) => const ContracforceContractPaymentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractPaymentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractPaymentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractPaymentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractor-compliance-documents',
      builder: (context, state) => const ContracforceContractorComplianceDocumentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorComplianceDocumentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorComplianceDocumentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorComplianceDocumentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractor-staff',
      builder: (context, state) => const ContracforceContractorStaffDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorStaffFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorStaffDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorStaffFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractor-staff-documents',
      builder: (context, state) => const ContracforceContractorStaffDocumentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorStaffDocumentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorStaffDocumentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorStaffDocumentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractors',
      builder: (context, state) => const ContracforceContractorDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contracts',
      builder: (context, state) => const ContracforceContractDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const ContracforceFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const ContracforceLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/comm',
  builder: (context, state) => const CommDashboardShell(),
  routes: [
    GoRoute(
      path: 'channel-members',
      builder: (context, state) => const CommChannelMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommChannelMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommChannelMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommChannelMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'channels',
      builder: (context, state) => const CommChannelDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommChannelFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommChannelDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommChannelFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const CommFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const CommLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'messages',
      builder: (context, state) => const CommMessageDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommMessageFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommMessageDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommMessageFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const CommModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const CommModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'notifications',
      builder: (context, state) => const CommNotificationDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommNotificationFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommNotificationDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommNotificationFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/survey',
  builder: (context, state) => const SurveyDashboardShell(),
  routes: [
    GoRoute(
      path: 'files',
      builder: (context, state) => const SurveyFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const SurveyLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const SurveyModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const SurveyModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'survey-pulse',
      builder: (context, state) => const SurveySurveyPulseDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyPulseFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyPulseDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyPulseFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'survey-questions',
      builder: (context, state) => const SurveySurveyQuestionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyQuestionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyQuestionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyQuestionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'survey-responses',
      builder: (context, state) => const SurveySurveyResponseDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyResponseFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyResponseDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyResponseFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'surveys',
      builder: (context, state) => const SurveySurveyDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/knowledge',
  builder: (context, state) => const KnowledgeDashboardShell(),
  routes: [
    GoRoute(
      path: 'doc-access-control',
      builder: (context, state) => const KnowledgeDocAccessControlDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocAccessControlFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocAccessControlDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocAccessControlFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-feedback',
      builder: (context, state) => const KnowledgeDocFeedbackDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocFeedbackFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocFeedbackDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocFeedbackFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-tag-map',
      builder: (context, state) => const KnowledgeDocTagMapDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocTagMapFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocTagMapDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocTagMapFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-tags',
      builder: (context, state) => const KnowledgeDocTagDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocTagFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocTagDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocTagFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-versions',
      builder: (context, state) => const KnowledgeDocVersionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocVersionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocVersionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocVersionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'docs',
      builder: (context, state) => const KnowledgeDocDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const KnowledgeFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const KnowledgeLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const KnowledgeModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const KnowledgeModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/training',
  builder: (context, state) => const TrainingDashboardShell(),
  routes: [
    GoRoute(
      path: 'assessment-attempts',
      builder: (context, state) => const TrainingAssessmentAttemptDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingAssessmentAttemptFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingAssessmentAttemptDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingAssessmentAttemptFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'assessment-questions',
      builder: (context, state) => const TrainingAssessmentQuestionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingAssessmentQuestionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingAssessmentQuestionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingAssessmentQuestionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'assessments',
      builder: (context, state) => const TrainingAssessmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingAssessmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingAssessmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingAssessmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'certifications',
      builder: (context, state) => const TrainingCertificationDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingCertificationFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingCertificationDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingCertificationFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'course-units',
      builder: (context, state) => const TrainingCourseUnitDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingCourseUnitFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingCourseUnitDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingCourseUnitFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'courses',
      builder: (context, state) => const TrainingCourseDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingCourseFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingCourseDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingCourseFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'enrollments',
      builder: (context, state) => const TrainingEnrollmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingEnrollmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingEnrollmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingEnrollmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const TrainingFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'lms-settings',
      builder: (context, state) => const TrainingLmsSettingDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingLmsSettingFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingLmsSettingDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingLmsSettingFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const TrainingLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const TrainingModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const TrainingModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'sessions',
      builder: (context, state) => const TrainingSessionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingSessionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingSessionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingSessionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'training-materials',
      builder: (context, state) => const TrainingTrainingMaterialDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TrainingTrainingMaterialFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TrainingTrainingMaterialDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TrainingTrainingMaterialFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/committee',
  builder: (context, state) => const CommitteeDashboardShell(),
  routes: [
    GoRoute(
      path: 'committee-meeting-records',
      builder: (context, state) => const CommitteeCommitteeMeetingRecordDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeMeetingRecordFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeMeetingRecordDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeMeetingRecordFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'committee-meetings',
      builder: (context, state) => const CommitteeCommitteeMeetingDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeMeetingFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeMeetingDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeMeetingFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'committee-members',
      builder: (context, state) => const CommitteeCommitteeMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'committees',
      builder: (context, state) => const CommitteeCommitteeDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeCommitteeFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeCommitteeDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeCommitteeFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const CommitteeFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const CommitteeLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommitteeLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommitteeLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommitteeLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/finac',
  builder: (context, state) => const FinacDashboardShell(),
  routes: [
    GoRoute(
      path: 'bank-accounts',
      builder: (context, state) => const FinacBankAccountDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacBankAccountFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacBankAccountDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacBankAccountFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'bank-transactions',
      builder: (context, state) => const FinacBankTransactionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacBankTransactionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacBankTransactionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacBankTransactionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'expense-categories',
      builder: (context, state) => const FinacExpenseCategorieDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacExpenseCategorieFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacExpenseCategorieDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacExpenseCategorieFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'expense-claim-details',
      builder: (context, state) => const FinacExpenseClaimDetailDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacExpenseClaimDetailFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacExpenseClaimDetailDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacExpenseClaimDetailFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'expense-claim-summary',
      builder: (context, state) => const FinacExpenseClaimSummaryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacExpenseClaimSummaryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacExpenseClaimSummaryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacExpenseClaimSummaryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const FinacFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'journal-entries',
      builder: (context, state) => const FinacJournalEntrieDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacJournalEntrieFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacJournalEntrieDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacJournalEntrieFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'journal-entry-lines',
      builder: (context, state) => const FinacJournalEntryLineDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacJournalEntryLineFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacJournalEntryLineDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacJournalEntryLineFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const FinacLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const FinacModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-roles',
      builder: (context, state) => const FinacModuleRoleDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleRoleFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleRoleDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleRoleFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const FinacModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-teams',
      builder: (context, state) => const FinacModuleTeamDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleTeamFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleTeamDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleTeamFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-users',
      builder: (context, state) => const FinacModuleUserDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const FinacModuleUserFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => FinacModuleUserDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => FinacModuleUserFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/taxforge',
  builder: (context, state) => const TaxforgeDashboardShell(),
  routes: [
    GoRoute(
      path: 'files',
      builder: (context, state) => const TaxforgeFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'gst-details',
      builder: (context, state) => const TaxforgeGstDetailDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeGstDetailFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeGstDetailDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeGstDetailFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'gst-transactions',
      builder: (context, state) => const TaxforgeGstTransactionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeGstTransactionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeGstTransactionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeGstTransactionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'hsn-sac-codes',
      builder: (context, state) => const TaxforgeHsnSacCodeDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeHsnSacCodeFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeHsnSacCodeDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeHsnSacCodeFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const TaxforgeLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'tds-details',
      builder: (context, state) => const TaxforgeTdsDetailDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeTdsDetailFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeTdsDetailDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeTdsDetailFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'tds-transactions',
      builder: (context, state) => const TaxforgeTdsTransactionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const TaxforgeTdsTransactionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => TaxforgeTdsTransactionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => TaxforgeTdsTransactionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/ledgie',
  builder: (context, state) => const LedgieDashboardShell(),
  routes: [
    GoRoute(
      path: 'active-customers',
      builder: (context, state) => const LedgieActiveCustomerDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieActiveCustomerFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieActiveCustomerDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieActiveCustomerFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'active-prospects',
      builder: (context, state) => const LedgieActiveProspectDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieActiveProspectFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieActiveProspectDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieActiveProspectFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'agreements',
      builder: (context, state) => const LedgieAgreementDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieAgreementFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieAgreementDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieAgreementFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'entities',
      builder: (context, state) => const LedgieEntitieDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEntitieFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEntitieDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEntitieFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'entity-contacts',
      builder: (context, state) => const LedgieEntityContactDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEntityContactFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEntityContactDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEntityContactFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'entity-files',
      builder: (context, state) => const LedgieEntityFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEntityFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEntityFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEntityFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'estimates',
      builder: (context, state) => const LedgieEstimateDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieEstimateFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieEstimateDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieEstimateFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const LedgieFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'hot-prospects',
      builder: (context, state) => const LedgieHotProspectDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieHotProspectFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieHotProspectDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieHotProspectFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const LedgieLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const LedgieModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-roles',
      builder: (context, state) => const LedgieModuleRoleDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleRoleFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleRoleDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleRoleFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const LedgieModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-teams',
      builder: (context, state) => const LedgieModuleTeamDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleTeamFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleTeamDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleTeamFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-users',
      builder: (context, state) => const LedgieModuleUserDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieModuleUserFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieModuleUserDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieModuleUserFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'proforma-invoices',
      builder: (context, state) => const LedgieProformaInvoiceDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieProformaInvoiceFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieProformaInvoiceDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieProformaInvoiceFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'proposals',
      builder: (context, state) => const LedgieProposalDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieProposalFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieProposalDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieProposalFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'tax-invoices',
      builder: (context, state) => const LedgieTaxInvoiceDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const LedgieTaxInvoiceFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => LedgieTaxInvoiceDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => LedgieTaxInvoiceFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/contracforce',
  builder: (context, state) => const ContracforceDashboardShell(),
  routes: [
    GoRoute(
      path: 'contract-payments',
      builder: (context, state) => const ContracforceContractPaymentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractPaymentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractPaymentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractPaymentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractor-compliance-documents',
      builder: (context, state) => const ContracforceContractorComplianceDocumentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorComplianceDocumentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorComplianceDocumentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorComplianceDocumentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractor-staff',
      builder: (context, state) => const ContracforceContractorStaffDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorStaffFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorStaffDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorStaffFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractor-staff-documents',
      builder: (context, state) => const ContracforceContractorStaffDocumentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorStaffDocumentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorStaffDocumentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorStaffDocumentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contractors',
      builder: (context, state) => const ContracforceContractorDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractorFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractorDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractorFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'contracts',
      builder: (context, state) => const ContracforceContractDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceContractFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceContractDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceContractFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const ContracforceFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const ContracforceLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const ContracforceLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => ContracforceLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => ContracforceLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/comm',
  builder: (context, state) => const CommDashboardShell(),
  routes: [
    GoRoute(
      path: 'channel-members',
      builder: (context, state) => const CommChannelMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommChannelMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommChannelMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommChannelMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'channels',
      builder: (context, state) => const CommChannelDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommChannelFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommChannelDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommChannelFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const CommFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const CommLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'messages',
      builder: (context, state) => const CommMessageDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommMessageFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommMessageDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommMessageFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const CommModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const CommModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'notifications',
      builder: (context, state) => const CommNotificationDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const CommNotificationFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => CommNotificationDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => CommNotificationFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/survey',
  builder: (context, state) => const SurveyDashboardShell(),
  routes: [
    GoRoute(
      path: 'files',
      builder: (context, state) => const SurveyFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const SurveyLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const SurveyModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const SurveyModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveyModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveyModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveyModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'survey-pulse',
      builder: (context, state) => const SurveySurveyPulseDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyPulseFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyPulseDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyPulseFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'survey-questions',
      builder: (context, state) => const SurveySurveyQuestionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyQuestionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyQuestionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyQuestionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'survey-responses',
      builder: (context, state) => const SurveySurveyResponseDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyResponseFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyResponseDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyResponseFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'surveys',
      builder: (context, state) => const SurveySurveyDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const SurveySurveyFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => SurveySurveyDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => SurveySurveyFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),
GoRoute(
  path: '/knowledge',
  builder: (context, state) => const KnowledgeDashboardShell(),
  routes: [
    GoRoute(
      path: 'doc-access-control',
      builder: (context, state) => const KnowledgeDocAccessControlDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocAccessControlFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocAccessControlDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocAccessControlFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-feedback',
      builder: (context, state) => const KnowledgeDocFeedbackDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocFeedbackFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocFeedbackDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocFeedbackFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-tag-map',
      builder: (context, state) => const KnowledgeDocTagMapDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocTagMapFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocTagMapDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocTagMapFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-tags',
      builder: (context, state) => const KnowledgeDocTagDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocTagFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocTagDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocTagFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'doc-versions',
      builder: (context, state) => const KnowledgeDocVersionDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocVersionFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocVersionDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocVersionFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'docs',
      builder: (context, state) => const KnowledgeDocDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeDocFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeDocDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeDocFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'files',
      builder: (context, state) => const KnowledgeFileDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeFileFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeFileDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeFileFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'log-history',
      builder: (context, state) => const KnowledgeLogHistoryDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeLogHistoryFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeLogHistoryDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeLogHistoryFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-role-assignments',
      builder: (context, state) => const KnowledgeModuleRoleAssignmentDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeModuleRoleAssignmentFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeModuleRoleAssignmentDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeModuleRoleAssignmentFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
    GoRoute(
      path: 'module-team-members',
      builder: (context, state) => const KnowledgeModuleTeamMemberDashboardPage(),
      routes: [
        GoRoute(path: 'new', builder: (context, state) => const KnowledgeModuleTeamMemberFormPage()),
        GoRoute(
          path: ':id',
          builder: (context, state) => KnowledgeModuleTeamMemberDetailPage(id: state.pathParameters['id']!),
          routes: [
            GoRoute(path: 'edit', builder: (context, state) => KnowledgeModuleTeamMemberFormPage(id: state.pathParameters['id'])),
          ],
        ),
      ],
    ),
  ],
),

    ],
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(_routerProvider);
    
    return MaterialApp.router(
      title: 'S360Hub',
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Just a placeholder redirect to Nexus for checking dashboard
class DashboardShell extends StatelessWidget {
  const DashboardShell({super.key});
  @override
  Widget build(BuildContext context) {
    return const NexusDashboardShell();
  }
}

class NexusDashboardShell extends StatelessWidget {
  const NexusDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nexus Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(context, 'Core'),
          _buildNavItem(context, Icons.people, 'Persons', '/nexus/persons'),
          _buildNavItem(context, Icons.list, 'Lookups', '/nexus/lookups'),
          _buildNavItem(context, Icons.location_on, 'Addresses', '/nexus/addresses'),
          _buildNavItem(context, Icons.contacts, 'Contacts', '/nexus/contacts'),
          
          _buildSectionHeader(context, 'Access Control'),
          _buildNavItem(context, Icons.manage_accounts, 'Users', '/nexus/users'),
          _buildNavItem(context, Icons.security, 'Roles', '/nexus/roles'),
          _buildNavItem(context, Icons.groups, 'Teams', '/nexus/teams'),

          _buildSectionHeader(context, 'Support & System'),
          _buildNavItem(context, Icons.folder, 'Files', '/nexus/files'),
          _buildNavItem(context, Icons.comment, 'Global Comments', '/nexus/comments'),
          _buildNavItem(context, Icons.history, 'Activity Log', '/nexus/activity-log'),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 24, 8, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class PulseDashboardShell extends StatelessWidget {
  const PulseDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pulse Dashboard (SaaS Control)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.business, 'Organizations', '/pulse/organizations'),
          _buildNavItem(context, Icons.price_change, 'Subscription Plans', '/pulse/plans'),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class StaffieDashboardShell extends StatelessWidget {
  const StaffieDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Staffie Dashboard (HR)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.badge, 'Employees', '/staffie/employees'),
          _buildNavItem(context, Icons.description, 'Contracts', '/staffie/contracts'),
          _buildNavItem(context, Icons.access_time_filled, 'Attendance', '/staffie/attendance'),
          _buildNavItem(context, Icons.receipt_long, 'Expense Claims', '/staffie/expenses'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class RecruitDashboardShell extends StatelessWidget {
  const RecruitDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recruit Dashboard (ATS)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.work, 'Jobs', '/recruit/jobs'),
          _buildNavItem(context, Icons.assignment_ind, 'Applications', '/recruit/applications'),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) => _buildCard(context, icon, title, route);
  Widget _buildCard(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class PerformanceDashboardShell extends StatelessWidget {
  const PerformanceDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Dashboard (PMS)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.flag, 'Goals (OKRs)', '/performance/goals'),
          _buildNavItem(context, Icons.rate_review, 'Reviews', '/performance/reviews'),
        ],
      ),
    );
  }
  
  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
      return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class ShieldDashboardShell extends StatelessWidget {
  const ShieldDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Shield Dashboard (Compliance)')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'Files', '/shield/files'),
          _buildNavItem(context, Icons.report_problem, 'Grievance Complaints', '/shield/grievance-complaints'),
          _buildNavItem(context, Icons.history, 'Log History', '/shield/log-history'),
          _buildNavItem(context, Icons.health_and_safety, 'Medical Exams', '/shield/medical-examinations'),
          _buildNavItem(context, Icons.security, 'POSH Complaints', '/shield/posh-complaints'),
          _buildNavItem(context, Icons.construction, 'PPE Issued', '/shield/ppe-issued'),
          _buildNavItem(context, Icons.assignment_return, 'PPE Returned', '/shield/ppe-returned'),
          _buildNavItem(context, Icons.warning_amber, 'Safety Incidents', '/shield/safety-incidents'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

// Generated Shells
class CommitteeDashboardShell extends StatelessWidget {
  const CommitteeDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Committee Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'CommitteeMeetingRecords', '/committee/committee-meeting-records'),
          _buildNavItem(context, Icons.folder, 'CommitteeMeetings', '/committee/committee-meetings'),
          _buildNavItem(context, Icons.folder, 'CommitteeMembers', '/committee/committee-members'),
          _buildNavItem(context, Icons.folder, 'Committees', '/committee/committees'),
          _buildNavItem(context, Icons.folder, 'Files', '/committee/files'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/committee/log-history'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class FinacDashboardShell extends StatelessWidget {
  const FinacDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finac Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'BankAccounts', '/finac/bank-accounts'),
          _buildNavItem(context, Icons.folder, 'BankTransactions', '/finac/bank-transactions'),
          _buildNavItem(context, Icons.folder, 'ExpenseCategories', '/finac/expense-categories'),
          _buildNavItem(context, Icons.folder, 'ExpenseClaimDetails', '/finac/expense-claim-details'),
          _buildNavItem(context, Icons.folder, 'ExpenseClaimSummary', '/finac/expense-claim-summary'),
          _buildNavItem(context, Icons.folder, 'Files', '/finac/files'),
          _buildNavItem(context, Icons.folder, 'JournalEntries', '/finac/journal-entries'),
          _buildNavItem(context, Icons.folder, 'JournalEntryLines', '/finac/journal-entry-lines'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/finac/log-history'),
          _buildNavItem(context, Icons.folder, 'ModuleRoleAssignments', '/finac/module-role-assignments'),
          _buildNavItem(context, Icons.folder, 'ModuleRoles', '/finac/module-roles'),
          _buildNavItem(context, Icons.folder, 'ModuleTeamMembers', '/finac/module-team-members'),
          _buildNavItem(context, Icons.folder, 'ModuleTeams', '/finac/module-teams'),
          _buildNavItem(context, Icons.folder, 'ModuleUsers', '/finac/module-users'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class TaxforgeDashboardShell extends StatelessWidget {
  const TaxforgeDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taxforge Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'Files', '/taxforge/files'),
          _buildNavItem(context, Icons.folder, 'GstDetails', '/taxforge/gst-details'),
          _buildNavItem(context, Icons.folder, 'GstTransactions', '/taxforge/gst-transactions'),
          _buildNavItem(context, Icons.folder, 'HsnSacCodes', '/taxforge/hsn-sac-codes'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/taxforge/log-history'),
          _buildNavItem(context, Icons.folder, 'TdsDetails', '/taxforge/tds-details'),
          _buildNavItem(context, Icons.folder, 'TdsTransactions', '/taxforge/tds-transactions'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class LedgieDashboardShell extends StatelessWidget {
  const LedgieDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ledgie Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'ActiveCustomers', '/ledgie/active-customers'),
          _buildNavItem(context, Icons.folder, 'ActiveProspects', '/ledgie/active-prospects'),
          _buildNavItem(context, Icons.folder, 'Agreements', '/ledgie/agreements'),
          _buildNavItem(context, Icons.folder, 'Entities', '/ledgie/entities'),
          _buildNavItem(context, Icons.folder, 'EntityContacts', '/ledgie/entity-contacts'),
          _buildNavItem(context, Icons.folder, 'EntityFiles', '/ledgie/entity-files'),
          _buildNavItem(context, Icons.folder, 'Estimates', '/ledgie/estimates'),
          _buildNavItem(context, Icons.folder, 'Files', '/ledgie/files'),
          _buildNavItem(context, Icons.folder, 'HotProspects', '/ledgie/hot-prospects'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/ledgie/log-history'),
          _buildNavItem(context, Icons.folder, 'ModuleRoleAssignments', '/ledgie/module-role-assignments'),
          _buildNavItem(context, Icons.folder, 'ModuleRoles', '/ledgie/module-roles'),
          _buildNavItem(context, Icons.folder, 'ModuleTeamMembers', '/ledgie/module-team-members'),
          _buildNavItem(context, Icons.folder, 'ModuleTeams', '/ledgie/module-teams'),
          _buildNavItem(context, Icons.folder, 'ModuleUsers', '/ledgie/module-users'),
          _buildNavItem(context, Icons.folder, 'ProformaInvoices', '/ledgie/proforma-invoices'),
          _buildNavItem(context, Icons.folder, 'Proposals', '/ledgie/proposals'),
          _buildNavItem(context, Icons.folder, 'TaxInvoices', '/ledgie/tax-invoices'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class ContracforceDashboardShell extends StatelessWidget {
  const ContracforceDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contracforce Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'ContractPayments', '/contracforce/contract-payments'),
          _buildNavItem(context, Icons.folder, 'ContractorComplianceDocuments', '/contracforce/contractor-compliance-documents'),
          _buildNavItem(context, Icons.folder, 'ContractorStaff', '/contracforce/contractor-staff'),
          _buildNavItem(context, Icons.folder, 'ContractorStaffDocuments', '/contracforce/contractor-staff-documents'),
          _buildNavItem(context, Icons.folder, 'Contractors', '/contracforce/contractors'),
          _buildNavItem(context, Icons.folder, 'Contracts', '/contracforce/contracts'),
          _buildNavItem(context, Icons.folder, 'Files', '/contracforce/files'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/contracforce/log-history'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class CommDashboardShell extends StatelessWidget {
  const CommDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comm Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'ChannelMembers', '/comm/channel-members'),
          _buildNavItem(context, Icons.folder, 'Channels', '/comm/channels'),
          _buildNavItem(context, Icons.folder, 'Files', '/comm/files'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/comm/log-history'),
          _buildNavItem(context, Icons.folder, 'Messages', '/comm/messages'),
          _buildNavItem(context, Icons.folder, 'ModuleRoleAssignments', '/comm/module-role-assignments'),
          _buildNavItem(context, Icons.folder, 'ModuleTeamMembers', '/comm/module-team-members'),
          _buildNavItem(context, Icons.folder, 'Notifications', '/comm/notifications'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class SurveyDashboardShell extends StatelessWidget {
  const SurveyDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Survey Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'Files', '/survey/files'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/survey/log-history'),
          _buildNavItem(context, Icons.folder, 'ModuleRoleAssignments', '/survey/module-role-assignments'),
          _buildNavItem(context, Icons.folder, 'ModuleTeamMembers', '/survey/module-team-members'),
          _buildNavItem(context, Icons.folder, 'SurveyPulse', '/survey/survey-pulse'),
          _buildNavItem(context, Icons.folder, 'SurveyQuestions', '/survey/survey-questions'),
          _buildNavItem(context, Icons.folder, 'SurveyResponses', '/survey/survey-responses'),
          _buildNavItem(context, Icons.folder, 'Surveys', '/survey/surveys'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class KnowledgeDashboardShell extends StatelessWidget {
  const KnowledgeDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Knowledge Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'DocAccessControl', '/knowledge/doc-access-control'),
          _buildNavItem(context, Icons.folder, 'DocFeedback', '/knowledge/doc-feedback'),
          _buildNavItem(context, Icons.folder, 'DocTagMap', '/knowledge/doc-tag-map'),
          _buildNavItem(context, Icons.folder, 'DocTags', '/knowledge/doc-tags'),
          _buildNavItem(context, Icons.folder, 'DocVersions', '/knowledge/doc-versions'),
          _buildNavItem(context, Icons.folder, 'Docs', '/knowledge/docs'),
          _buildNavItem(context, Icons.folder, 'Files', '/knowledge/files'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/knowledge/log-history'),
          _buildNavItem(context, Icons.folder, 'ModuleRoleAssignments', '/knowledge/module-role-assignments'),
          _buildNavItem(context, Icons.folder, 'ModuleTeamMembers', '/knowledge/module-team-members'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}

class TrainingDashboardShell extends StatelessWidget {
  const TrainingDashboardShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavItem(context, Icons.folder, 'AssessmentAttempts', '/training/assessment-attempts'),
          _buildNavItem(context, Icons.folder, 'AssessmentQuestions', '/training/assessment-questions'),
          _buildNavItem(context, Icons.folder, 'Assessments', '/training/assessments'),
          _buildNavItem(context, Icons.folder, 'Certifications', '/training/certifications'),
          _buildNavItem(context, Icons.folder, 'CourseUnits', '/training/course-units'),
          _buildNavItem(context, Icons.folder, 'Courses', '/training/courses'),
          _buildNavItem(context, Icons.folder, 'Enrollments', '/training/enrollments'),
          _buildNavItem(context, Icons.folder, 'Files', '/training/files'),
          _buildNavItem(context, Icons.folder, 'LmsSettings', '/training/lms-settings'),
          _buildNavItem(context, Icons.folder, 'LogHistory', '/training/log-history'),
          _buildNavItem(context, Icons.folder, 'ModuleRoleAssignments', '/training/module-role-assignments'),
          _buildNavItem(context, Icons.folder, 'ModuleTeamMembers', '/training/module-team-members'),
          _buildNavItem(context, Icons.folder, 'Sessions', '/training/sessions'),
          _buildNavItem(context, Icons.folder, 'TrainingMaterials', '/training/training-materials'),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right, size: 16),
        onTap: () => context.go(route),
      ),
    );
  }
}
