import 'package:esaa/config/constants.dart';
import 'package:esaa/screens/shared/shared.dart';
import 'package:flutter/material.dart';

import 'post_job_form.dart';

class PostJob extends StatelessWidget {
  const PostJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const CustomAppbar(
        child: SingleChildScrollView(
          child: Responsive(
            mobile: _MobilePostScreen(),
            desktop: _DesktopPostScreen(),
          ),
        ),
      ),
    );
  }
}

class _DesktopPostScreen extends StatelessWidget {
  const _DesktopPostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [

              SizedBox(
                width: 450,
                child: PostJobForm(), //change
              ),

              SizedBox(height: defaultPadding / 2),
            ],
          ),
        )
      ],
    );
  }
}

class _MobilePostScreen extends StatelessWidget {
  const _MobilePostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          children: const [
            Spacer(),

            Expanded(
              flex: 8,
              child: PostJobForm(),
            ),

            Spacer(),
          ],
        ),
      ],
    );
  }
}
