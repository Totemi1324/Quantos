import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_service.dart';
import '../../bloc/database_service.dart';
import '../../bloc/localization_service.dart';
import '../../bloc/profile_quiz_service.dart';
import '../../loading_routines.dart';

import '../../screens/base/home.dart';
import '../../screens/loading_screen.dart';
import '../../models/exceptions.dart';
import '../authentication_error_popup.dart';
import '../no_intnernet_popup.dart';
import '../../screens/profile/profile_name_screen.dart';

class AccessCodeForm extends StatefulWidget {
  const AccessCodeForm({super.key});

  @override
  State<AccessCodeForm> createState() => _AccessCodeFormState();
}

class _AccessCodeFormState extends State<AccessCodeForm> {
  final _formKey = GlobalKey<FormState>();
  final _nodes = List<FocusNode>.generate(6, (index) => FocusNode());
  final _code = List<String>.filled(6, "", growable: false);
  bool _isLoading = false;

  @override
  void dispose() {
    for (var node in _nodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onSubmit(BuildContext buildContext) async {
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    if (!mounted) return;

    final code = _code.join();

    try {
      final exists =
          await buildContext.read<DatabaseService>().accessCodeExists(code);
      if (!exists) {
        throw AuthenticationException(AuthenticationError.accessCodeNotFound);
      }
      if (!mounted) return;
      final data =
          await buildContext.read<DatabaseService>().getAccessCodeInfo(code);
      if (!data.item1) {
        throw AuthenticationException(AuthenticationError.userDisabled);
      }

      if (await buildContext
          .read<DatabaseService>()
          .accessCodeHasSignedUp(code)) {
        if (!mounted) return;
        await buildContext.read<AuthenticationService>().accessCodeLogIn(code);

        if (!mounted) return;
        Navigator.of(buildContext).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (buildContext) => LoadingScreen(
              getDefaultLoadingRoutine(buildContext),
              Home.routeName,
            ),
          ),
          (_) => false,
        );
      } else {
        if (!mounted) return;
        final currentLocale = buildContext.read<LocalizationService>().state;
        await buildContext
            .read<ProfileQuizService>()
            .loadFromLocale(currentLocale);
        if (!mounted) return;
        await buildContext.read<AuthenticationService>().accessCodeSignUp(code);

        if (!mounted) return;
        buildContext.read<DatabaseService>().fullReset();
        await buildContext.read<DatabaseService>().initializeUserEntry(
              buildContext.read<AuthenticationService>().state.userId,
              team: data.item2,
            );

        setState(() {
          _isLoading = false;
        });

        if (!mounted) return;
        Navigator.of(buildContext)
            .pushNamedAndRemoveUntil(ProfileNameScreen.routeName, (_) => false);
      }
    } on AuthenticationException catch (error) {
      showDialog(
        context: buildContext,
        builder: (_) => AuthenticationErrorPopup(error.responseCode),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    } on NoInternetException {
      showDialog(
        context: buildContext,
        builder: (_) => const NoInternetPopup(),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    } catch (error) {
      showDialog(
        context: buildContext,
        builder: (_) =>
            const AuthenticationErrorPopup(AuthenticationError.unknown),
        barrierDismissible: true,
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
  }

  Widget _buildAutoFormField(
    BuildContext buildContext, {
    required int index,
  }) {
    return SizedBox(
      width: 35,
      child: TextFormField(
        style: Theme.of(buildContext).textTheme.bodyLarge,
        textAlign: TextAlign.center,
        textCapitalization: TextCapitalization.characters,
        inputFormatters: [
          UpperCaseTextFormatter(),
          LengthLimitingTextInputFormatter(1),
        ],
        autocorrect: false,
        enableSuggestions: false,
        focusNode: _nodes[index],
        onChanged: (value) => _onFormFieldChange(
          buildContext,
          value,
          index > 0 ? _nodes[index - 1] : null,
          index < 5 ? _nodes[index + 1] : null,
        ),
        enabled: !_isLoading,
        onSaved: (newValue) => _code[index] = newValue ?? "",
      ),
    );
  }

  void _onFormFieldChange(
    BuildContext buildContext,
    String newValue,
    FocusNode? prev,
    FocusNode? next,
  ) {
    if (next != null) {
      if (newValue.isEmpty) {
        FocusScope.of(context).requestFocus(prev);
      } else {
        FocusScope.of(context).requestFocus(next);
      }
    } else if (prev != null && newValue.isEmpty) {
      FocusScope.of(context).requestFocus(prev);
    } else {
      _onSubmit(buildContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAutoFormField(context, index: 0),
            _buildAutoFormField(context, index: 1),
            _buildAutoFormField(context, index: 2),
            Text(
              "-",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            _buildAutoFormField(context, index: 3),
            _buildAutoFormField(context, index: 4),
            _buildAutoFormField(context, index: 5),
          ],
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
