import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:workshop/bloc/ignoreButtonsBloc.dart';
import 'package:workshop/bloc/publishManager/timer_personnel.dart';
import 'package:workshop/module/publish_manager/assign_personnel.dart';
import 'package:workshop/style/component/dialog_bg.dart';
import 'package:workshop/style/component/save_and_cancel_button.dart';
import 'package:workshop/style/theme/my_icons.dart';
import 'package:workshop/style/theme/textstyle.dart';

class SubmitDialog extends StatelessWidget {
  final AssignPersonnel assignPersonnel;
  final TimerPersonnelCubit timerPersonnel;

  SubmitDialog({this.assignPersonnel, this.timerPersonnel});

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
              "اتمام فعالیت",
              style: theme.textTheme.headline2,
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              "آیا میخواهید اتمام فعالیت را ثبت کنید؟",
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
                    //TODO : USER DETAIL
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
