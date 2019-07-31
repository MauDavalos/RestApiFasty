-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 31, 2019 at 06:03 PM
-- Server version: 5.7.19
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fasty`
--

-- --------------------------------------------------------

--
-- Table structure for table `contrato`
--

DROP TABLE IF EXISTS `contrato`;
CREATE TABLE IF NOT EXISTS `contrato` (
  `id_contrato` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion_contrato` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_inicio` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_fin` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_plan` int(11) NOT NULL,
  PRIMARY KEY (`id_contrato`),
  KEY `id_plan` (`id_plan`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `contrato`
--

INSERT INTO `contrato` (`id_contrato`, `descripcion_contrato`, `fecha_inicio`, `fecha_fin`, `id_usuario`, `id_plan`) VALUES
(1, 'Semestral', '01-01-2019', '01-06-2019', 1, 3),
(2, 'Anual', '01-01-2019', '01-01-2020', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `metodopago`
--

DROP TABLE IF EXISTS `metodopago`;
CREATE TABLE IF NOT EXISTS `metodopago` (
  `id_metodo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_metodo`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `metodopago`
--

INSERT INTO `metodopago` (`id_metodo`, `nombre`) VALUES
(1, 'paypal'),
(2, 'tarjeta');

-- --------------------------------------------------------

--
-- Table structure for table `pago`
--

DROP TABLE IF EXISTS `pago`;
CREATE TABLE IF NOT EXISTS `pago` (
  `id_pago` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_pago` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `monto_pago` float NOT NULL,
  `id_contrato` int(11) NOT NULL,
  `id_metodo` int(11) NOT NULL,
  PRIMARY KEY (`id_pago`),
  KEY `id_contrato` (`id_contrato`),
  KEY `id_metodo` (`id_metodo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `pago`
--

INSERT INTO `pago` (`id_pago`, `fecha_pago`, `monto_pago`, `id_contrato`, `id_metodo`) VALUES
(6, '21-10-2012', 200, 1, 1),
(7, '21-10-2012', 200, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `paypal`
--

DROP TABLE IF EXISTS `paypal`;
CREATE TABLE IF NOT EXISTS `paypal` (
  `id_paypal` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_paypal` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `clave_paypal` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_paypal`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `paypal`
--

INSERT INTO `paypal` (`id_paypal`, `usuario_paypal`, `clave_paypal`, `id_usuario`) VALUES
(1, 'davalos97', 'basketball23', 1),
(2, 'pacheco96', 'motocross10', 2);

-- --------------------------------------------------------

--
-- Table structure for table `plan`
--

DROP TABLE IF EXISTS `plan`;
CREATE TABLE IF NOT EXISTS `plan` (
  `id_plan` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_plan` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `tipo_plan` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `costo` float NOT NULL,
  `velocidad` float NOT NULL,
  PRIMARY KEY (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `plan`
--

INSERT INTO `plan` (`id_plan`, `nombre_plan`, `tipo_plan`, `costo`, `velocidad`) VALUES
(1, 'Plan Starter', 'Internet', 29.2, 50),
(2, 'Plan Gamer', 'Internet', 65, 100),
(3, 'Plan Xtreme', 'Internet', 99.99, 200);

-- --------------------------------------------------------

--
-- Table structure for table `tarjeta`
--

DROP TABLE IF EXISTS `tarjeta`;
CREATE TABLE IF NOT EXISTS `tarjeta` (
  `id_tarjeta` int(11) NOT NULL AUTO_INCREMENT,
  `numero_tarjeta` varchar(12) COLLATE utf8_spanish_ci NOT NULL,
  `cvv_tarjeta` varchar(3) COLLATE utf8_spanish_ci NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_tarjeta`),
  KEY `id_usuario` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `tarjeta`
--

INSERT INTO `tarjeta` (`id_tarjeta`, `numero_tarjeta`, `cvv_tarjeta`, `id_usuario`) VALUES
(1, '698852466810', '339', 1),
(2, '33652089456', '772', 2);

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `apellido_usuario` varchar(40) COLLATE utf8_spanish_ci NOT NULL,
  `nickname` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `img_url` varchar(255) COLLATE utf8_spanish_ci NOT NULL,
  `cedula` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `contrasena` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre_usuario`, `apellido_usuario`, `nickname`, `img_url`, `cedula`, `telefono`, `contrasena`) VALUES
(1, 'Mauricio', 'Dávalos', 'maudavalos', '', '1750428227', '0983344522', 'mau123'),
(2, 'Santiago', 'Pacheco', 'santipachi', '', '0758746339', '0984449507', 'pachi123');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contrato`
--
ALTER TABLE `contrato`
  ADD CONSTRAINT `contrato_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `contrato_ibfk_2` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `pago_ibfk_2` FOREIGN KEY (`id_contrato`) REFERENCES `contrato` (`id_contrato`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pago_ibfk_3` FOREIGN KEY (`id_metodo`) REFERENCES `metodopago` (`id_metodo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `paypal`
--
ALTER TABLE `paypal`
  ADD CONSTRAINT `paypal_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tarjeta`
--
ALTER TABLE `tarjeta`
  ADD CONSTRAINT `tarjeta_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
