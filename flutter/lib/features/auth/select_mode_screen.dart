import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/api/api_client.dart';
import '../../core/services/auth_service.dart';

class SelectModeScreen extends StatefulWidget {
  const SelectModeScreen({super.key});
  @override
  State<SelectModeScreen> createState() => _SelectModeScreenState();
}

class _SelectModeScreenState extends State<SelectModeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();
  bool _loading = false;
  String? _error;
  String? _selectedMode;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _selectMode() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final result = await _authService.switchMode(mode: _selectedMode!);
      await ApiClient.instance.saveAuth(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
      if (mounted) context.go('/home');
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString().replaceAll('Exception: ', '');
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar modo')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Text(
                  'VAN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Elige tu modo de operación:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 40),
                _buildModeOption(
                  context,
                  'Pasajero',
                  'Solicitar viajes como pasajero',
                  'passenger',
                  Icons.person,
                ),
                const SizedBox(height: 16),
                _buildModeOption(
                  context,
                  'Conductor',
                  'Operar como conductor de moto o auto',
                  'driver',
                  Icons.drive_eta,
                ),
                const SizedBox(height: 16),
                _buildModeOption(
                  context,
                  'Los dos',
                  'Tener ambos roles (pasajero y conductor)',
                  'both',
                  Icons.person_outline,
                ),
                const SizedBox(height: 40),
                if (_error != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: AppTheme.error),
                    ),
                  ),
                const SizedBox(height: 24),
                _loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: _selectedMode != null ? _selectMode : null,
                        child: const Text('Continuar'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildModeOption(
    BuildContext context,
    String title,
    String subtitle,
    String mode,
    IconData icon,
  ) {
    final isSelected = _selectedMode == mode;
    return Material(
      color: isSelected ? AppTheme.primary.withOpacity(0.1) : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          setState(() => _selectedMode = mode);
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? AppTheme.primary : AppTheme.textTertiary),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? AppTheme.primary : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? AppTheme.primary : AppTheme.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.check, color: AppTheme.primary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}