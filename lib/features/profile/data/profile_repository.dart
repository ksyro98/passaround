import 'package:passaround/data_structures/change_request.dart';
import 'package:passaround/data_structures/either.dart';
import 'package:passaround/data_structures/extended_bool.dart';
import 'package:passaround/features/profile/bloc/profile_data_access.dart';
import 'package:passaround/features/profile/data/profile_datasource.dart';
import 'package:passaround/utils/logger.dart';

class ProfileRepository implements ProfileDataAccess {
  static const String _unknownError = "An unknown error occurred. Please try again later.";

  final ProfileDatasource _datasource;

  const ProfileRepository(this._datasource);

  @override
  Future<Either<String, String>> updateUser(ChangeRequest<String> changeRequest) async {
    Map<String, Future<ExtendedBool> Function(String)> actions = {
      "username": _datasource.updateUsername,
      "email": _datasource.updateEmail,
      "password": _datasource.updatePassword,
    };

    final Future<ExtendedBool> Function(String)? action = actions[changeRequest.key];

    if (action != null) {
      final ExtendedBool result = await action(changeRequest.newValue);
      final bool succeeded = result.value;
      return succeeded ? Either.secondOnly(changeRequest.newValue) : Either.firstOnly(result.detail);
    }

    Logger.ePrint("An unknown key was provided in the updateUser method of ProfileRepository.");
    return const Either.firstOnly(_unknownError);
  }

  @override
  Future<void> logOut() async => await _datasource.logOut();
}
