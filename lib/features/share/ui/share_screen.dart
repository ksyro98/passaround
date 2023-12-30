import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passaround/entities/pa_user_manager.dart';
import 'package:passaround/features/share/bloc/share_bloc.dart';
import 'package:passaround/features/share/ui/input/share_input_field.dart';
import 'package:passaround/features/share/ui/list/share_items_list.dart';
import 'package:passaround/features/share/ui/top_app_bar/profile/profile_action.dart';
import 'package:passaround/navigation/utils/functions.dart';

import '../../../entities/pa_user.dart';
import '../../../utils/constants.dart';
import '../../../widgets/simple_snack_bar.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  PaUser get user => PaUserManager.get().current ?? const PaUser.empty();

  @override
  void initState() {
    super.initState();
    context.read<ShareBloc>().add(const ShareLoadingStarted());
    navigateAwayIfLoggedOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth <= FormFactorValues.smallScreenThreshold;
        return Scaffold(
          appBar: AppBar(
            title: const Text("PassAround", style: TextStyle(fontSize: 26)),
            actions: [
              ProfileAction(userId: user.id, username: user.username, isMobile: isMobile),
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlocConsumer<ShareBloc, ShareState>(
            listener: (BuildContext context, ShareState state) {
              if (state.value == ShareStateValue.error) {
                SimpleSnackBar.show(context, state.errorMessage);
                context.read<ShareBloc>().add(const ShareRecoverFromError());
              }
            },
            builder: (BuildContext context, ShareState state) {
              return isMobile ? _getSmallScreen(state) : _getLargeScreen(state);
            },
          ),
        );
      },
    );
  }

  Widget _getLargeScreen(ShareState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 6, child: ShareItemsList(state: state)),
        Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: ShareInputField(state: state, isSmallScreen: false),
          ),
        ),
      ],
    );
  }

  Widget _getSmallScreen(ShareState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: ShareItemsList(state: state)),
        ShareInputField(state: state, isSmallScreen: true),
      ],
    );
  }
}
