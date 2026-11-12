import 'package:flutter_test/flutter_test.dart';

import 'package:van/core/api/api_client.dart';
import 'package:van/main.dart';

void main() {
  testWidgets('VAN app renders login screen', (WidgetTester tester) async {
    ApiClient.instance.init(baseUrl: 'http://localhost:5000');
    await tester.pumpWidget(const VanAppRoot());
    await tester.pumpAndSettle();

    expect(find.text('VAN'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
    expect(find.text('¿No tenés cuenta? Registrate'), findsOneWidget);
  });
}
