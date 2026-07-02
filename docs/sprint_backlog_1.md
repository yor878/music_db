## Sprint Backlog – CRUD de Música (Flutter + Firebase)

**Sprint:** Sprint 1 (2 semanas)

**Objetivo del Sprint:**
Desarrollar una aplicación móvil en Flutter que permita registrar, consultar, editar y eliminar canciones utilizando Firebase como base de datos.

| Historia de Usuario                                                              | Tarea                        | Subtareas                                                                                                                           | Responsable   | Estado     |
| -------------------------------------------------------------------------------- | ---------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------------- | ---------- |
| Como usuario quiero registrar una canción para almacenarla en la aplicación.     | Crear pantalla de registro   | - Diseñar la interfaz en Flutter.<br>- Agregar TextField para Título, Artista, Álbum, Género y Año.<br>- Agregar botón Guardar.     | Desarrollador | Pendiente  |
|                                                                                  | Configurar Firebase          | - Crear proyecto en Firebase.<br>- Conectar Flutter con Firebase.<br>- Agregar dependencias (`firebase_core` y `cloud_firestore`).  | Desarrollador | Pendiente  |
|                                                                                  | Guardar datos en Firestore   | - Crear colección **musica**.<br>- Validar campos.<br>- Enviar datos mediante `add()`.<br>- Mostrar mensaje de éxito.               | Desarrollador | Pendiente  |
| Como usuario quiero visualizar todas las canciones registradas.                  | Crear pantalla principal     | - Diseñar ListView.<br>- Agregar AppBar.<br>- Crear botón para agregar nueva canción.                                               | Desarrollador | Pendiente  |
|                                                                                  | Mostrar datos desde Firebase | - Implementar `StreamBuilder`.<br>- Obtener documentos de Firestore.<br>- Mostrar información de cada canción.                      | Desarrollador | Pendiente  |
| Como usuario quiero editar la información de una canción.                        | Crear pantalla de edición    | - Cargar datos existentes.<br>- Permitir modificar información.<br>- Agregar botón Actualizar.                                      | Desarrollador | Pendiente  |
|                                                                                  | Actualizar documento         | - Obtener ID del documento.<br>- Usar método `update()`.<br>- Refrescar la lista automáticamente.                                   | Desarrollador | Pendiente  |
| Como usuario quiero eliminar una canción.                                        | Implementar eliminación      | - Agregar botón Eliminar.<br>- Mostrar cuadro de confirmación.<br>- Eliminar documento con `delete()`.<br>- Actualizar la lista.    | Desarrollador | Pendiente  |
| Como desarrollador quiero administrar el código fuente.                          | Configurar GitHub            | - Crear repositorio.<br>- Crear README.<br>- Crear rama `develop`.<br>- Subir proyecto inicial.                                     | Desarrollador | Completado |
|                                                                                  | Control de versiones         | - Crear ramas por funcionalidad.<br>- Realizar commits descriptivos.<br>- Hacer Pull Request.<br>- Integrar cambios mediante Merge. | Desarrollador | En proceso |
| Como desarrollador quiero verificar el correcto funcionamiento de la aplicación. | Realizar pruebas             | - Probar Create.<br>- Probar Read.<br>- Probar Update.<br>- Probar Delete.<br>- Corregir errores encontrados.                       | Desarrollador | Pendiente  |

---

## Tecnologías utilizadas

* **Lenguaje:** Dart
* **Framework:** Flutter
* **Base de datos:** Firebase Cloud Firestore
* **Backend:** Firebase
* **Control de versiones:** Git y GitHub
* **IDE:** Android Studio o Visual Studio Code

---

## Dependencias

Las dependencias son los elementos necesarios para poder completar las tareas del Sprint.

| ID | Dependencia               | Descripción                                                                   |
| -- | ------------------------- | ----------------------------------------------------------------------------- |
| D1 | Proyecto de Firebase      | Tener creado el proyecto en Firebase Console.                                 |
| D2 | Configuración de Firebase | Conectar correctamente Flutter con Firebase mediante `firebase_core`.         |
| D3 | Cloud Firestore           | Habilitar la base de datos Firestore para almacenar las canciones.            |
| D4 | Dependencias de Flutter   | Instalar los paquetes `firebase_core`, `cloud_firestore` y `cupertino_icons`. |
| D5 | Repositorio en GitHub     | Contar con un repositorio para el control de versiones.                       |
| D6 | Dispositivo o Emulador    | Tener un emulador Android/iOS o un dispositivo físico para realizar pruebas.  |
| D7 | Conexión a Internet       | Necesaria para sincronizar la aplicación con Firebase.                        |
| D8 | Flutter SDK               | Tener instalado y configurado correctamente Flutter y Dart.                   |

---

## Impedimentos

Los impedimentos son problemas que pueden retrasar el desarrollo del Sprint.

| ID | Impedimento                            | Posible solución                                                                                          |
| -- | -------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| I1 | Error al conectar Flutter con Firebase | Verificar el archivo `google-services.json` o `GoogleService-Info.plist` y la configuración del proyecto. |
| I2 | Firestore no permite escribir datos    | Revisar las reglas de seguridad de Firestore y los permisos.                                              |
| I3 | Dependencias incompatibles             | Actualizar las versiones de Flutter y de los paquetes utilizados.                                         |
| I4 | Problemas con GitHub                   | Verificar credenciales, permisos o configuración de Git.                                                  |
| I5 | Errores de compilación                 | Ejecutar `flutter clean`, `flutter pub get` y revisar el código.                                          |
| I6 | Sin conexión a Internet                | Utilizar una red estable para sincronizar con Firebase.                                                   |
| I7 | Emulador no inicia                     | Reiniciar el emulador o probar en un dispositivo físico.                                                  |
| I8 | Conflictos al integrar cambios en Git  | Resolver conflictos de merge antes de continuar con el desarrollo.                                        |

---

## Resultado esperado del Sprint

Al finalizar el Sprint se debe contar con:

* ✅ Aplicación desarrollada en Flutter.
* ✅ Firebase correctamente configurado.
* ✅ CRUD completo de canciones.
* ✅ Persistencia de datos en Cloud Firestore.
* ✅ Interfaz funcional y responsive.
* ✅ Proyecto almacenado en GitHub con historial de commits.
* ✅ Pruebas funcionales del sistema.

Este Sprint Backlog está adaptado específicamente para un proyecto de **Flutter (Dart) utilizando Firebase Firestore** y cumple con una estructura típica de metodologías ágiles (Scrum).
