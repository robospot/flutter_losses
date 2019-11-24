import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PhoneChanged extends LoginEvent {
  final String phone;

  const PhoneChanged({@required this.phone});

  @override
  List<Object> get props => [phone];

  @override
  String toString() => 'PhoneChanged { phone :$phone }';
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class Submitted extends LoginEvent {
  final String email;
  final String password;

  const Submitted({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

class LoginWithGooglePressed extends LoginEvent {}

class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginWithCredentialsPressed({
    @required this.email,
    @required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}

class VerifyPhoneNumber extends LoginEvent {
  final String phone;

  const VerifyPhoneNumber({
    @required this.phone,
  });

  @override
  List<Object> get props => [phone];

  @override
  String toString() {
    return 'VerifyPhoneNumber { phone: $phone, }';
  }
}

class LoginWithPhone extends LoginEvent {
  
  final String sms;

  const LoginWithPhone({
  
    @required this.sms,
  });

  @override
  List<Object> get props => [sms];

  @override
  String toString() {
    return 'LoginWithPhone {  sms: $sms }';
  }
}
