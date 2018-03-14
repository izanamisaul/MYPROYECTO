-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema izanami
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema izanami
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `izanami` DEFAULT CHARACTER SET utf8 ;
USE `izanami` ;

-- -----------------------------------------------------
-- Table `izanami`.`autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`autores` (
  `idAutor` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `ApellidoMater` VARCHAR(45) NULL DEFAULT NULL,
  `ApellidoPater` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`estado` (
  `idEstado` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`municipio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`municipio` (
  `idMunicipio` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Estado_idEstado` INT(11) NOT NULL,
  PRIMARY KEY (`idMunicipio`),
  INDEX `fk_Municipio_Estado1_idx` (`Estado_idEstado` ASC),
  CONSTRAINT `fk_Municipio_Estado1`
    FOREIGN KEY (`Estado_idEstado`)
    REFERENCES `izanami`.`estado` (`idEstado`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`clientes` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Teléfono` VARCHAR(45) NULL DEFAULT NULL,
  `Codigopostal` VARCHAR(45) NULL DEFAULT NULL,
  `Apellidopaterno` VARCHAR(45) NULL DEFAULT NULL,
  `Apellidomaterno` VARCHAR(30) NULL DEFAULT NULL,
  `Direccion` VARCHAR(45) NULL DEFAULT NULL,
  `colonia` VARCHAR(45) NULL DEFAULT NULL,
  `calle` VARCHAR(45) NULL DEFAULT NULL,
  `Municipio_idMunicipio` INT(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Clientes_Municipio1_idx` (`Municipio_idMunicipio` ASC),
  CONSTRAINT `fk_Clientes_Municipio1`
    FOREIGN KEY (`Municipio_idMunicipio`)
    REFERENCES `izanami`.`municipio` (`idMunicipio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`libros` (
  `idLibro` INT(11) NOT NULL AUTO_INCREMENT,
  `Nombre` TINYTEXT NULL DEFAULT NULL,
  `Año` VARCHAR(45) NULL DEFAULT NULL,
  `Editorial` TINYTEXT NULL DEFAULT NULL,
  `Lengua` VARCHAR(45) NULL DEFAULT NULL,
  `Encuadernación` VARCHAR(45) NULL DEFAULT NULL,
  `Disponibilidad` VARCHAR(45) NULL DEFAULT NULL,
  `Sinopsis` VARCHAR(45) NULL DEFAULT NULL,
  `paginas` VARCHAR(45) NULL DEFAULT NULL,
  `Genero` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`tarjetas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`tarjetas` (
  `idTargetas` INT(11) NOT NULL AUTO_INCREMENT,
  `Numtargeta` VARCHAR(20) NULL DEFAULT NULL,
  `Titular` TINYTEXT NULL DEFAULT NULL,
  `Fechadecaducidad` VARCHAR(45) NULL DEFAULT NULL,
  `CodigoCVV` INT(11) NOT NULL,
  PRIMARY KEY (`idTargetas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`ventas` (
  `idVenta` INT(11) NOT NULL AUTO_INCREMENT,
  `Ndeproductos` INT(11) NOT NULL,
  `Enviopaqueteria` VARCHAR(45) NULL DEFAULT NULL,
  `Clientes_idCliente` INT(11) NOT NULL,
  `idTarjetas` INT(11) NOT NULL,
  PRIMARY KEY (`idVenta`),
  INDEX `fk_Ventas_Clientes_idx` (`Clientes_idCliente` ASC),
  INDEX `fk_Ventas_Targetas1_idx` (`idTarjetas` ASC),
  CONSTRAINT `fk_Ventas_Clientes`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `izanami`.`clientes` (`idCliente`),
  CONSTRAINT `fk_Ventas_Targetas1`
    FOREIGN KEY (`idTarjetas`)
    REFERENCES `izanami`.`tarjetas` (`idTargetas`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`detalles_de_ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`detalles_de_ventas` (
  `idDetalles_de_venta` INT(11) NOT NULL AUTO_INCREMENT,
  `Ordcantidad` VARCHAR(20) NULL DEFAULT NULL,
  `Libros_idLibro` INT(11) NOT NULL,
  `Ventas_idVenta` INT(11) NOT NULL,
  PRIMARY KEY (`idDetalles_de_venta`),
  INDEX `fk_Orden_producto_Libros1_idx` (`Libros_idLibro` ASC),
  INDEX `fk_Orden_producto_Ventas1_idx` (`Ventas_idVenta` ASC),
  CONSTRAINT `fk_Orden_producto_Libros1`
    FOREIGN KEY (`Libros_idLibro`)
    REFERENCES `izanami`.`libros` (`idLibro`),
  CONSTRAINT `fk_Orden_producto_Ventas1`
    FOREIGN KEY (`Ventas_idVenta`)
    REFERENCES `izanami`.`ventas` (`idVenta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `izanami`.`libros_autores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `izanami`.`libros_autores` (
  `idlibros_autores` INT(11) NOT NULL AUTO_INCREMENT,
  `Libros_idLibro` INT(11) NOT NULL,
  `Autores_idAutor` INT(11) NOT NULL,
  PRIMARY KEY (`idlibros_autores`),
  INDEX `fk_libros_autores_Libros1_idx` (`Libros_idLibro` ASC),
  INDEX `fk_libros_autores_Autores1_idx` (`Autores_idAutor` ASC),
  CONSTRAINT `fk_libros_autores_Autores1`
    FOREIGN KEY (`Autores_idAutor`)
    REFERENCES `izanami`.`autores` (`idAutor`),
  CONSTRAINT `fk_libros_autores_Libros1`
    FOREIGN KEY (`Libros_idLibro`)
    REFERENCES `izanami`.`libros` (`idLibro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
