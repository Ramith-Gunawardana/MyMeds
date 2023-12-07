import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Frequency Asked Questions',
          style: TextStyle(
              color: Color(0xFF075260),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(height: 16),
              Text(
                'General Information:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF075260),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q1: What is the purpose of the Medicine Reminder Mobile App?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app is designed to help users manage their medications effectively by providing features such as medication reminders, prescription management, and health-related tools like a BMI calculator.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q2: Who is the target audience for the app?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app is intended for individuals of all ages who need assistance in managing their medication schedules and improving overall health awareness.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q3: On which platforms will the app be available?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app will be available on both Android and iOS platforms, ensuring accessibility for a wide range of users.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Features and Functionality:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q4: What features does the app offer for medication management?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app provides customizable medication reminders, prescription management with photo uploads, medication history tracking, and a comprehensive medication database.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q5: How does the medication reminder system work?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Users can set personalized medication reminders with specific frequencies and times. The app sends push notifications to remind users to take their medications.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q6: Can I upload photos of my prescriptions to the app?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Yes, the app allows users to securely upload photos of their prescriptions for easy management and retrieval.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q7: Is there a BMI calculator feature, and how does it work?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Yes, the app includes a BMI calculator. Users input their height and weight, and the app calculates their Body Mass Index, providing insights into their health.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q8: How does the app locate nearby hospitals and pharmacies?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app integrates with map services, allowing users to search for nearby hospitals and pharmacies based on their location. Filters are available for refining search results.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Security and Privacy:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q9: How is user data, especially prescription photos, secured?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'User data, including prescription photos, is encrypted to ensure privacy and security. The app adheres to data protection regulations to safeguard user information.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q10: What measures are in place to ensure data privacy and comply with regulations?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app follows industry-standard practices for data protection and complies with relevant healthcare regulations. Regular security audits are conducted to maintain a secure environment.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q11: Is the app compliant with healthcare data protection standards?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Yes, the app is designed to comply with healthcare data protection standards, ensuring the secure handling of user health information.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Technical Details:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q12: Will the app work on both Android and iOS devices?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'No, the app is compatible with only Android operating systems, providing a consistent experience across different devices.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q13: What APIs are used for map integration and medication databases?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app integrates with well-established map APIs for location-based assistance and utilizes reputable medication databases to ensure accurate and up-to-date information.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q14: Is the app available offline, and how does it handle synchronization?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app offers offline functionality for certain features. Synchronization ensures that user data is updated seamlessly across multiple devices when connected to the internet.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Health Information and Educational Content:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q15: Where does the app source its medication information?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app sources medication information from reputable databases and healthcare resources, ensuring accurate and reliable details about medications.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q16: How frequently will health tips and educational content be sent?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Health tips and educational content will be sent periodically based on user preferences. Users can customize the frequency in the app settings.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Compatibility and Updates:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q17: Will the app be compatible with my device\'s operating system?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app is designed to be compatible with a wide range of devices and operating systems. Regular updates ensure compatibility with the latest technologies.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q18: How often will the app be updated, and what do updates include?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Updates will be rolled out periodically to introduce new features, improvements, and bug fixes. Users will be notified of updates through the app store.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q19: Is there multi-device sync, and how does it work?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Yes, the app offers multi-device sync functionality. Users can securely sync their data across multiple devices by logging in with the same account.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'User Onboarding and Tutorials:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Q20: How easy is it for a new user to get started with the app?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'The app is designed with user-friendly interfaces and onboarding processes to make it easy for new users to get started quickly and efficiently.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/*
General Information:

 Q1: What is the purpose of the Medicine Reminder Mobile App?
   - A1: The app is designed to help users manage their medications effectively by providing features such as medication reminders, prescription management, and health-related tools like a BMI calculator.

 Q2: Who is the target audience for the app?
   - A2: The app is intended for individuals of all ages who need assistance in managing their medication schedules and improving overall health awareness.

Q3: On which platforms will the app be available?
   - A3: The app will be available on both Android and iOS platforms, ensuring accessibility for a wide range of users.

Features and Functionality:

Q4: What features does the app offer for medication management?
   - A4: The app provides customizable medication reminders, prescription management with photo uploads, medication history tracking, and a comprehensive medication database.

Q5: How does the medication reminder system work?
   - A5: Users can set personalized medication reminders with specific frequencies and times. The app sends push notifications to remind users to take their medications.

Q6: Can I upload photos of my prescriptions to the app?
   - A6: Yes, the app allows users to securely upload photos of their prescriptions for easy management and retrieval.

Q7: Is there a BMI calculator feature, and how does it work?
   - A7: Yes, the app includes a BMI calculator. Users input their height and weight, and the app calculates their Body Mass Index, providing insights into their health.

Q8: How does the app locate nearby hospitals and pharmacies?
   - A8: The app integrates with map services, allowing users to search for nearby hospitals and pharmacies based on their location. Filters are available for refining search results.

Security and Privacy:

Q9: How is user data, especially prescription photos, secured?
   - A9: User data, including prescription photos, is encrypted to ensure privacy and security. The app adheres to data protection regulations to safeguard user information.

Q10: What measures are in place to ensure data privacy and comply with regulations?
    - A10: The app follows industry-standard practices for data protection and complies with relevant healthcare regulations. Regular security audits are conducted to maintain a secure environment.

Q11: Is the app compliant with healthcare data protection standards?
    - A11: Yes, the app is designed to comply with healthcare data protection standards, ensuring the secure handling of user health information.

Technical Details:

Q12: Will the app work on both Android and iOS devices?
    - A12 No, the app is compatible with only Android operating systems, providing a consistent experience across different devices.

Q13: What APIs are used for map integration and medication databases?
    - A13: The app integrates with well-established map APIs for location-based assistance and utilizes reputable medication databases to ensure accurate and up-to-date information.

Q14: Is the app available offline, and how does it handle synchronization?
    - A14: The app offers offline functionality for certain features. Synchronization ensures that user data is updated seamlessly across multiple devices when connected to the internet.
Certainly! Here are additional Frequently Asked Questions (FAQs) for the Medicine Reminder Mobile App:

Health Information and Educational Content:

Q15: Where does the app source its medication information?
    - A15: The app sources medication information from reputable databases and healthcare resources, ensuring accurate and reliable details about medications.

Q16: How frequently will health tips and educational content be sent?
    - A16: Health tips and educational content will be sent periodically based on user preferences. Users can customize the frequency in the app settings.

Compatibility and Updates:

Q17: Will the app be compatible with my device's operating system?
    - A17: The app is designed to be compatible with a wide range of devices and operating systems. Regular updates ensure compatibility with the latest technologies.

Q18: How often will the app be updated, and what do updates include?
    - A18: Updates will be rolled out periodically to introduce new features, improvements, and bug fixes. Users will be notified of updates through the app store.

Q19: Is there multi-device sync, and how does it work?
    - A19: Yes, the app offers multi-device sync functionality. Users can securely sync their data across multiple devices by logging in with the same account.

User Onboarding and Tutorials:

Q20: How easy is it for a new user to get started with the app?
    - A20: The app is designed with user-friendly interfaces and onboarding processes to make it easy for new users to get started quickly and efficiently.

*/