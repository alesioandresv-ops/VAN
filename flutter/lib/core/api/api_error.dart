class ApiError {
  final String code;
  final String message;
  final int? statusCode;

  ApiError({required this.code, required this.message, this.statusCode});

  factory ApiError.fromResponse(Map<String, dynamic> body, {int? statusCode}) {
    final error = body['error'] ?? {};
    final code = error['code'] ?? body['error_code'] ?? 'UNKNOWN_ERROR';
    final message = error['message'] ?? body['error_message'] ?? 'Ocurrió un error inesperado';

    final codeMap = {
      'EMAIL_NOT_VERIFIED': 'NOT_VERIFIED',
      'TOKEN_REUSE_DETECTED': 'TOKEN_EXPIRED',
      'INVALID_REFRESH': 'TOKEN_EXPIRED',
      'MISSING_TOKEN': 'TOKEN_EXPIRED',
      'INVALID_TOKEN': 'TOKEN_EXPIRED',
      'INVALID_VEHICLE_TYPE': 'VALIDATION_ERROR',
      'INVALID_PAYMENT_METHOD': 'VALIDATION_ERROR',
      'CODE_EXPIRED': 'TOKEN_EXPIRED',
      'INVALID_CODE': 'VALIDATION_ERROR',
      'ACTIVE_TRIP_EXISTS': 'ACTIVE_TRIP_EXISTS',
      'TRIP_NOT_AVAILABLE': 'TRIP_NOT_AVAILABLE',
      'INSUFFICIENT_BALANCE': 'INSUFFICIENT_BALANCE',
      'FORBIDDEN': 'FORBIDDEN',
      'NOT_FOUND': 'NOT_FOUND',
      'VALIDATION_ERROR': 'VALIDATION_ERROR',
    };

    final mappedCode = codeMap[code] ?? code;
    return ApiError(
      code: mappedCode,
      message: message,
      statusCode: statusCode ?? error['status'] ?? body['status_code'],
    );
  }

  bool get isTokenExpired => code == 'TOKEN_EXPIRED';
  bool get isNotVerified => code == 'NOT_VERIFIED' || code == 'EMAIL_NOT_VERIFIED';
  bool get isForbidden => code == 'FORBIDDEN';
  bool get isNotFound => code == 'NOT_FOUND';
  bool get isInsufficientBalance => code == 'INSUFFICIENT_BALANCE';
  bool get isDuplicateTrip => code == 'DUPLICATE_TRIP' || code == 'ACTIVE_TRIP_EXISTS';
  bool get isActiveTripExists => code == 'ACTIVE_TRIP_EXISTS';
  bool get isTripNotAvailable => code == 'TRIP_NOT_AVAILABLE';
  bool get isInvalidTransition => code == 'INVALID_TRANSITION';
  bool get isLocationRequired => code == 'LOCATION_REQUIRED';
  bool get isValidationError => code == 'VALIDATION_ERROR';
}
