import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/entities/pa_user.dart';
import 'package:passaround/features/auth/ui/common/auth_fields.dart';
import 'package:passaround/widgets/circled_letter.dart';
import 'package:passaround/navigation/auth/log_in_go_route.dart';
import 'package:passaround/navigation/share_go_route.dart';
import 'package:passaround/widgets/loading_indicator.dart';

import '../../../navigation/utils/functions.dart';
import '../../../widgets/simple_snack_bar.dart';
import '../bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final String id;

  const ProfileScreen({super.key, required this.id});

  @override
  State<ProfileScreen> createState() => _ProfileScreeState();
}

class _ProfileScreeState extends State<ProfileScreen> {
  bool allowEdit = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    navigateAwayIfLoggedOut(context);

    if (widget.id == PaUser.instance?.id) {
      context.read<ProfileBloc>().add(const ProfileSameUserDetected());
      usernameController.text = PaUser.instance?.username ?? "";
      emailController.text = PaUser.instance?.email ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _navigateBack,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 320,
            child: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (BuildContext context, ProfileState state) {
                if (state.value == ProfileStateValue.error) {
                  SimpleSnackBar.show(context, state.errorMessage);
                } else if (state.value == ProfileStateValue.loggedOut) {
                  _navigateToLogInScreen();
                }
              },
              builder: (BuildContext context, ProfileState state) {
                if (state.value == ProfileStateValue.initial) {
                  return const LoadingIndicator();
                } else {
                  return Column(
                    children: [
                      const SizedBox(height: 24),
                      CircledLetter(letter: state.user?.username.characters.first.toUpperCase() ?? "U"),
                      const SizedBox(height: 60),
                      AuthFields(
                        usernameController: usernameController,
                        emailController: emailController,
                        passwordController: TextEditingController(),
                        excludePasswordField: true,
                        areDisabled: !allowEdit,
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _logOut,
                        child: Text(
                          "Log Out",
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToLogInScreen() => GoRouter.of(context).goNamed(LogInGoRoute.name);

  void _navigateBack() {
    if(GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    } else  {
      GoRouter.of(context).goNamed(ShareGoRoute.name);
    }
  }

  void _logOut() => context.read<ProfileBloc>().add(const ProfileLogOutRequested());
}
