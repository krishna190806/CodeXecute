import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class AddEditScreen extends StatefulWidget {
  final String? id;
  final String? currentTitle;
  final String? currentDesc;
  final bool? currentStatus;
  final bool isTask; // true for Task, false for Note

  const AddEditScreen({
    super.key,
    this.id,
    this.currentTitle,
    this.currentDesc,
    this.currentStatus,
    this.isTask = false,
  });

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool _status = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.currentTitle != null) _titleController.text = widget.currentTitle!;
    if (widget.currentDesc != null) _descController.text = widget.currentDesc!;
    if (widget.currentStatus != null) _status = widget.currentStatus!;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        if (widget.isTask) {
          // Task Logic
           if (widget.id == null) {
            await _firestoreService.addTask(
              _titleController.text,
              _descController.text,
            );
          } else {
            await _firestoreService.updateTask(
              widget.id!,
              _titleController.text,
              _descController.text,
              _status,
            );
          }
        } else {
          // Note Logic
          if (widget.id == null) {
            await _firestoreService.addNote(
              _titleController.text,
              _descController.text,
            );
          } else {
            await _firestoreService.updateNote(
              widget.id!,
              _titleController.text,
              _descController.text,
            );
            // Updating status for notes if needed, though usually just title/desc
             // If we want to support status update for notes too:
             // await _firestoreService.toggleStatus(widget.id!, _status);
          }
        }

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: $e')),
            );
          }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String type = widget.isTask ? 'Task' : 'Note';
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == null ? 'Add $type' : 'Edit $type'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFF1E1E24),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.05))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
                  prefixIcon: Icon(Icons.title, color: Colors.grey[400]),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: const Color(0xFF1E1E24),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.white.withOpacity(0.05))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2)),
                  prefixIcon: Icon(Icons.description_outlined, color: Colors.grey[400]),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              if (widget.isTask) ...[
                SwitchListTile(
                  title: const Text('Completed', style: TextStyle(color: Colors.white)),
                  value: _status,
                  onChanged: (val) => setState(() => _status = val),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.white.withOpacity(0.05))),
                  tileColor: const Color(0xFF1E1E24),
                ),
                const SizedBox(height: 24),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Save', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
