-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sitiorecetas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sitiorecetas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sitiorecetas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sitiorecetas` ;

-- -----------------------------------------------------
-- Table `sitiorecetas`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(16) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `fecha_registro` DATE NOT NULL,
  `contraseña` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`region` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre` (`nombre` ASC) VISIBLE,
  UNIQUE INDEX `region_nombre_unique` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`tipo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`complejidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`complejidad` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nivel` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nivel` (`nivel` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`tiempo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`tiempo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rango` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `rango` (`rango` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`estatus_reporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`estatus_reporte` (
  `id` TINYINT NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`recetas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(25) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `usuario_id` INT NOT NULL,
  `ingredientes` TEXT NOT NULL,
  `instrucciones` TEXT NOT NULL,
  `región_nombre` VARCHAR(25) NULL DEFAULT NULL,
  `tipo_nombre` VARCHAR(25) NULL DEFAULT NULL,
  `complejidad_nivel` VARCHAR(25) NULL DEFAULT NULL,
  `tiempo_duración` VARCHAR(25) NULL DEFAULT NULL,
  `fecha_creacion` DATETIME NOT NULL,
  `imagen_portada` VARCHAR(100) NOT NULL,
  `visitas` INT NOT NULL DEFAULT '0',
  `estatus` TINYINT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `tipo_nombre` (`tipo_nombre` ASC) VISIBLE,
  INDEX `complejidad_nivel` (`complejidad_nivel` ASC) VISIBLE,
  INDEX `tiempo_duración` (`tiempo_duración` ASC) VISIBLE,
  INDEX `recetas_ibfk_2` (`región_nombre` ASC) VISIBLE,
  INDEX `usuario_id` (`usuario_id` ASC) VISIBLE,
  INDEX `recetas_ibfk_7_idx` (`estatus` ASC) VISIBLE,
  CONSTRAINT `recetas_ibfk_2`
    FOREIGN KEY (`región_nombre`)
    REFERENCES `sitiorecetas`.`region` (`nombre`),
  CONSTRAINT `recetas_ibfk_3`
    FOREIGN KEY (`tipo_nombre`)
    REFERENCES `sitiorecetas`.`tipo` (`nombre`),
  CONSTRAINT `recetas_ibfk_4`
    FOREIGN KEY (`complejidad_nivel`)
    REFERENCES `sitiorecetas`.`complejidad` (`nivel`),
  CONSTRAINT `recetas_ibfk_5`
    FOREIGN KEY (`tiempo_duración`)
    REFERENCES `sitiorecetas`.`tiempo` (`rango`),
  CONSTRAINT `recetas_ibfk_6`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sitiorecetas`.`usuarios` (`id`),
  CONSTRAINT `recetas_ibfk_7`
    FOREIGN KEY (`estatus`)
    REFERENCES `sitiorecetas`.`estatus_reporte` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`comentarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contenido` TEXT NOT NULL,
  `usuario_id` INT NOT NULL,
  `receta_id` INT NOT NULL,
  `fecha_comentario` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `usuario_id` (`usuario_id` ASC) VISIBLE,
  INDEX `receta_id` (`receta_id` ASC) VISIBLE,
  CONSTRAINT `comentarios_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sitiorecetas`.`usuarios` (`id`),
  CONSTRAINT `comentarios_ibfk_2`
    FOREIGN KEY (`receta_id`)
    REFERENCES `sitiorecetas`.`recetas` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`permisos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`recetas_favoritas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`recetas_favoritas` (
  `usuario_id` INT NOT NULL,
  `receta_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `receta_id`),
  INDEX `recetas_favoritas_ibfk_2` (`receta_id` ASC) VISIBLE,
  CONSTRAINT `recetas_favoritas_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sitiorecetas`.`usuarios` (`id`),
  CONSTRAINT `recetas_favoritas_ibfk_2`
    FOREIGN KEY (`receta_id`)
    REFERENCES `sitiorecetas`.`recetas` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`recetas_guardadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`recetas_guardadas` (
  `usuario_id` INT NOT NULL,
  `receta_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `receta_id`),
  INDEX `recetas_guardadas_ibfk_2` (`receta_id` ASC) VISIBLE,
  CONSTRAINT `recetas_guardadas_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sitiorecetas`.`usuarios` (`id`),
  CONSTRAINT `recetas_guardadas_ibfk_2`
    FOREIGN KEY (`receta_id`)
    REFERENCES `sitiorecetas`.`recetas` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`reportes_comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`reportes_comentarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentario_id` INT NOT NULL,
  `motivo` TEXT NOT NULL,
  `fecha_reporte` DATE NOT NULL,
  `estatus` TINYINT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `reportes_comentarios_ibfk_1` (`comentario_id` ASC) VISIBLE,
  INDEX `estatus` (`estatus` ASC) VISIBLE,
  CONSTRAINT `reportes_comentarios_ibfk_1`
    FOREIGN KEY (`comentario_id`)
    REFERENCES `sitiorecetas`.`comentarios` (`id`),
  CONSTRAINT `reportes_comentarios_ibfk_3`
    FOREIGN KEY (`estatus`)
    REFERENCES `sitiorecetas`.`estatus_reporte` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`reportes_recetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`reportes_recetas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `receta_id` INT NOT NULL,
  `motivo` TEXT NOT NULL,
  `fecha_reporte` DATE NOT NULL,
  `estatus` TINYINT NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `reportes_recetas_ibfk_1` (`receta_id` ASC) VISIBLE,
  INDEX `estatus` (`estatus` ASC) VISIBLE,
  CONSTRAINT `reportes_recetas_ibfk_1`
    FOREIGN KEY (`receta_id`)
    REFERENCES `sitiorecetas`.`recetas` (`id`),
  CONSTRAINT `reportes_recetas_ibfk_2`
    FOREIGN KEY (`estatus`)
    REFERENCES `sitiorecetas`.`estatus_reporte` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`roles_permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`roles_permisos` (
  `rol_id` INT NOT NULL,
  `permiso_id` INT NOT NULL,
  PRIMARY KEY (`rol_id`, `permiso_id`),
  INDEX `permiso_id` (`permiso_id` ASC) VISIBLE,
  CONSTRAINT `roles_permisos_ibfk_1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `sitiorecetas`.`rol` (`id`),
  CONSTRAINT `roles_permisos_ibfk_2`
    FOREIGN KEY (`permiso_id`)
    REFERENCES `sitiorecetas`.`permisos` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`usuarios_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`usuarios_roles` (
  `usuario_id` INT NOT NULL,
  `rol_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `rol_id`),
  INDEX `rol_id` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `usuarios_roles_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sitiorecetas`.`usuarios` (`id`),
  CONSTRAINT `usuarios_roles_ibfk_2`
    FOREIGN KEY (`rol_id`)
    REFERENCES `sitiorecetas`.`rol` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sitiorecetas`.`valoraciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sitiorecetas`.`valoraciones` (
  `puntuacion` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  `receta_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `receta_id`),
  INDEX `receta_id` (`receta_id` ASC) VISIBLE,
  CONSTRAINT `valoraciones_ibfk_1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `sitiorecetas`.`usuarios` (`id`),
  CONSTRAINT `valoraciones_ibfk_2`
    FOREIGN KEY (`receta_id`)
    REFERENCES `sitiorecetas`.`recetas` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
