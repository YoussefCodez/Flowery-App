import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePasswordBaseState extends Equatable {
  final bool isChangingPassword;
  final bool didChangePasswordfail;

  const ChangePasswordBaseState({
    this.isChangingPassword = false,
    this.didChangePasswordfail = true,
  });

  ChangePasswordBaseState copyWith({
    bool? isChangingPassword,
    bool? didChangePasswordfail,
  }) => ChangePasswordBaseState(
    isChangingPassword: isChangingPassword ?? this.isChangingPassword,
    didChangePasswordfail: didChangePasswordfail ?? this.didChangePasswordfail,
  );

  @override
  List<Object?> get props => [isChangingPassword, didChangePasswordfail];
}
