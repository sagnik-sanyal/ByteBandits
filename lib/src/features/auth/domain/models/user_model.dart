import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    required String id,
    required String email,
    required String name,
    @Default(<UserModel>[]) List<UserModel> friends,
    String? photoUrl,
  }) = _UserModel;

  factory UserModel.initial() => const UserModel(
        id: '',
        email: '',
        name: '',
      );
}
