import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:katkoty/service/shared_preference/user_preference.dart';
import '../../../service/services/DeletePostServices.dart';
import '../../../utils/color.dart';

class Delete2Post extends StatelessWidget {
  final String postId;

  const Delete2Post({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DeletePostService deletePostService = DeletePostService();
    final userData2 = GetStorage();
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        onChanged: (value) {
          if (value == 'delete') {
            const server = 'DeletePost';
            final userId = userData2.read('id');
            deletePostService
                .deletePost(server, userId, postId)
                .then((response) {
              if (response.success) {
                print('Delete successful: ${response.message}');
              } else {
                print('Delete failed: ${response.message}');
              }
            }).catchError((error) {
              print('Error: $error');
            });
          }
        },
        icon: const Icon(Icons.more_vert_rounded),
        items: const <DropdownMenuItem<String>>[
          DropdownMenuItem<String>(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete_forever, color: AppbarColor),
                SizedBox(width: 8),
                Text('حذف البوست'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
