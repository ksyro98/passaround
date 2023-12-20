import 'package:passaround/data_structures/change_request.dart';
import 'package:passaround/data_structures/either.dart';
import 'package:passaround/features/profile/bloc/profile_data_access.dart';


class MockProfileDataAccess implements ProfileDataAccess {
  final bool shouldSucceed;

  const MockProfileDataAccess({required this.shouldSucceed});

  @override
  Future<Either<String, String>> updateUser(ChangeRequest<String> changeRequest) async =>
      shouldSucceed ? Either.secondOnly(changeRequest.newValue) : const Either.firstOnly("Update error");

  @override
  Future<void> logOut() async {
    // do nothing
  }
}
