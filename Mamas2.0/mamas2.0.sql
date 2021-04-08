/*
 Navicat Premium Data Transfer

 Source Server         : mamas
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : mamas2.0

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 09/04/2021 10:24:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for asignacionRol
-- ----------------------------
DROP TABLE IF EXISTS `asignacionRol`;
CREATE TABLE `asignacionRol` (
  `idUsuario` tinyint DEFAULT NULL,
  `idRol` tinyint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of asignacionRol
-- ----------------------------
BEGIN;
INSERT INTO `asignacionRol` VALUES (1, 1);
INSERT INTO `asignacionRol` VALUES (2, 2);
INSERT INTO `asignacionRol` VALUES (3, 2);
INSERT INTO `asignacionRol` VALUES (11, 2);
COMMIT;

-- ----------------------------
-- Table structure for examen
-- ----------------------------
DROP TABLE IF EXISTS `examen`;
CREATE TABLE `examen` (
  `id` tinyint NOT NULL AUTO_INCREMENT,
  `idProfesor` tinyint NOT NULL,
  `fechaInicio` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `fechaFin` timestamp NOT NULL ON UPDATE CURRENT_TIMESTAMP,
  `estado` tinyint NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `descripcion` varchar(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of examen
-- ----------------------------
BEGIN;
INSERT INTO `examen` VALUES (1, 1, '2020-12-01 10:04:16', '2020-12-01 10:04:16', 1, 'Examen de prueba 1', 'Este es el primer examen de prueba ');
INSERT INTO `examen` VALUES (2, 1, '2020-12-01 10:20:00', '2020-12-01 10:20:00', 0, 'Examen de prueba 2', 'Este es el segundo examen de prueba');
INSERT INTO `examen` VALUES (4, 1, '2021-04-14 13:35:00', '2021-04-14 13:35:00', 3, 'Examen de prueba 4', 'Este es el cuarto examen de prueba');
INSERT INTO `examen` VALUES (5, 1, '2021-04-08 14:00:29', '2021-04-08 14:00:29', 3, 'Examen de prueba 3', 'Este es el tercer examen de prueba');
COMMIT;

-- ----------------------------
-- Table structure for examenAlumno
-- ----------------------------
DROP TABLE IF EXISTS `examenAlumno`;
CREATE TABLE `examenAlumno` (
  `idExamen` tinyint NOT NULL,
  `idAlumno` tinyint NOT NULL,
  `nota` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of examenAlumno
-- ----------------------------
BEGIN;
INSERT INTO `examenAlumno` VALUES (5, 11, '3/5');
COMMIT;

-- ----------------------------
-- Table structure for pregunta
-- ----------------------------
DROP TABLE IF EXISTS `pregunta`;
CREATE TABLE `pregunta` (
  `idPregunta` int NOT NULL AUTO_INCREMENT,
  `idExamen` tinyint NOT NULL,
  `pregunta` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`idPregunta`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of pregunta
-- ----------------------------
BEGIN;
INSERT INTO `pregunta` VALUES (9, 5, 'Prueba de Texto');
INSERT INTO `pregunta` VALUES (10, 5, 'Cuanto es 2x2');
INSERT INTO `pregunta` VALUES (11, 5, 'Pregunta de una opcion, cuanto es 10+10');
INSERT INTO `pregunta` VALUES (12, 5, 'Pregunta de varias respuestas, Marcas alemanas de coches');
COMMIT;

-- ----------------------------
-- Table structure for respuestaAlumno
-- ----------------------------
DROP TABLE IF EXISTS `respuestaAlumno`;
CREATE TABLE `respuestaAlumno` (
  `idExamen` tinyint NOT NULL,
  `idAlumno` tinyint NOT NULL,
  `idPregunta` tinyint NOT NULL,
  `respuesta` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of respuestaAlumno
-- ----------------------------
BEGIN;
INSERT INTO `respuestaAlumno` VALUES (5, 11, 9, 'Alejandro');
INSERT INTO `respuestaAlumno` VALUES (5, 11, 10, '4');
INSERT INTO `respuestaAlumno` VALUES (5, 11, 11, '20');
INSERT INTO `respuestaAlumno` VALUES (5, 11, 12, 'BMW');
INSERT INTO `respuestaAlumno` VALUES (5, 11, 12, 'Audi');
COMMIT;

-- ----------------------------
-- Table structure for respuestaCorrecta
-- ----------------------------
DROP TABLE IF EXISTS `respuestaCorrecta`;
CREATE TABLE `respuestaCorrecta` (
  `idPregunta` int NOT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `respuesta1` varchar(2000) NOT NULL,
  `respuesta2` varchar(2000) DEFAULT NULL,
  `respuesta3` varchar(2000) DEFAULT NULL,
  `respuesta4` varchar(2000) DEFAULT NULL,
  `respuestaCorrecta` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of respuestaCorrecta
-- ----------------------------
BEGIN;
INSERT INTO `respuestaCorrecta` VALUES (9, 'Texto', 'Alejandro', '', '', '', 'Alejandro');
INSERT INTO `respuestaCorrecta` VALUES (10, 'Numerica', '4', '', '', '', '4');
INSERT INTO `respuestaCorrecta` VALUES (11, 'Una opcion', '10', '100', '20', '200', '20');
INSERT INTO `respuestaCorrecta` VALUES (12, 'Varias opciones', 'Alfa Romeo', 'BMW', 'Audi', 'Nissan', 'BMW###Audi###');
COMMIT;

-- ----------------------------
-- Table structure for rol
-- ----------------------------
DROP TABLE IF EXISTS `rol`;
CREATE TABLE `rol` (
  `idRol` tinyint DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of rol
-- ----------------------------
BEGIN;
INSERT INTO `rol` VALUES (1, 'Profesor');
INSERT INTO `rol` VALUES (2, 'Alumno');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `surname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `passwd` varchar(255) DEFAULT NULL,
  `status` tinyint DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES (1, 'Alejandro', 'Martín', 'alejandro.martin.perez.99@gmail.com', 'Chubaca2020', 1);
INSERT INTO `users` VALUES (2, 'Maki', 'Navaja', 'makina@gmail.com', 'Chubaca2020', 1);
INSERT INTO `users` VALUES (3, 'Armando', 'Guerra', 'armandoguerra@gmail.com', 'Chubaca2020', 0);
INSERT INTO `users` VALUES (11, 'Dimitri', 'Petrenko', 'dimitri@gmail.com', 'Chubaca2020', 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
