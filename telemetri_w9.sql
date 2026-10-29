-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 29, 2026 at 05:25 PM
-- Server version: 13.0.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `telemetri_w9`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ubah_status_node` (IN `p_id_node` INT, IN `p_status` VARCHAR(10))   BEGIN
    IF p_status NOT IN ('aktif', 'nonaktif', 'perawatan') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Gagal: Status node tidak valid! Pilih "aktif", "nonaktif", atau "perawatan".';
    ELSE
        UPDATE Node_Sensor 
        SET status = p_status 
        WHERE id_node = p_id_node;
        
        SELECT CONCAT('Status node ID ', p_id_node, ' berhasil diubah menjadi "', p_status, '".') AS pesan;
    END IF;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `jumlah_node_aktif` (`p_id_gateway` INT) RETURNS INT(11) READS SQL DATA BEGIN
    DECLARE v_jumlah INT;
    
    SELECT COUNT(*) INTO v_jumlah
    FROM Node_Sensor
    WHERE id_gateway = p_id_gateway AND status = 'aktif';
    
    RETURN IFNULL(v_jumlah, 0);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Gateway`
--

CREATE TABLE `Gateway` (
  `id_gateway` int(11) NOT NULL,
  `nama_gateway` varchar(50) NOT NULL,
  `lokasi` varchar(80) DEFAULT NULL,
  `ip_address` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Gateway`
--

INSERT INTO `Gateway` (`id_gateway`, `nama_gateway`, `lokasi`, `ip_address`) VALUES
(1, 'GW-Greenhouse', 'Greenhouse Riset', '10.20.1.10'),
(2, 'GW-Lab', 'Lab Komputer', '10.20.2.10');

-- --------------------------------------------------------

--
-- Table structure for table `Log_Perubahan_Status`
--

CREATE TABLE `Log_Perubahan_Status` (
  `id` int(11) NOT NULL,
  `id_node` int(11) DEFAULT NULL,
  `status_lama` varchar(10) DEFAULT NULL,
  `status_baru` varchar(10) DEFAULT NULL,
  `waktu_ubah` datetime DEFAULT NULL,
  `diubah_oleh` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Log_Telemetri`
--

CREATE TABLE `Log_Telemetri` (
  `id_log` bigint(20) NOT NULL,
  `id_node` int(11) NOT NULL,
  `waktu_baca` datetime NOT NULL DEFAULT current_timestamp(),
  `nilai` decimal(8,2) NOT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Log_Telemetri`
--

INSERT INTO `Log_Telemetri` (`id_log`, `id_node`, `waktu_baca`, `nilai`, `satuan`, `status`) VALUES
(1, 1, '2026-08-01 00:00:00', 26.00, '°C', 'anomali'),
(2, 2, '2026-08-01 00:00:00', 70.00, '%', 'normal'),
(3, 3, '2026-08-01 00:00:00', 27.00, '°C', 'normal'),
(4, 4, '2026-08-01 00:00:00', 27.50, '°C', 'normal'),
(5, 1, '2026-08-01 01:00:00', 27.03, '°C', 'normal'),
(6, 2, '2026-08-01 01:00:00', 73.88, '%', 'normal'),
(7, 3, '2026-08-01 01:00:00', 28.03, '°C', 'normal'),
(8, 4, '2026-08-01 01:00:00', 28.53, '°C', 'normal'),
(9, 1, '2026-08-01 02:00:00', 28.00, '°C', 'normal'),
(10, 2, '2026-08-01 02:00:00', 77.50, '%', 'normal'),
(11, 3, '2026-08-01 02:00:00', 29.00, '°C', 'normal'),
(12, 4, '2026-08-01 02:00:00', 29.50, '°C', 'normal'),
(13, 1, '2026-08-01 03:00:00', 28.83, '°C', 'normal'),
(14, 2, '2026-08-01 03:00:00', 80.60, '%', 'normal'),
(15, 3, '2026-08-01 03:00:00', 29.83, '°C', 'normal'),
(16, 4, '2026-08-01 03:00:00', 30.33, '°C', 'normal'),
(17, 1, '2026-08-01 04:00:00', 29.46, '°C', 'normal'),
(18, 2, '2026-08-01 04:00:00', 82.99, '%', 'normal'),
(19, 3, '2026-08-01 04:00:00', 30.46, '°C', 'normal'),
(20, 4, '2026-08-01 04:00:00', 30.96, '°C', 'normal'),
(21, 1, '2026-08-01 05:00:00', 29.86, '°C', 'normal'),
(22, 2, '2026-08-01 05:00:00', 84.49, '%', 'normal'),
(23, 3, '2026-08-01 05:00:00', 30.86, '°C', 'normal'),
(24, 4, '2026-08-01 05:00:00', 31.36, '°C', 'normal'),
(25, 1, '2026-08-01 06:00:00', 30.00, '°C', 'normal'),
(26, 2, '2026-08-01 06:00:00', 85.00, '%', 'normal'),
(27, 3, '2026-08-01 06:00:00', 31.00, '°C', 'normal'),
(28, 4, '2026-08-01 06:00:00', 31.50, '°C', 'normal'),
(29, 1, '2026-08-01 07:00:00', 29.86, '°C', 'normal'),
(30, 2, '2026-08-01 07:00:00', 84.49, '%', 'normal'),
(31, 3, '2026-08-01 07:00:00', 30.86, '°C', 'normal'),
(32, 4, '2026-08-01 07:00:00', 31.36, '°C', 'normal'),
(33, 1, '2026-08-01 08:00:00', 29.47, '°C', 'normal'),
(34, 2, '2026-08-01 08:00:00', 83.00, '%', 'normal'),
(35, 3, '2026-08-01 08:00:00', 30.47, '°C', 'normal'),
(36, 4, '2026-08-01 08:00:00', 30.97, '°C', 'normal'),
(37, 1, '2026-08-01 09:00:00', 28.83, '°C', 'normal'),
(38, 2, '2026-08-01 09:00:00', 80.62, '%', 'normal'),
(39, 3, '2026-08-01 09:00:00', 29.83, '°C', 'normal'),
(40, 4, '2026-08-01 09:00:00', 30.33, '°C', 'normal'),
(41, 1, '2026-08-01 10:00:00', 28.00, '°C', 'normal'),
(42, 2, '2026-08-01 10:00:00', 77.52, '%', 'normal'),
(43, 3, '2026-08-01 10:00:00', 29.00, '°C', 'normal'),
(44, 4, '2026-08-01 10:00:00', 29.50, '°C', 'normal'),
(45, 1, '2026-08-01 11:00:00', 27.04, '°C', 'normal'),
(46, 2, '2026-08-01 11:00:00', 73.90, '%', 'normal'),
(47, 3, '2026-08-01 11:00:00', 28.04, '°C', 'normal'),
(48, 4, '2026-08-01 11:00:00', 28.54, '°C', 'normal'),
(49, 1, '2026-08-01 12:00:00', 26.01, '°C', 'normal'),
(50, 2, '2026-08-01 12:00:00', 70.02, '%', 'normal'),
(51, 3, '2026-08-01 12:00:00', 27.01, '°C', 'normal'),
(52, 4, '2026-08-01 12:00:00', 27.51, '°C', 'normal'),
(53, 1, '2026-08-01 13:00:00', 24.97, '°C', 'normal'),
(54, 2, '2026-08-01 13:00:00', 66.14, '%', 'normal'),
(55, 3, '2026-08-01 13:00:00', 25.97, '°C', 'normal'),
(56, 4, '2026-08-01 13:00:00', 26.47, '°C', 'normal'),
(57, 1, '2026-08-01 14:00:00', 24.01, '°C', 'normal'),
(58, 2, '2026-08-01 14:00:00', 62.52, '%', 'normal'),
(59, 3, '2026-08-01 14:00:00', 25.01, '°C', 'normal'),
(60, 4, '2026-08-01 14:00:00', 25.51, '°C', 'normal'),
(61, 1, '2026-08-01 15:00:00', 23.18, '°C', 'normal'),
(62, 2, '2026-08-01 15:00:00', 59.41, '%', 'normal'),
(63, 3, '2026-08-01 15:00:00', 24.18, '°C', 'normal'),
(64, 4, '2026-08-01 15:00:00', 24.68, '°C', 'normal'),
(65, 1, '2026-08-01 16:00:00', 22.54, '°C', 'normal'),
(66, 2, '2026-08-01 16:00:00', 57.03, '%', 'normal'),
(67, 3, '2026-08-01 16:00:00', 23.54, '°C', 'normal'),
(68, 4, '2026-08-01 16:00:00', 24.04, '°C', 'normal'),
(69, 1, '2026-08-01 17:00:00', 22.14, '°C', 'normal'),
(70, 2, '2026-08-01 17:00:00', 55.52, '%', 'normal'),
(71, 3, '2026-08-01 17:00:00', 23.14, '°C', 'normal'),
(72, 4, '2026-08-01 17:00:00', 23.64, '°C', 'normal'),
(73, 1, '2026-08-01 18:00:00', 22.00, '°C', 'normal'),
(74, 2, '2026-08-01 18:00:00', 55.00, '%', 'normal'),
(75, 3, '2026-08-01 18:00:00', 23.00, '°C', 'normal'),
(76, 4, '2026-08-01 18:00:00', 23.50, '°C', 'normal'),
(77, 1, '2026-08-01 19:00:00', 22.13, '°C', 'normal'),
(78, 2, '2026-08-01 19:00:00', 55.50, '%', 'normal'),
(79, 3, '2026-08-01 19:00:00', 23.13, '°C', 'normal'),
(80, 4, '2026-08-01 19:00:00', 23.63, '°C', 'normal'),
(81, 1, '2026-08-01 20:00:00', 22.53, '°C', 'normal'),
(82, 2, '2026-08-01 20:00:00', 56.99, '%', 'normal'),
(83, 3, '2026-08-01 20:00:00', 23.53, '°C', 'normal'),
(84, 4, '2026-08-01 20:00:00', 24.03, '°C', 'normal'),
(85, 1, '2026-08-01 21:00:00', 23.16, '°C', 'normal'),
(86, 2, '2026-08-01 21:00:00', 59.36, '%', 'normal'),
(87, 3, '2026-08-01 21:00:00', 24.16, '°C', 'normal'),
(88, 4, '2026-08-01 21:00:00', 24.66, '°C', 'normal'),
(89, 1, '2026-08-01 22:00:00', 23.99, '°C', 'normal'),
(90, 2, '2026-08-01 22:00:00', 62.46, '%', 'normal'),
(91, 3, '2026-08-01 22:00:00', 24.99, '°C', 'normal'),
(92, 4, '2026-08-01 22:00:00', 25.49, '°C', 'normal'),
(93, 1, '2026-08-01 23:00:00', 24.95, '°C', 'normal'),
(94, 2, '2026-08-01 23:00:00', 66.07, '%', 'normal'),
(95, 3, '2026-08-01 23:00:00', 25.95, '°C', 'normal'),
(96, 4, '2026-08-01 23:00:00', 26.45, '°C', 'normal'),
(97, 1, '2026-08-02 00:00:00', 26.00, '°C', 'normal'),
(98, 2, '2026-08-02 00:00:00', 70.00, '%', 'normal'),
(99, 3, '2026-08-02 00:00:00', 27.00, '°C', 'normal'),
(100, 4, '2026-08-02 00:00:00', 27.50, '°C', 'normal'),
(101, 1, '2026-08-02 01:00:00', 27.03, '°C', 'normal'),
(102, 2, '2026-08-02 01:00:00', 73.88, '%', 'normal'),
(103, 3, '2026-08-02 01:00:00', 28.03, '°C', 'normal'),
(104, 4, '2026-08-02 01:00:00', 28.53, '°C', 'normal'),
(105, 1, '2026-08-02 02:00:00', 28.00, '°C', 'normal'),
(106, 2, '2026-08-02 02:00:00', 77.50, '%', 'normal'),
(107, 3, '2026-08-02 02:00:00', 29.00, '°C', 'normal'),
(108, 4, '2026-08-02 02:00:00', 29.50, '°C', 'normal'),
(109, 1, '2026-08-02 03:00:00', 28.83, '°C', 'normal'),
(110, 2, '2026-08-02 03:00:00', 80.60, '%', 'normal'),
(111, 3, '2026-08-02 03:00:00', 29.83, '°C', 'normal'),
(112, 4, '2026-08-02 03:00:00', 30.33, '°C', 'normal'),
(113, 1, '2026-08-02 04:00:00', 29.46, '°C', 'normal'),
(114, 2, '2026-08-02 04:00:00', 82.99, '%', 'normal'),
(115, 3, '2026-08-02 04:00:00', 30.46, '°C', 'normal'),
(116, 4, '2026-08-02 04:00:00', 30.96, '°C', 'normal'),
(117, 1, '2026-08-02 05:00:00', 29.86, '°C', 'normal'),
(118, 2, '2026-08-02 05:00:00', 84.49, '%', 'normal'),
(119, 3, '2026-08-02 05:00:00', 30.86, '°C', 'normal'),
(120, 4, '2026-08-02 05:00:00', 31.36, '°C', 'normal'),
(121, 1, '2026-08-02 06:00:00', 30.00, '°C', 'normal'),
(122, 2, '2026-08-02 06:00:00', 85.00, '%', 'normal'),
(123, 3, '2026-08-02 06:00:00', 31.00, '°C', 'normal'),
(124, 4, '2026-08-02 06:00:00', 31.50, '°C', 'normal'),
(125, 1, '2026-08-02 07:00:00', 29.86, '°C', 'normal'),
(126, 2, '2026-08-02 07:00:00', 84.49, '%', 'normal'),
(127, 3, '2026-08-02 07:00:00', 30.86, '°C', 'normal'),
(128, 4, '2026-08-02 07:00:00', 31.36, '°C', 'normal'),
(129, 1, '2026-08-02 08:00:00', 29.47, '°C', 'normal'),
(130, 2, '2026-08-02 08:00:00', 83.00, '%', 'normal'),
(131, 3, '2026-08-02 08:00:00', 30.47, '°C', 'normal'),
(132, 4, '2026-08-02 08:00:00', 30.97, '°C', 'normal'),
(133, 1, '2026-08-02 09:00:00', 28.83, '°C', 'normal'),
(134, 2, '2026-08-02 09:00:00', 80.62, '%', 'normal'),
(135, 3, '2026-08-02 09:00:00', 29.83, '°C', 'normal'),
(136, 4, '2026-08-02 09:00:00', 30.33, '°C', 'normal'),
(137, 1, '2026-08-02 10:00:00', 28.00, '°C', 'normal'),
(138, 2, '2026-08-02 10:00:00', 77.52, '%', 'normal'),
(139, 3, '2026-08-02 10:00:00', 29.00, '°C', 'normal'),
(140, 4, '2026-08-02 10:00:00', 29.50, '°C', 'normal'),
(141, 1, '2026-08-02 11:00:00', 27.04, '°C', 'normal'),
(142, 2, '2026-08-02 11:00:00', 73.90, '%', 'normal'),
(143, 3, '2026-08-02 11:00:00', 28.04, '°C', 'normal'),
(144, 4, '2026-08-02 11:00:00', 28.54, '°C', 'normal'),
(145, 1, '2026-08-02 12:00:00', 26.01, '°C', 'normal'),
(146, 2, '2026-08-02 12:00:00', 70.02, '%', 'normal'),
(147, 3, '2026-08-02 12:00:00', 27.01, '°C', 'normal'),
(148, 4, '2026-08-02 12:00:00', 27.51, '°C', 'normal'),
(149, 1, '2026-08-02 13:00:00', 24.97, '°C', 'normal'),
(150, 2, '2026-08-02 13:00:00', 66.14, '%', 'normal'),
(151, 3, '2026-08-02 13:00:00', 25.97, '°C', 'normal'),
(152, 4, '2026-08-02 13:00:00', 26.47, '°C', 'normal'),
(153, 1, '2026-08-02 14:00:00', 24.01, '°C', 'normal'),
(154, 2, '2026-08-02 14:00:00', 62.52, '%', 'normal'),
(155, 3, '2026-08-02 14:00:00', 41.50, '°C', 'anomali'),
(156, 4, '2026-08-02 14:00:00', 25.51, '°C', 'normal'),
(157, 1, '2026-08-02 15:00:00', 23.18, '°C', 'normal'),
(158, 2, '2026-08-02 15:00:00', 59.41, '%', 'normal'),
(159, 3, '2026-08-02 15:00:00', 24.18, '°C', 'normal'),
(160, 4, '2026-08-02 15:00:00', 24.68, '°C', 'normal'),
(161, 1, '2026-08-02 16:00:00', 22.54, '°C', 'normal'),
(162, 2, '2026-08-02 16:00:00', 57.03, '%', 'normal'),
(163, 3, '2026-08-02 16:00:00', 23.54, '°C', 'normal'),
(164, 4, '2026-08-02 16:00:00', 24.04, '°C', 'normal'),
(165, 1, '2026-08-02 17:00:00', 22.14, '°C', 'normal'),
(166, 2, '2026-08-02 17:00:00', 55.52, '%', 'normal'),
(167, 3, '2026-08-02 17:00:00', 23.14, '°C', 'normal'),
(168, 4, '2026-08-02 17:00:00', 23.64, '°C', 'normal'),
(169, 1, '2026-08-02 18:00:00', 22.00, '°C', 'normal'),
(170, 2, '2026-08-02 18:00:00', 55.00, '%', 'normal'),
(171, 3, '2026-08-02 18:00:00', 23.00, '°C', 'normal'),
(172, 4, '2026-08-02 18:00:00', 23.50, '°C', 'normal'),
(173, 1, '2026-08-02 19:00:00', 22.13, '°C', 'normal'),
(174, 2, '2026-08-02 19:00:00', 55.50, '%', 'normal'),
(175, 3, '2026-08-02 19:00:00', 23.13, '°C', 'normal'),
(176, 4, '2026-08-02 19:00:00', 23.63, '°C', 'normal'),
(177, 1, '2026-08-02 20:00:00', 22.53, '°C', 'normal'),
(178, 2, '2026-08-02 20:00:00', 56.99, '%', 'normal'),
(179, 3, '2026-08-02 20:00:00', 23.53, '°C', 'normal'),
(180, 4, '2026-08-02 20:00:00', 24.03, '°C', 'normal'),
(181, 1, '2026-08-02 21:00:00', 23.16, '°C', 'normal'),
(182, 2, '2026-08-02 21:00:00', 59.36, '%', 'normal'),
(183, 3, '2026-08-02 21:00:00', 24.16, '°C', 'normal'),
(184, 4, '2026-08-02 21:00:00', 24.66, '°C', 'normal'),
(185, 1, '2026-08-02 22:00:00', 23.99, '°C', 'normal'),
(186, 2, '2026-08-02 22:00:00', 62.46, '%', 'normal'),
(187, 3, '2026-08-02 22:00:00', 24.99, '°C', 'normal'),
(188, 4, '2026-08-02 22:00:00', 25.49, '°C', 'normal'),
(189, 1, '2026-08-02 23:00:00', 24.95, '°C', 'normal'),
(190, 2, '2026-08-02 23:00:00', 66.07, '%', 'normal'),
(191, 3, '2026-08-02 23:00:00', 25.95, '°C', 'normal'),
(192, 4, '2026-08-02 23:00:00', 26.45, '°C', 'normal'),
(193, 1, '2026-08-03 00:00:00', 26.00, '°C', 'normal'),
(194, 2, '2026-08-03 00:00:00', 70.00, '%', 'normal'),
(195, 3, '2026-08-03 00:00:00', 27.00, '°C', 'normal'),
(196, 4, '2026-08-03 00:00:00', 27.50, '°C', 'normal'),
(197, 1, '2026-08-03 01:00:00', 27.03, '°C', 'normal'),
(198, 2, '2026-08-03 01:00:00', 73.88, '%', 'normal'),
(199, 3, '2026-08-03 01:00:00', 28.03, '°C', 'normal'),
(200, 4, '2026-08-03 01:00:00', 28.53, '°C', 'normal'),
(201, 1, '2026-08-03 02:00:00', 28.00, '°C', 'normal'),
(202, 2, '2026-08-03 02:00:00', 77.50, '%', 'normal'),
(203, 3, '2026-08-03 02:00:00', 29.00, '°C', 'normal'),
(204, 4, '2026-08-03 02:00:00', 29.50, '°C', 'normal'),
(205, 1, '2026-08-03 03:00:00', 28.83, '°C', 'normal'),
(206, 2, '2026-08-03 03:00:00', 80.60, '%', 'normal'),
(207, 3, '2026-08-03 03:00:00', 29.83, '°C', 'normal'),
(208, 4, '2026-08-03 03:00:00', 30.33, '°C', 'normal'),
(209, 1, '2026-08-03 04:00:00', 29.46, '°C', 'normal'),
(210, 2, '2026-08-03 04:00:00', 82.99, '%', 'normal'),
(211, 3, '2026-08-03 04:00:00', 30.46, '°C', 'normal'),
(212, 4, '2026-08-03 04:00:00', 30.96, '°C', 'normal'),
(213, 1, '2026-08-03 05:00:00', 29.86, '°C', 'normal'),
(214, 2, '2026-08-03 05:00:00', 84.49, '%', 'normal'),
(215, 3, '2026-08-03 05:00:00', 30.86, '°C', 'normal'),
(216, 4, '2026-08-03 05:00:00', 31.36, '°C', 'normal'),
(217, 1, '2026-08-03 06:00:00', 30.00, '°C', 'normal'),
(218, 2, '2026-08-03 06:00:00', 85.00, '%', 'normal'),
(219, 3, '2026-08-03 06:00:00', 31.00, '°C', 'normal'),
(220, 4, '2026-08-03 06:00:00', 31.50, '°C', 'normal'),
(221, 1, '2026-08-03 07:00:00', 29.86, '°C', 'normal'),
(222, 2, '2026-08-03 07:00:00', 84.49, '%', 'normal'),
(223, 3, '2026-08-03 07:00:00', 30.86, '°C', 'normal'),
(224, 4, '2026-08-03 07:00:00', 31.36, '°C', 'normal'),
(225, 1, '2026-08-03 08:00:00', 29.47, '°C', 'normal'),
(226, 2, '2026-08-03 08:00:00', 83.00, '%', 'normal'),
(227, 3, '2026-08-03 08:00:00', 30.47, '°C', 'normal'),
(228, 4, '2026-08-03 08:00:00', 30.97, '°C', 'normal'),
(229, 1, '2026-08-03 09:00:00', 28.83, '°C', 'normal'),
(230, 2, '2026-08-03 09:00:00', 80.62, '%', 'normal'),
(231, 3, '2026-08-03 09:00:00', 29.83, '°C', 'normal'),
(232, 4, '2026-08-03 09:00:00', 30.33, '°C', 'normal'),
(233, 1, '2026-08-03 10:00:00', 28.00, '°C', 'normal'),
(234, 2, '2026-08-03 10:00:00', 77.52, '%', 'normal'),
(235, 3, '2026-08-03 10:00:00', 29.00, '°C', 'normal'),
(236, 4, '2026-08-03 10:00:00', 29.50, '°C', 'normal'),
(237, 1, '2026-08-03 11:00:00', 27.04, '°C', 'normal'),
(238, 2, '2026-08-03 11:00:00', 73.90, '%', 'normal'),
(239, 3, '2026-08-03 11:00:00', 28.04, '°C', 'normal'),
(240, 4, '2026-08-03 11:00:00', 28.54, '°C', 'normal'),
(241, 1, '2026-08-03 12:00:00', 26.01, '°C', 'normal'),
(242, 2, '2026-08-03 12:00:00', 70.02, '%', 'normal'),
(243, 3, '2026-08-03 12:00:00', 27.01, '°C', 'normal'),
(244, 4, '2026-08-03 12:00:00', 27.51, '°C', 'normal'),
(245, 1, '2026-08-03 13:00:00', 24.97, '°C', 'normal'),
(246, 2, '2026-08-03 13:00:00', 66.14, '%', 'normal'),
(247, 3, '2026-08-03 13:00:00', 25.97, '°C', 'normal'),
(248, 4, '2026-08-03 13:00:00', 26.47, '°C', 'normal'),
(249, 1, '2026-08-03 14:00:00', 24.01, '°C', 'normal'),
(250, 2, '2026-08-03 14:00:00', 62.52, '%', 'normal'),
(251, 3, '2026-08-03 14:00:00', 25.01, '°C', 'normal'),
(252, 4, '2026-08-03 14:00:00', 25.51, '°C', 'normal'),
(253, 1, '2026-08-03 15:00:00', 23.18, '°C', 'normal'),
(254, 2, '2026-08-03 15:00:00', 59.41, '%', 'normal'),
(255, 3, '2026-08-03 15:00:00', 24.18, '°C', 'normal'),
(256, 4, '2026-08-03 15:00:00', 24.68, '°C', 'normal'),
(257, 1, '2026-08-03 16:00:00', 22.54, '°C', 'normal'),
(258, 2, '2026-08-03 16:00:00', 57.03, '%', 'normal'),
(259, 3, '2026-08-03 16:00:00', 23.54, '°C', 'normal'),
(260, 4, '2026-08-03 16:00:00', 24.04, '°C', 'normal'),
(261, 1, '2026-08-03 17:00:00', 22.14, '°C', 'normal'),
(262, 2, '2026-08-03 17:00:00', 55.52, '%', 'normal'),
(263, 3, '2026-08-03 17:00:00', 23.14, '°C', 'normal'),
(264, 4, '2026-08-03 17:00:00', 23.64, '°C', 'normal'),
(265, 1, '2026-08-03 18:00:00', 22.00, '°C', 'normal'),
(266, 2, '2026-08-03 18:00:00', 55.00, '%', 'normal'),
(267, 3, '2026-08-03 18:00:00', 23.00, '°C', 'normal'),
(268, 4, '2026-08-03 18:00:00', 23.50, '°C', 'normal'),
(269, 1, '2026-08-03 19:00:00', 22.13, '°C', 'normal'),
(270, 2, '2026-08-03 19:00:00', 55.50, '%', 'normal'),
(271, 3, '2026-08-03 19:00:00', 23.13, '°C', 'normal'),
(272, 4, '2026-08-03 19:00:00', 23.63, '°C', 'normal'),
(273, 1, '2026-08-03 20:00:00', 22.53, '°C', 'normal'),
(274, 2, '2026-08-03 20:00:00', 56.99, '%', 'normal'),
(275, 3, '2026-08-03 20:00:00', 23.53, '°C', 'normal'),
(276, 4, '2026-08-03 20:00:00', 24.03, '°C', 'normal'),
(277, 1, '2026-08-03 21:00:00', 23.16, '°C', 'normal'),
(278, 2, '2026-08-03 21:00:00', 59.36, '%', 'normal'),
(279, 3, '2026-08-03 21:00:00', 24.16, '°C', 'normal'),
(280, 4, '2026-08-03 21:00:00', 24.66, '°C', 'normal'),
(281, 1, '2026-08-03 22:00:00', 23.99, '°C', 'normal'),
(282, 2, '2026-08-03 22:00:00', 62.46, '%', 'normal'),
(283, 3, '2026-08-03 22:00:00', 24.99, '°C', 'normal'),
(284, 4, '2026-08-03 22:00:00', 25.49, '°C', 'normal'),
(285, 1, '2026-08-03 23:00:00', 24.95, '°C', 'normal'),
(286, 2, '2026-08-03 23:00:00', 66.07, '%', 'normal'),
(287, 3, '2026-08-03 23:00:00', 25.95, '°C', 'normal'),
(288, 4, '2026-08-03 23:00:00', 26.45, '°C', 'normal');

--
-- Triggers `Log_Telemetri`
--
DELIMITER $$
CREATE TRIGGER `trg_cegah_ubah_log` BEFORE UPDATE ON `Log_Telemetri` FOR EACH ROW BEGIN
IF OLD.nilai <> NEW.nilai OR OLD.waktu_baca <> NEW.waktu_baca THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Gagal: Kolom nilai dan waktu_baca pada Log_Telemetri tidak boleh diubah!';
END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Log_Telemetri_Arsip`
--

CREATE TABLE `Log_Telemetri_Arsip` (
  `id_log` bigint(20) NOT NULL,
  `id_node` int(11) NOT NULL,
  `waktu_baca` datetime NOT NULL DEFAULT current_timestamp(),
  `nilai` decimal(8,2) NOT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Node_Sensor`
--

CREATE TABLE `Node_Sensor` (
  `id_node` int(11) NOT NULL,
  `nama_node` varchar(50) NOT NULL,
  `tipe_sensor` varchar(20) NOT NULL,
  `lokasi` varchar(80) DEFAULT NULL,
  `id_gateway` int(11) DEFAULT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Node_Sensor`
--

INSERT INTO `Node_Sensor` (`id_node`, `nama_node`, `tipe_sensor`, `lokasi`, `id_gateway`, `status`) VALUES
(1, 'Suhu Bedeng', 'suhu', 'Greenhouse', 1, 'perawatan'),
(2, 'Kelembapan Bedeng', 'kelembapan', 'Greenhouse', 1, 'aktif'),
(3, 'Suhu Rak Server', 'suhu', 'Ruang server', 2, 'aktif'),
(4, 'Suhu Ruang Praktikum', 'suhu', 'Lab 2', 2, 'aktif');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Gateway`
--
ALTER TABLE `Gateway`
  ADD PRIMARY KEY (`id_gateway`),
  ADD UNIQUE KEY `ip_address` (`ip_address`);

--
-- Indexes for table `Log_Perubahan_Status`
--
ALTER TABLE `Log_Perubahan_Status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Log_Telemetri`
--
ALTER TABLE `Log_Telemetri`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_node` (`id_node`);

--
-- Indexes for table `Log_Telemetri_Arsip`
--
ALTER TABLE `Log_Telemetri_Arsip`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_node` (`id_node`);

--
-- Indexes for table `Node_Sensor`
--
ALTER TABLE `Node_Sensor`
  ADD PRIMARY KEY (`id_node`),
  ADD KEY `id_gateway` (`id_gateway`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Gateway`
--
ALTER TABLE `Gateway`
  MODIFY `id_gateway` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Log_Perubahan_Status`
--
ALTER TABLE `Log_Perubahan_Status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Log_Telemetri`
--
ALTER TABLE `Log_Telemetri`
  MODIFY `id_log` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=512;

--
-- AUTO_INCREMENT for table `Log_Telemetri_Arsip`
--
ALTER TABLE `Log_Telemetri_Arsip`
  MODIFY `id_log` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Node_Sensor`
--
ALTER TABLE `Node_Sensor`
  MODIFY `id_node` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Log_Telemetri`
--
ALTER TABLE `Log_Telemetri`
  ADD CONSTRAINT `1` FOREIGN KEY (`id_node`) REFERENCES `Node_Sensor` (`id_node`);

--
-- Constraints for table `Node_Sensor`
--
ALTER TABLE `Node_Sensor`
  ADD CONSTRAINT `1` FOREIGN KEY (`id_gateway`) REFERENCES `Gateway` (`id_gateway`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
