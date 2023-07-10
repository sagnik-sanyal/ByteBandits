import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/models/user_model.dart';

final StateNotifierProvider<UserNotifier, UserModel> userProvider =
    StateNotifierProvider<UserNotifier, UserModel>(
        (StateNotifierProviderRef<UserNotifier, UserModel> ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier() : super(UserModel.initial());

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = UserModel.initial();
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updatePhotoUrl(String photoUrl) {
    state = state.copyWith(photoUrl: photoUrl);
  }

  void addFriend(UserModel friend) {
    state = state.copyWith(friends: <UserModel>[...state.friends, friend]);
  }

  @override
  void dispose() {
    clearUser();
    super.dispose();
  }
}
