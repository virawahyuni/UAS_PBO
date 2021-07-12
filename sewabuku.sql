-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2021 at 11:37 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `buku`
--

-- --------------------------------------------------------

--
-- Table structure for table `sewabuku`
--

CREATE TABLE `sewabuku` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_harus_kembali` date DEFAULT NULL,
  `tanggal_kembali` date DEFAULT NULL,
  `denda` int(11) DEFAULT NULL,
  `biaya_sewa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `sewabuku`
--

INSERT INTO `sewabuku` (`id`, `judul`, `tanggal_pinjam`, `tanggal_harus_kembali`, `tanggal_kembali`, `denda`, `biaya_sewa`) VALUES
(1, 'Harry Potter and The Gobblet of Fire', '2021-07-06', '2021-07-13', '2021-07-15', 4000, 9000),
(2, 'Ikigai 2', '2021-07-11', '2021-07-18', '2021-07-11', 0, 5000);

--
-- Triggers `sewabuku`
--
DELIMITER $$
CREATE TRIGGER `biaya` BEFORE UPDATE ON `sewabuku` FOR EACH ROW IF(datediff(new.tanggal_kembali, old.tanggal_harus_kembali)>1) THEN
	SET new.denda=(datediff(new.tanggal_kembali, old.tanggal_harus_kembali)*2000);
    SET new.biaya_sewa=5000+new.denda;
ELSE
	SET new.denda=0;
    SET new.biaya_sewa=5000;
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `kembali` BEFORE INSERT ON `sewabuku` FOR EACH ROW BEGIN
SET new.tanggal_harus_kembali=new.tanggal_pinjam+INTERVAL 1 WEEK;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sewabuku`
--
ALTER TABLE `sewabuku`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sewabuku`
--
ALTER TABLE `sewabuku`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
