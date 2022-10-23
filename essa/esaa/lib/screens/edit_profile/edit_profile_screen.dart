import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

import 'edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      title: const Text("تعديل حسابك الشخصي",
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis)),
      showLeading: true,
      child: SingleChildScrollView(
        child: Responsive(
          mobile: _MobileEditProfileScreen(),
          desktop: _DesktopEditProfileScreen(),
        ),
      ),
    );
  }
}

class _DesktopEditProfileScreen extends StatelessWidget {
  const _DesktopEditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 450,
                child: EditProfileForm(), //change
              ),
              const SizedBox(height: defaultPadding / 2),
            ],
          ),
        )
      ],
    );
  }
}

class _MobileEditProfileScreen extends StatelessWidget {
  const _MobileEditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: EditProfileForm(),
            ),
            const Spacer(),
          ],
        ),
      ],
    );
  }
}
