# PetCare Digital

Aplicación web para llevar en un solo lugar los datos de un perro o un gato: su registro, el carné de vacunas y desparasitaciones y las citas con el veterinario. Está pensada sobre todo para personas adultas mayores del sur de Bogotá, así que busca tener pocas pantallas, letra grande y botones claros.

Es el proyecto productivo (Producto Mínimo Viable) de la etapa productiva del Técnico en Programación de Software del SENA, Centro de Comercio y Servicios, Regional Cauca.

## Estado del proyecto

El proyecto está en desarrollo. Con el primer avance quedó hecho:

- La definición del alcance, los requisitos y las 11 historias de usuario.
- El diagrama de arquitectura.
- El modelo de datos: diagrama entidad-relación, diccionario de datos y el script SQL de la base de datos, que ya se probó en MySQL 8.

Falta programar la aplicación: inicio de sesión con roles, el CRUD de mascotas, el registro de vacunas, desparasitaciones y citas, y el panel de recordatorios.

## Qué problema busca resolver

Quien tiene una mascota debe acordarse de fechas de vacunas, desparasitaciones y citas. Casi siempre estos datos están en un carné de papel que se pierde o se daña, o en la memoria. Las aplicaciones que existen suelen funcionar como agendas y no son fáciles de usar para quien casi no usa tecnología. PetCare Digital reúne el historial de cada mascota y avisa qué fechas se acercan.

## Qué incluye la primera versión

- Registro de usuarios e inicio y cierre de sesión, con dos roles: usuario y administrador.
- Registro, consulta, edición y eliminación de mascotas.
- Registro de vacunas y desparasitaciones, con la fecha de la próxima dosis.
- Carné digital con el historial de cada mascota.
- Programación, edición y cancelación de citas veterinarias.
- Panel con las fechas próximas y las vencidas.
- Administración de usuarios para el rol de administrador.

Quedan para una versión posterior el módulo para veterinarias, la sección para negocios de productos de mascotas, los avisos por correo o WhatsApp y la aplicación móvil.

## Tecnologías

| Parte | Tecnología |
|---|---|
| Interfaz | HTML5, CSS3 y Bootstrap |
| Lógica del sistema | C# y ASP.NET Core Blazor |
| Base de datos | MySQL |
| Entorno de desarrollo | Visual Studio o Visual Studio Code |
| Diseño de pantallas | Figma |
| Control de versiones | Git y GitHub |
| Gestión del proyecto | Jira |

## Estructura del repositorio

```
PetCare-Digital/
├── database/
│   └── petcare_digital_esquema.sql   Script que crea la base de datos
├── .gitignore
└── README.md
```

La carpeta con el código de la aplicación se agregará cuando empiece la programación.

## Cómo crear la base de datos

Necesitas tener MySQL 8.0.16 o superior y MySQL Workbench (o phpMyAdmin).

1. Descarga o clona este repositorio.
2. Abre MySQL Workbench y entra a tu conexión local con tu usuario y contraseña.
3. Ve a File, Open SQL Script y elige `database/petcare_digital_esquema.sql`.
4. Pulsa el ícono del rayo para ejecutar todo el archivo.
5. Actualiza el panel Schemas. Debe aparecer `petcare_digital` con seis tablas: `roles`, `usuarios`, `mascotas`, `vacunas`, `desparasitaciones` y `citas`.

El script se puede ejecutar más de una vez. Borra las tablas y las vuelve a crear, así que no lo corras sobre una base con datos que quieras conservar.

## Cómo ejecutar la aplicación

Esta sección se completará cuando exista el código de la aplicación. Allí quedarán los requisitos (el SDK de .NET que se use), el comando para restaurar y arrancar el proyecto y la dirección local donde se abre.

## Variables de entorno

Los datos de conexión a la base no se suben al repositorio. Cuando la aplicación exista, se incluirá un archivo `.env.example` con esta forma, y cada persona crea su propio `.env` con sus valores:

```
DB_HOST=localhost
DB_PORT=3306
DB_NAME=petcare_digital
DB_USER=
DB_PASSWORD=
```

El archivo `.env` debe estar listado en `.gitignore` para que Git lo ignore.

## Ramas y commits

- `main`: la versión estable que se entrega.
- `dev`: la rama donde se integra el trabajo.
- `feature/nombre-de-la-funcion`: una rama por cada función, por ejemplo `feature/login` o `feature/mascotas`.

Los mensajes de commit son cortos y dicen qué cambió, por ejemplo: "Agrega el formulario de registro de mascotas".

## Autoría y seguimiento

- Aprendiz: Diana María Mancera Reinosa, ficha 30336034.
- Instructor técnico y de seguimiento: Ing. James Arles Ruiz Medina.
- Programa: Técnico en Programación de Software, SENA, Centro de Comercio y Servicios, Regional Cauca.
