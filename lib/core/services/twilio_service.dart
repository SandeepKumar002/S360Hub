import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TwilioService {
  // TODO: Replace these with environment variables using flutter_dotenv or similar
  // Never commit actual credentials to version control
  final String accountSid = 'YOUR_TWILIO_ACCOUNT_SID'; // Replace with env variable
  final String authToken = 'YOUR_TWILIO_AUTH_TOKEN';   // Replace with env variable
  final String fromPhone = 'YOUR_TWILIO_PHONE_NUMBER'; // Replace with env variable

  /// Sends an SMS using Twilio API
  Future<bool> sendSms({required String to, required String message}) async {
    try {
      final url = Uri.parse('https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json');
      
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('$accountSid:$authToken'))}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'From': fromPhone,
          'To': to,
          'Body': message,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Twilio SMS sent successfully');
        return true;
      } else {
        debugPrint('Failed to send Twilio SMS: ${response.body}');
        return false;
      }
    } catch (e) {
      debugPrint('Error sending Twilio SMS: $e');
      return false;
    }
  }
}
