import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:passaround/entities/pa_user.dart';
import 'package:passaround/features/auth/ui/common/auth_fields.dart';
import 'package:passaround/widgets/circled_letter.dart';
import 'package:passaround/navigation/auth/log_in_go_route.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  PaUser? get currentUser => context.read<ProfileBloc>().currentUser;

  @override
  void initState() {
    super.initState();
    navigateAwayIfLoggedOut(context);

    if (widget.id == currentUser?.id) {
      context.read<ProfileBloc>().add(const ProfileSameUserDetected());
      usernameController.text = currentUser?.username ?? "";
      emailController.text = currentUser?.email ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
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
                        formKey: _formKey,
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

  void _logOut() => context.read<ProfileBloc>().add(const ProfileLogOutRequested());
}
