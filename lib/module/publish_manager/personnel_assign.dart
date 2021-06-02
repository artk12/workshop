import 'package:workshop/module/publish_manager/personnel.dart';

import 'assign_personnel.dart';

class PersonnelAssignHolder {
  Personnel p;

  List<AssignPersonnel> a;

  PersonnelAssignHolder();

  set personnelSetter(Personnel p) {
    this.p = p;
  }

  set assignSetter(List<AssignPersonnel> a) {
    this.a = a;
  }
}
