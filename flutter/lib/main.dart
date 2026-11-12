import 'package:flutter/material.dart';
import 'app/theme.dart';
import 'app/router.dart';
import 'core/api/api_client.dart';

const _apiBaseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://10.0.2.2:5000',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiClient.instance.init(baseUrl: _apiBaseUrl);
  await ApiClient.instance.loadTokens();
  runApp(const VanAppRoot());
}

class VanAppRoot extends StatelessWidget {
  const VanAppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VAN',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: VanApp.router,
    );
  }
}
