import 'package:esaa/config/constants.dart';
import 'package:esaa/models/models.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

import 'edit_post_form.dart';

class EditPostScreen extends StatelessWidget {
  final Post post;
  const EditPostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomAppbar(
      showLeading: true,
      child: SingleChildScrollView(
        child: Responsive(
          mobile: _MobileEditPostScreen(post: post),
          desktop: _DesktopEditPostScreen(post: post),
        ),
      ),
    );
  }
}

class _DesktopEditPostScreen extends StatelessWidget {
  final Post post;
  const _DesktopEditPostScreen({
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
                child: EditPostForm(post: post), //change
              ),

              const SizedBox(height: defaultPadding / 2),
            ],
          ),
        )
      ],
    );
  }
}

class _MobileEditPostScreen extends StatelessWidget {
  final Post post;
  const _MobileEditPostScreen({
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
              child: EditPostForm(
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
