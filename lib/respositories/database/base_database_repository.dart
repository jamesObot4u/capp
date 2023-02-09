import '../../model/user_model.dart';

abstract class BaseDatabaseRepository {
  Stream<User> getUser(String userId);
  Future<void> createUser(User user);
  Future<void> createChat(User user);
  Stream<List<User>> getUsers(
      String userId, String gender, String prebio, String location);
  Stream<List<User>> getUsersChat(String userId);
  Future<void> updateUser(User user);
  Future<void> updateUserPictures(User user, String imageName);
}
