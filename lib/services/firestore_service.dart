import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _notesCollection = 'notes';

  // CREATE - Add a new note
  Future<void> addNote(String title, String desc) async {
    try {
      await _firestore.collection(_notesCollection).add({
        'title': title,
        'description': desc,
        'date': DateTime.now().toString(),
        'status': false, // Default status
      });
    } catch (e) {
      print("Error adding note: $e");
      rethrow;
    }
  }

  // READ - Get all notes as a stream
  Stream<QuerySnapshot> getNotesStream() {
    return _firestore
        .collection(_notesCollection)
        .orderBy('date', descending: true)
        .snapshots();
  }

  // READ - Get a single note by ID
  Future<DocumentSnapshot> getNote(String id) async {
    return await _firestore.collection(_notesCollection).doc(id).get();
  }

  // UPDATE - Update a note's title and description
  Future<void> updateNote(String id, String newTitle, String newDesc) async {
    try {
      await _firestore.collection(_notesCollection).doc(id).update({
        'title': newTitle,
        'description': newDesc,
      });
    } catch (e) {
      print("Error updating note: $e");
      rethrow;
    }
  }

  // UPDATE - Toggle note status
  Future<void> toggleStatus(String id, bool currentStatus) async {
    try {
      await _firestore.collection(_notesCollection).doc(id).update({
        'status': !currentStatus,
      });
    } catch (e) {
      print("Error toggling status: $e");
      rethrow;
    }
  }

  // DELETE - Delete a note
  Future<void> deleteNote(String id) async {
    try {
      await _firestore.collection(_notesCollection).doc(id).delete();
    } catch (e) {
      print("Error deleting note: $e");
      rethrow;
    }
  }
}
