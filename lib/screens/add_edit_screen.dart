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
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
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
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.title),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Please enter a title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.description_outlined),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              if (widget.isTask) ...[
                SwitchListTile(
                  title: const Text('Completed'),
                  value: _status,
                  onChanged: (val) => setState(() => _status = val),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300)),
                ),
                const SizedBox(height: 24),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _save,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
