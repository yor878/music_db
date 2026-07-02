## Product Backlog - Sistema CRUD de Canciones

### Épica 1: Gestión de Usuarios

Objetivo: Permitir que los usuarios creen una cuenta e ingresen al sistema de forma segura para administrar canciones.

Historias de usuario 

| ID |	User Story |	Prioridad |
|---|---|---|
| US-01 |	Como visitante, quiero registrarme para crear una cuenta y acceder al sistema. |	Alta |
| US-02 |	Como usuario registrado, quiero iniciar sesión para acceder a mis funciones. |	Alta |
| US-03 |	Como usuario, quiero cerrar sesión para proteger mi información. | Alta

#### US-01: Registro de Usuario

**Como** visitante, **quiero** registrarme con mis datos personales **para** poder acceder al sistema.

Acceptance Criteria (Gherkin)

```gherkin
Feature: Registro de usuario

Scenario: Registro exitoso
Given que el usuario está en la pantalla de registro
And ingresa un nombre válido
And ingresa un correo electrónico no registrado
And escribe una contraseña válida
When presiona el botón "Registrarse"
Then el sistema crea la cuenta
And muestra un mensaje de registro exitoso.

Scenario: Registro fallido por correo existente
Given que el usuario está en la pantalla de registro
And el correo ya está registrado
When presiona el botón "Registrarse"
Then el sistema rechaza el registro
And muestra el mensaje "El correo ya existe".
```

#### US-02: Inicio de Sesión

Como usuario registrado, quiero iniciar sesión para administrar las canciones.

Acceptance Criteria (Gherkin)
```gherkin
Feature: Inicio de sesión

Scenario: Inicio de sesión exitoso
Given que el usuario está registrado
And escribe un correo válido
And escribe la contraseña correcta
When presiona "Iniciar sesión"
Then el sistema permite el acceso
And muestra el menú principal.

Scenario: Inicio de sesión fallido
Given que el usuario está registrado
And escribe una contraseña incorrecta
When presiona "Iniciar sesión"
Then el sistema niega el acceso
And muestra el mensaje "Credenciales incorrectas".
```
#### US-03: Cerrar Sesión

Como usuario, quiero cerrar sesión para finalizar el acceso al sistema.

Acceptance Criteria (Gherkin)
```gherkin
Feature: Cerrar sesión

Scenario: Cierre exitoso
Given que el usuario inició sesión
When selecciona "Cerrar sesión"
Then el sistema finaliza la sesión
And redirige al inicio de sesión.
```
## Épica 2: Crear Canciones (CREATE)

Objetivo: Permitir registrar nuevas canciones.

| ID	| User Story |	Prioridad |
|---|---|---|
| US-04	| Como usuario, quiero registrar una canción para almacenarla en el sistema. |	Muy Alta |

#### US-04: Registrar Canción

Como usuario, quiero agregar una nueva canción para almacenarla en la base de datos.

Acceptance Criteria (Gherkin)
```gherkin
Feature: Registrar canción

Scenario: Registro exitoso
Given que el usuario inició sesión
And completa correctamente los campos
When presiona "Guardar"
Then el sistema almacena la canción
And muestra el mensaje "Canción registrada correctamente".

Scenario: Registro fallido
Given que el usuario inició sesión
And deja un campo obligatorio vacío
When presiona "Guardar"
Then el sistema no registra la canción
And muestra el mensaje "Complete los campos obligatorios".
```

## Épica 3: Consultar Canciones (READ)

Objetivo: Permitir visualizar la información almacenada.

| ID	| User Story |	Prioridad |
|---|---|---|
| US-05 |	Como usuario, quiero visualizar la lista de canciones para consultar la información registrada. |	Muy Alta |

#### US-05: Ver Canciones

Como usuario, quiero consultar todas las canciones registradas.

Acceptance Criteria (Gherkin)
```gherkin
Feature: Consultar canciones

Scenario: Consulta exitosa
Given que existen canciones registradas
When el usuario entra al apartado "Canciones"
Then el sistema muestra la lista completa.

Scenario: No existen canciones
Given que no hay canciones registradas
When el usuario entra al apartado "Canciones"
Then el sistema muestra el mensaje "No existen canciones registradas".
```
### Épica 4: Actualizar Canciones (UPDATE)

Objetivo: Permitir modificar la información de una canción.

| ID | User Story | Prioridad |
|---|---|---|
|US-06	| Como usuario, quiero editar una canción para mantener la información actualizada. |	Alta

#### US-06: Editar Canción

Como usuario, quiero modificar los datos de una canción registrada.
```gherkin
Acceptance Criteria (Gherkin)
Feature: Editar canción

Scenario: Actualización exitosa
Given que existe una canción registrada
And el usuario selecciona "Editar"
When modifica la información
And presiona "Actualizar"
Then el sistema guarda los cambios
And muestra el mensaje "Canción actualizada correctamente".

Scenario: Actualización fallida
Given que existe una canción registrada
And el usuario deja un campo obligatorio vacío
When presiona "Actualizar"
Then el sistema no guarda los cambios
And muestra el mensaje "Debe completar los campos obligatorios".
```
### Épica 5: Eliminar Canciones (DELETE)

Objetivo: Permitir eliminar canciones que ya no sean necesarias.

| ID | User Story |	Prioridad |
|---|---|---|
| US-07	| Como usuario, quiero eliminar una canción para mantener actualizada la base de datos.	| Alta

#### US-07: Eliminar Canción

Como usuario, quiero eliminar una canción registrada para que ya no aparezca en el sistema.

Acceptance Criteria (Gherkin)
```gherkin
Feature: Eliminar canción

Scenario: Eliminación exitosa
Given que existe una canción registrada
And el usuario selecciona "Eliminar"
When confirma la eliminación
Then el sistema elimina la canción
And muestra el mensaje "Canción eliminada correctamente".

Scenario: Eliminación cancelada
Given que existe una canción registrada
When el usuario cancela la eliminación
Then el sistema conserva la canción
And regresa a la lista de canciones.
```
Product Backlog Priorizado

| Prioridad |	ID	| Épica |	Historia de Usuario	| Estado |
|---|---|---|---|---|
| 1|	US-01 |	Gestión de Usuarios	| Registro de usuario | Pendiente |
| 2| US-02	|Gestión de Usuarios	| Inicio de sesión	| Pendient |
| 3|	US-03	| Gestión de Usuarios	| Cerrar sesión	| Pendiente |
| 4|	US-04	| CREATE	Registrar | canción	| Pendiente |
| 5|	US-05	| READ	Consultar | canciones	| Pendiente |
| 6|	US-06	| UPDATE	Editar | canción	| Pendiente |
| 7|	US-07	| DELETE	Eliminar | canción	| Pendiente |

Relación con CRUD

Operación	Historia de Usuario
Create (Crear)	US-04 Registrar canción
Read (Leer)	US-05 Consultar canciones
Update (Actualizar)	US-06 Editar canción
Delete (Eliminar)	US-07 Eliminar canción
Referencias
