import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/controllers/notes_controller.dart';
import 'package:note_app/utils/get_random_background_colors.dart';
import 'package:note_app/widgets/floating_button/custom_floating_action_button.dart';

import '../controllers/auth_controller.dart';
import 'edit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    NotesController notesController = Get.put(NotesController());

    return Scaffold(
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.to(() => const EditScreen());
        },
        icon: Icons.add,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notes',
                  style: Theme.of(context).primaryTextTheme.headlineMedium,
                ),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {},
                    icon: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade800.withOpacity(.8),
                      ),
                      child: const Icon(
                        Icons.logout,
                        size: 22,
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  hintText: "Search notes ...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintStyle: const TextStyle(color: Colors.grey),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: notesController.notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => EditScreen(
                            note: notesController.notes[index],
                          ));
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      color: getRandomBackgroundColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: ListTile(
                        title: RichText(
                          maxLines: 3,
                          text: TextSpan(
                            text: '${notesController.notes[index].title}\n',
                            style:
                                Theme.of(context).primaryTextTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: notesController.notes[index].content,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodySmall,
                              )
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            ' ${DateFormat('hh:mm a EEE dd/MM/yy').format(notesController.notes[index].modifiedTime)}',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey.shade800,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        trailing: SizedBox(
                          width: 120,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 30,
                                top: 0,
                                bottom: 0,
                                child: Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                bottom: 0,
                                child: IconButton(
                                  onPressed: () async {
                                    final result = await confirmDialog(context);
                                    if (result != null && result) {
                                      // deleteNote(index);
                                    }
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<dynamic> confirmDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          icon: const Icon(
            Icons.info,
            color: Colors.grey,
          ),
          title: const Text(
            'Are you sure you want to delete?',
            style: TextStyle(color: Colors.white),
          ),
          content:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'Yes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ]),
        );
      });
}
