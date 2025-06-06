import 'package:errands_boys/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class PrivacySharingScreen extends StatefulWidget {
  const PrivacySharingScreen({super.key});

  @override
  State<PrivacySharingScreen> createState() => _PrivacySharingScreen();
}

class _PrivacySharingScreen extends State<PrivacySharingScreen> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Bottom Nav Bar Icon $index pressed');
    });
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          'Privacy & Sharing',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold
          ),
        )
      ),
           
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Introduction \nAt Errand Boys, we value and respect your privacy. This Privacy & Sharing page explains how we collect, use, share, and protect your information when you use our services. By using our app, you agree to the practices described in this policy.'
              ),

              const SizedBox(height: 10,),

              Text(
                '2. Information We Collect \nTo provide and improve our services, we collect the following types of information from you: \n• Personal Information:\n   • Name\n   • Email address\n   • Phone number\n   • Billing information (if applicable)\n   • Profile picture (optional)\n• Location Information:\n   • GPS location data (for tracking errands and service \n      requests)\n   • IP address (for location identification)\n• Usage Data:\n   • Interaction with app features\n   • Device information (OS, version, device type)\n   • Log files (app crashes, performance logs, etc.)\n• Payment Information:\n   • Payment details (processed through third-party \n     payment processors)\n• Communication Data:\n   • Messages exchanged between users (errand \n     requests, updates)'
              ),

              const SizedBox(height: 10,),

              Text(
                '3. How We Use Your Information\nWe use your information for the following purposes:\n• To provide and improve our errand services\n• To personalize your experience and \n   recommendations\n• To process transactions and send receipts\n• To communicate with you about your account, \n   services, and promotions\n• To monitor app performance and resolve technical \n   issues\n• To comply with legal obligations and resolve disputes\n• To offer customer support and handle complaints or \n  queries'
              ),

              const SizedBox(height: 10),

              Text(
                '4. How We Share Your Information\nWe may share your information in the following circumstances:\n• With Errand Boys Partners: \n   • We may share your information with authorized \n     service providers or third-party partners who help \n     us deliver the service (e.g., payment processors, \n     delivery services, or customer support).\n• For Legal Compliance:\n   • If required by law or in response to legal processes \n     (e.g., a subpoena), we may share your information \n     to comply with legal obligations.\n• In Case of Business Transfers: \n   • If we undergo a merger, acquisition, or sale of \n     assets, your personal information may be \n     transferred as part of that transaction.\n• With Your Consent:\n   • We may share your information if you give explicit \n     consent for certain purposes.'
              ),

              const SizedBox(height: 10),

              Text(
                '5. Data Security\nWe take your privacy seriously and implement reasonable administrative, technical, and physical measures to protect your data. However, no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee the absolute security of your information.'
              ),

              const SizedBox(height: 10),

              Text(
                '6. Data Retention\nWe will retain your personal information only for as long as necessary to fulfill the purposes outlined in this privacy policy, unless a longer retention period is required by law. When no longer needed, we will safely delete or anonymize your data.'
              ),

              const SizedBox(height: 10),

              Text(
                '7. Your Rights\nAs a user, you have the following rights concerning your personal information:\n• Access: You can request access to the personal data we hold about you.\n• Correction: You can request to correct any inaccuracies in your information.\n• Deletion: You can request that we delete your personal information.\n• Opt-out of Marketing Communications: You can unsubscribe from promotional emails and notifications.\n• Data Portability: You may request a copy of your personal information in a structured, commonly used format.\nFor any of these requests, please contact us at [errandboysss@gmail.com].'
              ),

              const SizedBox(height: 10),

              Text(
                '8. Cookies and Tracking Technologies\nWe use cookies and similar tracking technologies to enhance your experience on our app. These technologies collect information about how you use the app and help us analyze performance and user behavior. You can adjust your cookie settings through your device or app settings.'
              ),

              const SizedBox(height: 10),

              Text(
                '9. Third-Party Links\nOur app may contain links to third-party websites or services not owned or controlled by Errand Boys. We are not responsible for the privacy practices of these third parties, and we encourage you to review their privacy policies before sharing any information.'
              ),

              const SizedBox(height: 10),

              Text(
                '10. Children\'s Privacy\nOur app is not intended for children under the age of 13. We do not knowingly collect personal information from children. If we learn that we have collected personal information from a child under 13, we will take steps to delete such information as quickly as possible.'
              ),

              const SizedBox(height: 10,),

              Text(
                '11. Changes to This Privacy Policy\nWe may update this Privacy & Sharing Policy from time to time. Any changes will be posted in this section with an updated date. We encourage you to review this policy periodically to stay informed about how we are protecting your information.'
              ),

              const SizedBox(height: 10),

              Text(
                '12. Contact Us\nIf you have any questions, concerns, or requests related to your privacy or this policy, please contact us at:\nErrand Boys Privacy Team\nEmail: [errandboysss@gmail.com]\nPhone: [123-456-7890]'
              ),

              const SizedBox(height: 10),

              Text(
                '13. Effective Date\nThis Privacy & Sharing Policy is effective as of [Date].'
              ),
            ],
          ),
        ),
      ),
 
      bottomNavigationBar: BottomNavBar(
        navBarOnTap: _onItemTapped,
        navBarSelectedIndex: _selectedIndex,
      ),
    );
  }
}
