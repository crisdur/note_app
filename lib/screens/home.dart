import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/auth_controller.dart';
import 'package:note_app/controllers/notes_controller.dart';
import 'package:note_app/widgets/floating_button/custom_floating_action_button.dart';

import '../theme/colors.dart';
import '../widgets/card/note_card.dart';
import 'edit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotesController notesController = Get.put(NotesController());
    AuthController authController = Get.put(AuthController());
    final TextEditingController searchController = TextEditingController();

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
            Header(authController: authController),
            SearchSection(
                searchController: searchController,
                notesController: notesController),
            _Content(notesController: notesController)
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.authController,
  });

  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Notas',
          style: Theme.of(context).primaryTextTheme.headlineMedium,
        ),
        IconButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {
              authController.signOut();
            },
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
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({
    super.key,
    required this.searchController,
    required this.notesController,
  });

  final TextEditingController searchController;
  final NotesController notesController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          notesController.searchString!.value = (value);
        },
        style: const TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          hintText: "Buscar ...",
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
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.notesController,
  });

  final NotesController notesController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        // Sort notes by completion status and modified time
        notesController.notes.sort((a, b) {
          if (a.completed != b.completed) {
            // Completed notes go to the bottom
            return a.completed! ? 1 : -1;
          } else {
            // Sort by modified time for notes with the same completion status
            return b.modifiedTime.compareTo(a.modifiedTime);
          }
        });

        // Filter notes based on the search text
        final searchText = notesController.searchString!.value.toLowerCase();
        final filteredNotes = searchText.isEmpty
            ? notesController.notes
            : notesController.notes.where((note) {
                return note.title.toLowerCase().contains(searchText) ||
                    note.content.toLowerCase().contains(searchText);
              }).toList();

        if (notesController.accountStatus.value == AccountStatus.loading) {
          return const CircularProgressIndicator();
        } else if (filteredNotes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.do_not_disturb_off_rounded, size: 80),
                const SizedBox(height: 16),
                Text('Crea tu primera nota',
                    style: Theme.of(context).primaryTextTheme.headlineMedium)
              ],
            ),
          );
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => EditScreen(
                        note: filteredNotes[index],
                      ));
                },
                child: NoteCard(
                  notesController: notesController,
                  index: notesController.notes.indexOf(filteredNotes[index]),
                ),
              );
            },
          );
        }
      }),
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
