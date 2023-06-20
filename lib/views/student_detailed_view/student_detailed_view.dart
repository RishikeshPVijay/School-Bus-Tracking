import 'package:flutter/material.dart';
import 'package:smart_school_bus/enums/user_type.dart';
import 'package:smart_school_bus/models/student.dart';
import 'package:smart_school_bus/pages/ssb_dashboard_page_with_user.dart';

class StudentDetailedView extends StatelessWidget {
  final Student student;
  const StudentDetailedView({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SSBDashboardPageWithUser(
      appBarTitle: 'Student',
      isPadded: false,
      builder: (user) {
        final bool isAdmin = user.userType == UserType.admin;
        return ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: size.height, maxWidth: size.width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(bottom: 80.0),
                        color: Theme.of(context).primaryColor,
                        child: SizedBox(
                          height: 130.0,
                          child: Image.asset('images/student.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 150.0,
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    student.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Class',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      '--->',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        student.cls,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Address',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      '--->',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        student.address,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Admission no',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      '--->',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        student.admissionNumber,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                if (isAdmin && student.rfid != null)
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'RFID',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        '--->',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          student.rfid!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if (isAdmin && student.rfid == null)
                                  const Text(
                                    'RFID not assigned',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
