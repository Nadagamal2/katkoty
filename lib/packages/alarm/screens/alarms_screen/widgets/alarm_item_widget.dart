import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:katkoty/packages/alarm/models/alarm_database_model.dart';
import 'package:katkoty/packages/alarm/models/alarm_model.dart';
import 'package:katkoty/packages/alarm/screens/alarms_screen/alarms_list_viewmodel.dart';


// ignore: must_be_immutable
class AlarmItemWidget extends StatelessWidget {
  AlarmDatabaseModel alarmDatabaseModel;
  AlarmsListViewModel viewModel;

  AlarmItemWidget(this.viewModel, this.alarmDatabaseModel, {Key? key})
      : super(key: key);

  late AlarmModel alarm;

  @override
  Widget build(BuildContext context) {
    alarm = alarmDatabaseModel.alarmData!;
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 15, left: 15),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                InkWell(
                  child: Card(
                    color: Colors.amber[600],
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20, right: 20, left: 20),
                      child: ListTile(
                        title: Text(
                          alarm.title!,
                          textAlign: TextAlign.right,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('الوقت' + ' : '),
                                Text(DateFormat().add_jm().format(alarm.time)),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('النغمه' + ' : '),
                            //     Expanded(
                            //       child: TextField(
                            //         decoration: InputDecoration(
                            //             enabled: false,
                            //             border: InputBorder.none,
                            //             hintStyle: TextStyle(
                            //                 color: Colors.black),
                            //             hintText:
                            //                 '${controller.alarms[index]['alarmSoundName']}'),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //       MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text('التكرار' + ' : '),
                            //     Text(controller.alarms[index]['repeat']
                            //         .toString()
                            //         .replaceAll('[', '')
                            //         .replaceAll(']', '')
                            //         .tr),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (alarm.snooze == false)
                              const Text('')
                            else
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('غفوة' + ' : '),
                                  Icon(Icons.check),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
                Positioned(
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: IconButton(
                      onPressed: () {
                        viewModel.remove(alarmDatabaseModel);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
