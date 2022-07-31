import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'dart:async';

void main() {

  group('Register', () {
    final button = find.byValueKey("SignUpButton");

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Registration  Test - 1', () async {
      await driver.tap(button);
      var emailField = find.byValueKey('emailReg');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped email");
      await driver.enterText("test100@gmail.com");  // enter text

      var pwd1Field = find.byValueKey('pwd1Reg');
      print("Password 1 found");
      await driver.tap(pwd1Field);  // acquire focus
      print("tapped password 1");
      await driver.enterText("test1");  // enter text

      var pwd2Field = find.byValueKey('pwd2Reg');
      print("Password 2 found");
      await driver.tap(pwd2Field);  // acquire focus
      print("tapped password 2");
      await driver.enterText("test1");  // enter text


      final btn2=find.byValueKey("signupReg");

      await driver.tap(btn2);

      print("tapped signup button");

      var err = await driver.getText(find.byValueKey('errorReg'));
      print("Found ");

      expect(err, 'Sign up successful!!!');


    });

    test('Registration  Test - 2', () async {
      await Future.delayed(Duration(milliseconds: 3000));
      var pwd1Field = find.byValueKey('pwd1Reg');
      print("Password 1 found");
      await driver.tap(pwd1Field);  // acquire focus
      print("tapped password 1");
      await driver.enterText("test1");  // enter text

      var pwd2Field = find.byValueKey('pwd2Reg');
      print("Password 2 found");
      await driver.tap(pwd2Field);  // acquire focus
      print("tapped password 2");
      await driver.enterText("test1");  // enter text

      final btn2=find.byValueKey("signupReg");
      await driver.tap(btn2);
      print("tapped signup button");

      var err = await driver.getText(find.byValueKey('errorReg'));
      print("Found ");

      expect(err, 'Sign up successful!!!');


    });

    test('Registration  Test - 3', () async {
      await Future.delayed(Duration(milliseconds: 3000));
      var emailField = find.byValueKey('emailReg');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped email");
      await driver.enterText("test100@gmail.com");  // enter text


      var pwd2Field = find.byValueKey('pwd2Reg');
      print("Password 2 found");
      await driver.tap(pwd2Field);  // acquire focus
      print("tapped password 2");
      await driver.enterText("test1");  // enter text


      final btn2=find.byValueKey("signupReg");

      await driver.tap(btn2);

      print("tapped signup button");

      var err = await driver.getText(find.byValueKey('errorReg'));
      print("Found ");

      expect(err, 'Sign up successful!!!');



    });

    test('Registration  Test - 4', () async {
      await Future.delayed(Duration(milliseconds: 3000));
      var emailField = find.byValueKey('emailReg');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped email");
      await driver.enterText("test100@gmail.com");  // enter text

      var pwd1Field = find.byValueKey('pwd1Reg');
      print("Password 1 found");
      await driver.tap(pwd1Field);  // acquire focus
      print("tapped password 1");
      await driver.enterText("test1");  // enter text


      final btn2=find.byValueKey("signupReg");

      await driver.tap(btn2);

      print("tapped signup button");

      var err = await driver.getText(find.byValueKey('errorReg'));
      print("Found ");

      expect(err, 'Sign up successful!!!');


    });

    test('Registration  Test - 5', () async {

      await Future.delayed(Duration(milliseconds: 3000));
      var emailField = find.byValueKey('emailReg');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped email");
      await driver.enterText("test107@gmail.com");  // enter text

      var pwd1Field = find.byValueKey('pwd1Reg');
      print("Password 1 found");
      await driver.tap(pwd1Field);  // acquire focus
      print("tapped password 1");
      await driver.enterText("test12345@");  // enter text

      var pwd2Field = find.byValueKey('pwd2Reg');
      print("Password 2 found");
      await driver.tap(pwd2Field);  // acquire focus
      print("tapped password 2");
      await driver.enterText("test12345@");  // enter text


      final btn2=find.byValueKey("signupReg");

      await driver.tap(btn2);

      print("tapped signup button");
      final logtxt=find.byValueKey("LoginText");
      expect(await driver.getText(logtxt), "LOGIN");

    });
  });
  group('Login', () {
    final button = find.byValueKey("LoginButton");

    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Login Testing - 1', () async {
      await driver.tap(button);

      await Future.delayed(Duration(milliseconds: 3000));
      var emailField = find.byValueKey('emailField');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped");
       await driver.enterText("test101@gmail.com");  // enter text
     
      var pwdField = find.byValueKey('pwdField');
      print("Password found");
      await driver.tap(pwdField);  // acquire focus
      print("tapped password");
      await driver.enterText("test123456@");  // enter text

      await driver.tap(button);
      // final text = find.text('Enter a valid email !');

     // expect(await driver.getText(text), 'Enter a valid email !');

      var err = await driver.getText(find.byValueKey('error'));
      print("Found ");

      expect(err, 'Unable to log in with provided credentials');
    });
    test('Login Testing - 2', () async {

      await Future.delayed(Duration(milliseconds: 3000));

      var pwdField = find.byValueKey('pwdField');
      print("Password found");
      await driver.tap(pwdField);  // acquire focus
      print("tapped password");
      await driver.enterText("test123456@");  // enter text

      await driver.tap(button);
      // final text = find.text('Enter a valid email !');

      // expect(await driver.getText(text), 'Enter a valid email !');

      var err = await driver.getText(find.byValueKey('error'));
      print("Found ");

      expect(err, 'Unable to log in with provided credentials');
    });
    test('Login Testing - 3', () async {

      await Future.delayed(Duration(milliseconds: 3000));
      var emailField = find.byValueKey('emailField');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped");
      await driver.enterText("test101@gmail.com");  // enter text



      await driver.tap(button);


      var err = await driver.getText(find.byValueKey('error'));
      print("Found ");

      expect(err, 'Unable to log in with provided credentials');
    });
    test('Login Testing - 4', () async {

      await Future.delayed(Duration(milliseconds: 3000));
      var emailField = find.byValueKey('emailField');
      print("Email found");
      await driver.tap(emailField);  // acquire focus
      print("tapped");
      await driver.enterText("test107@gmail.com");  // enter text

      var pwdField = find.byValueKey('pwdField');
      print("Password found");
      await driver.tap(pwdField);  // acquire focus
      print("tapped password");
      await driver.enterText("test12345@");  // enter text

      await driver.tap(button);
      final text = find.text('Color-blindness test');

      expect(await driver.getText(text), 'Color-blindness test');
    });


  });



}
