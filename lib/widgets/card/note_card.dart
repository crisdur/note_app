import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../controllers/notes_controller.dart';
import '../../screens/home.dart';
import '../../utils/get_random_background_colors.dart';

class NoteCard extends StatefulWidget {
  var index;

  NoteCard({
    super.key,
    required this.notesController,
    required this.index,
  });

  final NotesController notesController;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

bool showTranslatedContent = false;

class _NoteCardState extends State<NoteCard> {
  bool showTranslatedContent = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      color: getRandomBackgroundColor(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: ListTile(
        title: RichText(
          maxLines: null,
          text: TextSpan(
            text: '${widget.notesController.notes[widget.index].title}\n',
            style: Theme.of(context).primaryTextTheme.bodyMedium,
            children: [
              TextSpan(
                text: showTranslatedContent
                    ? widget.notesController.notes[widget.index]
                        .translatedContent!['en']
                    : widget.notesController.notes[widget.index].content,
                style: Theme.of(context).primaryTextTheme.bodySmall,
              )
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            ' ${DateFormat('hh:mm a EEE dd/MM/yy').format(widget.notesController.notes[widget.index].modifiedTime)}',
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
                left: 37,
                top: 0,
                bottom: 0,
                child: Checkbox(
                  value: widget.notesController.notes[widget.index].completed,
                  onChanged: (value) {
                    widget.notesController.updateCompletedStatus(
                        widget.notesController.notes[widget.index].noteId!,
                        !widget.notesController.notes[widget.index].completed!);
                  },
                ),
              ),
              if (widget
                      .notesController.notes[widget.index].translatedContent !=
                  null)
                Positioned(
                  left: 5,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    onPressed: () async {
                      setState(() {
                        showTranslatedContent = !showTranslatedContent;
                      });
                    },
                    icon: const Icon(Icons.translate),
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
                      widget.notesController.deleteNote(
                          widget.notesController.notes[widget.index].noteId!);
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
