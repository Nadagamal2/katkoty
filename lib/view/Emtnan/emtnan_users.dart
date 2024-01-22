import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/UserStaticsController.dart';

class EmtnanUsers extends StatelessWidget {
  const EmtnanUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child:GetX<UserStaticsController>(
            init: UserStaticsController(),
            builder: (controller) {
              if (controller.users.isEmpty) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                  itemCount: controller.users.length,
                  itemBuilder: (context, index) {
                    final user = controller.users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.photo),
                      ),
                      title: Text(user.fullName),
                      subtitle: Text(user.email),
                      trailing: Text('Posts: ${user.numPosts.toString()}'),
                    );
                  },
                );
              }
           },
),
        ),
      ],
    );
  }
}
