-- PetCare Digital
-- Script inicial de la base de datos (MySQL 8.0.16 o superior)
-- Autora: Diana María Mancera Reinosa
-- Para ejecutarlo: importar este archivo en phpMyAdmin o MySQL Workbench.

CREATE DATABASE IF NOT EXISTS petcare_digital
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE petcare_digital;

-- Se borran en orden inverso para poder volver a correr el script sin errores.
DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS desparasitaciones;
DROP TABLE IF EXISTS vacunas;
DROP TABLE IF EXISTS mascotas;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS roles;

-- 1. Roles del sistema (HU11)
CREATE TABLE roles (
  id_rol  TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre  VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_rol),
  UNIQUE KEY uq_roles_nombre (nombre)
) ENGINE=InnoDB;

-- 2. Usuarios (HU1, HU2, HU3, HU11)
-- La contraseña nunca se guarda en claro, solo su hash.
CREATE TABLE usuarios (
  id_usuario      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  nombre          VARCHAR(80)  NOT NULL,
  correo          VARCHAR(120) NOT NULL,
  contrasena_hash VARCHAR(255) NOT NULL,
  id_rol          TINYINT UNSIGNED NOT NULL DEFAULT 2,
  activo          TINYINT(1)   NOT NULL DEFAULT 1,
  fecha_registro  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_usuario),
  UNIQUE KEY uq_usuarios_correo (correo),
  KEY idx_usuarios_rol (id_rol),
  CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES roles (id_rol)
) ENGINE=InnoDB;

-- 3. Mascotas (HU4, HU5)
-- Si se borra un usuario, se borran también sus mascotas.
-- Que la fecha de nacimiento no sea futura se valida en la aplicación,
-- porque MySQL no permite usar la fecha de hoy dentro de un CHECK.
CREATE TABLE mascotas (
  id_mascota       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_usuario       INT UNSIGNED NOT NULL,
  nombre           VARCHAR(60)  NOT NULL,
  especie          ENUM('perro','gato') NOT NULL,
  raza             VARCHAR(60)  NULL,
  sexo             ENUM('macho','hembra') NOT NULL,
  fecha_nacimiento DATE NULL,
  PRIMARY KEY (id_mascota),
  KEY idx_mascotas_usuario (id_usuario),
  CONSTRAINT fk_mascotas_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuarios (id_usuario) ON DELETE CASCADE
) ENGINE=InnoDB;

-- 4. Vacunas (HU6, HU8)
CREATE TABLE vacunas (
  id_vacuna        INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_mascota       INT UNSIGNED NOT NULL,
  nombre           VARCHAR(80)  NOT NULL,
  fecha_aplicacion DATE NOT NULL,
  fecha_proxima    DATE NULL,
  observaciones    TEXT NULL,
  PRIMARY KEY (id_vacuna),
  KEY idx_vacunas_mascota_proxima (id_mascota, fecha_proxima),
  CONSTRAINT fk_vacunas_mascota FOREIGN KEY (id_mascota)
    REFERENCES mascotas (id_mascota) ON DELETE CASCADE,
  CONSTRAINT ck_vacunas_fechas
    CHECK (fecha_proxima IS NULL OR fecha_proxima >= fecha_aplicacion)
) ENGINE=InnoDB;

-- 5. Desparasitaciones (HU7, HU8)
CREATE TABLE desparasitaciones (
  id_desparasitacion INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_mascota         INT UNSIGNED NOT NULL,
  tipo               ENUM('interna','externa') NOT NULL,
  producto           VARCHAR(80) NOT NULL,
  fecha_aplicacion   DATE NOT NULL,
  fecha_proxima      DATE NULL,
  PRIMARY KEY (id_desparasitacion),
  KEY idx_despar_mascota_proxima (id_mascota, fecha_proxima),
  CONSTRAINT fk_despar_mascota FOREIGN KEY (id_mascota)
    REFERENCES mascotas (id_mascota) ON DELETE CASCADE,
  CONSTRAINT ck_despar_fechas
    CHECK (fecha_proxima IS NULL OR fecha_proxima >= fecha_aplicacion)
) ENGINE=InnoDB;

-- 6. Citas veterinarias (HU9, HU10)
-- Que la cita sea en una fecha futura al crearla se valida en la aplicación.
CREATE TABLE citas (
  id_cita     INT UNSIGNED NOT NULL AUTO_INCREMENT,
  id_mascota  INT UNSIGNED NOT NULL,
  motivo      VARCHAR(120) NOT NULL,
  lugar       VARCHAR(120) NULL,
  fecha_hora  DATETIME NOT NULL,
  estado      ENUM('programada','realizada','cancelada') NOT NULL DEFAULT 'programada',
  PRIMARY KEY (id_cita),
  KEY idx_citas_mascota_fecha (id_mascota, fecha_hora),
  KEY idx_citas_estado (estado),
  CONSTRAINT fk_citas_mascota FOREIGN KEY (id_mascota)
    REFERENCES mascotas (id_mascota) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Datos iniciales: los dos roles del sistema
INSERT INTO roles (id_rol, nombre) VALUES
  (1, 'administrador'),
  (2, 'usuario');
