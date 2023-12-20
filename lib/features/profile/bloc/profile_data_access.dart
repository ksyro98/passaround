import 'package:passaround/data_structures/change_request.dart';

import '../../../data_structures/either.dart';

abstract class ProfileDataAccess {
  Future<Either<String, String>> updateUser(ChangeRequest<String> changeRequest);

  Future<void> logOut();
}