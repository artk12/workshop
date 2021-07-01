import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/save_and_cancel_button.dart';

class StartTaskDialog extends StatelessWidget {

  StartTaskDialog();

  @override
  Widget build(BuildContext context) {
    IgnoreButtonCubit ignoreButtonCubit =
        IgnoreButtonCubit(IgnoreButtonState(ignore: false));
    ThemeData theme = Theme.of(context);
    return DialogBg(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "شروع فعالیت",
              style: theme.textTheme.headline2,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "آیا میخواهید فعالیت را شروع کنید؟",
              style: theme.textTheme.headline5,
            ),
            SizedBox(
              height: 40,
            ),
            BlocBuilder(
              cubit: ignoreButtonCubit,
              builder: (BuildContext context, IgnoreButtonState state) =>
                  IgnorePointer(
                ignoring: state.ignore,
                child: SaveAndCancelButton(
                  saveButton: () async {
                    Navigator.of(context).pop("OK");
                  },
                  cancelButton: (){Navigator.of(context).pop();},
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
