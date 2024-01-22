import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:katkoty/packages/alarm/screens/base_view_model.dart';
import 'package:katkoty/packages/alarm/screens/base_view_model_impl.dart';
import 'package:katkoty/db/database_service.dart';

abstract class AlarmsImpl extends BaseViewModelImpl {}

class AlarmsListViewModel extends BaseViewModel {
  AlarmsImpl impl;

  AppDatabase appDatabase = AppDatabase();
  List<AlarmDatabaseModel> alarmsList = [];

  AlarmsListViewModel(this.impl);

  void getAlarms() async {
    alarmsList.clear();
    var allAlarms = await appDatabase.getAllAlarms();

    alarmsList.addAll(allAlarms
        .where((element) => element.alarmData!.snoozedAlarmId == null));
    notifyState();
  }

  void remove(AlarmDatabaseModel alarmDatabaseModel) async {
    await appDatabase.delete(alarmDatabaseModel);
    getAlarms();
    notifyState();
  }

  void notifyState() {
    impl.notifyState();
  }
}
