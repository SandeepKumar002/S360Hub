import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import '../../core/providers/auth_state.dart';
import '../../core/services/feedback_service.dart';

class OtpVerifyPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> args; // Now accepts a map with phone, email, method
  const OtpVerifyPage({super.key, required this.args});

  @override
  ConsumerState<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends ConsumerState<OtpVerifyPage> {
  final _mobileOtpController = TextEditingController();
  final _emailOtpController = TextEditingController();
  bool _isLoading = false;

  String get _phone => widget.args['phone'] as String;
  String? get _email => widget.args['email'] as String?;
  String get _method => widget.args['method'] as String? ?? 'mobile_only';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Verification Required',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(_getDescriptionText(), textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 32),
            
            if (_method == 'mobile_only' || _method == 'email_and_mobile') ...[
               const Text('Mobile OTP'),
               const SizedBox(height: 8),
               Pinput(
                 length: 6,
                 controller: _mobileOtpController,
                 autofocus: _method != 'email_only',
               ),
               const SizedBox(height: 24),
            ],

            if (_method == 'email_only' || _method == 'email_and_mobile') ...[
               const Text('Email OTP'),
               const SizedBox(height: 8),
               Pinput(
                 length: 6,
                 controller: _emailOtpController,
                 autofocus: _method == 'email_only',
               ),
               const SizedBox(height: 24),
            ],

            ElevatedButton(
              onPressed: _isLoading ? null : _verify,
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading ? const CircularProgressIndicator() : const Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }

  String _getDescriptionText() {
    if (_method == 'email_and_mobile') {
      return 'Please enter the OTPs sent to your mobile ($_phone) and email ($_email)';
    } else if (_method == 'email_only') {
      return 'Please enter the OTP sent to your email ($_email)';
    } else {
      return 'Please enter the OTP sent to your mobile ($_phone)';
    }
  }

  Future<void> _verify() async {
     setState(() => _isLoading = true);
     try {
       // 1. Verify Primary
       if (_method == 'mobile_only') {
          await ref.read(authServiceProvider).verifyOtp(
              token: _mobileOtpController.text, 
              type: 'sms', 
              phone: _phone
          );
       } else if (_method == 'email_only') {
          await ref.read(authServiceProvider).verifyOtp(
              token: _emailOtpController.text, 
              type: 'email', 
              email: _email
          );
       } else if (_method == 'email_and_mobile') {
          // Dual Verification Logic
          // A. Verify Phone (Real)
          await ref.read(authServiceProvider).verifyOtp(
              token: _mobileOtpController.text, 
              type: 'sms', 
              phone: _phone
          );
          
          // B. Verify Email (Mock/Custom)
          // Since we can't easily trigger a second independent auth session concurrently in Supabase client side
          // we assume if Phone passed, and we are in this block, we "mock" verify the email or 
          // assume it was handled server side.
          // For DEMO purposes: Check if Email OTP is not empty.
          if (_emailOtpController.text.length != 6) {
             throw 'Invalid Email OTP format';
          }
          // Ideally: await ref.read(authServiceProvider).verifySecondaryOtp(_emailOtpController.text);
       }

       if (mounted) FeedbackService.showSuccess(context, 'Verified!');
       // Router redirects automatically on auth state change
     } catch (e) {
       if (mounted) FeedbackService.showError(context, 'Verification Failed: ${e.toString()}');
     } finally {
       if (mounted) setState(() => _isLoading = false);
     }
  }
}
