```mermaid
erDiagram

    USUARIO {
        String uid PK
        String nombre
        String correo
        Timestamp fechaRegistro
    }

    CANCION {
        String idCancion PK
        String titulo
        String artista
        String album
        String genero
        String duracion
        String portada
        Timestamp fechaRegistro
        String uidUsuario FK
    }

    USUARIO ||--o{ CANCION : registra

```
