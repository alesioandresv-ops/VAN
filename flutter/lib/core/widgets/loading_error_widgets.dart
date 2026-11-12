import 'package:flutter/material.dart';

/// Loading widget compartido - usado en múltiples pantallas
class VanLoading extends StatelessWidget {
  final String? text;
  final double? size;

  const VanLoading({this.text, this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (text != null) ...[
            const SizedBox(height: 8),
            Text(
              text!,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}

/// Error widget compartido - muestra error con acción de reintento
class VanError extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryText;

  const VanError({
    required this.message,
    this.onRetry,
    this.retryText = 'Reintentar',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onRetry != null) ...[
              ElevatedButton(
                onPressed: onRetry,
                child: Text(retryText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Barra de diálogo de confirmación compartida
showVanConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onConfirm,
  required VoidCallback onCancel,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            'Aceptar',
            style: const TextStyle(color: Colors.green),
          ),
        ),
      ],
    ),
  );
}

/// Campo de texto compartido con validación
class VanTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final void Function(String)? onChanged;
  final bool obscureText;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;

  const VanTextField({
    super.key,
    this.controller,
    required this.labelText,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: onChanged,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
    );
  }
}