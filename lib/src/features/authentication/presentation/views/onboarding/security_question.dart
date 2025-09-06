import 'package:auto_route/annotations.dart';
import 'package:designerwardrobe/src/router/route_names.dart';
import 'package:flutter/material.dart';

@RoutePage(name: securityQuestionsRoute)
class SecurityQuestionsScreen extends StatefulWidget {
  const SecurityQuestionsScreen({super.key});

  @override
  State<SecurityQuestionsScreen> createState() =>
      _SecurityQuestionsScreenState();
}

class _SecurityQuestionsScreenState extends State<SecurityQuestionsScreen> {
  String? _question1;
  String? _question2;
  final _answer1Controller = TextEditingController();
  final _answer2Controller = TextEditingController();

  final List<String> questions = [
    "What was your childhood nickname?",
    "What is the name of your first pet?",
    "What is your mother’s maiden name?",
    "What is your favorite teacher’s name?",
  ];

  bool get _isFormValid =>
      _question1 != null &&
          _question2 != null &&
          _answer1Controller.text.isNotEmpty &&
          _answer2Controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Step 3 of 4",
                style: TextStyle(
                  fontFamily: "Creato Display",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              "Set up Security Questions",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0A0A0C),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Add an extra layer of security by setting a question only you can answer.",
              style: const TextStyle(
                fontFamily: "Creato Display",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF92939E),
              ),
            ),
            const SizedBox(height: 24),

            // Question 1
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Question 1"),
              value: _question1,
              items: questions
                  .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                  .toList(),
              onChanged: (val) => setState(() => _question1 = val),
            ),
            const SizedBox(height: 16),

            // Answer 1
            TextField(
              controller: _answer1Controller,
              decoration: const InputDecoration(labelText: "Answer"),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),

            // Question 2
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Question 2"),
              value: _question2,
              items: questions
                  .map((q) => DropdownMenuItem(value: q, child: Text(q)))
                  .toList(),
              onChanged: (val) => setState(() => _question2 = val),
            ),
            const SizedBox(height: 16),

            // Answer 2
            TextField(
              controller: _answer2Controller,
              decoration: const InputDecoration(labelText: "Answer"),
              onChanged: (_) => setState(() {}),
            ),
            const Spacer(),

            // Submit button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _isFormValid
                    ? () {
                  // TODO: save security questions
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isFormValid
                      ? const Color(0xFF0092FF)
                      : const Color(0xFFF4F4F4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  "Set Security Question",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:
                    _isFormValid ? Colors.white : const Color(0xFFA3A3A3),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Skip option
            Center(
              child: GestureDetector(
                onTap: () {
                  // TODO: skip setup
                },
                child: const Text(
                  "Set up later",
                  style: TextStyle(
                    fontFamily: "Creato Display",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0092FF),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}