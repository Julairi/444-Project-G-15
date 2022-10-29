import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

import 'apply_form.dart';

class ApplyScreen extends StatelessWidget {
  final Post post;
  const ApplyScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: _MobileApplyScreen(post: post),
          desktop: _DesktopApplyScreen(post: post),
        ),
      ),
    );
  }
}

class _DesktopApplyScreen extends StatelessWidget {
  final Post post;
  const _DesktopApplyScreen({
    Key? key,
    required this.post,
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
                child: ApplyForm(post: post), //change
              ),

              const SizedBox(height: defaultPadding / 2),
            ],
          ),
        )
      ],
    );
  }
}

class _MobileApplyScreen extends StatelessWidget {
  final Post post;
  const _MobileApplyScreen({
    Key? key,
    required this.post,
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
              child: ApplyForm(
                post: post,
              ),
            ),

            const Spacer(),
          ],
        ),
      ],
    );
  }
}
