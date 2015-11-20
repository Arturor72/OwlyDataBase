SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Universidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Universidad` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Universidad` (
  `uniId` INT NOT NULL AUTO_INCREMENT ,
  `uniCod` VARCHAR(16) NULL ,
  `uniDes` TEXT NOT NULL ,
  PRIMARY KEY (`uniId`) ,
  UNIQUE INDEX `uniCod_UNIQUE` (`uniCod` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Especialidad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Especialidad` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Especialidad` (
  `espId` INT NOT NULL AUTO_INCREMENT ,
  `espCod` VARCHAR(16) NULL ,
  `espDen` VARCHAR(100) NOT NULL ,
  `uniId` INT NOT NULL ,
  PRIMARY KEY (`espId`) ,
  UNIQUE INDEX `espCod_UNIQUE` (`espCod` ASC) ,
  INDEX `fk_Especialidad_Universidad1_idx` (`uniId` ASC) ,
  CONSTRAINT `fk_Especialidad_Universidad1`
    FOREIGN KEY (`uniId` )
    REFERENCES `mydb`.`Universidad` (`uniId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alumno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Alumno` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Alumno` (
  `aluId` INT NOT NULL AUTO_INCREMENT ,
  `aluCod` VARCHAR(16) NULL ,
  `aluApePat` VARCHAR(50) NOT NULL ,
  `aluApeMat` VARCHAR(50) NOT NULL ,
  `aluNom` VARCHAR(100) NOT NULL ,
  `aluEda` INT NULL ,
  `aluDni` VARCHAR(8) NULL ,
  `aluUsu` VARCHAR(45) NOT NULL ,
  `aluPas` VARCHAR(20) NOT NULL ,
  `aluEma` VARCHAR(100) NULL ,
  `espId` INT NOT NULL ,
  PRIMARY KEY (`aluId`) ,
  UNIQUE INDEX `codAlum_UNIQUE` (`aluCod` ASC) ,
  INDEX `fk_Alumno_Especialidad_idx` (`espId` ASC) ,
  CONSTRAINT `fk_Alumno_Especialidad`
    FOREIGN KEY (`espId` )
    REFERENCES `mydb`.`Especialidad` (`espId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstadoEjercicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EstadoEjercicio` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EstadoEjercicio` (
  `estEjeId` INT NOT NULL AUTO_INCREMENT ,
  `estEjeDes` VARCHAR(100) NULL ,
  PRIMARY KEY (`estEjeId`) ,
  UNIQUE INDEX `estEjeDes_UNIQUE` (`estEjeDes` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`NivelUrgencia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`NivelUrgencia` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`NivelUrgencia` (
  `nivUrgId` INT NOT NULL AUTO_INCREMENT ,
  `nivUrgDes` VARCHAR(50) NULL ,
  PRIMARY KEY (`nivUrgId`) ,
  UNIQUE INDEX `nivUrgDes_UNIQUE` (`nivUrgDes` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Nivel` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Nivel` (
  `nivId` INT NOT NULL AUTO_INCREMENT ,
  `nivCod` VARCHAR(50) NOT NULL ,
  `nivDes` TEXT NULL ,
  PRIMARY KEY (`nivId`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tutor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tutor` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Tutor` (
  `tutId` INT NOT NULL AUTO_INCREMENT ,
  `tutCod` VARCHAR(16) NULL ,
  `tutApePat` VARCHAR(50) NOT NULL ,
  `tutApeMat` VARCHAR(50) NOT NULL ,
  `tutNom` VARCHAR(100) NOT NULL ,
  `tutEda` INT NULL ,
  `tutDni` VARCHAR(8) NULL ,
  `tutUsu` VARCHAR(45) NOT NULL ,
  `tutPas` VARCHAR(20) NOT NULL ,
  `tutPuntos` INT NULL ,
  `nivId` INT NOT NULL ,
  PRIMARY KEY (`tutId`) ,
  UNIQUE INDEX `codAlum_UNIQUE` (`tutCod` ASC) ,
  INDEX `fk_Tutor_Nivel1_idx` (`nivId` ASC) ,
  CONSTRAINT `fk_Tutor_Nivel1`
    FOREIGN KEY (`nivId` )
    REFERENCES `mydb`.`Nivel` (`nivId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`SolucionImg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`SolucionImg` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`SolucionImg` (
  `solImgId` INT NOT NULL AUTO_INCREMENT ,
  `solImgDes` TEXT NULL ,
  `solImgPat` VARCHAR(45) NULL ,
  `solImgPun` INT NOT NULL ,
  `solImgHor` TIME NULL ,
  `solImgFec` DATE NULL ,
  `solImgPre` DOUBLE NOT NULL ,
  `tutId` INT NOT NULL ,
  PRIMARY KEY (`solImgId`, `tutId`) ,
  INDEX `fk_SolucionImg_Tutor1_idx` (`tutId` ASC) ,
  CONSTRAINT `fk_SolucionImg_Tutor1`
    FOREIGN KEY (`tutId` )
    REFERENCES `mydb`.`Tutor` (`tutId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ejercicio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ejercicio` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Ejercicio` (
  `ejeId` INT NOT NULL AUTO_INCREMENT ,
  `ejeDes` TEXT NULL ,
  `ejePat` TEXT NULL ,
  `ejeHor` TIME NULL ,
  `ejeFec` DATE NULL ,
  `ejeReq` TEXT NULL ,
  `estEjeId` INT NOT NULL ,
  `nivUrgId` INT NOT NULL ,
  `aluId` INT NOT NULL ,
  `solImgId` INT NOT NULL ,
  `tutId` INT NOT NULL ,
  PRIMARY KEY (`ejeId`, `solImgId`, `tutId`) ,
  INDEX `fk_Ejercicio_EstadoEjercicio1_idx` (`estEjeId` ASC) ,
  INDEX `fk_Ejercicio_NivelUrgencia1_idx` (`nivUrgId` ASC) ,
  INDEX `fk_Ejercicio_Alumno1_idx` (`aluId` ASC) ,
  INDEX `fk_Ejercicio_SolucionImg1_idx` (`solImgId` ASC, `tutId` ASC) ,
  CONSTRAINT `fk_Ejercicio_EstadoEjercicio1`
    FOREIGN KEY (`estEjeId` )
    REFERENCES `mydb`.`EstadoEjercicio` (`estEjeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ejercicio_NivelUrgencia1`
    FOREIGN KEY (`nivUrgId` )
    REFERENCES `mydb`.`NivelUrgencia` (`nivUrgId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ejercicio_Alumno1`
    FOREIGN KEY (`aluId` )
    REFERENCES `mydb`.`Alumno` (`aluId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ejercicio_SolucionImg1`
    FOREIGN KEY (`solImgId` , `tutId` )
    REFERENCES `mydb`.`SolucionImg` (`solImgId` , `tutId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Curso` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Curso` (
  `curId` INT NOT NULL AUTO_INCREMENT ,
  `curCod` VARCHAR(16) NOT NULL ,
  `curDes` TEXT NOT NULL ,
  PRIMARY KEY (`curId`) ,
  UNIQUE INDEX `curCod_UNIQUE` (`curCod` ASC) )
 
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tema` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Tema` (
  `temId` INT NOT NULL AUTO_INCREMENT ,
  `temCod` VARCHAR(16) NULL ,
  `temDes` TEXT NULL ,
  `curId` INT NOT NULL ,
  PRIMARY KEY (`temId`) ,
  UNIQUE INDEX `temCod_UNIQUE` (`temCod` ASC),
   INDEX `fk_Tema_Curso1_idx` (`curId` ASC) ,
  CONSTRAINT `fk_Tema_Curso1`
    FOREIGN KEY (`curId` )
    REFERENCES `mydb`.`Curso` (`curId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EjercicioTema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EjercicioTema` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EjercicioTema` (
  `Ejercicio_ejeId` INT NOT NULL ,
  `Tema_temId` INT NOT NULL ,
  PRIMARY KEY (`Ejercicio_ejeId`, `Tema_temId`) ,
  INDEX `fk_Ejercicio_has_Tema_Tema1_idx` (`Tema_temId` ASC) ,
  INDEX `fk_Ejercicio_has_Tema_Ejercicio1_idx` (`Ejercicio_ejeId` ASC) ,
  CONSTRAINT `fk_Ejercicio_has_Tema_Ejercicio1`
    FOREIGN KEY (`Ejercicio_ejeId` )
    REFERENCES `mydb`.`Ejercicio` (`ejeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ejercicio_has_Tema_Tema1`
    FOREIGN KEY (`Tema_temId` )
    REFERENCES `mydb`.`Tema` (`temId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




-- -----------------------------------------------------
-- Table `mydb`.`Postulacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Postulacion` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Postulacion` (
  `ejeId` INT NOT NULL ,
  `tutId` INT NOT NULL ,
  `posPre` DOUBLE NOT NULL ,
  `posHor` TIME NULL ,
  `posFec` DATE NULL ,
  PRIMARY KEY (`ejeId`, `tutId`) ,
  INDEX `fk_Ejercicio_has_Tutor_Tutor1_idx` (`tutId` ASC) ,
  INDEX `fk_Ejercicio_has_Tutor_Ejercicio1_idx` (`ejeId` ASC) ,
  CONSTRAINT `fk_Ejercicio_has_Tutor_Ejercicio1`
    FOREIGN KEY (`ejeId` )
    REFERENCES `mydb`.`Ejercicio` (`ejeId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ejercicio_has_Tutor_Tutor1`
    FOREIGN KEY (`tutId` )
    REFERENCES `mydb`.`Tutor` (`tutId` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
