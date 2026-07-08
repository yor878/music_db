# SRS (Software Requirements Specification)

## Sistema CRUD de Música

**Tecnologías:** Flutter (Dart) + Firebase Firestore + GitHub

---

# 1. Introducción

## 1.1 Propósito

Desarrollar una aplicación móvil que permita administrar un catálogo de canciones mediante operaciones CRUD (Crear, Leer, Actualizar y Eliminar), utilizando Flutter para el desarrollo de la interfaz y Firebase Firestore como base de datos.

---

## 1.2 Alcance

La aplicación permitirá:

* Registrar canciones.
* Visualizar todas las canciones.
* Editar la información de una canción.
* Eliminar canciones.
* Almacenar la información en Firebase Firestore.
* Controlar el desarrollo mediante GitHub.

---

# 2. Historias de Usuario

## HU-01 Registrar canción

**Como usuario**
quiero registrar una canción
**para** almacenarla en la base de datos y consultarla posteriormente.

### Requisitos funcionales

* RF-01 Permitir ingresar el título de la canción.
* RF-02 Permitir ingresar el nombre del artista.
* RF-03 Permitir ingresar el álbum.
* RF-04 Permitir ingresar el género musical.
* RF-05 Permitir ingresar el año de lanzamiento.
* RF-06 Validar que los campos obligatorios no estén vacíos.
* RF-07 Guardar la información en Firebase Firestore.
* RF-08 Mostrar un mensaje cuando el registro sea exitoso.

### Requisitos no funcionales

* RNF-01 El registro deberá realizarse en menos de 3 segundos.
* RNF-02 La interfaz deberá ser intuitiva y fácil de utilizar.
* RNF-03 La información deberá almacenarse de forma segura en Firestore.
* RNF-04 La aplicación deberá funcionar en Android 8.0 o superior.

### Stack tecnológico

| Tecnología      | Uso                   |
| --------------- | --------------------- |
| Flutter         | Interfaz de usuario   |
| Dart            | Programación          |
| Firebase Core   | Conexión con Firebase |
| Cloud Firestore | Almacenamiento        |
| GitHub          | Control de versiones  |

---

# HU-02 Consultar canciones

**Como usuario**
quiero visualizar todas las canciones registradas
**para** consultar su información.

### Requisitos funcionales

* RF-09 Mostrar una lista con todas las canciones.
* RF-10 Mostrar título, artista y género.
* RF-11 Actualizar la lista automáticamente cuando existan cambios.
* RF-12 Permitir seleccionar una canción.

### Requisitos no funcionales

* RNF-05 La lista deberá cargarse en menos de 2 segundos.
* RNF-06 La interfaz deberá adaptarse a diferentes tamaños de pantalla.
* RNF-07 Los datos deberán actualizarse en tiempo real.

### Stack tecnológico

| Tecnología      | Uso                      |
| --------------- | ------------------------ |
| Flutter         | Pantalla principal       |
| StreamBuilder   | Actualización automática |
| Cloud Firestore | Consulta de datos        |
| GitHub          | Versionamiento           |

---

# HU-03 Editar canción

**Como usuario**
quiero modificar la información de una canción
**para** mantener los datos actualizados.

### Requisitos funcionales

* RF-13 Permitir seleccionar una canción.
* RF-14 Mostrar la información actual.
* RF-15 Permitir modificar los datos.
* RF-16 Actualizar la información en Firestore.
* RF-17 Mostrar mensaje de actualización exitosa.

### Requisitos no funcionales

* RNF-08 La actualización deberá realizarse en menos de 3 segundos.
* RNF-09 Mantener la integridad de la información.
* RNF-10 La aplicación no deberá cerrarse durante la actualización.

### Stack tecnológico

| Tecnología      | Uso                 |
| --------------- | ------------------- |
| Flutter         | Pantalla de edición |
| Dart            | Lógica              |
| Cloud Firestore | Método `update()`   |
| GitHub          | Control de cambios  |

---

# HU-04 Eliminar canción

**Como usuario**
quiero eliminar una canción
**para** mantener actualizado mi catálogo musical.

### Requisitos funcionales

* RF-18 Permitir seleccionar una canción.
* RF-19 Solicitar confirmación antes de eliminar.
* RF-20 Eliminar el documento de Firestore.
* RF-21 Actualizar automáticamente la lista.
* RF-22 Mostrar mensaje de eliminación exitosa.

### Requisitos no funcionales

* RNF-11 La eliminación deberá completarse en menos de 2 segundos.
* RNF-12 Evitar eliminaciones accidentales mediante confirmación.
* RNF-13 Mantener la consistencia de la base de datos.

### Stack tecnológico

| Tecnología      | Uso               |
| --------------- | ----------------- |
| Flutter         | Interfaz          |
| Dart            | Programación      |
| Cloud Firestore | Método `delete()` |
| GitHub          | Versionamiento    |

---

# HU-05 Control de versiones

**Como desarrollador**
quiero administrar el código fuente mediante GitHub
**para** mantener un historial de cambios y facilitar el trabajo colaborativo.

### Requisitos funcionales

* RF-23 Crear un repositorio en GitHub.
* RF-24 Utilizar ramas para nuevas funcionalidades.
* RF-25 Realizar commits descriptivos.
* RF-26 Integrar cambios mediante Pull Request.
* RF-27 Mantener un archivo `README.md` actualizado.

### Requisitos no funcionales

* RNF-14 El repositorio deberá estar organizado.
* RNF-15 Los commits deberán seguir una nomenclatura consistente.
* RNF-16 El código deberá mantenerse documentado y respaldado.

### Stack tecnológico

| Tecnología | Uso                         |
| ---------- | --------------------------- |
| Git        | Control de versiones        |
| GitHub     | Repositorio remoto          |
| Markdown   | Documentación (`README.md`) |

---

# 3. Stack Tecnológico General

| Componente              | Tecnología                          |
| ----------------------- | ----------------------------------- |
| Lenguaje                | Dart                                |
| Framework               | Flutter                             |
| Base de datos           | Firebase Cloud Firestore            |
| Backend                 | Firebase                            |
| Control de versiones    | Git                                 |
| Repositorio remoto      | GitHub                              |
| IDE                     | Android Studio / Visual Studio Code |
| Gestión de dependencias | Pub (`pubspec.yaml`)                |

---

