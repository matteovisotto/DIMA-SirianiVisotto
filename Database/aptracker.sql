-- phpMyAdmin SQL Dump
-- version 5.2.0-rc1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Mag 05, 2022 alle 21:55
-- Versione del server: 10.5.15-MariaDB-0ubuntu0.21.10.1
-- Versione PHP: 8.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aptracker`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `auth`
--

CREATE TABLE `auth` (
  `id` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `refreshToken` varchar(255) NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expireAt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `auth`
--

INSERT INTO `auth` (`id`, `userId`, `accessToken`, `refreshToken`, `updatedAt`, `expireAt`) VALUES
(38, 2, 'e5fc0eb3545d94027d97cf849bd53dec', 'c9b22116938b0e600613a9531e8bed57c898e8e24265fcb5d77513fa6f184f5e', '2022-04-29 16:17:54', '2022-04-30 16:17:54'),
(46, 2, 'cf0eaad30e72d114fee6698e943302fb', 'dda69971c4b2ad07c8d00165422d4ca687befbd8367b8c8e272e05fa6f458ab8', '2022-05-01 10:12:37', '2022-05-02 10:12:37'),
(52, 3, 'c944c8fc09c6b3b4abbe94fffa543553', 'a8bdc701b5890e3b6bcd6b505721bb27142ced96003a9cacf05118a663be031a', '2022-05-05 06:17:43', '2022-05-06 06:17:43'),
(61, 1, '1b34729d408ab7492c6e7c0f28576d8a', '87db46d442df0584dade3abaeeb91718252a6694caf0fbd6a049a291860e0e29', '2022-05-03 09:02:40', '2022-05-04 09:02:40'),
(63, 1, 'f4fea6cb67e5f396afb9614f384d81ad', '9f68afe2c68cf86c4ab84da329f9bfa432e9f0eb37fa0be3402b853de2037ea9', '2022-05-05 19:31:31', '2022-05-06 19:31:31'),
(65, 6, 'a3417df9a826742eadb3e7e17746d90f', '2b40b7b578676c4b2a582b6be875e326d27dd3a7067bf4340c81253262a0b722', '2022-05-05 19:54:12', '2022-05-06 19:54:12'),
(67, 12, 'b5e68cd9f8dd64cbd6b2d4dab4627eec', 'd6f1db3251ddd957890f5302e77a4b0707d23c632cab48d1128f8d6c0119fc16', '2022-05-04 08:51:52', '2022-05-05 08:51:52'),
(74, 1, '07ae67f8cdf3a7b51f3d87f0b1c3b17b', 'd5d78bd643129a1717f5b9cf76af527ead9b1f8fbeceb3a3febea97bae94945b', '2022-05-05 13:27:04', '2022-05-06 13:27:04');

--
-- Trigger `auth`
--
DELIMITER $$
CREATE TRIGGER `tokenExpireOnInsert` BEFORE INSERT ON `auth` FOR EACH ROW BEGIN
set new.expireAt = NOW() + INTERVAL 24 HOUR;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tokenExpireOnUpdate` BEFORE UPDATE ON `auth` FOR EACH ROW BEGIN
set new.expireAt = NOW() + INTERVAL 24 HOUR;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `comment`
--

CREATE TABLE `comment` (
  `id` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `productId` int(11) NOT NULL,
  `comment` text NOT NULL,
  `publishedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `comment`
--

INSERT INTO `comment` (`id`, `userId`, `productId`, `comment`, `publishedAt`) VALUES
(2, 3, 13, 'This is just a simple test comment in order to have test data', '2022-04-30 17:57:50'),
(6, 3, 24, 'Let’s try this', '2022-04-30 19:39:30');

-- --------------------------------------------------------

--
-- Struttura della tabella `device`
--

CREATE TABLE `device` (
  `deviceId` varchar(255) NOT NULL,
  `fcmToken` varchar(255) NOT NULL,
  `userEmail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `device`
--

INSERT INTO `device` (`deviceId`, `fcmToken`, `userEmail`) VALUES
('1798A3F2-5CC7-42BF-9C26-D27E86E84D80', 'eDxub5OjkEoZtWgQjGyO7e:APA91bFOVfqahivrq0M4TBAhR4KRarZZ_J39o0xocnr458tJbX9NNwq77DLNoFRoF6X94EgHE19Rnx1MPI_Hm_U0zpgB2GZ7jFQB7QULWc9G77ItTUrr6AB4peCG24udRWG3GVQtPjqF', 'ely982010@hotmail.it'),
('1B8F9BFE-00C4-4265-8555-B27A0EBFE930', 'cPGYwdozLEzUiUb-ZO01h2:APA91bFDnUMrCkywkMIPjOxmGDqzVtv7DdztBrTxdDOaqDsuQ2xY_6LgcfMicZxH7D1J4eiwcbp7EKjIEqYFaUyaRr4GyWg-sAPcCErMCZCWHe9rmLTUMgdK9uHmd6bxOPCG6q5qnDfd', 'tototia98@gmail.com'),
('59AEACB1-5DCA-473E-93EB-BE3C937CBA86', 'eLfp2AkFHEnYs7bDpaBiJK:APA91bFrtkkQqyW2ZIh6pbOIF6YWzAwXMlvwqaIpEEWSlwTDmmMcPnA2B8XWsXSULICLEUPeVdugXJR8ISM0y42eNV6ukpx3_BGO6uVB4nKlaaonW53-NN0jOKguScjfiPfux_oVzUxs', NULL),
('76A6EED2-9EB0-48D6-8E27-A2A6A93E2BC0', 'cdPbD2RxzEyVg5Gn4rVHuM:APA91bHfeUIoy9OhdntSxHZjae7xVaoQ_HY8yuj2EBiPfVSON6C5-sI4R4I0jQvuzmq2PYHSzf3cpoTJTgg_DvFbHJaO3_OSwP5BAC2WS_aOB8oTJYf-q6V00lnwJpsZMLLCa2z1wQHE', NULL),
('973E9297-CA5B-4BF8-AA60-D68D30E25E57', 'fcYl9jLPgERug2cGD-l2he:APA91bEgSSKlVZYZA2bKBNh5Wu_qdb6uiGo0jdzi2FTKX8IyOHv672lpPdA1lfpdKGEpvnSOc_RPNsV2PTRtZQCikOdmuxdEuhaRbYtefA_NYNXbJ7N8SEbkETFZY6dyw2yolISNgnIN', 'tototia98@gmail.com'),
('A952810F-EBB6-4104-AC27-C1EC1D8EA677', 'c70nhTu1o0ZPrNL3g-oOvS:APA91bEVi4pDI6muUOTHj9HaPQ3ZAMv_5Lu-pmJUjcMijZDtDavWs7XKNfpDdT8bARQGSNx4z-Ei9RnVOBSzYi2RA9ssN5rM4gFxOwrlXysOdKvj1l9PG0kpXusSnHPW89p58l8Jxwj1', 'matteo.visotto@mail.polimi.it'),
('AFCBE63F-F314-4453-8145-F31460259E0C', 'cOny1YwE60hfkl33H0qqSg:APA91bGI8AgKhdnaBI7WzyW-cIlr43EXts-3KNRcVKM5vjprOW_98Xtu8P49JIoENcFgRc5avUI8DWiqCz7CmCKD_BIhbZvzd83LLHySVwjg62LbE8dEQ-14Vvk44udn7nGJC85L1GcG', 'tototia98@gmail.com'),
('B343EE11-B121-4BB0-8B31-AB7B70B479C3', 'fXBi8WRvK0h-rzITpV_A9e:APA91bGZ-iMD8SRlRL1OP-yKQQ2Ca53ssXAOBcC7ONC7RDAu0d_YdqxBtpyE9Z76hVkYk1sepu12JSTfJ3owQdNQsTMti2sSkeyZ8O9tUDpvW4E7g86qwYrACVLvSyfL326WDrQKLwf4', NULL),
('BFF2A34B-C789-4956-8AC8-F897260F38CE', 'fko43n7hm0LVtVnMooIaOZ:APA91bFaljP-1C7vFxZRqZfkWBXkgw6xGd3KtLl7hPlLzgxSllrBT5GGMJpnduamsXEgzERCJyD8tLOVGTBUyhhjR_Ran8BGkJv_R-f_s_Z1xtCtNL_y65XAFhyAlY0YIOHhTDKqjlNl', NULL),
('CE754AE6-A34B-407C-AA5B-1CFFC1553593', 'e7p9hgDrgEt7u6AIjJO4od:APA91bE40jiu35dYZIINKEUyeyvZZDGSPBi5sEWok_ha_r-BXWvauX_N4HZ_j-hFCTxSA33WMFYXmv0EfokA_XGlJPlMHpFXuoz_3eh_JyPU8XHbkfEOASQOLwpoqhrEWGa4dGgYIbzF', 'svevastriuli@gmail.com'),
('D571A35E-0BE2-4316-B429-13822C7D8A02', 'cSwWf0_Zskzwv0pNf0f2yG:APA91bHubvM5r7QJ0uURWZIHojhl1FJnuxjDcEv_1uGflbgInRpxY4aQanUfuhxArdL5Zxs65moB5p2ti6zNQP0k9YoCQ2rC3zBfmhDEdZIh8mGHmp8_VB1dpHGLQB5Hz92NQZwwz8kt', 'matev1998@gmail.com'),
('D5A2B469-7560-4F59-A9CB-C12A54E12236', 'dW5yRBQEDkuukvQYhHuXQz:APA91bEl7Mn3wpv0U-PdMVYU93pLqrU85vI4y3fcmpb1SynMbT8Wd7YSqbjterNhhTFLGQqLmuIRwRmET0o7X4S_eJuqKoVH1jCLEehmeP5g7l7FDX_pT82OA4syq7lFlmvh9pxm9Jhf', 'tototia98@gmail.com'),
('E3B527C6-B197-45FA-8B39-0E2CA35225F9', 'cnq8oNSVAEvVhOVzNkAim3:APA91bEIsmSE2QAtSEl91YrAXtDAGcu-pEHwerMA7tT8NEqRZ72fdqP315WHyMCOFz4rD-uwyNG-qb4pqeIZTrCoK8YreaG4aFG-MGV_SMPORXEM_neNixzc_yyGoPXLiGHIRl98QVNP', NULL);

-- --------------------------------------------------------

--
-- Struttura della tabella `image`
--

CREATE TABLE `image` (
  `productId` int(11) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `image`
--

INSERT INTO `image` (`productId`, `url`) VALUES
(13, 'https://m.media-amazon.com/images/I/51jPwfIulzL._AC_US200_.jpg'),
(15, 'https://m.media-amazon.com/images/I/413w6ZndFAL._AC_SR320,320_.jpg'),
(15, 'https://m.media-amazon.com/images/I/41jRiFzbp-L._AC_SR320,320_.jpg'),
(15, 'https://m.media-amazon.com/images/I/41Wt2ixASTL._AC_SR320,320_.jpg'),
(15, 'https://m.media-amazon.com/images/I/512yn70xgQL._AC_SR320,320_.jpg'),
(15, 'https://m.media-amazon.com/images/I/51F+IHCDCCL._AC_SR320,320_.jpg'),
(15, 'https://m.media-amazon.com/images/I/51gkZudwnqL._AC_SR320,320_.jpg'),
(15, 'https://m.media-amazon.com/images/I/61rbSsU4RZL._SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(16, 'https://m.media-amazon.com/images/I/416GFwFY+rL._AC_SR320,320_.jpg'),
(16, 'https://m.media-amazon.com/images/I/41bR8h-417L._AC_SR320,320_.jpg'),
(16, 'https://m.media-amazon.com/images/I/41h29LkYUzL._AC_SR320,320_.jpg'),
(16, 'https://m.media-amazon.com/images/I/41mK4JL-f3L._AC_SR320,320_.jpg'),
(16, 'https://m.media-amazon.com/images/I/41Y34JKJQeL._AC_SR320,320_.jpg'),
(16, 'https://m.media-amazon.com/images/I/41YU4KwnryL._AC_SR320,320_.jpg'),
(17, 'https://m.media-amazon.com/images/I/416GFwFY+rL._AC_SR320,320_.jpg'),
(17, 'https://m.media-amazon.com/images/I/41bR8h-417L._AC_SR320,320_.jpg'),
(17, 'https://m.media-amazon.com/images/I/41h29LkYUzL._AC_SR320,320_.jpg'),
(17, 'https://m.media-amazon.com/images/I/41mK4JL-f3L._AC_SR320,320_.jpg'),
(17, 'https://m.media-amazon.com/images/I/41Y34JKJQeL._AC_SR320,320_.jpg'),
(17, 'https://m.media-amazon.com/images/I/41YU4KwnryL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/31JYW8CguVL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/41LDsio7LnL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/517aBvs8DaL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/51eODPH8RZL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/61e3OLrkQyL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/61rmo+qCfUL._AC_SR320,320_.jpg'),
(18, 'https://m.media-amazon.com/images/I/71ONQWpECRL._SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(19, 'https://m.media-amazon.com/images/I/31j+8Yoq9vL._AC_SR320,320_.jpg'),
(19, 'https://m.media-amazon.com/images/I/41DfDQjz8oL._AC_SR320,320_.jpg'),
(19, 'https://m.media-amazon.com/images/I/41GWBFFcFPL._AC_SR320,320_.jpg'),
(19, 'https://m.media-amazon.com/images/I/41jLhW8CrRL._AC_SR320,320_.jpg'),
(19, 'https://m.media-amazon.com/images/I/41nrSO1ONdL._AC_SR320,320_.jpg'),
(19, 'https://m.media-amazon.com/images/I/41TWlo-rhNL._AC_SR320,320_.jpg'),
(19, 'https://m.media-amazon.com/images/I/61g8ZtBfDPL._AC_SR320,320_.jpg'),
(20, 'https://m.media-amazon.com/images/I/41S5YSaDIxL._AC_SR320,320_.jpg'),
(20, 'https://m.media-amazon.com/images/I/41zoWTDmeqL._AC_SR320,320_.jpg'),
(20, 'https://m.media-amazon.com/images/I/51I06Fgy-DL._AC_SR320,320_.jpg'),
(20, 'https://m.media-amazon.com/images/I/51mQbIO0IvL._AC_SR320,320_.jpg'),
(20, 'https://m.media-amazon.com/images/I/51myJwopO7L._AC_SR320,320_.jpg'),
(20, 'https://m.media-amazon.com/images/I/51RvHinqz7L._SS40_PKmb-play-button-overlay-thumb_.jpg'),
(20, 'https://m.media-amazon.com/images/I/51uY3ykxbrL._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/41N+hjULYJL._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/51-xwKsQsQS._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/51dJyJxjkyL._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/51en6zfHOrL._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/51kLuGr3mlL._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/51nY9s9dxKL._AC_SR320,320_.jpg'),
(22, 'https://m.media-amazon.com/images/I/61rbSsU4RZL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(23, 'https://m.media-amazon.com/images/I/315vs3rLEZL._AC_SR38,50_.jpg'),
(23, 'https://m.media-amazon.com/images/I/31aq0fhLKGL._AC_SR38,50_.jpg'),
(23, 'https://m.media-amazon.com/images/I/31WICrCOtgL._AC_SR38,50_.jpg'),
(23, 'https://m.media-amazon.com/images/I/41M1IqPP71L._SX35_SY46._CR0,0,35,46_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(23, 'https://m.media-amazon.com/images/I/41o4PKX160L._AC_SR38,50_.jpg'),
(23, 'https://m.media-amazon.com/images/I/41TPEDRrKeL._AC_SR38,50_.jpg'),
(23, 'https://m.media-amazon.com/images/I/41We4gnqyDL._AC_SR38,50_.jpg'),
(24, 'https://m.media-amazon.com/images/I/411OFA0XD+L._AC_SR320,320_.jpg'),
(24, 'https://m.media-amazon.com/images/I/41fGyRDEPPL._AC_SR320,320_.jpg'),
(24, 'https://m.media-amazon.com/images/I/41HLKkM9lcL._AC_SR320,320_.jpg'),
(24, 'https://m.media-amazon.com/images/I/41KSZKD1lUL._AC_SR320,320_.jpg'),
(24, 'https://m.media-amazon.com/images/I/51jsgg-cITL._AC_SR320,320_.jpg'),
(24, 'https://m.media-amazon.com/images/I/51oWNon3wqL._AC_SR320,320_.jpg'),
(25, 'https://m.media-amazon.com/images/I/214koyqz4IL._AC_SR38,50_.jpg'),
(25, 'https://m.media-amazon.com/images/I/21uDH-VmRHL._AC_SR38,50_.jpg'),
(25, 'https://m.media-amazon.com/images/I/31WUTr5oiVL._AC_SR38,50_.jpg'),
(25, 'https://m.media-amazon.com/images/I/41WAZJyhCML._AC_SR38,50_.jpg'),
(26, 'https://m.media-amazon.com/images/I/41bfcLVaJBL._AC_SR320,320_.jpg'),
(26, 'https://m.media-amazon.com/images/I/41kQlzkOodL._AC_SR320,320_.jpg'),
(26, 'https://m.media-amazon.com/images/I/511dSKSEsqL._AC_SR320,320_.jpg'),
(26, 'https://m.media-amazon.com/images/I/51CckWyROyL._AC_SR320,320_.jpg'),
(26, 'https://m.media-amazon.com/images/I/51RZutQZX7L.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(26, 'https://m.media-amazon.com/images/I/51ZH5tPWJ0L._AC_SR320,320_.jpg'),
(26, 'https://m.media-amazon.com/images/I/51Zi8PvgK+L._AC_SR320,320_.jpg'),
(27, 'https://m.media-amazon.com/images/I/31QXZo9lRAL._AC_SR38,50_.jpg'),
(27, 'https://m.media-amazon.com/images/I/41l1gRC9-1L._AC_SR38,50_.jpg'),
(27, 'https://m.media-amazon.com/images/I/41QQKtC-VkL._AC_SR38,50_.jpg'),
(27, 'https://m.media-amazon.com/images/I/51GCHSItqIL._AC_SR38,50_.jpg'),
(27, 'https://m.media-amazon.com/images/I/51q1vnNyYJL._AC_SR38,50_.jpg'),
(27, 'https://m.media-amazon.com/images/I/51ZH6jefRyL._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/31a+VqyslEL._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/41+v-9eC9GL._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/413ok++Xx6L._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/41auad3b5yL._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/41jJdiRH7JL._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/41jyW5qyI8L._AC_SR38,50_.jpg'),
(28, 'https://m.media-amazon.com/images/I/51rTiD0-zRL.SX38_SY50_CR,0,0,38,50_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(29, 'https://m.media-amazon.com/images/I/31-wOLZRxwL._AC_SR320,320_.jpg'),
(29, 'https://m.media-amazon.com/images/I/31ljnysEYrL._AC_SR320,320_.jpg'),
(29, 'https://m.media-amazon.com/images/I/41drmtnrf1L._AC_SR320,320_.jpg'),
(29, 'https://m.media-amazon.com/images/I/41h12Bn9IgL._AC_SR320,320_.jpg'),
(29, 'https://m.media-amazon.com/images/I/41oVHCEKKeL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(29, 'https://m.media-amazon.com/images/I/41vuYPyCFAL._AC_SR320,320_.jpg'),
(30, 'https://m.media-amazon.com/images/I/21JUJ0Vvx8L._AC_SR320,320_.jpg'),
(30, 'https://m.media-amazon.com/images/I/412D24IQq3L._AC_SR320,320_.jpg'),
(30, 'https://m.media-amazon.com/images/I/415vyQIoeML._AC_SR320,320_.jpg'),
(30, 'https://m.media-amazon.com/images/I/41yxPE2+VZL._AC_SR320,320_.jpg'),
(31, 'https://m.media-amazon.com/images/I/115c4146zhS._AC_SR38,50_.jpg'),
(31, 'https://m.media-amazon.com/images/I/21BfIIiHYlL._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/31F7G3-preL._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/31j-w4Yl-dL._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/31vhDdIkQkL._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/31vkmB-vYJL._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/4149cxx9kNL._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/41iB1kwcRML._AC_SR38,50_.jpg'),
(32, 'https://m.media-amazon.com/images/I/51TDUMgvbVL._SX35_SY46._CR0,0,35,46_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(33, 'https://m.media-amazon.com/images/I/41SaR8DjchL._AC_SR320,320_.jpg'),
(33, 'https://m.media-amazon.com/images/I/512hh57dByL._AC_SR320,320_.jpg'),
(33, 'https://m.media-amazon.com/images/I/512SZyRhFiL._AC_SR320,320_.jpg'),
(33, 'https://m.media-amazon.com/images/I/517MDZc3+xL._AC_SR320,320_.jpg'),
(33, 'https://m.media-amazon.com/images/I/51FSQJDTEhL._AC_SR320,320_.jpg'),
(33, 'https://m.media-amazon.com/images/I/51vpyTl2woL._AC_SR320,320_.jpg'),
(33, 'https://m.media-amazon.com/images/I/61IkMWC3+9L.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(34, 'https://m.media-amazon.com/images/I/418VfpBIDgL._AC_SR38,50_.jpg'),
(34, 'https://m.media-amazon.com/images/I/418Y6fF0C7L._AC_SR38,50_.jpg'),
(34, 'https://m.media-amazon.com/images/I/41EHnRqPs1L._AC_SR38,50_.jpg'),
(34, 'https://m.media-amazon.com/images/I/41TbgZVviOL._AC_SR38,50_.jpg'),
(34, 'https://m.media-amazon.com/images/I/41ysLf9rlXL._AC_SR38,50_.jpg'),
(34, 'https://m.media-amazon.com/images/I/516OXtOO0eL._AC_SR38,50_.jpg'),
(34, 'https://m.media-amazon.com/images/I/61pbvG1GtpL.SX38_SY50_CR,0,0,38,50_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(35, 'https://m.media-amazon.com/images/I/41hX+2Es+vL._AC_SR320,320_.jpg'),
(35, 'https://m.media-amazon.com/images/I/41UHocYfr6L._AC_SR320,320_.jpg'),
(35, 'https://m.media-amazon.com/images/I/41wXZBvGVfL._AC_SR320,320_.jpg'),
(35, 'https://m.media-amazon.com/images/I/513nPHHS9dL._AC_SR320,320_.jpg'),
(35, 'https://m.media-amazon.com/images/I/519QB3jdLvL._AC_SR320,320_.jpg'),
(35, 'https://m.media-amazon.com/images/I/51SpgqvSfUL._AC_SR320,320_.jpg'),
(35, 'https://m.media-amazon.com/images/I/51ZuFo04uHS._AC_SR320,320_.jpg'),
(36, 'https://m.media-amazon.com/images/I/4120OD7wqJL._AC_SR320,320_.jpg'),
(36, 'https://m.media-amazon.com/images/I/41dBO+UsG6L._AC_SR320,320_.jpg'),
(36, 'https://m.media-amazon.com/images/I/41OhPsWCDVL._AC_SR320,320_.jpg'),
(36, 'https://m.media-amazon.com/images/I/41S+TNnlmBL._AC_SR320,320_.jpg'),
(36, 'https://m.media-amazon.com/images/I/51MXMeGyyWL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(36, 'https://m.media-amazon.com/images/I/51O2wFARlxL._AC_SR320,320_.jpg'),
(36, 'https://m.media-amazon.com/images/I/51sequix9WL._AC_SR320,320_.jpg'),
(37, 'https://m.media-amazon.com/images/I/4174QIvkPSL._AC_SR38,50_.jpg'),
(37, 'https://m.media-amazon.com/images/I/417lGTFuJvL._AC_SR38,50_.jpg'),
(37, 'https://m.media-amazon.com/images/I/41owxRst03L._AC_SR38,50_.jpg'),
(37, 'https://m.media-amazon.com/images/I/41S0dbb2IkL._AC_SR38,50_.jpg'),
(37, 'https://m.media-amazon.com/images/I/41UVOrUGuNL._AC_SR38,50_.jpg'),
(37, 'https://m.media-amazon.com/images/I/51RCbweAoEL._AC_SR38,50_.jpg'),
(37, 'https://m.media-amazon.com/images/I/51Y2qg+xTiL._AC_SR38,50_.jpg'),
(39, 'https://m.media-amazon.com/images/I/41LKbyFN1ML._AC_SR320,320_.jpg'),
(40, 'https://m.media-amazon.com/images/I/41rwmw0GNCL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(40, 'https://m.media-amazon.com/images/I/512BhB4L70S._AC_SR320,320_.jpg'),
(40, 'https://m.media-amazon.com/images/I/514YT48XiLS._AC_SR320,320_.jpg'),
(40, 'https://m.media-amazon.com/images/I/51Dic8HHnMS._AC_SR320,320_.jpg'),
(40, 'https://m.media-amazon.com/images/I/51hZlc8yFtL._AC_SR320,320_.jpg'),
(40, 'https://m.media-amazon.com/images/I/51pWF8z0FGL._AC_SR320,320_.jpg'),
(40, 'https://m.media-amazon.com/images/I/51sn3O4wjOS._AC_SR320,320_.jpg'),
(41, 'https://m.media-amazon.com/images/I/41rwmw0GNCL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(41, 'https://m.media-amazon.com/images/I/41yDhDOASRL._AC_SR320,320_.jpg'),
(41, 'https://m.media-amazon.com/images/I/512BhB4L70S._AC_SR320,320_.jpg'),
(41, 'https://m.media-amazon.com/images/I/514YT48XiLS._AC_SR320,320_.jpg'),
(41, 'https://m.media-amazon.com/images/I/51hZlc8yFtL._AC_SR320,320_.jpg'),
(41, 'https://m.media-amazon.com/images/I/51sfR0lJ6LS._AC_SR320,320_.jpg'),
(41, 'https://m.media-amazon.com/images/I/51sn3O4wjOS._AC_SR320,320_.jpg'),
(42, 'https://m.media-amazon.com/images/I/51A7tk1wbWL._AC_SR320,320_.jpg'),
(42, 'https://m.media-amazon.com/images/I/51A9LLnJECL._AC_SR320,320_.jpg'),
(42, 'https://m.media-amazon.com/images/I/51Bx7Y+mKWL._AC_SR320,320_.jpg'),
(42, 'https://m.media-amazon.com/images/I/51cZOjm-5ML._AC_SR320,320_.jpg'),
(42, 'https://m.media-amazon.com/images/I/51eMRmRZPyL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(42, 'https://m.media-amazon.com/images/I/51LQ+xTCylL._AC_SR320,320_.jpg'),
(42, 'https://m.media-amazon.com/images/I/51nohpH1gIL._AC_SR320,320_.jpg'),
(43, 'https://m.media-amazon.com/images/I/419cjJZEomL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(43, 'https://m.media-amazon.com/images/I/41YEzjP-G6L._AC_SR320,320_.jpg'),
(43, 'https://m.media-amazon.com/images/I/5145wYDNXVL._AC_SR320,320_.jpg'),
(43, 'https://m.media-amazon.com/images/I/51j10M2YaXL._AC_SR320,320_.jpg'),
(43, 'https://m.media-amazon.com/images/I/51J88Io8GjL._AC_SR320,320_.jpg'),
(43, 'https://m.media-amazon.com/images/I/51QhMAsiDiL._AC_SR320,320_.jpg'),
(43, 'https://m.media-amazon.com/images/I/51RbwWzsyxL._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/51bpsRs7ePL._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/51DK8HIqWiL._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/51Ised7B4fL._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/51myxxrrFyL._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/51ole9vNE2L._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/51v5SLLJnKL._AC_SR320,320_.jpg'),
(44, 'https://m.media-amazon.com/images/I/61O09B6wF3L.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(45, 'https://m.media-amazon.com/images/I/513NV-S4d8L._AC_SR320,320_.jpg'),
(45, 'https://m.media-amazon.com/images/I/513ZnZAysVL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(45, 'https://m.media-amazon.com/images/I/518-v-gg1qL._AC_SR320,320_.jpg'),
(45, 'https://m.media-amazon.com/images/I/51fDP-Ub9KL._AC_SR320,320_.jpg'),
(45, 'https://m.media-amazon.com/images/I/51tqiJA8JML._AC_SR320,320_.jpg'),
(45, 'https://m.media-amazon.com/images/I/51V-4RLSOVS._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/31xAVlvG8aL._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/41h9sREoHUL._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/41HgMz2pRCL._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/51JY-MM1HOL._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/51nrUvy8OuL._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/51obuq7ZekL._AC_SR320,320_.jpg'),
(46, 'https://m.media-amazon.com/images/I/51wolUvpbSL._AC_SR320,320_.jpg'),
(47, 'https://m.media-amazon.com/images/I/41AFfIbv5cL._AC_SR320,320_.jpg'),
(47, 'https://m.media-amazon.com/images/I/41DHSaHN1tL._AC_SR320,320_.jpg'),
(47, 'https://m.media-amazon.com/images/I/41FEV9B7eML._AC_SR320,320_.jpg'),
(47, 'https://m.media-amazon.com/images/I/41pIvX4eX4L._AC_SR320,320_.jpg'),
(47, 'https://m.media-amazon.com/images/I/518+finHw7L._AC_SR320,320_.jpg'),
(47, 'https://m.media-amazon.com/images/I/518fatzxhnL.SS40_BG85,85,85_BR-120_PKdp-play-icon-overlay__.jpg'),
(47, 'https://m.media-amazon.com/images/I/51H0cZVwRGL._AC_SR320,320_.jpg');

-- --------------------------------------------------------

--
-- Struttura della tabella `numberOfTrackers`
--

CREATE TABLE `numberOfTrackers` (
  `productId` int(11) NOT NULL,
  `nTrackers` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `numberOfTrackers`
--

INSERT INTO `numberOfTrackers` (`productId`, `nTrackers`) VALUES
(13, 1),
(15, 0),
(16, 0),
(17, 0),
(18, 3),
(19, 2),
(20, 2),
(22, 1),
(23, 2),
(24, 1),
(25, 1),
(26, 1),
(27, 3),
(28, 0),
(29, 0),
(30, 0),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(39, 1),
(40, 1),
(41, 2),
(42, 2),
(43, 2),
(44, 1),
(45, 1),
(46, 1),
(47, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `price`
--

CREATE TABLE `price` (
  `productId` int(11) NOT NULL,
  `price` double NOT NULL,
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `price`
--

INSERT INTO `price` (`productId`, `price`, `updatedAt`) VALUES
(13, 39.59, '2022-04-09 08:13:13'),
(13, 39.44, '2022-04-09 22:00:08'),
(13, 39.44, '2022-04-10 10:00:07'),
(13, 39.59, '2022-04-10 22:00:10'),
(13, 39.59, '2022-04-11 10:00:08'),
(13, 39.59, '2022-04-11 22:00:09'),
(13, 39.59, '2022-04-12 10:00:08'),
(13, 38.99, '2022-04-12 22:00:09'),
(13, 38.99, '2022-04-13 10:00:08'),
(13, 38.99, '2022-04-13 22:00:07'),
(13, 38.99, '2022-04-14 10:00:09'),
(13, 38.99, '2022-04-14 20:29:57'),
(13, 38.99, '2022-04-15 10:00:03'),
(13, 38.99, '2022-04-15 22:00:04'),
(13, 38.99, '2022-04-16 10:00:03'),
(13, 38.99, '2022-04-16 22:00:04'),
(13, 38.99, '2022-04-17 10:00:04'),
(13, 38.8, '2022-04-17 22:00:03'),
(13, 38.8, '2022-04-18 10:00:04'),
(13, 38.8, '2022-04-18 22:00:04'),
(13, 38.8, '2022-04-19 10:00:03'),
(13, 38.5, '2022-04-19 22:00:04'),
(13, 38.5, '2022-04-20 10:00:08'),
(13, 38.8, '2022-04-20 22:00:04'),
(13, 38.8, '2022-04-21 10:00:04'),
(13, 38.8, '2022-04-21 22:00:12'),
(13, 38.8, '2022-04-22 10:00:03'),
(13, 38.8, '2022-04-22 22:00:04'),
(13, 38.8, '2022-04-23 10:00:03'),
(13, 38.8, '2022-04-23 22:00:03'),
(13, 38.8, '2022-04-24 10:00:03'),
(13, 38.8, '2022-04-24 22:00:03'),
(13, 38.8, '2022-04-25 10:00:03'),
(13, 38.8, '2022-04-25 22:00:04'),
(13, 38.8, '2022-04-26 10:00:04'),
(13, 38.8, '2022-04-26 22:00:03'),
(13, 38.8, '2022-04-27 10:00:05'),
(13, 38.8, '2022-04-27 22:00:14'),
(13, 38.8, '2022-04-28 10:00:04'),
(13, 38.8, '2022-04-28 22:00:03'),
(13, 38.8, '2022-04-29 10:00:03'),
(13, 38.8, '2022-04-29 22:00:04'),
(13, 38.8, '2022-04-30 10:00:04'),
(13, 38.8, '2022-04-30 22:00:06'),
(13, 38.8, '2022-05-01 10:00:04'),
(13, 38.8, '2022-05-01 19:41:33'),
(13, 38.8, '2022-05-02 10:00:04'),
(13, 38.8, '2022-05-02 22:00:03'),
(13, 38.8, '2022-05-03 10:00:04'),
(13, 38.8, '2022-05-03 15:17:59'),
(13, 38.5, '2022-05-03 22:00:03'),
(13, 38.5, '2022-05-04 10:00:04'),
(13, 38.8, '2022-05-04 22:00:04'),
(13, 38.8, '2022-05-05 10:00:04'),
(15, 24.99, '2022-04-14 09:10:18'),
(15, 24.99, '2022-04-14 20:30:00'),
(15, 36.28, '2022-04-15 10:00:05'),
(15, 36.28, '2022-04-15 22:00:06'),
(15, 36.28, '2022-04-16 10:00:06'),
(15, 36.28, '2022-04-16 22:00:06'),
(15, 36.28, '2022-04-17 10:00:06'),
(15, 36.28, '2022-04-17 22:00:06'),
(15, 36.28, '2022-04-18 10:00:06'),
(15, 36.28, '2022-04-18 22:00:06'),
(15, 36.28, '2022-04-19 10:00:06'),
(15, 36.28, '2022-04-19 22:00:06'),
(15, 42, '2022-04-20 10:00:10'),
(15, 42, '2022-04-20 22:00:07'),
(15, 42, '2022-04-21 10:00:06'),
(15, 42, '2022-04-21 22:00:14'),
(15, 44.88, '2022-04-22 10:00:05'),
(15, 44.88, '2022-04-22 22:00:06'),
(15, 44.88, '2022-04-23 10:00:06'),
(15, 44, '2022-04-23 22:00:05'),
(15, 44, '2022-04-24 10:00:05'),
(15, 44, '2022-04-24 22:00:06'),
(15, 44, '2022-04-25 10:00:06'),
(15, 39.76, '2022-04-25 22:00:06'),
(15, 39.76, '2022-04-26 10:00:06'),
(15, 39.76, '2022-04-26 22:00:05'),
(15, 39.76, '2022-04-27 10:00:08'),
(15, 39.76, '2022-04-27 22:00:16'),
(15, 39.76, '2022-04-28 10:00:06'),
(15, 39.76, '2022-04-28 22:00:05'),
(15, 39.76, '2022-04-29 10:00:06'),
(15, 39.76, '2022-04-29 22:00:06'),
(15, 39.76, '2022-04-30 10:00:06'),
(15, 39.76, '2022-04-30 22:00:08'),
(15, 39.76, '2022-05-01 10:00:07'),
(15, 39.76, '2022-05-01 19:41:35'),
(15, 39.59, '2022-05-02 10:00:06'),
(15, 39.59, '2022-05-02 22:00:06'),
(15, 39.59, '2022-05-03 10:00:06'),
(15, 39.59, '2022-05-03 15:18:01'),
(15, 39.59, '2022-05-03 22:00:06'),
(15, 39.59, '2022-05-04 10:00:06'),
(15, 39.59, '2022-05-04 22:00:07'),
(15, 39.59, '2022-05-05 10:00:07'),
(16, 23.48, '2022-04-14 09:33:56'),
(16, 23.48, '2022-04-14 20:30:02'),
(16, 23.48, '2022-04-15 10:00:07'),
(16, 23.48, '2022-04-15 22:00:08'),
(16, 23.48, '2022-04-16 10:00:08'),
(16, 23.48, '2022-04-16 22:00:08'),
(16, 23.48, '2022-04-17 10:00:08'),
(16, 23.48, '2022-04-17 22:00:08'),
(16, 23.48, '2022-04-18 10:00:08'),
(16, 23.48, '2022-04-18 22:00:08'),
(16, 23.48, '2022-04-19 10:00:08'),
(16, 23.48, '2022-04-19 22:00:08'),
(16, 24.74, '2022-04-20 10:00:13'),
(16, 24.74, '2022-04-20 22:00:09'),
(16, 24.74, '2022-04-21 10:00:09'),
(16, 24.74, '2022-04-21 22:00:16'),
(16, 24.74, '2022-04-22 10:00:07'),
(16, 24.74, '2022-04-22 22:00:08'),
(16, 24.74, '2022-04-23 10:00:08'),
(16, 24.74, '2022-04-23 22:00:08'),
(16, 24.74, '2022-04-24 10:00:07'),
(16, 24.74, '2022-04-24 22:00:08'),
(16, 24.74, '2022-04-25 10:00:08'),
(16, 24.74, '2022-04-25 22:00:08'),
(16, 24.74, '2022-04-26 10:00:08'),
(16, 24.74, '2022-04-26 22:00:08'),
(16, 24.77, '2022-04-27 10:00:10'),
(16, 24.77, '2022-04-27 22:00:18'),
(16, 24.77, '2022-04-28 10:00:07'),
(16, 24.77, '2022-04-28 22:00:07'),
(16, 24.77, '2022-04-29 10:00:08'),
(16, 24.77, '2022-04-29 22:00:08'),
(16, 24.77, '2022-04-30 10:00:08'),
(16, 24.77, '2022-04-30 22:00:10'),
(16, 24.77, '2022-05-01 10:00:09'),
(16, 24.77, '2022-05-01 19:41:37'),
(16, 24.77, '2022-05-02 10:00:08'),
(16, 24.77, '2022-05-02 22:00:08'),
(16, 24.77, '2022-05-03 10:00:08'),
(16, 24.77, '2022-05-03 15:18:03'),
(16, 24.77, '2022-05-03 22:00:08'),
(16, 24.92, '2022-05-04 10:00:08'),
(16, 24.92, '2022-05-04 22:00:09'),
(16, 24.92, '2022-05-05 10:00:09'),
(17, 23.48, '2022-04-14 09:42:34'),
(17, 23.48, '2022-04-14 20:30:05'),
(17, 23.48, '2022-04-15 10:00:09'),
(17, 23.48, '2022-04-15 22:00:10'),
(17, 23.48, '2022-04-16 10:00:09'),
(17, 23.48, '2022-04-16 22:00:10'),
(17, 23.48, '2022-04-17 10:00:11'),
(17, 23.48, '2022-04-17 22:00:10'),
(17, 23.48, '2022-04-18 10:00:10'),
(17, 23.48, '2022-04-18 22:00:11'),
(17, 23.48, '2022-04-19 10:00:10'),
(17, 23.48, '2022-04-19 22:00:11'),
(17, 24.74, '2022-04-20 10:00:15'),
(17, 24.74, '2022-04-20 22:00:11'),
(17, 24.74, '2022-04-21 10:00:11'),
(17, 24.74, '2022-04-21 22:00:18'),
(17, 24.74, '2022-04-22 10:00:09'),
(17, 24.74, '2022-04-22 22:00:10'),
(17, 24.74, '2022-04-23 10:00:10'),
(17, 24.74, '2022-04-23 22:00:09'),
(17, 24.74, '2022-04-24 10:00:09'),
(17, 24.74, '2022-04-24 22:00:09'),
(17, 24.74, '2022-04-25 10:00:10'),
(17, 24.74, '2022-04-25 22:00:10'),
(17, 24.74, '2022-04-26 10:00:10'),
(17, 24.74, '2022-04-26 22:00:09'),
(17, 24.77, '2022-04-27 10:00:12'),
(17, 24.77, '2022-04-27 22:00:20'),
(17, 24.77, '2022-04-28 10:00:09'),
(17, 24.77, '2022-04-28 22:00:09'),
(17, 24.77, '2022-04-29 10:00:10'),
(17, 24.77, '2022-04-29 22:00:10'),
(17, 24.77, '2022-04-30 10:00:10'),
(17, 24.77, '2022-04-30 22:00:12'),
(17, 24.77, '2022-05-01 10:00:11'),
(17, 24.77, '2022-05-01 19:41:39'),
(17, 24.77, '2022-05-02 10:00:10'),
(17, 24.77, '2022-05-02 22:00:10'),
(17, 24.77, '2022-05-03 10:00:10'),
(17, 24.77, '2022-05-03 15:18:06'),
(17, 24.77, '2022-05-03 22:00:10'),
(17, 24.92, '2022-05-04 10:00:10'),
(17, 24.92, '2022-05-04 22:00:11'),
(17, 24.92, '2022-05-05 10:00:11'),
(18, 23.19, '2022-04-14 10:59:14'),
(18, 23.19, '2022-04-14 20:30:06'),
(18, 23.19, '2022-04-15 10:00:11'),
(18, 23.19, '2022-04-15 22:00:12'),
(18, 28.99, '2022-04-16 10:00:11'),
(18, 28.99, '2022-04-16 22:00:13'),
(18, 28.99, '2022-04-17 10:00:13'),
(18, 28.99, '2022-04-17 22:00:12'),
(18, 28.99, '2022-04-18 10:00:12'),
(18, 28.99, '2022-04-18 22:00:13'),
(18, 28.99, '2022-04-19 10:00:12'),
(18, 28.99, '2022-04-19 22:00:13'),
(18, 28.99, '2022-04-20 10:00:17'),
(18, 28.99, '2022-04-20 22:00:13'),
(18, 28.99, '2022-04-21 10:00:12'),
(18, 28.99, '2022-04-21 22:00:20'),
(18, 28.99, '2022-04-22 10:00:12'),
(18, 28.99, '2022-04-22 22:00:13'),
(18, 28.99, '2022-04-23 10:00:12'),
(18, 28.99, '2022-04-23 22:00:12'),
(18, 28.99, '2022-04-24 10:00:11'),
(18, 28.99, '2022-04-24 22:00:12'),
(18, 28.99, '2022-04-25 10:00:12'),
(18, 28.99, '2022-04-25 22:00:12'),
(18, 28.99, '2022-04-26 10:00:12'),
(18, 28.99, '2022-04-26 22:00:11'),
(18, 28.99, '2022-04-27 10:00:14'),
(18, 28.99, '2022-04-27 22:00:22'),
(18, 28.99, '2022-04-28 10:00:11'),
(18, 28.99, '2022-04-28 22:00:11'),
(18, 28.99, '2022-04-29 10:00:12'),
(18, 28.99, '2022-04-29 22:00:12'),
(18, 28.99, '2022-04-30 10:00:13'),
(18, 28.99, '2022-04-30 22:00:15'),
(18, 28.99, '2022-05-01 10:00:14'),
(18, 28.99, '2022-05-01 19:41:42'),
(18, 28.99, '2022-05-02 10:00:13'),
(18, 28.99, '2022-05-02 22:00:12'),
(18, 28.99, '2022-05-03 10:00:12'),
(18, 28.99, '2022-05-03 15:18:08'),
(18, 28.99, '2022-05-03 22:00:12'),
(18, 28.99, '2022-05-04 10:00:12'),
(18, 28.99, '2022-05-04 22:00:13'),
(18, 28.99, '2022-05-05 10:00:13'),
(19, 75.85, '2022-04-14 10:59:42'),
(19, 75.85, '2022-04-14 20:30:08'),
(19, 75.85, '2022-04-15 10:00:13'),
(19, 75.85, '2022-04-15 22:00:14'),
(19, 75.85, '2022-04-16 10:00:13'),
(19, 75.85, '2022-04-16 22:00:15'),
(19, 75.85, '2022-04-17 10:00:15'),
(19, 75.85, '2022-04-17 22:00:14'),
(19, 75.85, '2022-04-18 10:00:13'),
(19, 75.85, '2022-04-18 22:00:15'),
(19, 75.85, '2022-04-19 10:00:14'),
(19, 75.85, '2022-04-19 22:00:15'),
(19, 75.85, '2022-04-20 10:00:19'),
(19, 75.85, '2022-04-20 22:00:15'),
(19, 75.85, '2022-04-21 10:00:14'),
(19, 75.85, '2022-04-21 22:00:22'),
(19, 75.85, '2022-04-22 10:00:14'),
(19, 75.85, '2022-04-22 22:00:15'),
(19, 75.85, '2022-04-23 10:00:14'),
(19, 75.85, '2022-04-23 22:00:14'),
(19, 75.85, '2022-04-24 10:00:14'),
(19, 75.85, '2022-04-24 22:00:13'),
(19, 75.85, '2022-04-25 10:00:14'),
(19, 75.85, '2022-04-25 22:00:14'),
(19, 75.85, '2022-04-26 10:00:14'),
(19, 75.85, '2022-04-26 22:00:13'),
(19, 75.85, '2022-04-27 10:00:16'),
(19, 75.85, '2022-04-27 22:00:24'),
(19, 75.85, '2022-04-28 10:00:13'),
(19, 75.85, '2022-04-28 22:00:13'),
(19, 75.85, '2022-04-29 10:00:14'),
(19, 75.85, '2022-04-29 22:00:15'),
(19, 75.85, '2022-04-30 10:00:15'),
(19, 75.85, '2022-04-30 22:00:17'),
(19, 75.85, '2022-05-01 10:00:16'),
(19, 75.85, '2022-05-01 19:41:44'),
(19, 64.47, '2022-05-02 10:00:15'),
(19, 64.47, '2022-05-02 22:00:14'),
(19, 64.47, '2022-05-03 10:00:14'),
(19, 64.47, '2022-05-03 15:18:10'),
(19, 64.47, '2022-05-03 22:00:14'),
(19, 64.47, '2022-05-04 10:00:15'),
(19, 64.47, '2022-05-04 22:00:16'),
(19, 64.47, '2022-05-05 10:00:15'),
(20, 34.9, '2022-04-20 20:03:21'),
(20, 0, '2022-04-21 10:00:16'),
(20, 0, '2022-04-21 22:00:24'),
(20, 31.2, '2022-04-22 10:00:16'),
(20, 0, '2022-04-22 22:00:17'),
(20, 0, '2022-04-23 10:00:16'),
(20, 0, '2022-04-23 22:00:17'),
(20, 40.05, '2022-04-24 10:00:16'),
(20, 40.05, '2022-04-24 22:00:16'),
(20, 49.99, '2022-04-25 10:00:16'),
(20, 0, '2022-04-25 22:00:16'),
(20, 0, '2022-04-26 10:00:16'),
(20, 0, '2022-04-26 22:00:15'),
(20, 0, '2022-04-27 10:00:18'),
(20, 0, '2022-04-27 22:00:26'),
(20, 34.9, '2022-04-28 10:00:15'),
(20, 34.9, '2022-04-28 22:00:15'),
(20, 0, '2022-04-29 10:00:16'),
(20, 34.9, '2022-04-29 22:00:17'),
(20, 0, '2022-04-30 10:00:17'),
(20, 0, '2022-04-30 22:00:19'),
(20, 42.49, '2022-05-01 10:00:18'),
(20, 0, '2022-05-01 19:41:46'),
(20, 0, '2022-05-02 10:00:17'),
(20, 0, '2022-05-02 22:00:16'),
(20, 0, '2022-05-03 10:00:16'),
(20, 0, '2022-05-03 15:18:13'),
(20, 34.9, '2022-05-03 22:00:16'),
(20, 0, '2022-05-04 10:00:17'),
(20, 0, '2022-05-04 22:00:18'),
(20, 0, '2022-05-05 10:00:17'),
(22, 23.99, '2022-04-23 13:16:31'),
(22, 23.99, '2022-04-23 22:00:19'),
(22, 23.99, '2022-04-24 10:00:18'),
(22, 23.99, '2022-04-24 22:00:18'),
(22, 23.99, '2022-04-25 10:00:18'),
(22, 23.99, '2022-04-25 22:00:19'),
(22, 23.99, '2022-04-26 10:00:18'),
(22, 23.99, '2022-04-26 22:00:17'),
(22, 23.99, '2022-04-27 10:00:20'),
(22, 23.99, '2022-04-27 22:00:28'),
(22, 23.99, '2022-04-28 10:00:18'),
(22, 31.55, '2022-04-28 22:00:18'),
(22, 37.55, '2022-04-29 10:00:19'),
(22, 37.55, '2022-04-29 22:00:19'),
(22, 37.55, '2022-04-30 10:00:20'),
(22, 37.55, '2022-04-30 22:00:21'),
(22, 31, '2022-05-01 10:00:20'),
(22, 31, '2022-05-01 19:41:49'),
(22, 37.55, '2022-05-02 10:00:19'),
(22, 37.55, '2022-05-02 22:00:19'),
(22, 37.55, '2022-05-03 10:00:19'),
(22, 37.55, '2022-05-03 15:18:15'),
(22, 37.55, '2022-05-03 22:00:18'),
(22, 37.55, '2022-05-04 10:00:19'),
(22, 32.81, '2022-05-04 22:00:21'),
(22, 34.99, '2022-05-05 10:00:19'),
(23, 939, '2022-04-23 15:57:23'),
(23, 939, '2022-04-23 22:00:21'),
(23, 879, '2022-04-24 10:00:20'),
(23, 939, '2022-04-24 22:00:21'),
(23, 939, '2022-04-25 10:00:20'),
(23, 939, '2022-04-25 22:00:21'),
(23, 939, '2022-04-26 10:00:20'),
(23, 826.32, '2022-04-26 22:00:20'),
(23, 826.32, '2022-04-27 10:00:22'),
(23, 826.32, '2022-04-27 22:00:30'),
(23, 939, '2022-04-28 10:00:19'),
(23, 939, '2022-04-28 22:00:20'),
(23, 936, '2022-04-29 10:00:21'),
(23, 936, '2022-04-29 22:00:21'),
(23, 936, '2022-04-30 10:00:22'),
(23, 936, '2022-04-30 22:00:23'),
(23, 799, '2022-05-01 10:00:22'),
(23, 936, '2022-05-01 19:41:51'),
(23, 868, '2022-05-02 10:00:21'),
(23, 799, '2022-05-02 22:00:20'),
(23, 939, '2022-05-03 10:00:21'),
(23, 922.99, '2022-05-03 15:18:17'),
(23, 868, '2022-05-03 22:00:21'),
(23, 922.99, '2022-05-04 10:00:21'),
(23, 799, '2022-05-04 22:00:24'),
(23, 922.99, '2022-05-05 10:00:21'),
(24, 20.56, '2022-04-23 15:58:35'),
(24, 19.36, '2022-04-23 22:00:23'),
(24, 21.36, '2022-04-24 10:00:22'),
(24, 23.36, '2022-04-24 22:00:23'),
(24, 21.63, '2022-04-25 10:00:22'),
(24, 18.24, '2022-04-25 22:00:23'),
(24, 20.16, '2022-04-26 10:00:22'),
(24, 22.16, '2022-04-26 22:00:22'),
(24, 18.54, '2022-04-27 10:00:24'),
(24, 20.4, '2022-04-27 22:00:32'),
(24, 22.92, '2022-04-28 10:00:21'),
(24, 19.56, '2022-04-28 22:00:22'),
(24, 21.58, '2022-04-29 10:00:23'),
(24, 23.74, '2022-04-29 22:00:23'),
(24, 19.58, '2022-04-30 10:00:24'),
(24, 19.58, '2022-04-30 22:00:25'),
(24, 19.58, '2022-05-01 10:00:24'),
(24, 19.58, '2022-05-01 19:41:53'),
(24, 19.58, '2022-05-02 10:00:23'),
(24, 19.58, '2022-05-02 22:00:22'),
(24, 19.58, '2022-05-03 10:00:23'),
(24, 19.58, '2022-05-03 15:18:19'),
(24, 19.58, '2022-05-03 22:00:23'),
(24, 19.58, '2022-05-04 10:00:23'),
(24, 19.58, '2022-05-04 22:00:25'),
(24, 19.58, '2022-05-05 10:00:23'),
(25, 23.99, '2022-04-23 15:59:18'),
(25, 23.99, '2022-04-23 22:00:25'),
(25, 23.99, '2022-04-24 10:00:24'),
(25, 23.99, '2022-04-24 22:00:24'),
(25, 23.99, '2022-04-25 10:00:24'),
(25, 23.99, '2022-04-25 22:00:24'),
(25, 23.99, '2022-04-26 10:00:24'),
(25, 23.99, '2022-04-26 22:00:24'),
(25, 23.99, '2022-04-27 10:00:25'),
(25, 23.99, '2022-04-27 22:00:34'),
(25, 23.99, '2022-04-28 10:00:23'),
(25, 23.99, '2022-04-28 22:00:24'),
(25, 23.99, '2022-04-29 10:00:24'),
(25, 23.99, '2022-04-29 22:00:24'),
(25, 23.99, '2022-04-30 10:00:25'),
(25, 23.99, '2022-04-30 22:00:27'),
(25, 23.99, '2022-05-01 10:00:26'),
(25, 23.99, '2022-05-01 19:41:55'),
(25, 23.99, '2022-05-02 10:00:25'),
(25, 23.99, '2022-05-02 22:00:24'),
(25, 23.99, '2022-05-03 10:00:24'),
(25, 23.99, '2022-05-03 15:18:21'),
(25, 23.99, '2022-05-03 22:00:24'),
(25, 23.99, '2022-05-04 10:00:25'),
(25, 23.99, '2022-05-04 22:00:27'),
(25, 23.99, '2022-05-05 10:00:25'),
(26, 9.99, '2022-04-24 09:21:08'),
(26, 9.99, '2022-04-24 22:00:27'),
(26, 9.99, '2022-04-25 10:00:26'),
(26, 9.99, '2022-04-25 22:00:27'),
(26, 9.99, '2022-04-26 10:00:26'),
(26, 9.99, '2022-04-26 22:00:25'),
(26, 9.99, '2022-04-27 10:00:27'),
(26, 9.99, '2022-04-27 22:00:36'),
(26, 9.99, '2022-04-28 10:00:25'),
(26, 9.99, '2022-04-28 22:00:26'),
(26, 9.99, '2022-04-29 10:00:27'),
(26, 9.99, '2022-04-29 22:00:27'),
(26, 9.99, '2022-04-30 10:00:27'),
(26, 9.99, '2022-04-30 22:00:29'),
(26, 9.99, '2022-05-01 10:00:29'),
(26, 9.99, '2022-05-01 19:41:57'),
(26, 9.99, '2022-05-02 10:00:27'),
(26, 9.99, '2022-05-02 22:00:26'),
(26, 9.99, '2022-05-03 10:00:27'),
(26, 9.99, '2022-05-03 15:18:23'),
(26, 9.99, '2022-05-03 22:00:26'),
(26, 9.99, '2022-05-04 10:00:27'),
(26, 9.99, '2022-05-04 22:00:29'),
(26, 9.99, '2022-05-05 10:00:27'),
(27, 8.99, '2022-04-25 21:40:39'),
(27, 0, '2022-04-26 10:00:27'),
(27, 0, '2022-04-26 22:00:27'),
(27, 8.99, '2022-04-27 10:00:29'),
(27, 8.99, '2022-04-27 22:00:38'),
(27, 0, '2022-04-28 10:00:27'),
(27, 0, '2022-04-28 22:00:28'),
(27, 8.99, '2022-04-29 10:00:29'),
(27, 8.99, '2022-04-29 22:00:28'),
(27, 0, '2022-05-01 19:48:17'),
(27, 8.99, '2022-05-02 10:00:29'),
(27, 0, '2022-05-02 22:00:29'),
(27, 0, '2022-05-03 10:00:29'),
(27, 0, '2022-05-03 15:18:26'),
(27, 0, '2022-05-03 22:00:29'),
(27, 0, '2022-05-04 10:00:29'),
(27, 0, '2022-05-04 22:00:31'),
(27, 0, '2022-05-05 10:00:29'),
(28, 160, '2022-04-28 11:03:15'),
(28, 160, '2022-04-28 22:00:30'),
(28, 160, '2022-04-29 10:00:31'),
(28, 160, '2022-04-29 22:00:31'),
(28, 160, '2022-04-30 10:00:32'),
(28, 160, '2022-04-30 22:00:33'),
(28, 160, '2022-05-01 10:00:33'),
(28, 160, '2022-05-01 19:42:02'),
(28, 160, '2022-05-02 10:00:31'),
(28, 160, '2022-05-02 22:00:31'),
(28, 160, '2022-05-03 10:00:32'),
(28, 160, '2022-05-03 15:18:28'),
(28, 160, '2022-05-03 22:00:31'),
(28, 160, '2022-05-04 10:00:32'),
(28, 160, '2022-05-04 22:00:34'),
(28, 160, '2022-05-05 10:00:32'),
(29, 8.5, '2022-04-30 07:13:51'),
(29, 8.5, '2022-04-30 22:00:35'),
(29, 8.58, '2022-05-01 10:00:35'),
(29, 8.58, '2022-05-01 19:42:04'),
(29, 8.58, '2022-05-02 10:00:33'),
(29, 8.58, '2022-05-02 22:00:33'),
(29, 8.58, '2022-05-03 10:00:34'),
(29, 8.58, '2022-05-03 15:18:30'),
(29, 8.58, '2022-05-03 22:00:33'),
(29, 8.58, '2022-05-04 10:00:34'),
(29, 8.58, '2022-05-04 22:00:36'),
(29, 8.58, '2022-05-05 10:00:34'),
(30, 9.99, '2022-04-30 07:16:22'),
(30, 9.99, '2022-04-30 22:00:37'),
(30, 9.99, '2022-05-01 10:00:37'),
(30, 9.99, '2022-05-01 19:42:06'),
(30, 9.99, '2022-05-02 10:00:35'),
(30, 9.99, '2022-05-02 22:00:35'),
(30, 9.99, '2022-05-03 10:00:36'),
(30, 9.99, '2022-05-03 15:18:33'),
(30, 9.99, '2022-05-03 22:00:36'),
(30, 9.99, '2022-05-04 10:00:36'),
(30, 9.99, '2022-05-04 22:00:38'),
(30, 9.99, '2022-05-05 10:00:36'),
(31, 122.99, '2022-04-30 09:42:40'),
(31, 122.99, '2022-04-30 22:00:39'),
(31, 122.99, '2022-05-01 10:00:39'),
(31, 122.99, '2022-05-01 19:42:08'),
(31, 122.99, '2022-05-02 10:00:37'),
(31, 122.99, '2022-05-02 22:00:37'),
(31, 122.99, '2022-05-03 10:00:38'),
(31, 122.99, '2022-05-03 15:18:34'),
(31, 122.99, '2022-05-03 22:00:37'),
(31, 122.99, '2022-05-04 10:00:37'),
(31, 122.99, '2022-05-04 22:00:40'),
(31, 122.99, '2022-05-05 10:00:38'),
(32, 780, '2022-04-30 09:43:28'),
(32, 780, '2022-04-30 22:00:41'),
(32, 780, '2022-05-01 10:00:41'),
(32, 780, '2022-05-01 19:42:10'),
(32, 780, '2022-05-02 10:00:39'),
(32, 780, '2022-05-02 22:00:39'),
(32, 780, '2022-05-03 10:00:40'),
(32, 780, '2022-05-03 15:18:36'),
(32, 780, '2022-05-03 22:00:39'),
(32, 780, '2022-05-04 10:00:40'),
(32, 780, '2022-05-04 22:00:42'),
(32, 811, '2022-05-05 10:00:40'),
(33, 219.99, '2022-04-30 13:41:38'),
(33, 219.99, '2022-04-30 22:00:43'),
(33, 219.99, '2022-05-01 10:00:43'),
(33, 219.99, '2022-05-01 19:42:12'),
(33, 259.99, '2022-05-02 10:00:42'),
(33, 259.99, '2022-05-02 22:00:42'),
(33, 259.99, '2022-05-03 10:00:42'),
(33, 259.99, '2022-05-03 15:18:39'),
(33, 259.99, '2022-05-03 22:00:42'),
(33, 259.99, '2022-05-04 10:00:42'),
(33, 259.99, '2022-05-04 22:00:45'),
(33, 259.99, '2022-05-05 10:00:43'),
(34, 15.99, '2022-05-01 08:18:04'),
(34, 15.99, '2022-05-01 19:42:14'),
(34, 12.79, '2022-05-02 10:00:44'),
(34, 12.79, '2022-05-02 22:00:44'),
(34, 12.79, '2022-05-03 10:00:45'),
(34, 12.79, '2022-05-03 15:18:41'),
(34, 12.79, '2022-05-03 22:00:44'),
(34, 12.79, '2022-05-04 10:00:44'),
(34, 12.79, '2022-05-04 22:00:47'),
(34, 12.79, '2022-05-05 10:00:45'),
(35, 29.99, '2022-05-01 08:19:30'),
(35, 29.99, '2022-05-01 19:42:18'),
(35, 29.99, '2022-05-02 10:00:47'),
(35, 29.99, '2022-05-02 22:00:47'),
(35, 33.99, '2022-05-03 10:00:47'),
(35, 33.99, '2022-05-03 15:18:44'),
(35, 33.99, '2022-05-03 22:00:47'),
(35, 27.99, '2022-05-04 10:00:47'),
(35, 27.99, '2022-05-04 22:00:49'),
(35, 27.99, '2022-05-05 10:00:47'),
(36, 24.89, '2022-05-01 17:51:11'),
(36, 24.89, '2022-05-02 10:00:50'),
(36, 24.89, '2022-05-02 22:00:49'),
(36, 24.89, '2022-05-03 10:00:50'),
(36, 24.89, '2022-05-03 15:18:47'),
(36, 24.89, '2022-05-03 22:00:49'),
(36, 24.89, '2022-05-04 10:00:50'),
(36, 24.89, '2022-05-04 22:00:52'),
(36, 24.89, '2022-05-05 10:00:50'),
(37, 4.99, '2022-05-03 06:43:47'),
(37, 4.99, '2022-05-03 15:18:49'),
(37, 4.99, '2022-05-03 22:00:51'),
(37, 4.99, '2022-05-04 10:00:52'),
(37, 4.99, '2022-05-04 22:00:54'),
(37, 4.99, '2022-05-05 10:00:52'),
(39, 43.6, '2022-05-03 19:30:38'),
(39, 43.6, '2022-05-04 10:00:54'),
(39, 43.6, '2022-05-04 22:00:56'),
(39, 36.1, '2022-05-05 10:00:54'),
(40, 16.99, '2022-05-03 19:30:50'),
(40, 16.99, '2022-05-04 10:00:57'),
(40, 16.99, '2022-05-04 22:00:59'),
(40, 16.99, '2022-05-05 10:00:57'),
(41, 34.49, '2022-05-03 19:31:35'),
(41, 34.49, '2022-05-04 10:00:59'),
(41, 34.9, '2022-05-04 22:01:02'),
(41, 34.9, '2022-05-05 10:01:00'),
(42, 13.06, '2022-05-03 19:32:12'),
(42, 13.06, '2022-05-04 10:01:02'),
(42, 13.06, '2022-05-04 22:01:04'),
(42, 13.06, '2022-05-05 10:01:02'),
(43, 9.99, '2022-05-03 19:32:27'),
(43, 9.99, '2022-05-04 10:01:04'),
(43, 9.99, '2022-05-04 22:01:06'),
(43, 9.99, '2022-05-05 10:01:04'),
(44, 20.99, '2022-05-03 19:32:48'),
(44, 20.99, '2022-05-04 10:01:06'),
(44, 20.99, '2022-05-04 22:01:08'),
(44, 20.99, '2022-05-05 10:01:06'),
(45, 27.99, '2022-05-03 19:37:12'),
(45, 27.99, '2022-05-04 10:01:08'),
(45, 27.99, '2022-05-04 22:01:10'),
(45, 27.99, '2022-05-05 10:01:09'),
(46, 24.99, '2022-05-05 12:51:41'),
(47, 7.39, '2022-05-05 13:06:40');

--
-- Trigger `price`
--
DELIMITER $$
CREATE TRIGGER `min_max_price_update` AFTER INSERT ON `price` FOR EACH ROW BEGIN
DECLARE max_value double;
DECLARE min_value double;
SET max_value = (SELECT highestPrice FROM product WHERE new.productId = id);
SET min_value = (SELECT lowestPrice FROM product WHERE new.productId = id);
IF max_value < new.price	
	THEN UPDATE product SET highestPrice = new.price WHERE id = new.productId;
end if;
IF min_value > new.price	
	THEN UPDATE product SET lowestPrice = new.price WHERE id = new.productId;
    ELSEIF min_value = 0
    THEN UPDATE product SET lowestPrice = new.price WHERE id = new.productId;
end if;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateProductLastUpdate` AFTER INSERT ON `price` FOR EACH ROW BEGIN
UPDATE product SET lastUpdate = NOW() where id=new.productId;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `priceDrop`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `priceDrop` (
`productId` int(11)
,`priceDrop` double(19,2)
,`lastPrice` double
,`updatedAt` timestamp
);

-- --------------------------------------------------------

--
-- Struttura della tabella `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `link` text NOT NULL,
  `name` text NOT NULL,
  `shortName` varchar(255) NOT NULL DEFAULT '',
  `category` varchar(255) NOT NULL DEFAULT 'generic',
  `description` text NOT NULL,
  `lowestPrice` double NOT NULL DEFAULT 0,
  `highestPrice` double NOT NULL DEFAULT 0,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `lastUpdate` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `product`
--

INSERT INTO `product` (`id`, `link`, `name`, `shortName`, `category`, `description`, `lowestPrice`, `highestPrice`, `createdAt`, `lastUpdate`) VALUES
(13, 'https://www.amazon.it/Lavazza-Capsule-caffe-Modo-Intenso/dp/B07KGGD8FR', 'Lavazza 180 capsule caffè modo mio intenso', 'Lavazza 180 capsule caffè modo mio intenso', 'generic', '.', 38.5, 39.59, '2022-04-09 08:13:13', '2022-05-05 10:00:04'),
(15, 'https://www.amazon.it/Oral-B-Spazzolino-Tecnologia-CleanMaximiser-Confezione/dp/B08BLGKHD9', 'Oral-b cross action testine spazzolino elettrico, confezione da 10 pezzi, con tecnologia cleanmaximise, pacco adatto alla buca delle lettere, nero', 'Oral b spazzolino tecnologia cleanmaximiser confezione', 'generic', 'Consegna facile: confezione da 10 testine di ricambio Oral-B Cross Action con dimensioni adatte alla buca delle lettere. Con la tecnologia CleanMaximiser, le setole da verdi diventano gialle quando è il momento di sostituire la testina. La testina rimuove fino al 100% di placca per gengive sane rispetto ad uno spazzolino manuale tradizionale. I dentisti raccomandano di cambiare lo spazzolino ogni 3 mesi per una pulizia efficace. Compatibile con tutti gli spazzolini Oral-B, tranne Pulsonic e iO. Da Oral-B, la marca di spazzolini più usata dai dentisti nel mondo*.', 24.99, 44.88, '2022-04-14 09:10:18', '2022-05-05 10:00:07'),
(16, 'https://www.amazon.it/AmazonBasics-larghe-tampone-pollici-colore/dp/B00QSR9PRI', 'Amazon basics - legal/larghe a righe, 50 fogli per tampone da 5 pollici, da 8 pollici, colore: bianco', 'Amazonbasics larghe tampone pollici colore', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Amazon è un marchio.', 23.48, 24.92, '2022-04-14 09:33:56', '2022-05-05 10:00:09'),
(17, 'https://www.amazon.it/AmazonBasics-larghe-tampone-pollici-colore/dp/B00QSR9PRI/', 'Amazon basics - legal/larghe a righe, 50 fogli per tampone da 5 pollici, da 8 pollici, colore: bianco', 'Amazonbasics larghe tampone pollici colore', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Amazon è un marchio.', 23.48, 24.92, '2022-04-14 09:42:34', '2022-05-05 10:00:11'),
(18, 'https://www.amazon.it/Queshark-Occhiali-Ciclismo-Polarizzati-Intercambiabili/dp/B07ZRP7SY9', 'Queshark occhiali da ciclismo polarizzati con 3 lenti intercambiabili per uomo donna uv 400', 'Queshark occhiali ciclismo polarizzati intercambiabili', 'generic', 'TRE LENTI INTERCAMBIABILI- Tutte le lenti con rivestimento protettivo al 100% UV400, bloccano i raggi UVA e UVB dannosi al 100%. Ripristina il vero colore, elimina la luce riflessa e la luce diffusa ， rende lo scenario più chiaro e morbido e protegge perfettamente gli occhi. Quello principale è una lente colorata, quello posteriore è polarizzato per la guida e altre attività.. CHIARO, SUPERLIGHT, ELEGANTE E DUREVOLE - Design dell\'obiettivo di grandi dimensioni, molto alla moda e alla moda. Il design leggero è ideale per moto e bici da ciclismo, guida, corsa, pesca, corsa, sci, arrampicata, trekking o altre attività all\'aperto. Moda e design elegante, con ricche combinazioni di colori di montature e lenti. Le lenti e le montature in policarbonato sono resistenti agli urti, ai graffi, durevoli e infrangibili.. SOFT PUB NOSE PAD, lascia che il tuo naso si senta a tuo agio mentre indossi gli occhiali da sole QUESHARK Sports per ciclismo e pesca Golf. Con una montatura per miopia Se sei miope, questo sarà molto utile.. GARANZIA DI ROTTURA A VITA SU TELAIO - Le montature e le lenti sono infrangibili per nessun rischio di acquisto. In caso di problemi rotti, contattare il venditore di Torege senza esitazione per risolvere il problema fino alla soddisfazione. QUESHARK offre un servizio post-vendita a vita per tutti i prodotti Queshark.. GARANZIA DI RIMBORSO DI 30 GIORNI- Tutti i clienti QUESHARK godono della garanzia di rimborso di 30 giorni. I clienti possono restituire e ottenere il rimborso nel caso in cui l\'acquisto non sia soddisfacente per qualsiasi motivo. Non hai rischi di provare..', 23.19, 28.99, '2022-04-14 10:59:14', '2022-05-05 10:00:13'),
(19, 'https://www.amazon.it/AmazonBasics-Sedia-ufficio-schienale-basso/dp/B016ID34BO/', 'Amazon basics - sedia da ufficio con schienale basso', 'Amazon basics - sedia da ufficio con schienale basso', 'generic', 'Sedia da ufficio rivestita in tessuto nero.. Seduta e schienale imbottiti per garantire il massimo comfort e supporto.. Regolazione pneumatica dell\'altezza della seduta; rotazione a 360°; rotelle scorrevoli.. Peso massimo supportato di 110 kg; istruzioni di assemblaggio incluse.. Misura 64 x 47,5 x 87,9 - 96 cm (L x l x A); ..', 64.47, 75.85, '2022-04-14 10:59:42', '2022-05-05 10:00:15'),
(20, 'https://www.amazon.it/Giesswein-Neudau-Pantofole-Unisex-Adulto-Schiefer/dp/B00264FX4Q/', 'Giesswein neudau 42471, pantofole unisex adulto', 'Giesswein neudau 42471, pantofole unisex adulto', 'generic', 'Materiale esterno: Tessuto. Fodera: Lana. Materiale suola: Gomma. Chiusura: Senza Chiusura. Tipo di tacco: Piatto. Larghezza scarpa: medium.', 0, 49.99, '2022-04-20 20:03:21', '2022-05-05 10:00:17'),
(22, 'https://www.amazon.it/Oral-B-CrossAction-Spazzolino-Tecnologia-CleanMaximiser/dp/B086TX9BWR', 'Oral-b cross action testine spazzolino elettrico, confezione da 10 pezzi, con tecnologia cleanmaximise, pacco adatto alla buca delle lettere, bianco', 'Oral b crossaction spazzolino tecnologia cleanmaximiser', 'generic', 'Con la tecnologia CleanMaximiser, le setole da verdi diventano gialle quando è il momento di sostituire la testina. Rimozione della placca fino al 100 % in più e gengive più sane rispetto ad uno spazzolino manuale tradizionale. Oral-B è ottimale per una pulizia completa della bocca (escluso Oral-B iO). Ottimamente inclinata a 16 gradi per arrivare in profondità negli spazi interdentali e rimuovere la placca. Compatibile con tutti gli spazzolini Oral-B, tranne Pulsonic e iO. Dalla marca di spazzolini usata dai dentisti. Numero di testine per spazzolino incluse nella confezione: 10.', 23.99, 37.55, '2022-04-23 13:16:31', '2022-05-05 10:00:19'),
(23, 'https://www.amazon.it/Apple-iPhone-13-128-GB/dp/B09V4KBWPL/ref=mp_s_a_1_1_sspa', 'Apple iphone 13 (128 gb) - verde', 'Apple iphone 13 (128 gb) - verde', 'generic', 'Display Super Retina XDR da 6,1\". Modalità Cinema con profondità di campo smart e spostamento automatico della messa a fuoco nei video. Evoluto sistema a doppia fotocamera da 12MP (grandangolo e ultra-grandangolo) con Stili fotografici, Smart HDR 4, modalità Notte e registrazione video HDR a 4K con Dolby Vision. Fotocamera anteriore TrueDepth da 12MP con modalità Notte e registrazione video HDR a 4K con Dolby Vision. Chip A15 Bionic per prestazioni fulminee. Fino a 19 ore di riproduzione video. Robusto design con Ceramic Shield. Resistenza all’acqua di grado IP68, la migliore del settore. 5G per download velocissimi e streaming ad alta qualità. iOS 15 e le sue nuove funzioni per fare ancora di più con iPhone.', 799, 939, '2022-04-23 15:57:23', '2022-05-05 10:00:21'),
(24, 'https://www.amazon.it/Starbucks-Tostatura-tostato-Morbido-cioccolato/dp/B07P8N1PZ1/ref=mp_s_a_1_2_sspa', 'Starbucks 4427 caffè tostato, 200 g', 'Starbucks 4427 caffè tostato, 200 g', 'generic', 'Buona resistenza alla corrosione, resistenza al calore. Non è facile da rompere, è robusta e resistente. Scelta intelligente per le necessità quotidiane.', 18.24, 23.74, '2022-04-23 15:58:35', '2022-05-05 10:00:23'),
(25, 'https://www.amazon.it/Apple-Cavo-Lightning-USB-1-m/dp/B081FWVSG8/ref=mp_s_a_1_3', 'Apple cavo da lightning a usb (1 m)', 'Apple cavo da lightning a usb (1 m)', 'generic', 'Con il cavo da lightning a usb ricarichi il tuo iphone o ipod con connettore lightning e li sincronizzi al tuo mac o pc windows. Double face. 1m.', 23.99, 23.99, '2022-04-23 15:59:18', '2022-05-05 10:00:25'),
(26, 'https://www.amazon.it/Airwick-Profumatore-Diffusore-Bastoncini-dellHimalaya/dp/B08K9B1QYK/ref=mp_s_a_1_3', 'Airwick botanica, profumatore per ambienti con diffusore a bastoncini, fragranza vaniglia e magnolia dell\'himalaya, fragranza naturale, confezione da 80 ml', 'Airwick profumatore diffusore bastoncini dellhimalaya', 'generic', 'LA CONFEZIONE: La confezione contiene 1 profumatore per ambienti a bastoncini Airwick Botanica, fragranza Vaniglia e Magnolia dell\'Himalaya. LA FRAGRANZA: Riempi la tua casa con il profumo della Vaniglia addolcito dalla nota di Magnolia dell’Himalaya. I BASTONCINI: I Bastoncini di Rattan naturale diffondono la fragranza delicatamente non alterando l’autentico profumo degli ingredienti naturali. LA DURATA DELLA FRAGRANZA: Il profumatore a bastoncini di Botanica può durare fino a 45 giorni. L\'ATTENZIONE PER L\'AMBIENTE: Le fragranze Botanica sono realizzate con ricercati ingredienti naturali, attentamente selezionati in modo da rispettare il nostro pianeta; non ci sono coloranti, no test sugli animali sul prodotto finito, no Ftalati, ingredienti naturali selezionati responsabilmente.', 9.99, 9.99, '2022-04-24 09:21:08', '2022-05-05 10:00:27'),
(27, 'https://www.amazon.it/Roits-Calze-Avocado-Nero-36-40/dp/B0814Z9RGT/ref=mp_s_a_1_1_sspa', 'Roits calze avocado nero uomo donna - calzini fantasia disegni divertenti colorati', 'Roits calze avocado nero 36 40', 'generic', 'QUALITÀ SUPERIORE - Le nostre calze sono realizzate in cotone pettinato di altissima qualità e sono certificate OEKO-TEX. La pettinatura in cotone elimina le fibre più corte. Questo processo migliora la qualità del capo, poiché le fibre lunghe sono molto più resistenti e si rompono meno facilmente, oltre ad essere più morbide al tatto.. PRODOTTI IN SPAGNA - La qualità dei prodotti spagnoli è innegabile. Produciamo tutti i nostri prodotti in una piccola fabbrica a Valencia, che ci consente di controllare molto meglio il processo di produzione e garantire la qualità finale. Inoltre, uno dei principali obiettivi del nostro marchio è promuovere l\'economia locale e collaborare con piccoli produttori.. PERFETTO PER IL REGALO - Fare il disegno giusto è la tua cosa, ma ti assicuriamo che i nostri disegni porteranno un sorriso al destinatario. Inoltre, non sono solo una bella sorpresa, ma diventano uno strumento che può illuminare la tua mattina ogni volta che li indossi.. COMPOSIZIONE - 80% cotone pettinato, 15% poliammide, 5% elastan. Utilizziamo la più alta percentuale di cotone possibile per favorire il comfort e l\'assorbimento del sudore, al fine di prevenire la comparsa di cattivi odori. La poliammide fornisce ulteriore morbidezza ed elastan aggiunge l\'elasticità necessaria per adattarsi a ciascun piede e rimanere in posizione.. MARCHIO STABILITO NEL SETTORE - Per coloro che non ci conoscono, Roits Socks è un marchio che vende calze sia online che nei negozi fisici da diversi anni. Collaboriamo con designer e influencer per dare vita ai nostri modelli..', 0, 8.99, '2022-04-25 21:40:39', '2022-05-05 10:00:29'),
(28, 'https://www.amazon.it/Orologio-Smartwatch-Monitoraggio-Batteria-Bluetooth/dp/B0999CRXJF', 'Samsung galaxy watch4 44mm orologio smartwatch, monitoraggio salute, fitness tracker, batteria lunga durata, bluetooth, verde (green), 2021 [versione italiana]', 'Orologio smartwatch monitoraggio batteria bluetooth', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Impara a conoscere il tuo corpo – Monitora i tuoi progressi di fitness con il nostro primo smartwatch che misura comodamente la composizione corporea. Monitora i tuoi passi e gareggia con gli amici in una competizione divertente tramite una bacheca in tempo reale. Le sfide prevedono medaglie e un sistema a punti per rendere l’esercizio socialmente divertente, stimolante e gratificante. Fitness Tracking – monitora attività e punteggi di fitness sul tuo smartwatch android. Conta i passi, controlla le calorie e sfrutta il GPS durante lo sport. Pressione sanguigna ed elettrocardiogramma - Il sensore Samsung BioActive di questo orologio fitness ti permette il monitoraggio ECG e la misurazione della pressione sanguigna in tempo reale. La funzione di monitoraggio del sonno dello smartwatch rileva e analizza mediante approccio olistico le fasi del tuo sonno mentre riposi. Opzioni di misurazione avanzate ti consentono inoltre di controllare i livelli di ossigeno nel sangue e il tuo russare. Contenuto confezione: Galaxy Watch, stazione di ricarica, guida rapida.', 160, 160, '2022-04-28 11:03:15', '2022-05-05 10:00:32'),
(29, 'https://www.amazon.it/AmazonBasics-A6-Ruled-Index-Cards/dp/B07JBCG9FJ', 'Amazon basics, cartoncini a6, a righe, colori assortiti (confezione da 200)', 'Amazonbasics a6 ruled index cards', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Confezione da 200 cartoncini in 4 diversi colori fluo. Ideali per progetti di codifica con colori, per creare flashcard, studiare, realizzare liste e molto altro. Prodotto di qualità ingegneristica con preciso taglio dei bordi per dimensioni uniformi. Con righe su un lato per rendere più semplice prendere appunti. Dimensioni: 5.67*4.12 inch.', 8.5, 8.58, '2022-04-30 07:13:51', '2022-05-05 10:00:34'),
(30, 'https://www.amazon.it/Wedo-2506303-Schedario-Riempito-Trasparente/dp/B004RLPMRE/', 'Wedo 2506303 box schedario riempito, a6/200, 15.9 x 8.3 x 13.7 cm, trasparente/blu', 'Wedo 2506303 schedario riempito trasparente', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Box schedario din a6. Con un indice alfabetico in cartoncino e 100 schede bianche a righe. In plastica trasparente blu e con una chiusura a scatto. Trasversale DIN A6 per ca. 200 carte, blu traslucido di plastica, incl. 100 schede e schede, 15,9 x 8,3 x 13,7 cm.', 9.99, 9.99, '2022-04-30 07:16:22', '2022-05-05 10:00:36'),
(31, 'https://www.amazon.it/Apple-MU8F2ZM-A-Pencil-seconda-generazione/dp/B07K2PK3BV/ref=mp_s_a_1_2_sspa', 'Apple pencil (seconda generazione)', 'Apple pencil (seconda generazione)', 'generic', 'Con Apple Pencil (2a generazione), ogni tuo lavoro prende vita.. Ha una latenza impercettibile, è precisa fino all’ultimo pixel ed è sensibile all’inclinazione e alla pressione. All’occorrenza si trasforma in un pennello, un carboncino o una matita, ed è pronta a diventare il tuo strumento creativo preferito.. Dipingere, disegnare, prendere appunti e scarabocchiare non è mai stato così bello.. Si aggancia magneticamente al tuo iPad Pro e iPad Air, si ricarica in wireless e ti fa cambiare strumento con un semplice doppio tap.. Compatibile con iPad Pro 12,9\" (3a, 4a e 5a generazione), iPad Pro 11\" (1a, 2a e 3a generazione) e iPad Air (4a generazione)..', 122.99, 122.99, '2022-04-30 09:42:40', '2022-05-05 10:00:38'),
(32, 'https://www.amazon.it/2022-Apple-iPad-Air-Wi-Fi-256GB/dp/B09V4LHHJ8/', '2022 apple ipad air (wi-fi, 256gb) - grigio siderale (5a generazione)', '2022 apple ipad air wi fi 256gb', 'generic', 'Display Liquid Retina da 10,9\"1 con True Tone, ampia gamma cromatica P3 e rivestimento antiriflesso. Chip Apple M1 con Neural Engine. Grandangolo da 12MP. Fotocamera frontale da 12MP con ultra‐grandangolo e Inquadratura automatica. Fino a 256GB di archiviazione. Disponibile nei colori blu, viola, rosa, galassia e grigio siderale. Altoparlanti stereo in orizzontale. Touch ID per l’autenticazione sicura e Apple Pay. Un giorno intero di batteria. Wi-Fi 6 e reti cellulari 5G.', 780, 811, '2022-04-30 09:43:28', '2022-05-05 10:00:40'),
(33, 'https://www.amazon.it/UMI-Amazon-Ergonomica-Regolabile-Traspirante/dp/B081HWKWN6', 'Amazon brand – umi sedia ergonomica da ufficio-sedia da scrivania per computer con supporto lombare regolabile e braccioli in pu-schienale traspirante a rete e seduta imbottita-carico massimo 150 kg', 'Umi amazon ergonomica regolabile traspirante', 'generic', 'Schienale classico: l\'esterno è realizzato in nylon ecosostenibile, robusto, resistente e sicuro. Lo schienale a S è formato da un cuscino lombare regolabile che si adatta alla tua colonna cervicale e alle vertebre lombari riducendo i dolori alla schiena. Se studiare o lavorare alla scrivania per periodi prolungati ti provoca fastidi, puoi inclinare lo schienale a 102-110-130° per rilassare testa e schiena.. Traspirante e confortevole: schienale e poggiatesta sono realizzati in rete di poliestere di alta qualità che mantiene la tua schiena fresca e comoda. La seduta è imbottita con schiuma ad alta densità che non si deforma e ti supporta tutto il giorno.. Regolabile a piacimento: il poggiatesta e i braccioli rendono questa sedia ancora più ergonomica, sia il poggiatesta che i braccioli sono regolabili in altezza in base al tuo corpo e potrai sempre trovare la posizione perfetta per supportare collo, colonna cervicale, spalle e braccia per rilassarti. È adattabile a qualsiasi spazio e ambiente di lavoro.. Sicura e affidabile: il pistone in acciaio a tre stadi e le gambe in nylon sono in grado di reggere fino a 150 kg di peso e sono certificati BIFMA e SGS. Il telaio in acciaio è spesso e a prova di cedimento, pensato per durare lungo. Le ruote sono silenziose, girevoli a 360°, rivestite in PU e adatte a quasi tutte le superfici.. Servizio premium: questa sedia executive da ufficio è coperta da 3 anni di garanzia. In caso di difetti, contattaci immediatamente e faremo del nostro meglio per risolvere il tuo problema. Questa splendida sedia a rete include anche istruzioni passo passo e tutti gli accessori di montaggio..', 219.99, 259.99, '2022-04-30 13:41:38', '2022-05-05 10:00:43'),
(34, 'https://www.amazon.it/dp/B084V4VKB6/ref=cm_gf_aack_iaaa_mB_p0_e0_qd0_bsWgP3Qjx7PWnNsdaXvi', 'Lamicall supporto telefono regolabile, dock telefono - universale supporto dock per iphone 12 mini, 12 pro max, 11 pro, xs max, x, xr, 8, 7, 6 plus, samsung s10 s9 s8, huawei, altri smartphone - nero', 'Lamicall supporto telefono regolabile, dock telefono - universale supporto dock per iphone 12 mini, 12 pro max, 11 pro, xs max, x, xr, 8, 7, 6 plus, samsung s10 s9 s8, huawei, altri smartphone - nero', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. 【Supporto Telefono Regolabile】 Goditi il ​​perfetto angolo di visione quando usi FaceTime e guardi film. Il design regolabile offre una visione favolosa conforme al design ergonomico.. 【Squisita fattura】 Robusta lega di alluminio, bordo liscio, leggero, portatile, supporto per telefono in metallo freddo, design con centro a bassa gravità.. 【Compatibilità universale】 Supporto universale per iPhone e smartphone da 3,5 ~ 8 pollici, come iPhone 12 Mini, 12 Pro Max, 11 Pro Xs Xs Max XR X 8 7 6 6s Plus SE 5 5s 5c 4 4s dock, Switch, Huawei, Samsung Galaxy S10 S9 S8 S7 S6, Nota 6 5, LG, Sony, Nexus, telefoni Apple, anche questi telefoni con cover (lo spessore del telefono con custodia dovrebbe essere inferiore a 14 mm).. 【Caratteristiche e protezione】 I cuscini in gomma offrono una protezione completa, proteggono il tuo dispositivo da graffi e scivoli.. 【Che Speciale】 Distinto da design minimalista, pregevole fattura e angolo di visione regolabile. Ospita il tuo dispositivo con un solido supporto ovunque tu vada, come ufficio, soggiorno, cucina, ecc..', 12.79, 15.99, '2022-05-01 08:18:04', '2022-05-05 10:00:45'),
(35, 'https://www.amazon.it/amazon-echo-dot-3-generazione-altoparlante-intelligente-con-integrazione-alexa-tessuto-antracite/dp/B07PHPXHQS/ref=mp_s_a_1_1', 'Echo dot (3ª generazione) - altoparlante intelligente con integrazione alexa - tessuto antracite', 'Amazon echo dot 3 generazione altoparlante intelligente con integrazione alexa tessuto antracite', 'generic', 'Ti presentiamo Echo Dot - Il nostro altoparlante intelligente più venduto, con un rivestimento in tessuto, che si adatta perfettamente anche agli spazi più piccoli.. Controlla la musica con la tua voce – Ascolta brani in streaming da Amazon Music, Apple Music, Spotify, TuneIn e altri servizi musicali. Con Audible puoi anche ascoltare i tuoi audiolibri preferiti.. Audio più ricco e potente - Associalo a un altro Echo Dot (3ª generazione) per un audio stereo potente. Per riempire di musica casa tua, puoi usare più dispositivi Echo compatibili in varie stanze.. Sempre pronta ad aiutarti - Chiedi ad Alexa di riprodurre musica, rispondere a domande, leggerti le ultime notizie, darti le previsioni del tempo, impostare sveglie, controllare dispositivi per Casa Intelligente compatibili e molto altro.. Resta sempre in contatto con gli altri - Chiama e invia messaggi senza dover usare le mani a chiunque possieda un dispositivo Echo, l’App Alexa o Skype. Con la funzione Drop In, puoi anche chiamare immediatamente un dispositivo Echo compatibile che si trova in un’altra stanza.. Personalizza Alexa con le Skill - Grazie alle centinaia di Skill disponibili, Alexa diventa sempre più intelligente e nuove funzionalità e Skill vengono aggiunte costantemente. Usale per monitorare i tuoi allenamenti, giocare e molto altro.. Controlla i dispositivi per Casa Intelligente con la voce - Usa la tua voce per accendere la luce, regolare un termostato e controllare altri dispositivi compatibili.. Progettato per tutelare la tua privacy - Echo è stato progettato con diversi elementi per la protezione e il controllo della privacy, tra cui un apposito pulsante per disattivare i microfoni..', 27.99, 33.99, '2022-05-01 08:19:30', '2022-05-05 10:00:47'),
(36, 'https://www.amazon.it/TP-Link-TL-SG108-Configurazione-Richiesta-Struttura/dp/B01EXDG2MO/ref=mp_s_a_1_2_sspa', 'Tp-link tl-sg108 switch 8 porte gigabit, 10/100/1000 mbps, plug & play, nessuna configurazione richiesta, struttura in acciaio', 'Tp link tl sg108 configurazione richiesta struttura', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Plug and play, nessuna configurazione richiesta. 8 porte RJ45 Gigabit con auto-negoziazione, supporta auto MDI / MDIX. Guscio in acciaio, predisposto per l\'installazione sul desktop o a parete. Spegnimento automatico delle porte inutilizzate per risparmiare energia. ATTENZIONE! Verifica la compatibilità di questo prodotto con altri dispositivi e con i servizi del tuo ISP prima di acquistarlo!.', 24.89, 24.89, '2022-05-01 17:51:10', '2022-05-05 10:00:50'),
(37, 'https://www.amazon.it/SPALMABILE-PERNIGOTTI-GIANDUIA-CIOCCOLATO-FONDENTE/dp/B014JLVONW/', 'Pernigotti crema gianduia nero, 350g', 'Pernigotti crema gianduia nero, 350g', 'generic', 'Crema gianduia fondente con il 30% di nocciole e il 14% di cacao: nocciole di prima scelta sapientemente tostate e solo la più pregiata miscela di cacao. Una golosa crema spalmabile ispirata alla tradizione dell’iconico Gianduiotto Nero Pernigotti, preparata con ingredienti di altissima qualità e un’elevata quantità di nocciole e cacao. Gusto autentico: senza olio di palma, senza glutine. La perfetta spalmabilità è ottenuta solo con i grassi naturalmente presenti nelle nocciole, nel cacao e nel burro di latte. Formato: vasetto da 350 gr. Pernigotti: tradizione dolciaria dal 1860.', 4.99, 4.99, '2022-05-03 06:43:47', '2022-05-05 10:00:52'),
(39, 'https://www.amazon.it/HP-Originale-Ciano-Magenta-Giallo/dp/B08N7V5F2W/ref=mp_s_a_1_3', 'Hp 302 originale nero, ciano, magenta, giallo', 'Hp 302 originale nero, ciano, magenta, giallo', 'generic', '.', 36.1, 43.6, '2022-05-03 19:30:38', '2022-05-05 10:00:54'),
(40, 'https://www.amazon.it/HP-Cartuccia-Originale-Getto-dInchiostro/dp/B00VYAWIRS/ref=mp_s_a_1_1_sspa', 'Hp 302 nero, f6u66ae, cartuccia originale hp, compatibile con stampanti hp deskjet 1110, 2130 e 3630, hp officejet 3830 e 4650', 'Hp cartuccia originale getto dinchiostro', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. COMPATIBILE CON IL SERVIZIO HP INSTANT INK: la stampante monitora i livelli di inchiostro, così riceverai le cartucce a casa ancora prima che tu rimanga senza. HP PENSA ALL\'AMBIENTE: oltre 4.7 miliardi di bottiglie di plastica non finiscono nelle discariche perché vengono impiegate nelle nuove cartucce di inchiostro originali HP. COMPATIBILITA\' STAMPANTI: HP Deskjet 1110, 2130, 3630, 3632, 3634, 3636, 3637, Envy 4520, 4522, 4524, 4525, 4526, 4527, 4528, Officejet 3830, 3833, 3835, 4650, 4652, 4654, 4655, 5220, e 5230. Ottima per stampare sia foto con qualità da laboratorio che documenti per tutti i giorni, con risultati uniformi e di alta qualità; rendimento medio di stampa in pagine: 190 Nero. Cartuccia con testina Integrata: ogni volta che si cambia la cartuccia alla stampante, la testina di stampa sarà nuova, offrendo così una definizione di stampa migliore, colori nitidi e precisi.', 16.99, 16.99, '2022-05-03 19:30:50', '2022-05-05 10:00:57'),
(41, 'https://www.amazon.it/HP-Cartuccia-Originale-dInchiostro-Tricromia/dp/B00VYAWKJY/ref=mp_s_a_1_1_sspa', 'Hp 302xl tricromia, f6u67ae, cartuccia originale hp, ad alta capacità, compatibile con stampanti hp deskjet 1110, 2130 e 3630, hp officejet 3830 e 4650, hp envy 4520', 'Hp cartuccia originale dinchiostro tricromia', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. COMPATIBILE CON IL SERVIZIO HP INSTANT INK: la stampante monitora i livelli di inchiostro, così riceverai le cartucce a casa ancora prima che tu rimanga senza. HP PENSA ALL\'AMBIENTE: oltre 4.7 miliardi di bottiglie di plastica non finiscono nelle discariche perché vengono impiegate nelle nuove cartucce di inchiostro originali HP. COMPATIBILITA\' STAMPANTI: HP Deskjet 1110, 2130, 3630, 3632, 3634, 3636, 3637, Envy 4520, 4522, 4524, 4525, 4526, 4527, 4528, Officejet 3830, 3833, 3835, 4650, 4652, 4654, 4655, 5220, e 5230. Ottima per stampare sia foto con qualità da laboratorio che documenti per tutti i giorni, con risultati uniformi e di alta qualità; rendimento medio di stampa in pagine: 330 Colore. Cartuccia con testina Integrata: ogni volta che si cambia la cartuccia alla stampante, la testina di stampa sarà nuova, offrendo così una definizione di stampa migliore, colori nitidi e precisi.', 34.49, 34.9, '2022-05-03 19:31:34', '2022-05-05 10:01:00'),
(42, 'https://www.amazon.it/Finish-Pastiglie-Lavastoviglie-All-Limone/dp/B089WVJD3M/ref=mp_s_a_1_1_sspa', 'Finish, 72 pastiglie per lavastoviglie, all in one max, limone', 'Finish pastiglie lavastoviglie all limone', 'generic', 'LA CONFEZIONE - Il pacco contiene 1 confezione da 72 pastiglie Finish All In 1 Max, Limone. FINISH ALL IN 1 MAX - Le pastiglie lavastoviglie All In 1 Max racchiudono 10 azioni in una pastiglia per una pulizia efficace e profonda. LA POLVERE - Il detersivo lavastoviglie in pastiglie con azione sgrassante e pretrattante rimuove facilmente le incrostazioni di cibo ardue, come uovo e sugo. LA POWERBALL - grazie alla tecnologia Finish Powerball, le pastiglie per lavastoviglie donano pulizia al primo lavaggio, anche a basse temperature. Per Il VETRO - Gli agenti salvavetro delle pastiglie Lavastoviglie Finish proteggono i tuoi bicchieri dalla corrosione del vetro. COME SI USA - le pastiglie sono nel pratico formato monodose e non hanno bisogno di essere scartate. L\'ATTENZIONE PER L\'AMBIENTE - La confezione è riciclabile. LA LAVASTOVIGLIE - I prodotti Finish sono progettati per essere utlizzati con tutte le principali marche di lavastoviglie: Finish è raccomandato da Beko, Bosch, LG, Neff, Siemens e Smeg (Fonte Nielsen 2019, Nielsen Homescan, Totale Italia, Prodotti per Lavastoviglie).', 13.06, 13.06, '2022-05-03 19:32:12', '2022-05-05 10:01:02'),
(43, 'https://www.amazon.it/Fairy-Pastiglie-Lavastoviglie-Tecnologia-Anti-Opaco/dp/B09SQB93QQ/ref=mp_s_a_1_2_sspa', 'Fairy platinum plus pastiglie lavastoviglie, 50 capsule lavastoviglie, detersivo lavastoviglie al limone, l\'ottima pulizia di fairy per stoviglie, tecnologia anti-opaco con azione brillante', 'Fairy pastiglie lavastoviglie tecnologia anti opaco', 'generic', 'OTTIME PASTIGLIE PER LAVASTOVIGLIE FAIRY: Fairy Platinum Plus rimuove le macchie di cibo più incrostato, lascia i piatti puliti e rimuove l\'opacità. EFFICACI NEI CICLI ECOLOGICI: Il sistema di prelavaggio integrato pretratta le stoviglie, consentendoti di risparmiare acqua; ogni pastiglia ha 3 camere per liquido e si dissolve rapidamente anche a temperature più basse.', 9.99, 9.99, '2022-05-03 19:32:27', '2022-05-05 10:01:04'),
(44, 'https://www.amazon.it/Fairy-Detersivo-Lavastoviglie-Confezione-Pastiglie/dp/B074KKMX11/ref=mp_s_a_1_8', 'Fairy platinum pastiglie lavastoviglie, 125 lavaggi, 5 x 25 capsule lavastoviglie, detersivo lavastoviglie al limone, con sistema di prelavaggio integrato, efficace nei cicli ecologici', 'Fairy detersivo lavastoviglie confezione pastiglie', 'generic', 'AZIONE RAPIDA CONTRO LO SPORCO OSTINATO: le pastiglie lavastoviglie Fairy Platinum rimuovono lo sporco ostinato fin dal primo lavaggio e rimuovono il grasso perfino dal filtro.. PIATTI BRILLANTI: Le pastiglie lavastoviglie Fairy Platinum regalano piatti brillanti, le capsule rimuovono lo sporco ostinato fin dal primo lavaggio.. FACILI DA USARE: le capsule lavastoviglie sono pronte all\'uso senza bisogno di scartare, sono solubili, posizionare semplicemente una capsula nel vano per il detergente della lavastoviglie prima di ogni ciclo di lavaggio.. PROFUMO DI FRESCO E PULITO: La tabs lavastoviglie Fairy Platinum sono delle capsule che rimuovo rimuovono l\'accumulo di grasso nel sistema di scarico, nei filtri e nel mulinello lasciando un profumo di fresco e di pulito nella tua lavastoviglie.. RACCOMANDATE DAI PRODUTTORI DI LAVASTOVIGLIE: Le capsule per la lavastoviglie Fairy Platinum sono raccomandate dai produttori di lavastoviglie a livello mondiale.. AZIONE BRILLANTANTE INTEGRATA: Fairy Platinum Tutto in Uno caps per lavastoviglie hanno la funzione del sale per lavastoviglie e un\'azione brillantante integrata, con protezione del vetro e dell’argento.. CONFEZIONE: Il pacco contiene 5 confezioni da 25 pastiglie lavastoviglie Fairy Platinum.. ABBONATI: Iscriviti e risparmia subito il 10% e fino al 15% sulle consegne automatiche dei tuoi detersivi Fairy..', 20.99, 20.99, '2022-05-03 19:32:48', '2022-05-05 10:01:06'),
(45, 'https://www.amazon.it/GPC-Image-sostituzione-Compatibili-SL-M2835DW/dp/B07FZVTG91/ref=mp_s_a_1_2_sspa', 'Gpc image compatibili cartucce di toner sostituzione per samsung mlt-d116l per xpress sl m2885fw m2825nd m2675fn m2625d m2875fd m2835dw m2875fw m2825dw m2825dw m2825 m2885 m2875 (nero, 2-pack)', 'Gpc image sostituzione compatibili sl m2835dw', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Contenuto del pacco: 2 nero cartucce toner mlt-d116l. Numero stimato di pagine: 3000 pagine per cartuccia toner d116l (con copertura del 5% di A4). Compatibili con: Samsung Xpress SL M2835dw M2625d M2825nd M2885fw M2825dw M2675 M2675fn M2875fd M2626 M2626d M2676 M2676n M2676fh M2825 M2825fd M2826 M2826nd M2875 M2875fw M2875nd M2875. GPC Image sostituzione compatibile per Samsung D116L MLT-D116L cartucce di toner. Le nostre cartucce per stampanti rendono sia il testo che le foto chiare e fluide.', 27.99, 27.99, '2022-05-03 19:37:11', '2022-05-05 10:01:09'),
(46, 'https://www.amazon.it/fire-tv-stick-con-telecomando-vocale-alexa/dp/B08C1KN5J2/ref=mp_s_a_1_1', 'Fire tv stick con telecomando vocale alexa (con comandi per la tv) | streaming in hd', 'Fire tv stick con telecomando vocale alexa', 'generic', 'La nuova generazione del nostro dispositivo per lo streaming più venduto - Il 50% più potente rispetto a Fire TV Stick (modello 2019) per uno streaming rapido e in Full HD. La confezione include il telecomando vocale Alexa con comandi per accensione/spegnimento e regolazione del volume.. Meno disordine, più controllo - Con il telecomando vocale Alexa puoi usare la voce per cercare e avviare la riproduzione di contenuti da varie app. I nuovi pulsanti preimpostati per le app ti permettono di aprirle rapidamente. Inoltre, puoi accendere e spegnere i dispositivi compatibili (TV e soundbar), nonché regolarne il volume, senza usare un altro telecomando.. Audio di qualità home theatre con supporto per il formato Dolby Atmos - Le immagini prenderanno vita con l’avvolgente audio Dolby Atmos, disponibile per alcuni titoli collegando Fire TV Stick a un impianto stereo compatibile.. Migliaia di canali, Skill Alexa e app disponibili, tra cui Netflix, YouTube, Prime Video, Disney+, NOW, DAZN, Mediaset Play Infinity, RaiPlay e altri. Potrebbe essere necessario un abbonamento separato.. Gli iscritti ad Amazon Prime hanno accesso illimitato a migliaia di film ed episodi di serie TV.. Programmi TV ed eventi sportivi in diretta - Guarda eventi in diretta con un abbonamento a DAZN, RaiPlay e Mediaset Infinity.. TV gratuita - Guarda film e serie TV da app come Pluto TV e YouTube.. Ascolta la musica - Ascolta contenuti in streaming da Amazon Music, Spotify e altri servizi. Potrebbe essere necessario un abbonamento separato.. Semplice e intuitiva - Accedi rapidamente alle tue app preferite e alle sezioni che usi più di frequente dal menu principale.. Configurazione semplice e design discreto - Inseriscila in un ingresso sul retro della TV, accendi quest\'ultima e connettiti a Internet per avviare la configurazione.. Certificato per gli umani - Zero affanni, zero fatica, zero stress: perdere la pazienza sarà solo un ricordo. È semplice!.', 24.99, 24.99, '2022-05-05 12:51:41', '2022-05-05 12:51:41'),
(47, 'https://www.amazon.it/KabelDirekt-compatibile-Ultra-1080p-Ethernet/dp/B004XISZ8E/ref=sxin_20', 'Kabeldirekt – 1 m – cavo hdmi 4k (4k@120 hz e 4k@60 hz per una spettacolare esperienza ultra hd – high speed con ethernet, compatibile con hdmi 2.0/1.4, blu-ray/ps4/ps5/xbox series x/switch, nero)', 'Kabeldirekt compatibile ultra 1080p ethernet', 'generic', 'Clicca qui per verificare la compatibilità di questo prodotto con il tuo modello. Universale: il cavo (connettore/connettore) collega televisori o monitor con lettori Blu-ray, console e altri dispositivi dotati di uscita HDMI, per una fantastica qualità video e audio. Più efficiente: il cavo supera i requisiti High-Speed grazie alla qualità di produzione di primo ordine e trasmette risoluzioni UHD-II-quali 8K@60 Hz e 4K@120 Hz (a max. 3 m), HDR, suono surround 7.1, ARC e perfino dati Ethernet. Pregiato: i cavi HDMI di KabelDirekt sono saldati a macchina e sottoposti a rigorosi test funzionali. I connettori placcati in oro, la schermatura multipla e i fili in rame a elevata purezza garantiscono un funzionamento senza problemi. 36 mesi di garanzia del produttore. Adatto per PC/portatili, console giochi, lettori Blu-ray/DVD, ricevitori TV e streaming, monitor, televisori, beamer/proiettori e qualsiasi dispositivo con attacco HDMI. Ulteriori accessori su amazon.it/kabeldirekt.', 7.39, 7.39, '2022-05-05 13:06:40', '2022-05-05 13:06:40');

--
-- Trigger `product`
--
DELIMITER $$
CREATE TRIGGER `addNumberOfTrackers` AFTER INSERT ON `product` FOR EACH ROW BEGIN
insert into numberOfTrackers(productId) values (new.id);
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `deleteNumberOfTrackers` AFTER DELETE ON `product` FOR EACH ROW BEGIN
delete from numberOfTrackers where productId = old.id;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `tracking`
--

CREATE TABLE `tracking` (
  `userId` int(11) NOT NULL,
  `productId` int(11) NOT NULL,
  `trackingSince` timestamp NOT NULL DEFAULT current_timestamp(),
  `dropValue` double NOT NULL DEFAULT 0,
  `dropKey` varchar(20) NOT NULL DEFAULT 'none'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `tracking`
--

INSERT INTO `tracking` (`userId`, `productId`, `trackingSince`, `dropValue`, `dropKey`) VALUES
(1, 18, '2022-05-01 14:21:32', 0, 'always'),
(1, 23, '2022-05-03 15:38:28', 0, 'always'),
(1, 27, '2022-05-01 19:48:07', 0, 'always'),
(1, 33, '2022-04-30 13:41:38', 0, 'always'),
(1, 34, '2022-05-01 08:18:04', 0, 'always'),
(1, 35, '2022-05-01 08:19:30', 0, 'always'),
(1, 37, '2022-05-03 06:43:47', 0, 'always'),
(1, 42, '2022-05-03 19:56:37', 0, 'always'),
(1, 43, '2022-05-03 19:56:50', 0, 'always'),
(1, 46, '2022-05-05 12:51:41', 0, 'always'),
(1, 47, '2022-05-05 13:06:40', 0, 'always'),
(2, 18, '2022-04-14 10:59:14', 0, 'always'),
(2, 19, '2022-04-14 10:59:42', 0, 'always'),
(2, 20, '2022-05-01 13:12:04', 0, 'always'),
(3, 13, '2022-04-09 08:13:13', 0, 'always'),
(3, 18, '2022-04-14 20:23:30', 0, 'always'),
(3, 19, '2022-04-14 20:23:30', 0, 'always'),
(3, 20, '2022-04-20 20:03:21', 0, 'always'),
(3, 27, '2022-05-01 19:46:20', 0, 'always'),
(3, 31, '2022-04-30 09:42:40', 0, 'always'),
(3, 32, '2022-04-30 09:43:28', 0, 'always'),
(3, 36, '2022-05-01 17:51:11', 0, 'always'),
(3, 41, '2022-05-03 19:48:04', 0, 'always'),
(3, 45, '2022-05-03 19:37:12', 0, 'always'),
(6, 22, '2022-04-23 13:16:31', 0, 'always'),
(6, 39, '2022-05-03 19:30:38', 0, 'always'),
(6, 40, '2022-05-03 19:30:50', 0, 'always'),
(6, 41, '2022-05-03 19:31:35', 0, 'always'),
(6, 42, '2022-05-03 19:32:12', 0, 'always'),
(6, 43, '2022-05-03 19:32:27', 0, 'always'),
(6, 44, '2022-05-03 19:32:48', 0, 'always'),
(7, 23, '2022-04-23 15:57:23', 0, 'always'),
(7, 24, '2022-04-23 15:58:35', 0, 'always'),
(7, 25, '2022-04-23 15:59:18', 0, 'always'),
(7, 26, '2022-04-24 09:21:08', 0, 'always'),
(7, 27, '2022-04-25 21:40:39', 0, 'always');

--
-- Trigger `tracking`
--
DELIMITER $$
CREATE TRIGGER `updateNumberOfTrackerOnDelete` AFTER DELETE ON `tracking` FOR EACH ROW begin 
update numberOfTrackers set nTrackers = nTrackers - 1 where productId = old.productId;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `updateNumberOfTrackerOnInsert` AFTER INSERT ON `tracking` FOR EACH ROW begin 
update numberOfTrackers set nTrackers = nTrackers + 1 where productId = new.productId;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `user`
--

INSERT INTO `user` (`id`, `email`, `username`, `name`, `surname`, `password`, `salt`, `createdAt`) VALUES
(1, 'matteo.visotto@mail.polimi.it', 'matteopoli', 'Matteo', 'PoliMi', 'd5c04b10bd9ea72611806b8f2dc66f0942e6f01420a2120a358eb538f09758b6', '8d0c137a31cc14ee', '2022-04-03 19:07:19'),
(2, 'tototia98@gmail.com', 'mattiasiriani', 'Mattia', 'Siriani', 'ae643abdc2f3a62590de680fb459c0d9ac64dc6b98ccbb120672fc7f007901ec', '377cea237d8f25f2', '2022-04-03 19:42:32'),
(3, 'matev1998@gmail.com', 'matteovisotto', 'Matteo', 'Visotto', 'f7d6a41c80bc7905d1d313fff40272c548be0e4d09f37e85c32353878d2a7410', 'a79c5e3a85ce9979', '2022-04-04 10:50:14'),
(6, 'svevastriuli@gmail.com', 'Sve', 'Sveva ', 'Striuli ', '19be55cd7d5559c97e77d8617c4ffdb1201d7db5efa4cb38e7f585bbf4771191', 'a45de12b5c9b1239', '2022-04-23 13:16:05'),
(7, 'e.nossa@campus.unimib.it', 'ElisaNossa', 'Elisa', 'Nossa', 'dc1806f539fe64e9d95f715f4f48208fae9dc1afbc693d79fd14a275f13fe42d', '6539186f5d56c3ba', '2022-04-23 15:56:01'),
(12, 'ely982010@hotmail.it', 'elisanossa', '', 'Nossa', '2ddb50132fb0dd372cdbea77488a9f0158812a71aec08cbc36edbe104e8753d0', '629b413510a1e44a', '2022-04-29 15:11:39');

-- --------------------------------------------------------

--
-- Struttura per vista `priceDrop`
--
DROP TABLE IF EXISTS `priceDrop`;

CREATE ALGORITHM=UNDEFINED DEFINER=`matteo`@`%` SQL SECURITY DEFINER VIEW `priceDrop`  AS SELECT `p`.`id` AS `productId`, round(`p`.`highestPrice` - `p`.`lowestPrice`,2) AS `priceDrop`, `a`.`price` AS `lastPrice`, `a`.`updatedAt` AS `updatedAt` FROM (`product` `p` join `price` `a` on(`p`.`id` = `a`.`productId`)) WHERE `a`.`updatedAt` = (select max(`p2`.`updatedAt`) from `price` `p2` where `a`.`productId` = `p2`.`productId`)  ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indici per le tabelle `comment`
--
ALTER TABLE `comment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `productId` (`productId`);

--
-- Indici per le tabelle `device`
--
ALTER TABLE `device`
  ADD PRIMARY KEY (`deviceId`,`fcmToken`);

--
-- Indici per le tabelle `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`productId`,`url`);

--
-- Indici per le tabelle `numberOfTrackers`
--
ALTER TABLE `numberOfTrackers`
  ADD PRIMARY KEY (`productId`);

--
-- Indici per le tabelle `price`
--
ALTER TABLE `price`
  ADD PRIMARY KEY (`productId`,`updatedAt`);

--
-- Indici per le tabelle `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `tracking`
--
ALTER TABLE `tracking`
  ADD PRIMARY KEY (`userId`,`productId`),
  ADD KEY `productId` (`productId`);

--
-- Indici per le tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `auth`
--
ALTER TABLE `auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT per la tabella `comment`
--
ALTER TABLE `comment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT per la tabella `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT per la tabella `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `auth`
--
ALTER TABLE `auth`
  ADD CONSTRAINT `auth_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `image_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `numberOfTrackers`
--
ALTER TABLE `numberOfTrackers`
  ADD CONSTRAINT `numberOfTrackers_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `price`
--
ALTER TABLE `price`
  ADD CONSTRAINT `price_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `tracking`
--
ALTER TABLE `tracking`
  ADD CONSTRAINT `tracking_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tracking_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
