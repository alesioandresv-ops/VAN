import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../app/theme.dart';
import '../../core/api/api_error.dart';
import '../../core/services/trip_service.dart';
import '../../core/models/trip.dart';

class DriverTripScreen extends StatefulWidget {
  final int tripId;
  const DriverTripScreen({super.key, required this.tripId});
  @override
  State<DriverTripScreen> createState() => _DriverTripScreenState();
}

class _DriverTripScreenState extends State<DriverTripScreen> {
  final _tripService = TripService();
  Trip? _trip;
  bool _loading = true;
  bool _busy = false;

  static const _paymentMethods = [
    'efectivo',
    'billetera',
    'mercadopago',
    'transferencia',
    'tarjeta',
  ];

  @override
  void initState() {
    super.initState();
    _loadTrip();
  }

  Future<void> _loadTrip() async {
    final trip = await _tripService.getTrip(widget.tripId);
    if (mounted) {
      setState(() {
        _trip = trip;
        _loading = false;
      });
    }
  }

  Future<void> _startTrip() async {
    setState(() => _busy = true);
    try {
      await _tripService.startTrip(widget.tripId);
      await _loadTrip();
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _completeTrip() async {
    final method = await _selectPaymentMethod();
    if (method == null) return;
    setState(() => _busy = true);
    try {
      await _tripService.completeTrip(widget.tripId,
          paymentMethod: method);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Viaje completado (${_methodLabel(method)})')),
        );
        context.pop();
      }
    } on ApiError catch (e) {
      if (mounted) {
        if (e.isInsufficientBalance) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'El pasajero no tiene saldo en billetera. Elegí otro método de pago.'),
            ),
          );
          await _loadTrip();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.message}')),
          );
        }
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<String?> _selectPaymentMethod() async {
    final method = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('¿Cómo cobrás este viaje?'),
        children: _paymentMethods
            .map(
              (m) => SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, m),
                child: Text(_methodLabel(m)),
              ),
            )
            .toList(),
      ),
    );
    if (method == null) return null;
    return method;
  }

  String _methodLabel(String m) {
    switch (m) {
      case 'efectivo':
        return 'Efectivo';
      case 'billetera':
        return 'Billetera VAN';
      case 'mercadopago':
        return 'Mercado Pago';
      case 'transferencia':
        return 'Transferencia';
      case 'tarjeta':
        return 'Tarjeta';
      default:
        return m;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Viaje')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _trip == null
              ? const Center(child: Text('Viaje no encontrado'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildStatusBadge(),
                      const SizedBox(height: 20),
                      _buildAddressCard('Origen', _trip!.pickupAddress,
                          Icons.circle, AppTheme.success),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Icon(Icons.arrow_downward,
                            color: AppTheme.textSecondary),
                      ),
                      _buildAddressCard('Destino', _trip!.dropoffAddress,
                          Icons.location_on, AppTheme.accent),
                      const SizedBox(height: 20),
                      if (_trip!.fare != null)
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Tarifa'),
                              Text(
                                '\$${_trip!.fare!.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 24),
                      if (_trip!.status == 'accepted')
                        ElevatedButton(
                          onPressed: _busy ? null : _startTrip,
                          child: const Text('Iniciar Viaje'),
                        ),
                      if (_trip!.status == 'ongoing')
                        ElevatedButton(
                          onPressed: _busy ? null : _completeTrip,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.success),
                          child: _busy
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                )
                              : const Text('Finalizar Viaje'),
                        ),
                      if (_trip!.status == 'requested')
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Esperando confirmación del pasajero...'),
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildStatusBadge() {
    final color = _trip!.status == 'ongoing'
        ? AppTheme.success
        : _trip!.status == 'accepted'
            ? AppTheme.warning
            : AppTheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _statusLabel(),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAddressCard(
      String title, String? address, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textSecondary)),
                Text(address ?? 'Sin dirección',
                    style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel() {
    switch (_trip?.status) {
      case 'requested':
        return 'Esperando';
      case 'accepted':
        return 'En camino al pasajero';
      case 'ongoing':
        return 'En viaje';
      case 'completed':
        return 'Completado';
      case 'cancelled':
        return 'Cancelado';
      default:
        return '';
    }
  }
}
