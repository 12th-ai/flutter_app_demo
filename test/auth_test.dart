import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:my_app/main.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/dashboard_screen.dart';

void main() {
  testWidgets('Successful registration and login', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MyApp(isLoggedIn: false));

    // Navigate to the Register screen
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);

    // Enter registration details
    await tester.enterText(find.bySemanticsLabel('Username'), 'testuser');
    await tester.enterText(
        find.bySemanticsLabel('Email'), 'testuser@example.com');
    await tester.enterText(find.bySemanticsLabel('Password'), 'password123');
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    // Verify registration success popup
    expect(find.text('Registration successful!'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify we are on the Login screen
    expect(find.byType(LoginScreen), findsOneWidget);

    // Enter login details
    await tester.enterText(find.bySemanticsLabel('Username'), 'testuser');
    await tester.enterText(find.bySemanticsLabel('Password'), 'password123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify login success popup
    expect(find.text('Login successful!'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify we are on the Dashboard screen
    expect(find.byType(DashboardScreen), findsOneWidget);
    expect(find.text('Welcome to the Dashboard!'), findsOneWidget);
  });

  testWidgets('Unsuccessful login', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({
      'username': 'testuser',
      'email': 'testuser@example.com',
      'password': 'password123',
    });

    await tester.pumpWidget(const MyApp(isLoggedIn: false));

    // Navigate to the Login screen
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);

    // Enter incorrect login details
    await tester.enterText(find.bySemanticsLabel('Username'), 'testuser');
    await tester.enterText(find.bySemanticsLabel('Password'), 'wrongpassword');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify login error popup
    expect(find.text('Invalid credentials!'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    // Verify we are still on the Login screen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
