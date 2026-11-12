# ROL

Actúa como un equipo senior completo formado por:

- Arquitecto de software.
- Desarrollador Flutter/Dart senior.
- Desarrollador backend Python/Flask senior.
- Ingeniero de integración de APIs REST.
- Especialista en UX/UI móvil.
- Ingeniero QA y testing.
- Especialista en seguridad de aplicaciones.
- Ingeniero DevOps y despliegues.
- Especialista en publicación de aplicaciones Android.

Tu misión es llevar el proyecto VAN desde su estado actual hasta una
versión móvil MVP funcional, conectada al backend real y preparada
para su lanzamiento en Google Play.

No quiero una demostración ficticia, una maqueta desconectada ni
funcionalidades simuladas que aparenten estar terminadas.

Quiero una aplicación que funcione realmente.

--------------------------------------------------
# 1. CONTEXTO DEL PROYECTO
--------------------------------------------------

VAN es una plataforma de movilidad urbana que permite solicitar
viajes en moto y automóvil.

Está orientada inicialmente a ciudades pequeñas, como Paso de los
Libres, Corrientes, Argentina.

La plataforma contempla:

- Pasajeros.
- Conductores.
- Usuarios que pueden tener ambos roles.
- Empresas.
- Administradores.

El objetivo inmediato es lanzar la aplicación móvil MVP para
pasajeros y conductores.

La aplicación debe permitir solicitar, aceptar y completar viajes
reales utilizando el backend existente.

--------------------------------------------------
# 2. FUENTE DE VERDAD OBLIGATORIA
--------------------------------------------------

ANTES DE MODIFICAR CUALQUIER ARCHIVO:

1. Lee completamente VAN_MASTER_SPEC.md si existe.
2. Lee el README y la documentación técnica disponible.
3. Inspecciona la estructura real del repositorio.
4. Revisa el backend existente.
5. Revisa la carpeta flutter/.
6. Revisa los modelos de datos.
7. Revisa todos los endpoints de la API v1.
8. Revisa los tests existentes.
9. Revisa la configuración de producción.
10. Revisa los archivos de configuración Android.

No inventes archivos, endpoints, modelos, credenciales ni
funcionalidades.

Si VAN_MASTER_SPEC.md no existe, crea un documento de especificación
equivalente antes de continuar.

La documentación real del proyecto tiene prioridad sobre cualquier
suposición tuya.

--------------------------------------------------
# 3. ESTADO TÉCNICO CONOCIDO
--------------------------------------------------

Backend:

- Python.
- Flask.
- SQLAlchemy.
- PostgreSQL en la arquitectura actual.
- MySQL únicamente como legado histórico.
- API REST bajo /api/v1.
- Autenticación JWT.
- Access tokens.
- Refresh tokens rotativos.
- OpenAPI/Swagger.
- Servicios compartidos para la lógica de viajes.
- Sistema de billetera.
- Integración con Mercado Pago.
- Tests automatizados.
- Frontend web Jinja2 existente.

La API utiliza:

- Authorization: Bearer <access_token>
- Access token con expiración.
- Refresh token persistido mediante hash.
- Rotación de refresh tokens.
- Respuestas con envelope success/data o success/error.

La documentación actual indica que el backend tiene una suite de
aproximadamente 441 tests, pero debes ejecutar los tests y verificar
el estado real en lugar de asumir que siguen pasando.

Flutter:

- Existe una estructura inicial en flutter/.
- La arquitectura prevista es feature-first.
- Se contemplan servicios, modelos, cliente HTTP y pantallas
  separadas para pasajero, conductor, viajes, billetera y perfil.
- Debes comprobar si Flutter está instalado.
- Debes comprobar si Android SDK, Java y Gradle están disponibles.
- Debes comprobar si la estructura actual es un proyecto Flutter
  compilable.

No asumas que estas herramientas están instaladas.

--------------------------------------------------
# 4. OBJETIVO PRINCIPAL
--------------------------------------------------

Construir y dejar funcionando el MVP móvil de VAN.

El MVP debe permitir:

PASAJERO:

1. Registrarse.
2. Iniciar sesión.
3. Cerrar sesión.
4. Recuperar la sesión.
5. Renovar el access token.
6. Ver su perfil.
7. Editar sus datos básicos.
8. Ver su billetera.
9. Ver el mapa.
10. Seleccionar origen.
11. Seleccionar destino.
12. Elegir moto o auto.
13. Ver una estimación de tarifa si el backend la proporciona.
14. Elegir el método de pago permitido.
15. Solicitar un viaje.
16. Consultar el estado del viaje.
17. Ver la información del conductor asignado.
18. Ver la ubicación disponible del conductor.
19. Cancelar un viaje cuando las reglas del backend lo permitan.
20. Consultar el historial.
21. Calificar un viaje completado.
22. Consultar sus movimientos de billetera.
23. Iniciar una recarga de Mercado Pago cuando esté habilitada.
24. Verificar el estado de una recarga.

CONDUCTOR:

1. Registrarse como conductor.
2. Iniciar sesión.
3. Consultar el estado de aprobación.
4. Ver su perfil.
5. Verificar si puede operar como conductor.
6. Activarse como disponible.
7. Desactivarse como disponible.
8. Compartir su ubicación cuando corresponda.
9. Consultar viajes disponibles.
10. Ver origen y destino de un viaje.
11. Aceptar un viaje disponible.
12. Rechazar un viaje.
13. Iniciar un viaje aceptado.
14. Consultar el estado del viaje.
15. Finalizar un viaje mediante el flujo de cobro existente.
16. Seleccionar el método de cobro real cuando corresponda.
17. Consultar historial.
18. Consultar métodos de pago aceptados.
19. Gestionar sus métodos de cobro, si el backend lo permite.
20. Subir o actualizar su QR de Mercado Pago si está implementado.

USUARIO CON AMBOS ROLES:

1. Debe poder cambiar de modo cuando el backend lo autorice.
2. El modo seleccionado no debe utilizarse como mecanismo de
   autorización.
3. La autorización real debe depender de los roles y permisos
   proporcionados por el backend.

--------------------------------------------------
# 5. REGLA FUNDAMENTAL: NO REHACER EL BACKEND
--------------------------------------------------

El backend existente es la fuente de verdad.

No reemplaces Flask.
No reemplaces PostgreSQL.
No reemplaces JWT.
No reemplaces la API por Firebase.
No crees una segunda lógica de viajes en Flutter.
No dupliques las reglas de tarifas.
No dupliques la lógica de permisos.
No inventes endpoints equivalentes.

Flutter debe consumir la API existente.

Si un requisito móvil necesita una capacidad que el backend todavía
no proporciona:

1. Identifica el problema.
2. Comprueba si existe un endpoint alternativo.
3. Evalúa si puede resolverse correctamente desde el cliente.
4. Si requiere backend, implementa el cambio mínimo necesario.
5. Conserva la compatibilidad con la web.
6. Agrega o modifica tests.
7. Documenta el cambio.
8. No continúes fingiendo que la funcionalidad está terminada.

--------------------------------------------------
# 6. FASE 0 — AUDITORÍA REAL DEL ENTORNO
--------------------------------------------------

Antes de programar, ejecuta las comprobaciones necesarias:

- flutter --version
- dart --version
- java -version
- adb version
- flutter doctor -v
- flutter devices
- flutter pub get
- flutter analyze
- flutter test

También verifica:

- Android SDK.
- Android emulator.
- Dispositivo físico conectado.
- Gradle.
- AndroidManifest.xml.
- Gradle configuration.
- applicationId.
- minSdk.
- targetSdk.
- compileSdk.
- Permisos de ubicación.
- Permisos de internet.
- Configuración de mapas.
- Configuración de deep links.
- Configuración de release.

Si Flutter no está instalado:

- No simules una compilación.
- Explica qué falta.
- Proporciona los pasos concretos para instalarlo.
- Continúa trabajando en archivos que puedan prepararse sin
  inventar resultados de compilación.

Al finalizar esta fase, genera un diagnóstico técnico real.

--------------------------------------------------
# 7. FASE 1 — PREPARAR EL PROYECTO FLUTTER
--------------------------------------------------

Comprueba si flutter/ es un proyecto Flutter válido.

Si está incompleto:

- Completa únicamente lo necesario.
- No sobrescribas código útil.
- No elimines funcionalidades existentes sin justificarlo.
- Usa una estructura mantenible.

Arquitectura recomendada:

flutter/
  lib/
    core/
      api/
      auth/
      config/
      errors/
      models/
      storage/
      theme/
      widgets/
    features/
      auth/
      passenger/
      driver/
      trip/
      wallet/
      profile/
      history/
    routing/
    main.dart
  test/
  android/
  ios/

Puedes adaptar esta estructura si el proyecto real ya tiene otra
arquitectura razonable.

Dependencias previstas:

- dio.
- flutter_secure_storage.
- go_router.
- geolocator.
- permission_handler.
- google_maps_flutter o la solución de mapas ya adoptada.
- geocoding, si realmente es necesaria.
- cached_network_image.
- image_picker.
- url_launcher.

No agregues dependencias innecesarias.

Todas las dependencias deben ser compatibles entre sí y con la
versión de Flutter instalada.

--------------------------------------------------
# 8. FASE 2 — API CLIENT Y AUTENTICACIÓN
--------------------------------------------------

Implementa o corrige un ApiClient real utilizando Dio.

Debe incluir:

- Base URL configurable.
- Headers comunes.
- Authorization Bearer.
- Serialización JSON.
- Manejo de errores del envelope de la API.
- Interceptor de autenticación.
- Renovación automática del access token.
- Persistencia segura de tokens.
- Logout.
- Prevención de múltiples refresh simultáneos.
- Limpieza segura de credenciales inválidas.
- Timeout.
- Manejo de errores de red.
- Manejo de respuestas 401.
- Manejo de respuestas 403.
- Manejo de respuestas 409.
- Manejo de errores del servidor.

El refresh token nunca debe aparecer en logs.

El cliente debe diferenciar:

- Error de validación.
- Error de autenticación.
- Error de autorización.
- Viaje no disponible.
- Conductor no aprobado.
- Conductor fuera de línea.
- Saldo insuficiente.
- Error de conexión.
- Error inesperado.

La aplicación debe iniciar correctamente el ApiClient desde main.dart
antes de realizar peticiones.

No hardcodees credenciales ni secretos.

--------------------------------------------------
# 9. FASE 3 — FLUJO DE AUTENTICACIÓN
--------------------------------------------------

Implementa las pantallas y flujos reales:

- Splash.
- Login.
- Registro de pasajero.
- Registro de conductor.
- Selección de modo.
- Recuperación de sesión.
- Perfil.
- Cierre de sesión.

Utiliza los endpoints reales:

POST /api/v1/auth/register
POST /api/v1/auth/register/driver
POST /api/v1/auth/login
POST /api/v1/auth/refresh
POST /api/v1/auth/logout
GET /api/v1/auth/me
POST /api/v1/auth/switch-mode
PUT /api/v1/auth/profile
POST /api/v1/auth/password

No supongas que un usuario puede operar como conductor sin
aprobación.

Si el backend exige verificación de email o aceptación de guidelines,
representa ese estado correctamente en la interfaz.

--------------------------------------------------
# 10. FASE 4 — EXPERIENCIA DEL PASAJERO
--------------------------------------------------

Construye una interfaz móvil moderna, clara y profesional.

La identidad visual debe corresponder a VAN.

Prioridades:

- Buena legibilidad.
- Diseño responsive.
- Botones grandes.
- Navegación sencilla.
- Estados de carga.
- Estados vacíos.
- Mensajes de error comprensibles.
- Confirmaciones para acciones importantes.
- No bloquear la interfaz durante peticiones largas.
- Accesibilidad básica.
- Soporte para pantallas pequeñas.

Pantallas mínimas:

- PassengerHome.
- RequestTrip.
- TripSearching.
- ActiveTrip.
- TripDetails.
- RateTrip.
- Wallet.
- WalletTransactions.
- TopUp.
- Profile.
- History.

El pasajero debe poder solicitar viajes mediante la API real.

Endpoint principal:

POST /api/v1/trips

Debe enviar:

- Origen.
- Destino.
- Coordenadas cuando estén disponibles.
- Tipo de vehículo.
- Método de pago.
- Idempotency-Key obligatorio.

La clave de idempotencia debe ser única por intento lógico de
solicitud y reutilizarse si se reintenta la misma operación.

Nunca generes una nueva clave automáticamente para cada reintento
de una misma solicitud.

--------------------------------------------------
# 11. FASE 5 — MAPAS Y UBICACIÓN
--------------------------------------------------

Implementa mapas reales únicamente si la configuración está
disponible.

Debes verificar:

- API key.
- Configuración Android.
- Permisos de ubicación.
- Restricciones de la API key.
- Funcionamiento en dispositivo físico.
- Funcionamiento en emulador.

No pongas claves reales dentro del código fuente.

La aplicación debe manejar:

- Permiso concedido.
- Permiso denegado.
- Permiso denegado permanentemente.
- GPS desactivado.
- Ubicación no disponible.
- Error de geocodificación.
- Error de red.

Utiliza los endpoints reales:

GET /api/v1/geo/geocode?q=
GET /api/v1/drivers/nearby
GET /api/v1/trips/{id}/eta
GET /api/v1/trips/{id}/status

No prometas ubicación en tiempo real si el backend actual solo
proporciona polling.

--------------------------------------------------
# 12. FASE 6 — EXPERIENCIA DEL CONDUCTOR
--------------------------------------------------

Construye:

- DriverHome.
- Estado online/offline.
- Viajes disponibles.
- Detalle del viaje.
- Viaje aceptado.
- Viaje en curso.
- Finalización y cobro.
- Historial.
- Perfil.
- Métodos de pago.

Utiliza:

POST /api/v1/drivers/online
POST /api/v1/drivers/location
GET /api/v1/trips/available
POST /api/v1/trips/{id}/accept
POST /api/v1/trips/{id}/reject
POST /api/v1/trips/{id}/start
POST /api/v1/trips/{id}/complete
POST /api/v1/trips/{id}/cancel

Respeta estrictamente los estados y errores del backend.

El conductor no debe poder aceptar viajes si:

- No está aprobado.
- Está offline.
- Está ocupado.
- El viaje ya fue aceptado.
- El viaje ya no está disponible.

El claim atómico del backend es la autoridad final.

--------------------------------------------------
# 13. FASE 7 — VIAJES Y ESTADOS
--------------------------------------------------

Implementa una máquina de estados coherente en la interfaz.

Estados principales:

requested
accepted
ongoing
completed
cancelled

El flujo de finalización debe respetar la implementación real del
backend:

- El viaje se inicia.
- El conductor completa mediante el flujo de cobro.
- Se utiliza el método de cobro real.
- El backend realiza las validaciones.
- Si hay saldo insuficiente, el viaje no debe marcarse como
  completado incorrectamente.
- Los reintentos deben ser seguros.

No permitas transiciones inventadas desde Flutter.

El backend es la autoridad sobre el estado.

--------------------------------------------------
# 14. FASE 8 — BILLETERA Y MERCADO PAGO
--------------------------------------------------

Integra la billetera mediante los endpoints reales.

GET /api/v1/wallet
GET /api/v1/wallet/transactions
POST /api/v1/wallet/topups
GET /api/v1/wallet/topups
GET /api/v1/wallet/topups/{id}
POST /api/v1/wallet/topups/{id}/voucher

Mercado Pago:

- No coloques tokens privados en Flutter.
- No acredites dinero desde el cliente.
- No confíes únicamente en el resultado visual del checkout.
- El backend debe validar el pago.
- Respeta los deep links configurados.
- Verifica el flujo en entorno de prueba.
- No utilices cuentas reales para pruebas.
- No habilites producción sin credenciales y configuración correctas.

Si el flujo móvil de Mercado Pago no puede probarse todavía, marca
la integración como pendiente de validación y no como terminada.

--------------------------------------------------
# 15. FASE 9 — DISEÑO Y UX
--------------------------------------------------

El diseño debe ser profesional, consistente y fácil de utilizar.

Define:

- Tema centralizado.
- Tipografía consistente.
- Espaciados.
- Bordes.
- Botones.
- Tarjetas.
- Formularios.
- Estados de error.
- Estados de carga.
- Dialogs.
- Bottom sheets.
- Navegación.

La aplicación debe evitar:

- Pantallas vacías.
- Textos diminutos.
- Botones difíciles de pulsar.
- Errores técnicos sin explicación.
- Datos mock en producción.
- Navegación sin salida.
- Pantallas sin estados de carga.
- Crashes ante errores de red.

No copies diseños de otras aplicaciones de forma literal.

VAN debe tener identidad visual propia.

--------------------------------------------------
# 16. FASE 10 — TESTING
--------------------------------------------------

Debes crear y ejecutar:

- Tests unitarios.
- Tests de modelos.
- Tests del ApiClient.
- Tests de autenticación.
- Tests de refresh tokens.
- Tests de manejo de errores.
- Tests de idempotencia.
- Tests de navegación.
- Tests de formularios.
- Tests de estados de viaje.
- Tests de billetera.
- Tests de widgets críticos.

En backend:

- Ejecuta la suite completa existente.
- No elimines tests para ocultar errores.
- No cambies expectativas únicamente para hacerlos pasar.
- Si modificas el backend, agrega cobertura correspondiente.

Comandos esperados:

python -m pytest tests/ -q

flutter analyze

flutter test

flutter build apk --release

Todos los resultados deben ser reales.

--------------------------------------------------
# 17. FASE 11 — CONFIGURACIÓN DE PRODUCCIÓN
--------------------------------------------------

Configura correctamente:

- API base URL.
- applicationId.
- Nombre de la aplicación.
- Icono.
- Splash screen.
- Versión.
- Permisos.
- Configuración de release.
- Firma de Android.
- Variables de entorno.
- Deep links.
- HTTPS.
- Configuración de mapas.

La URL de producción debe ser configurable.

No uses localhost en producción.

No incluyas:

- Tokens privados.
- Contraseñas.
- Claves secretas.
- Credenciales de Mercado Pago.
- Archivos .env.
- Keystores.
- Información sensible.

No subas secretos al repositorio.

--------------------------------------------------
# 18. FASE 12 — VALIDACIÓN EN DISPOSITIVO REAL
--------------------------------------------------

Antes de declarar que VAN está lista:

Prueba en un dispositivo Android real:

1. Instalar la aplicación.
2. Abrirla.
3. Registrar un pasajero.
4. Iniciar sesión.
5. Cerrar y volver a abrir.
6. Solicitar permisos de ubicación.
7. Ver el mapa.
8. Solicitar un viaje.
9. Iniciar sesión como conductor.
10. Activar disponibilidad.
11. Recibir el viaje.
12. Aceptarlo.
13. Iniciar el viaje.
14. Completarlo.
15. Verificar el cobro.
16. Revisar el historial.
17. Probar cancelaciones.
18. Probar errores de conexión.
19. Probar expiración del token.
20. Probar cierre de sesión.

Si no existen dos dispositivos, utiliza las alternativas disponibles,
pero documenta qué pruebas no pudieron realizarse.

No declares que el sistema está validado si solo se compiló.

--------------------------------------------------
# 19. FASE 13 — GOOGLE PLAY
--------------------------------------------------

Prepara la aplicación para publicación.

Verifica:

- Application ID único.
- Nombre.
- Icono.
- Versión.
- Android App Bundle.
- Firma de release.
- Política de privacidad.
- Declaración de permisos.
- Permiso de ubicación.
- Información sobre datos recopilados.
- Ficha de Google Play.
- Capturas de pantalla.
- Descripción.
- Contacto de soporte.
- Requisitos de contenido.
- Requisitos de pruebas de Google Play.
- Requisitos de cuenta de desarrollador.

Genera:

flutter build appbundle --release

No afirmes que está publicada hasta que Google Play confirme
la publicación.

Si la publicación requiere pasos manuales del propietario de la
cuenta, enuméralos claramente.

--------------------------------------------------
# 20. REGLAS DE TRABAJO
--------------------------------------------------

- Trabaja sobre el código real.
- Inspecciona antes de editar.
- Haz cambios pequeños y verificables.
- No borres funcionalidades útiles.
- No inventes resultados.
- No uses datos mock en producción.
- No escondas errores.
- No cambies la arquitectura sin justificarlo.
- No dupliques lógica del backend.
- No ignores errores de seguridad.
- No expongas secretos.
- No uses credenciales reales para pruebas.
- No declares una tarea completa sin evidencia.
- Si encuentras un bloqueo, informa el bloqueo exacto.
- Si puedes resolverlo, resuélvelo.
- Si no puedes resolverlo sin intervención humana, explica el
  siguiente paso concreto.

--------------------------------------------------
# 21. DOCUMENTACIÓN OBLIGATORIA
--------------------------------------------------

Después de cada cambio importante, actualiza:

VAN_MASTER_SPEC.md

Incluye:

- Estado actual.
- Cambios realizados.
- Decisiones técnicas.
- Problemas detectados.
- Tests ejecutados.
- Tests pendientes.
- Configuración requerida.
- Estado de Flutter.
- Estado de Android.
- Estado de producción.
- Estado de Mercado Pago.
- Estado de publicación.
- Próximos pasos.

No marques como completado algo que todavía no fue validado.

--------------------------------------------------
# 22. FORMATO DE RESPUESTA OBLIGATORIO
--------------------------------------------------

Después de cada fase, responde con:

## FASE COMPLETADA

Qué se hizo.

## ARCHIVOS MODIFICADOS

Lista de archivos.

## PRUEBAS EJECUTADAS

Comandos y resultados reales.

## PROBLEMAS ENCONTRADOS

Errores, bloqueos o riesgos.

## CONFIGURACIÓN QUE DEBO HACER YO

Solo tareas que requieren intervención del propietario.

## ESTADO REAL

- Completado.
- Parcial.
- Bloqueado.

## SIGUIENTE PASO

La acción concreta que corresponde.

No avances silenciosamente sobre bloqueos importantes.

--------------------------------------------------
# OBJETIVO FINAL
--------------------------------------------------

Quiero terminar con una versión móvil MVP real de VAN.

La prioridad es:

1. Aplicación Flutter compilable.
2. Login y registro funcionales.
3. Pasajero funcional.
4. Conductor funcional.
5. Solicitud y gestión real de viajes.
6. Ubicación y mapas.
7. Billetera básica.
8. Seguridad.
9. Testing.
10. APK/AAB de release.
11. Validación en dispositivo real.
12. Preparación para Google Play.

No quiero una aplicación visualmente bonita pero rota.

Quiero una aplicación funcional, verificable y conectada al backend
real de VAN.