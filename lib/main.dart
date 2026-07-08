import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MusicCrudApp());
}

// =========================================================================
// 1. MODELOS DE DATOS (Basados en el Diagrama ER)
// =========================================================================

class Usuario {
  final String uid;
  final String nombre;
  final String correo;
  final DateTime fechaRegistro;

  Usuario({
    required this.uid,
    required this.nombre,
    required this.correo,
    required this.fechaRegistro,
  });
}

class Cancion {
  final String idCancion;
  final String titulo;
  final String artista;
  final String album;
  final String genero;
  final String duracion;
  final String portada;
  final DateTime fechaRegistro;
  final String uidUsuario;

  Cancion({
    required this.idCancion,
    required this.titulo,
    required this.artista,
    required this.album,
    required this.genero,
    required this.duracion,
    this.portada = 'https://via.placeholder.com/150',
    required this.fechaRegistro,
    required this.uidUsuario,
  });

  Cancion copyWith({
    String? titulo,
    String? artista,
    String? album,
    String? genero,
    String? duracion,
  }) {
    return Cancion(
      idCancion: idCancion,
      titulo: titulo ?? this.titulo,
      artista: artista ?? this.artista,
      album: album ?? this.album,
      genero: genero ?? this.genero,
      duracion: duracion ?? this.duracion,
      portada: portada,
      fechaRegistro: fechaRegistro,
      uidUsuario: uidUsuario,
    );
  }
}

// =========================================================================
// 2. MOCK FIREBASE SERVICE (Simulación de Cloud Firestore y Auth)
// =========================================================================

class MockFirebaseService {
  // Singleton para mantener el estado en toda la app
  static final MockFirebaseService _instance = MockFirebaseService._internal();
  factory College() => _instance;
  MockFirebaseService._internal() {
    // Inicializar con datos de prueba
    _cancionesController.add(_cancionesDb);
  }

  // Base de datos en memoria
  final List<Usuario> _usuariosDb = [
    Usuario(uid: 'user123', nombre: 'Test User', correo: 'test@mail.com', fechaRegistro: DateTime.now())
  ];
  
  final List<Cancion> _cancionesDb = [
    Cancion(
      idCancion: '1',
      titulo: 'Bohemian Rhapsody',
      artista: 'Queen',
      album: 'A Night at the Opera',
      genero: 'Rock',
      duracion: '5:55',
      fechaRegistro: DateTime.now(),
      uidUsuario: 'user123',
    ),
    Cancion(
      idCancion: '2',
      titulo: 'Blinding Lights',
      artista: 'The Weeknd',
      album: 'After Hours',
      genero: 'Pop',
      duracion: '3:20',
      fechaRegistro: DateTime.now(),
      uidUsuario: 'user123',
    ),
  ];

  Usuario? _usuarioActual;
  Usuario? get currentUser => _usuarioActual;

  // Stream Controller para emular las actualizaciones en tiempo real de Firestore (StreamBuilder)
  final StreamController<List<Cancion>> _cancionesController = StreamController<List<Cancion>>.broadcast();
  Stream<List<Cancion>> get cancionesStream => _cancionesController.stream;

  // --- MOCK AUTHENTICATION ---
  
  Future<bool> registrarUsuario(String nombre, String correo, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // RNF-01 (Simulación delay)
    if (_usuariosDb.any((u) => u.correo == correo)) return false;
    
    final nuevoUsuario = Usuario(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      nombre: nombre,
      correo: correo,
      fechaRegistro: DateTime.now(),
    );
    _usuariosDb.add(nuevoUsuario);
    _usuarioActual = nuevoUsuario;
    return true;
  }

  Future<bool> login(String correo, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final userIdx = _usuariosDb.indexWhere((u) => u.correo == correo && password.isNotEmpty);
    if (userIdx != -1) {
      _usuarioActual = _usuariosDb[userIdx];
      return true;
    }
    return false;
  }

  void logout() {
    _usuarioActual = null;
  }

  // --- MOCK FIRESTORE CRUD ---

  Future<void> registrarCancion(String titulo, String artista, String album, String genero) async {
    await Future.delayed(const Duration(seconds: 1)); // RNF-01 < 3s
    final nueva = Cancion(
      idCancion: 'song_${DateTime.now().millisecondsSinceEpoch}',
      titulo: titulo,
      artista: artista,
      album: album,
      genero: genero,
      duracion: '3:30', // Dummy
      fechaRegistro: DateTime.now(),
      uidUsuario: _usuarioActual?.uid ?? 'anonimo',
    );
    _cancionesDb.add(nueva);
    _cancionesController.add(List.from(_cancionesDb)); // Notificar cambios en tiempo real (RF-11)
  }

  Future<void> editarCancion(String id, String titulo, String artista, String album, String genero) async {
    await Future.delayed(const Duration(seconds: 1)); // RNF-08 < 3s
    final idx = _cancionesDb.indexWhere((c) => c.idCancion == id);
    if (idx != -1) {
      _cancionesDb[idx] = _cancionesDb[idx].copyWith(
        titulo: titulo,
        artista: artista,
        album: album,
        genero: genero,
      );
      _cancionesController.add(List.from(_cancionesDb));
    }
  }

  Future<void> eliminarCancion(String id) async {
    await Future.delayed(const Duration(milliseconds: 500)); // RNF-11 < 2s
    _cancionesDb.removeWhere((c) => c.idCancion == id);
    _cancionesController.add(List.from(_cancionesDb));
  }
}

final firebaseService = MockFirebaseService._instance;

// =========================================================================
// 3. VISTAS Y NAVEGACIÓN
// =========================================================================

class MusicCrudApp extends StatelessWidget {
  const MusicCrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Canciones',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // Punto de partida: US-02
    );
  }
}

// --- PANTALLA DE LOGIN (US-02) ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correoCtrl = TextEditingController(text: 'test@mail.com');
  final _passCtrl = TextEditingController(text: '123456');
  bool _loading = false;

  void _iniciarSesion() async {
    setState(() => _loading = true);
    bool exito = await firebaseService.login(_correoCtrl.text, _passCtrl.text);
    setState(() => _loading = false);

    if (exito && mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Credenciales incorrectas')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: _correoCtrl, decoration: const InputDecoration(labelText: 'Correo electrónico')),
            TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
            const SizedBox(height: 24),
            _loading 
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _iniciarSesion, child: const Text('Iniciar sesión')),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
              child: const Text('¿No tienes cuenta? Regístrate'),
            )
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA DE REGISTRO (US-01) ---
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nombreCtrl = TextEditingController();
  final _correoCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  void _registrar() async {
    if (_nombreCtrl.text.isEmpty || _correoCtrl.text.isEmpty || _passCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Complete los campos obligatorios')));
      return;
    }
    setState(() => _loading = true);
    bool creado = await firebaseService.registrarUsuario(_nombreCtrl.text, _correoCtrl.text, _passCtrl.text);
    setState(() => _loading = false);

    if (creado && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Registro exitoso')));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('El correo ya existe')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nombreCtrl, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: _correoCtrl, decoration: const InputDecoration(labelText: 'Correo')),
            TextField(controller: _passCtrl, decoration: const InputDecoration(labelText: 'Contraseña'), obscureText: true),
            const SizedBox(height: 24),
            _loading ? const CircularProgressIndicator() : ElevatedButton(onPressed: _registrar, child: const Text('Registrarse')),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA PRINCIPAL / CONSULTAR (US-05 / HU-02) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Canciones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              firebaseService.logout(); // US-03
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
            },
          )
        ],
      ),
      body: StreamBuilder<List<Cancion>>(
        stream: firebaseService.cancionesStream, // RF-11 e Integración en tiempo real
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final canciones = snapshot.data!;

          if (canciones.isEmpty) {
            return const Center(child: Text('No existen canciones registradas.')); // Criterio US-05
          }

          return ListView.builder(
            itemCount: canciones.length,
            itemSpacing: 8.0,
            itemBuilder: (context, index) {
              final cancion = canciones[index];
              return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(cancion.portada)),
                title: Text(cancion.titulo), // RF-10
                subtitle: Text('${cancion.artista} • ${cancion.genero}'), // RF-10
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.orange),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FormCancionScreen(cancion: cancion))), // US-06
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _confirmarEliminacion(context, cancion), // US-07 / HU-04
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FormCancionScreen())), // US-04
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmarEliminacion(BuildContext context, Cancion cancion) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar canción'),
        content: Text('¿Está seguro de que desea eliminar "${cancion.titulo}"?'), // RF-19 Confirmación
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')), // US-07 Cancelar
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await firebaseService.eliminarCancion(cancion.idCancion);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Canción eliminada correctamente.')));
              }
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          )
        ],
      ),
    );
  }
}

// --- FORMULARIO CREAR / EDITAR (US-04 y US-06) ---
class FormCancionScreen extends StatefulWidget {
  final Cancion? cancion; // Si es null, Crea. Si tiene valor, Edita.
  const FormCancionScreen({super.key, this.cancion});

  @override
  State<FormCancionScreen> createState() => _FormCancionScreenState();
}

class _FormCancionScreenState extends State<FormCancionScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloCtrl;
  late TextEditingController _artistaCtrl;
  late TextEditingController _albumCtrl;
  late TextEditingController _generoCtrl;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // RF-14: Mostrar información actual si se va a editar
    _tituloCtrl = TextEditingController(text: widget.cancion?.titulo ?? '');
    _artistaCtrl = TextEditingController(text: widget.cancion?.artista ?? '');
    _albumCtrl = TextEditingController(text: widget.cancion?.album ?? '');
    _generoCtrl = TextEditingController(text: widget.cancion?.genero ?? '');
  }

  void _guardar() async {
    if (!_formKey.currentState!.validate()) return; // RF-06 Validación campos obligatorios

    setState(() => _loading = true);

    if (widget.cancion == null) {
      // Guardar nueva canción (US-04 / HU-01)
      await firebaseService.registrarCancion(_tituloCtrl.text, _artistaCtrl.text, _albumCtrl.text, _generoCtrl.text);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Canción registrada correctamente.')));
    } else {
      // Modificar canción existente (US-06 / HU-03)
      await firebaseService.editarCancion(widget.cancion!.idCancion, _tituloCtrl.text, _artistaCtrl.text, _albumCtrl.text, _generoCtrl.text);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Canción actualizada correctamente.')));
    }

    setState(() => _loading = false);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.cancion != null;
    return Scaffold(
      appBar: AppBar(title: Text(esEdicion ? 'Editar Canción' : 'Registrar Canción')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _tituloCtrl, decoration: const InputDecoration(labelText: 'Título *'), validator: (v) => v!.isEmpty ? 'Campo requerido' : null), // RF-01
              TextFormField(controller: _artistaCtrl, decoration: const InputDecoration(labelText: 'Artista *'), validator: (v) => v!.isEmpty ? 'Campo requerido' : null), // RF-02
              TextFormField(controller: _albumCtrl, decoration: const InputDecoration(labelText: 'Álbum *'), validator: (v) => v!.isEmpty ? 'Campo requerido' : null), // RF-03
              TextFormField(controller: _generoCtrl, decoration: const InputDecoration(labelText: 'Género Musical *'), validator: (v) => v!.isEmpty ? 'Campo requerido' : null), // RF-04
              const SizedBox(height: 32),
              _loading 
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(onPressed: _guardar, child: Text(esEdicion ? 'Actualizar' : 'Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
