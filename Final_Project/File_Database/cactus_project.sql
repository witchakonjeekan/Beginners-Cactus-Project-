-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 30, 2021 at 03:31 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cactus_db`
--
CREATE DATABASE IF NOT EXISTS `cactus_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `cactus_db`;

-- --------------------------------------------------------

--
-- Table structure for table `detailcactus`
--

CREATE TABLE `detailcactus` (
  `Manager_id` int(11) NOT NULL,
  `Spe_main` varchar(280) NOT NULL,
  `Spe_sup` varchar(280) NOT NULL,
  `Detail` varchar(280) NOT NULL,
  `Price` int(11) NOT NULL,
  `Image_cactus` varchar(108) NOT NULL,
  `Shop_id` int(11) NOT NULL,
  `Shopname` varchar(108) NOT NULL,
  `Type_cactus` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detailcactus`
--

INSERT INTO `detailcactus` (`Manager_id`, `Spe_main`, `Spe_sup`, `Detail`, `Price`, `Image_cactus`, `Shop_id`, `Shopname`, `Type_cactus`) VALUES
(1, 'Astrophytum', 'Ornatum Britton', 'แคคตัสยอดนิยม', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus396839.jpg', 1, 'ไปด้วยกัน', 0),
(2, 'Astrophytum', 'Myriostigma Kikko(variegated)', 'โตแล้ว ด่าง', 250, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus585313.jpg', 1, 'ไปด้วยกัน', 0),
(3, 'Astrophytum', 'Myriostigma Kikko', 'แคคตัส3เดือนเขียวเข้ม', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus648703.jpg', 1, 'ไปด้วยกัน', 0),
(4, 'Astrophytum', 'Ornatum', 'จุดประขาวแซมเขียว', 200, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus794611.jpg', 1, 'ไปด้วยกัน', 0),
(5, 'Coryphantha', 'Elephantidens', 'ช้าง1เดือน', 150, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus722267.jpg', 1, 'ไปด้วยกัน', 0),
(6, 'Coryphantha', 'Elephantidens', 'ช้างออกดอก', 500, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus404913.jpg', 1, 'ไปด้วยกัน', 0),
(7, 'Gymnocalycium', 'Mihanovichii(variegated)', 'เล็กแดง1เดือน', 250, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus727076.jpg', 1, 'ไปด้วยกัน', 0),
(8, 'Gymnocalycium', 'Mihanovichii(variegated)', '2เดือนด่าง', 300, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus989591.jpg', 1, 'ไปด้วยกัน', 0),
(9, 'Gymnocalycium', 'Intertextum Backeb', 'กลมลายปลานกลาง', 120, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus743363.jpg', 1, 'ไปด้วยกัน', 0),
(10, 'Gymnocalycium', 'Intertextum Backeb', 'กลมใหญ่ออกดอก', 400, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus16352.jpg', 1, 'ไปด้วยกัน', 0),
(11, 'Lophophora', 'Fricii', 'จุดปลายขาว', 200, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus615732.jpg', 1, 'ไปด้วยกัน', 0),
(12, 'Mammillaria', 'Elongata', 'แมมนิ้วทอง', 250, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus23165.jpg', 1, 'ไปด้วยกัน', 0),
(13, 'Mammillaria', 'Knipelliana Quehl', 'ปลายขนขาว', 300, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus413245.jpg', 1, 'ไปด้วยกัน', 0),
(14, 'Mammillaria', 'Karwinskiana(variegated)', 'แมมโตแตกกอ', 400, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus621584.jpg', 1, 'ไปด้วยกัน', 0),
(15, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'สายพันธ์ุนำเข้าแตกกอ', 800, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus513491.jpg', 2, 'ถุงเงิน', 0),
(16, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'สายพันธ์ุนำเข้า', 600, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus853251.jpg', 2, 'ถุงเงิน', 0),
(17, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'นำเข้าสีรุ้ง', 600, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus861118.jpg', 2, 'ถุงเงิน', 0),
(18, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'นำเข้าสีพลาสเทล', 700, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus718677.jpg', 2, 'ถุงเงิน', 0),
(19, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'แตกหน่อ', 500, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus301437.jpg', 2, 'ถุงเงิน', 0),
(20, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'นำเข้าลายใบเรือ', 700, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus687708.jpg', 2, 'ถุงเงิน', 0),
(21, 'Gymnocalycium', 'Mihanonichii hybrid(variegated)', 'ด่างนำเข้า', 450, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus911863.jpg', 2, 'ถุงเงิน', 0),
(22, 'Mammillaria', 'Deherdtiana Farwig', 'ออกดอกชมพู', 110, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus735168.jpg', 2, 'ถุงเงิน', 0),
(23, 'Mammillaria', 'Deherdtiana Farwig', 'ออกดอกสีแดง', 115, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus9146.jpg', 2, 'ถุงเงิน', 0),
(24, 'Mammillaria', 'Deherdtiana Farwig', 'ออกดอกชมพู', 110, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus195056.jpg', 2, 'ถุงเงิน', 0),
(25, 'Mammillaria', 'Deherdtiana Farwig', 'ออกดอกชมพู', 110, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus184474.jpg', 2, 'ถุงเงิน', 0),
(26, 'Mammillaria', 'Bocasana Multilnata', 'ปุยฝ้าย', 280, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus967158.jpg', 2, 'ถุงเงิน', 0),
(27, 'Mammillaria', 'Bocasana Multilnata', 'ปุยฝ้ายสีทอง', 290, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus578476.jpg', 2, 'ถุงเงิน', 0),
(28, 'Mammillaria', 'Bocasana Multilnata', 'ออกดอก', 300, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus899062.jpg', 2, 'ถุงเงิน', 0),
(29, 'Mammillaria', 'Bocasana Multilnata', 'ปุยฝ้ายสีขาว', 280, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus974391.jpg', 2, 'ถุงเงิน', 0),
(30, 'Astrophytum', 'Asterias', 'เล็ก', 140, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus257835.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(31, 'Astrophytum', 'Asterias', 'ลายด่างขนขาว', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus595920.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(32, 'Astrophytum', 'Myriostigma Kikko', 'ปานกลาง', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus672731.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(33, 'Astrophytum', 'Myriostigma(variegated)', 'สามแฉกด่าง', 290, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus233518.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(34, 'Astrophytum', 'Myriostigma Onzuka', '5เหลี่ยมจุดด่าง', 350, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus822327.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(35, 'Othercactus', 'Opuntia หูกระต่าย', 'ขนาดเล็ก', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus696221.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(36, 'Othercactus', 'Opuntia หูกระต่าย', 'ขนาดใหญ่', 300, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus890283.jpg', 3, 'ฟาร์มคุรุสภา แคคตัส', 0),
(37, 'Astrophytum', 'Albina', 'แคคตัสตัดต่อสีทอง', 150, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus692826.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(38, 'Astrophytum', 'Kikko', 'ขนาดใหญ่ออกดอก', 350, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus728015.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(39, 'Lophophora', 'Prolifera', 'แตกหน่อ ออกดอก', 490, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus858024.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(40, 'Astrophytum', 'STAR TYPE', '5แฉกกลายจุด', 300, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus437298.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(41, 'Astrophytum', 'Rosa', 'กลมลายจุดออกดอก', 300, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus423476.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(42, 'Gymnocalycium', 'Achirasense', 'ขนาดเล็กพร้อมส่ง', 150, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus633063.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(43, 'Lophophora', 'Calochlorum var. proliferum', 'ขนาดใหญ่พึ่งออกดอก', 600, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus429123.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(44, 'Coryphantha', 'Capillaense', 'กลมหนามเลื่อย', 210, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus254408.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(45, 'Gymnocalycium', 'Marquezii', 'หนามตะขอ', 150, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus348652.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(46, 'Gymnocalycium', 'Spegazzinii', 'กลมหนามเลื่อย', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus560744.jpg', 4, 'เพชรพฤษา แคคตัส', 0),
(47, 'Astrophytum', 'Capricorne', 'แฉก5เหลี่ยมออกดอก', 450, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus221607.jpg', 5, 'dressrosa garden', 0),
(48, 'Astrophytum', 'Capricorne', 'กราฟแคคตัส', 350, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus805928.jpg', 5, 'dressrosa garden', 0),
(49, 'Astrophytum', 'Asterais', 'กลมจุดขาว', 180, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus769076.jpg', 5, 'dressrosa garden', 0),
(50, 'Astrophytum', 'Asterais', 'ขนาดเล็ก', 120, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus159475.jpg', 5, 'dressrosa garden', 0),
(51, 'Astrophytum', 'Ornatum Meztitlan', 'ลายจุดพันธ์ุหนาม', 230, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus488502.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 1),
(52, 'Astrophytum', 'Hybrid', 'ลายแฉกจุดลูกศร', 400, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus545319.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 1),
(53, 'Coryphantha', 'Ornatum', 'ขนาดใหญ่ออกดอก', 500, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus457483.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0),
(54, 'Gymnocalycium', 'Spegazzinii', 'หนามยาว', 200, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus271770.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0),
(55, 'Mammillaria', 'Saglionis', 'ปานกลางออกดอกเยอะ', 350, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus770483.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0),
(56, 'Mammillaria', 'Bocasana', 'ออกดอกเป็นกอ', 600, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus78900.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0),
(57, 'Lophophora', 'Aureilanata', 'ออกดอกเป็นกอ', 500, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus980557.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0),
(58, 'Mammillaria', 'Berkiana', 'แคคตัสขนาดใหญ่ออกดอก', 800, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus144666.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0),
(60, 'Mammillaria', 'Tlalocii', 'ดอกรอบต้นสีชมพูหายาก', 1150, '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageCactus/PageCactus711328.jpg', 6, 'ร้านแคคตัส เพชรบูรณ์', 0);

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `ID` int(11) NOT NULL,
  `ID_User` int(11) NOT NULL,
  `Token_User` varchar(280) NOT NULL,
  `ID_Shop` int(11) NOT NULL,
  `Name_shop` varchar(180) NOT NULL,
  `Token_Shop` varchar(280) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`ID`, `ID_User`, `Token_User`, `ID_Shop`, `Name_shop`, `Token_Shop`) VALUES
(71, 8, 'dt1KPWSpQrqgJC_ImkjsaH:APA91bHA_3i5VYZa79GXM1A-csI2tyZsBNjmUJRP1n_DBRY3lgi-hiVTrqip8jCIAIdLrMBjCCN2ovqoBPAkdDZshJhVvAV4N2-05k4qDgNmSIo4nD_-q3FXDY22eyHJ4s5j8smw8BdM', 2, 'ถุงเงิน', 'tokenshop'),
(74, 8, 'dt1KPWSpQrqgJC_ImkjsaH:APA91bHA_3i5VYZa79GXM1A-csI2tyZsBNjmUJRP1n_DBRY3lgi-hiVTrqip8jCIAIdLrMBjCCN2ovqoBPAkdDZshJhVvAV4N2-05k4qDgNmSIo4nD_-q3FXDY22eyHJ4s5j8smw8BdM', 3, 'ฟาร์มคุรุสภา แคคตัส', 'tokenshop'),
(75, 8, 'dt1KPWSpQrqgJC_ImkjsaH:APA91bHA_3i5VYZa79GXM1A-csI2tyZsBNjmUJRP1n_DBRY3lgi-hiVTrqip8jCIAIdLrMBjCCN2ovqoBPAkdDZshJhVvAV4N2-05k4qDgNmSIo4nD_-q3FXDY22eyHJ4s5j8smw8BdM', 1, 'ไปด้วยกัน', 'tokenshop');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `ID` int(11) NOT NULL,
  `Shop_name` varchar(128) NOT NULL,
  `Shop_id` varchar(128) NOT NULL,
  `report_send` varchar(108) NOT NULL,
  `Token` varchar(280) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `shop`
--

CREATE TABLE `shop` (
  `Shop_id` int(11) NOT NULL,
  `Name_Shop` varchar(208) NOT NULL,
  `Image_Shop` varchar(208) NOT NULL,
  `Detail` varchar(208) NOT NULL,
  `ID_card` varchar(208) NOT NULL,
  `ID` int(11) NOT NULL,
  `Status` varchar(30) NOT NULL,
  `Username` varchar(180) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `shop`
--

INSERT INTO `shop` (`Shop_id`, `Name_Shop`, `Image_Shop`, `Detail`, `ID_card`, `ID`, `Status`, `Username`) VALUES
(1, 'ไปด้วยกัน', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/PageShop689251.jpg', 'จำหน่ายแคคตัสหลากหลายสายพันธ์ุเลือกชมได้เลยจ้า', '3524218882631', 3, 'Shop', 'gotogetter'),
(2, 'ถุงเงิน', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/PageShop353396.jpg', 'ร้านถุงเงิน แคคตัส : Small cactus plants ขายกระบองเพชร สระบุรี', '3269973442795', 4, 'Shop', 'Arrietty'),
(3, 'ฟาร์มคุรุสภา แคคตัส', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/PageShop970638.jpg', 'ฟาร์มคุรุสภา แคคตัส ขาย กระบองเพชร cactus เชียงใหม่ เปิดเข้าชม', '6430718659444', 5, 'Shop', 'farmkuu'),
(4, 'เพชรพฤษา แคคตัส', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/PageShop839481.jpg', 'จำหน่ายแคคตัส ยิมโน แอสโตร', '2198599126739', 6, 'Shop', 'jack'),
(5, 'dressrosa garden', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/PageShop708303.jpg', 'ร้านกาแฟผสมผสานแคคตัสพันธ์ุสวยงาม', '6380102371365', 7, 'Shop', 'dressrosa'),
(6, 'ร้านแคคตัส เพชรบูรณ์', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageShopDetail/PageShop989637.jpg', 'ขายปลีกกระบองเพรช', '6112892216166', 8, 'Shop', 'cactusshop');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `ID_User` int(11) NOT NULL,
  `Username` varchar(208) NOT NULL,
  `Email` varchar(208) NOT NULL,
  `Password` varchar(208) NOT NULL,
  `Image_Profile` varchar(208) NOT NULL,
  `Status` varchar(208) NOT NULL,
  `Token` varchar(280) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`ID_User`, `Username`, `Email`, `Password`, `Image_Profile`, `Status`, `Token`) VALUES
(1, 'witchakon', 'witchakon7896@gmail.com', 'witchakon789654', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageCactus124861.jpg', 'UserNormal', 'f94LFILNQNSiO7tFRK1GwB:APA91bG9nSaLlvFnEv2A3rW9RDDwc2s1f7aktk0q9MTlAHFzWh_F5Vd_D3QZbXOYjBlZqrSqtBIPXLEvLZDbsyImar3rtMzAR3qJ0apNFB7e9eQXghLLsefwXPdeq-m48LKAWRL1phaO'),
(2, 'ratthakan', 'ratthakan01@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop851285.jpg', 'UserNormal', 'fWPfiFfgSIiYyp2maQlyop:APA91bGywaFmYCsKR1BSIm9Yqp-hkPg4iro1iYscwSXARZ8x6UqprEX7ayzYTOtVXIps1e5SG7c95IjU3Q7SDkrwJpWDQyztoNGbwyMtVfaUxz-IhTYBT6eP4_Gz-v_7W_tgq_2TL3vT'),
(3, 'gotogetter', 'gogo@gmail.com', 'shop01', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop623133.jpg', 'UserShop', 'c6HXZ5nRRr-hofiCj2qydS:APA91bHRaPgZEDH2TV7x72A-Bcoi0q_BB7LrfBM-h0fWUMRwarr18IRA7Qu3XPOe84-nIoMioBx_Sf7rfCV9O4ofmC5CGN5MmFBbgUme0lLKiFW2vJsViq-qhr3fKqbzn9iFeGcEQrPx'),
(4, 'Arrietty', 'shop02@gmail.com', 'shop02', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop565441.jpg', 'UserShop', 'c6HXZ5nRRr-hofiCj2qydS:APA91bHRaPgZEDH2TV7x72A-Bcoi0q_BB7LrfBM-h0fWUMRwarr18IRA7Qu3XPOe84-nIoMioBx_Sf7rfCV9O4ofmC5CGN5MmFBbgUme0lLKiFW2vJsViq-qhr3fKqbzn9iFeGcEQrPx'),
(5, 'farmkuu', 'shop03@gmail.com', 'shop03', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop28237.jpg', 'UserShop', 'c6HXZ5nRRr-hofiCj2qydS:APA91bHRaPgZEDH2TV7x72A-Bcoi0q_BB7LrfBM-h0fWUMRwarr18IRA7Qu3XPOe84-nIoMioBx_Sf7rfCV9O4ofmC5CGN5MmFBbgUme0lLKiFW2vJsViq-qhr3fKqbzn9iFeGcEQrPx'),
(6, 'jack', 'shop04@gmail.com', 'shop04', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop890014.jpg', 'UserShop', 'c6HXZ5nRRr-hofiCj2qydS:APA91bHRaPgZEDH2TV7x72A-Bcoi0q_BB7LrfBM-h0fWUMRwarr18IRA7Qu3XPOe84-nIoMioBx_Sf7rfCV9O4ofmC5CGN5MmFBbgUme0lLKiFW2vJsViq-qhr3fKqbzn9iFeGcEQrPx'),
(7, 'dressrosa', 'shop05@gmail.com', 'shop05', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop325049.jpg', 'UserShop', 'c6HXZ5nRRr-hofiCj2qydS:APA91bHRaPgZEDH2TV7x72A-Bcoi0q_BB7LrfBM-h0fWUMRwarr18IRA7Qu3XPOe84-nIoMioBx_Sf7rfCV9O4ofmC5CGN5MmFBbgUme0lLKiFW2vJsViq-qhr3fKqbzn9iFeGcEQrPx'),
(8, 'cactusshop', 'shop06@gmail.com', 'shop06', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop675774.jpg', 'UserShop', 'dt1KPWSpQrqgJC_ImkjsaH:APA91bHA_3i5VYZa79GXM1A-csI2tyZsBNjmUJRP1n_DBRY3lgi-hiVTrqip8jCIAIdLrMBjCCN2ovqoBPAkdDZshJhVvAV4N2-05k4qDgNmSIo4nD_-q3FXDY22eyHJ4s5j8smw8BdM'),
(9, 'admin01', 'testtoken@gmail.com', 'admin01', '-', 'UserAdmin', 'f94LFILNQNSiO7tFRK1GwB:APA91bG9nSaLlvFnEv2A3rW9RDDwc2s1f7aktk0q9MTlAHFzWh_F5Vd_D3QZbXOYjBlZqrSqtBIPXLEvLZDbsyImar3rtMzAR3qJ0apNFB7e9eQXghLLsefwXPdeq-m48LKAWRL1phaO'),
(10, 'jeekan', 'jeekan@gmail.com', 'jeekan', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop175861.jpg', 'UserNormal', 'fP0EwpeZRwqq2PLf_IHUTK:APA91bGCcdQkEYpW3OPbl3ecpOWzmiw7qx7mBrMtyoruPARuhB2uDAIwEjYUgOaCB1-brMU8QZVtUUYWZdkNFakeuzMHHWkzyrXbQcwIPKDXRER_KVuUm5cQCBvV74_HwofFdUtrO9I9'),
(11, 'testdataimg', 'imgtest@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop526229.jpg', 'UserShop', ''),
(12, 'testmodel', 'testmodel01@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageCactus22838.jpg', 'UserNormal', 'f94LFILNQNSiO7tFRK1GwB:APA91bG9nSaLlvFnEv2A3rW9RDDwc2s1f7aktk0q9MTlAHFzWh_F5Vd_D3QZbXOYjBlZqrSqtBIPXLEvLZDbsyImar3rtMzAR3qJ0apNFB7e9eQXghLLsefwXPdeq-m48LKAWRL1phaO'),
(13, 'testfaver', 'testfaver01@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop790165.jpg', 'UserShop', 'f94LFILNQNSiO7tFRK1GwB:APA91bG9nSaLlvFnEv2A3rW9RDDwc2s1f7aktk0q9MTlAHFzWh_F5Vd_D3QZbXOYjBlZqrSqtBIPXLEvLZDbsyImar3rtMzAR3qJ0apNFB7e9eQXghLLsefwXPdeq-m48LKAWRL1phaO'),
(14, 'testnameshop', 'testnameshop@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop935795.jpg', 'UserShop', 'f94LFILNQNSiO7tFRK1GwB:APA91bG9nSaLlvFnEv2A3rW9RDDwc2s1f7aktk0q9MTlAHFzWh_F5Vd_D3QZbXOYjBlZqrSqtBIPXLEvLZDbsyImar3rtMzAR3qJ0apNFB7e9eQXghLLsefwXPdeq-m48LKAWRL1phaO'),
(15, 'testnoimage', 'testnoimage@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop499381.jpg', 'UserNormal', ''),
(16, 'jeekanwitchakon', 'jeekanwitchakon@gmail.com', '123456', '/Final_Project/flutter_login_signup-master/lib/src/Connection_DB/ImageUser/PageShop744242.jpg', 'UserNormal', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detailcactus`
--
ALTER TABLE `detailcactus`
  ADD PRIMARY KEY (`Manager_id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `shop`
--
ALTER TABLE `shop`
  ADD PRIMARY KEY (`Shop_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`ID_User`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detailcactus`
--
ALTER TABLE `detailcactus`
  MODIFY `Manager_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=96;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `shop`
--
ALTER TABLE `shop`
  MODIFY `Shop_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `ID_User` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
