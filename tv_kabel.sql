-- -------------------------------------------------------------
-- TablePlus 3.6.2(322)
--
-- https://tableplus.com/
--
-- Database: tv_kabel
-- Generation Time: 2022-12-13 16:47:10.7460
-- -------------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `tbl_failed_jobs`;
CREATE TABLE `tbl_failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tbl_failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_hideable_columns`;
CREATE TABLE `tbl_hideable_columns` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `index` int NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_hideable_columns_user_id_foreign` (`user_id`),
  CONSTRAINT `tbl_hideable_columns_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_keluhans`;
CREATE TABLE `tbl_keluhans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `judul_keluhan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isi_keluhan` text COLLATE utf8mb4_unicode_ci,
  `gambar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_keluhans_user_id_foreign` (`user_id`),
  CONSTRAINT `tbl_keluhans_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_menu_role`;
CREATE TABLE `tbl_menu_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_id` bigint unsigned NOT NULL,
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_menu_role_menu_id_foreign` (`menu_id`),
  KEY `tbl_menu_role_role_id_foreign` (`role_id`),
  CONSTRAINT `tbl_menu_role_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `tbl_menus` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_menu_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_menus`;
CREATE TABLE `tbl_menus` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `menu_label` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_route` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `menu_icon` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `menu_order` int DEFAULT '0',
  `show_menu` char(1) COLLATE utf8mb4_unicode_ci DEFAULT '1',
  `parent_id` bigint DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_metode_pembayarans`;
CREATE TABLE `tbl_metode_pembayarans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama_bank_pembayaran` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nama_rekening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nomor_rekening` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_migrations`;
CREATE TABLE `tbl_migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_panduans`;
CREATE TABLE `tbl_panduans` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `judul_panduan` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `isi_panduan` text COLLATE utf8mb4_unicode_ci,
  `gambar` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_password_resets`;
CREATE TABLE `tbl_password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `tbl_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_payments`;
CREATE TABLE `tbl_payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` bigint unsigned DEFAULT NULL,
  `payment_status` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priode` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_payments_user_id_foreign` (`user_id`),
  CONSTRAINT `tbl_payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_permission_role`;
CREATE TABLE `tbl_permission_role` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_permission_role_permission_id_foreign` (`permission_id`),
  KEY `tbl_permission_role_role_id_foreign` (`role_id`),
  CONSTRAINT `tbl_permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `tbl_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_permissions`;
CREATE TABLE `tbl_permissions` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_value` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `permission_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_personal_access_tokens`;
CREATE TABLE `tbl_personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tbl_personal_access_tokens_token_unique` (`token`),
  KEY `tbl_personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_role_user`;
CREATE TABLE `tbl_role_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_role_user_role_id_foreign` (`role_id`),
  KEY `tbl_role_user_user_id_foreign` (`user_id`),
  CONSTRAINT `tbl_role_user_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `tbl_roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_role_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_roles`;
CREATE TABLE `tbl_roles` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_sessions`;
CREATE TABLE `tbl_sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_sessions_user_id_index` (`user_id`),
  KEY `tbl_sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_team_user`;
CREATE TABLE `tbl_team_user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `team_id` bigint unsigned NOT NULL,
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_team_user_team_id_foreign` (`team_id`),
  KEY `tbl_team_user_user_id_foreign` (`user_id`),
  CONSTRAINT `tbl_team_user_team_id_foreign` FOREIGN KEY (`team_id`) REFERENCES `tbl_teams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tbl_team_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_teams`;
CREATE TABLE `tbl_teams` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_team` tinyint NOT NULL DEFAULT '1',
  `user_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tbl_teams_user_id_foreign` (`user_id`),
  CONSTRAINT `tbl_teams_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `tbl_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `tbl_users`;
CREATE TABLE `tbl_users` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_team_id` bigint unsigned DEFAULT '1',
  `profile_photo_path` varchar(2048) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tbl_users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `tbl_keluhans` (`id`, `user_id`, `judul_keluhan`, `isi_keluhan`, `gambar`, `created_at`, `updated_at`) VALUES
('1', 'b831b338-7a64-4c5e-a613-b83ddd9b133d', 'erwer', '<p>ewrewrerewr</p>', 'upload/59yYsLVpwIK0cfIoIW94mx9F3IpfmIOHlYKGz23I.png', '2022-12-05 08:30:47', '2022-12-05 08:30:47');

INSERT INTO `tbl_menu_role` (`id`, `menu_id`, `role_id`) VALUES
('1', '1', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('2', '2', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('3', '3', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('4', '4', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('5', '5', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('6', '6', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('7', '1', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('8', '1', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('9', '7', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('10', '8', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('11', '8', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('12', '9', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('13', '9', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('14', '10', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('15', '10', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('16', '10', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('17', '11', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('18', '11', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('19', '11', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('20', '9', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('21', '12', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('22', '12', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6');

INSERT INTO `tbl_menus` (`id`, `menu_label`, `menu_route`, `menu_icon`, `menu_order`, `show_menu`, `parent_id`, `created_at`, `updated_at`) VALUES
('1', 'Dashboard', 'dashboard', 'fas fa-home', '1', '1', NULL, '2022-12-05 07:21:23', '2022-12-05 07:21:23'),
('2', 'Site Management', '#', 'fas fa-key', '7', '1', NULL, '2022-12-05 07:21:23', '2022-12-05 15:01:11'),
('3', 'Menu', 'menu', NULL, '1', '1', '2', '2022-12-05 07:21:23', '2022-12-05 07:21:23'),
('4', 'Role', 'role', NULL, '2', '1', '2', '2022-12-05 07:21:23', '2022-12-05 07:21:23'),
('5', 'Permission', 'permission', NULL, '3', '1', '2', '2022-12-05 07:21:23', '2022-12-05 07:21:23'),
('6', 'Crud Generator', 'crud.generator', 'fas fa-cogs', '8', '1', NULL, '2022-12-05 07:21:23', '2022-12-05 15:01:11'),
('7', 'Role Permission', 'permission.role', 'fas fa-cogs', '9', '0', NULL, '2022-12-05 07:21:23', '2022-12-05 15:01:11'),
('8', 'Metode Pembayaran', 'metode-pembayaran', 'fas fa-list', '3', '1', NULL, '2022-12-05 08:07:17', '2022-12-05 15:01:11'),
('9', 'Payment', 'master.payment', 'fas fa-list', '4', '1', NULL, '2022-12-05 08:07:41', '2022-12-05 15:01:11'),
('10', 'Keluhan', 'keluhan', 'fas fa-list', '5', '1', NULL, '2022-12-05 08:21:34', '2022-12-05 15:01:11'),
('11', 'Paduan', 'panduan', 'fas fa-list', '6', '1', NULL, '2022-12-05 08:21:49', '2022-12-05 15:01:11'),
('12', 'Pelanggan', 'user', 'fas fa-users', '2', '1', NULL, '2022-12-05 15:01:08', '2022-12-05 15:01:11');

INSERT INTO `tbl_metode_pembayarans` (`id`, `nama_bank_pembayaran`, `nama_rekening`, `nomor_rekening`, `created_at`, `updated_at`) VALUES
('1', 'BCA', 'Yudi Candra', '123456789', '2022-12-05 08:12:57', '2022-12-05 08:12:57');

INSERT INTO `tbl_migrations` (`id`, `migration`, `batch`) VALUES
('1', '2014_10_12_000000_create_users_table', '1'),
('2', '2014_10_12_100000_create_password_resets_table', '1'),
('3', '2014_10_12_200000_add_two_factor_columns_to_users_table', '1'),
('4', '2019_08_19_000000_create_failed_jobs_table', '1'),
('5', '2019_12_14_000001_create_personal_access_tokens_table', '1'),
('6', '2021_06_19_080055_create_sessions_table', '1'),
('7', '2021_07_12_043446_create_teams_table', '1'),
('8', '2021_07_12_043522_create_team_user_table', '1'),
('9', '2021_07_12_044626_create_permissions_table', '1'),
('10', '2021_07_12_044633_create_roles_table', '1'),
('11', '2021_07_12_044703_create_permission_role_table', '1'),
('12', '2021_07_12_044839_create_role_user_table', '1'),
('13', '2021_07_14_160437_create_hideable_columns_table', '1'),
('14', '2021_08_15_112441_create_menus_table', '1'),
('15', '2021_09_04_220510_create_menu_role_table', '1'),
('16', '2022_11_30_112029_create_metode_pembayarans_table', '1'),
('17', '2022_11_30_132405_create_payments_table', '1'),
('18', '2022_12_05_071858_create_keluhans_table', '1'),
('19', '2022_12_05_071917_create_panduans_table', '1');

INSERT INTO `tbl_panduans` (`id`, `judul_panduan`, `isi_panduan`, `gambar`, `created_at`, `updated_at`) VALUES
('1', 'Buat Pembayaran', '<p>1. Pilih Menu Payment</p><p>2. Pilih Add New</p><p>3. Untuk Membatalkan Pilih Cancel</p><p>4. Isi panduan dan klik tombol simpan untuk melanjutkan</p>', 'upload/JQnll4lSyUr6fvrMiVSnb3U2tfZBDlOzIXFCaIpa.png', '2022-12-05 08:27:24', '2022-12-05 08:28:32'),
('2', 'Komplain atau keluhan', '<p>1. Pilih Menu Keluhan</p><p>2. Klik add new untuk input keluhan pelanggan</p><p>3. Isi form dan simpan</p>', 'upload/FpW2whtOK7xECjkNcd9I2rcr1FoFYDCBUkewv8Xi.png', '2022-12-05 08:29:20', '2022-12-05 08:29:20');

INSERT INTO `tbl_permission_role` (`id`, `permission_id`, `role_id`) VALUES
('1', '7c0dcd38-abf2-4182-8ea2-f23831188f91', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('2', '7c0dcd38-abf2-4182-8ea2-f23831188f91', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('3', '1ea292cd-3273-40dc-a031-5d3aadb3ca5e', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('4', '08a7f9bb-eb21-4bfe-90f1-a19291ecea67', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('5', 'c16bae28-61c9-49de-92fe-409d58d46a90', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('6', '3ead74e6-8f7c-4594-a198-9e6f9f27a174', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('7', '77e7b7fd-90db-41a0-9925-b28356455b1d', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('8', 'bddc0db5-0844-461f-b5a8-4872487a55b8', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('9', '5e68ef0b-99eb-43aa-bccc-6eda27f35d5b', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('10', '5d410b63-66c4-4081-8503-aff7b125d84b', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('11', 'abc26750-899c-4ebb-b6f2-5d2426a2d1c2', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('12', '2a049bdd-4111-4522-a973-02188de661a4', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('13', 'ec2c5f16-0a94-4c15-a27c-26215437e80a', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('14', 'a8a923bf-7f6c-4030-a162-13cecd56a806', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('15', '7a90a632-edbd-4d1e-9be9-fb8e69ee8c70', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('16', '7a90a632-edbd-4d1e-9be9-fb8e69ee8c70', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('17', '9819d722-2217-4c73-b10b-b5fa19531046', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('18', '9819d722-2217-4c73-b10b-b5fa19531046', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('19', '3c66805a-7b8b-4bb0-80a9-ed1c5289ea6e', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('21', '3c66805a-7b8b-4bb0-80a9-ed1c5289ea6e', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('22', 'f4806b84-426e-4a2d-81db-9b5128afaa49', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('24', 'f4806b84-426e-4a2d-81db-9b5128afaa49', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('25', 'c21a881b-72d6-4b32-becd-de726f2aa05f', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('26', 'a8c1bee0-e904-4c4b-903b-1816f3b5c3f1', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('27', 'fea01ae0-0481-4a3c-9219-e1ddbfcaf747', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('28', '97311d7d-d1aa-4b27-81a1-2162bf1d9962', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('29', 'c21a881b-72d6-4b32-becd-de726f2aa05f', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('30', '3e8f121d-b873-4b02-adb1-8b5c18c14823', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('31', 'b0e5b041-3d2d-46ae-abeb-47ba56fe0965', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('32', '783e3470-4e56-4d37-b647-bd8e8cef2b76', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('33', 'b9acd42a-d2cc-46f4-a0da-64112e4b59fd', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('34', 'c21a881b-72d6-4b32-becd-de726f2aa05f', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('35', '97311d7d-d1aa-4b27-81a1-2162bf1d9962', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('36', '97311d7d-d1aa-4b27-81a1-2162bf1d9962', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6'),
('37', '9819d722-2217-4c73-b10b-b5fa19531046', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('38', '3c66805a-7b8b-4bb0-80a9-ed1c5289ea6e', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('39', '3e8f121d-b873-4b02-adb1-8b5c18c14823', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('40', 'b0e5b041-3d2d-46ae-abeb-47ba56fe0965', '0feb7d3a-90c0-42b9-be3f-63757088cb9a'),
('41', '192a2eae-5a53-49f2-8c51-0ac7550af44e', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816'),
('42', '192a2eae-5a53-49f2-8c51-0ac7550af44e', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6');

INSERT INTO `tbl_permissions` (`id`, `permission_value`, `permission_name`, `created_at`, `updated_at`) VALUES
('08a7f9bb-eb21-4bfe-90f1-a19291ecea67', 'menu:update', 'Update menu', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('192a2eae-5a53-49f2-8c51-0ac7550af44e', 'user:delete', 'Delete Pelanggan', '2022-12-05 15:01:08', '2022-12-05 15:01:08'),
('1ea292cd-3273-40dc-a031-5d3aadb3ca5e', 'menu:read', 'Access menu', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('2a049bdd-4111-4522-a973-02188de661a4', 'permission:update', 'Update permission', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('3c66805a-7b8b-4bb0-80a9-ed1c5289ea6e', 'keluhan:delete', 'Delete Keluhan', '2022-12-05 08:21:34', '2022-12-05 08:21:34'),
('3e8f121d-b873-4b02-adb1-8b5c18c14823', 'keluhan:update', 'Update Keluhan', '2022-12-05 08:21:34', '2022-12-05 08:21:34'),
('3ead74e6-8f7c-4594-a198-9e6f9f27a174', 'menu:delete', 'Delete menu', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('5d410b63-66c4-4081-8503-aff7b125d84b', 'role:delete', 'Delete role', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('5e68ef0b-99eb-43aa-bccc-6eda27f35d5b', 'role:create', 'Create role', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('77e7b7fd-90db-41a0-9925-b28356455b1d', 'role:read', 'Access role', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('783e3470-4e56-4d37-b647-bd8e8cef2b76', 'panduan:update', 'Update Paduan', '2022-12-05 08:21:49', '2022-12-05 08:21:49'),
('7a90a632-edbd-4d1e-9be9-fb8e69ee8c70', 'metode-pembayaran:delete', 'Delete Metode Pembayaran', '2022-12-05 08:07:17', '2022-12-05 08:07:17'),
('7c0dcd38-abf2-4182-8ea2-f23831188f91', 'dashboard:read', 'Access dashboard menu', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('97311d7d-d1aa-4b27-81a1-2162bf1d9962', 'master.payment:update', 'Update Payment', '2022-12-05 08:07:41', '2022-12-05 08:07:41'),
('9819d722-2217-4c73-b10b-b5fa19531046', 'master.payment:delete', 'Delete Payment', '2022-12-05 08:07:41', '2022-12-05 08:07:41'),
('a8a923bf-7f6c-4030-a162-13cecd56a806', 'permission:delete', 'Delete permission', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('a8c1bee0-e904-4c4b-903b-1816f3b5c3f1', 'metode-pembayaran:update', 'Update Metode Pembayaran', '2022-12-05 08:07:17', '2022-12-05 08:07:17'),
('abc26750-899c-4ebb-b6f2-5d2426a2d1c2', 'permission:read', 'Access permission', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('b0e5b041-3d2d-46ae-abeb-47ba56fe0965', 'keluhan:create', 'Create Keluhan', '2022-12-05 08:21:34', '2022-12-05 08:21:34'),
('b9acd42a-d2cc-46f4-a0da-64112e4b59fd', 'panduan:create', 'Create Paduan', '2022-12-05 08:21:49', '2022-12-05 08:21:49'),
('bddc0db5-0844-461f-b5a8-4872487a55b8', 'role:update', 'Update role', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('c16bae28-61c9-49de-92fe-409d58d46a90', 'menu:create', 'Create menu', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('c21a881b-72d6-4b32-becd-de726f2aa05f', 'master.payment:create', 'Create Payment', '2022-12-05 08:07:41', '2022-12-05 08:07:41'),
('e831ceac-3faa-4932-aeec-ae13f6ac88cf', 'user:update', 'Update Pelanggan', '2022-12-05 15:01:08', '2022-12-05 15:01:08'),
('e950f158-9068-4fd2-b414-21b08b72ce95', 'user:create', 'Create Pelanggan', '2022-12-05 15:01:08', '2022-12-05 15:01:08'),
('ec2c5f16-0a94-4c15-a27c-26215437e80a', 'permission:create', 'Create permission', '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('f4806b84-426e-4a2d-81db-9b5128afaa49', 'panduan:delete', 'Delete Paduan', '2022-12-05 08:21:49', '2022-12-05 08:21:49'),
('fea01ae0-0481-4a3c-9219-e1ddbfcaf747', 'metode-pembayaran:create', 'Create Metode Pembayaran', '2022-12-05 08:07:17', '2022-12-05 08:07:17');

INSERT INTO `tbl_role_user` (`id`, `role_id`, `user_id`) VALUES
('1', 'aaf5ab14-a1cd-46c9-9838-84188cd064b6', '963b12db-5dbf-4cd5-91f7-366b2123ccb9'),
('2', '0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816', 'e859c822-4bd1-472b-84eb-361799c0d850'),
('3', '0feb7d3a-90c0-42b9-be3f-63757088cb9a', 'b831b338-7a64-4c5e-a613-b83ddd9b133d');

INSERT INTO `tbl_roles` (`id`, `role_type`, `role_name`, `created_at`, `updated_at`) VALUES
('0c1afb3f-1de0-4cb4-a512-f8ef9fc8e816', 'admin', 'Admin', '2022-12-05 07:21:23', '2022-12-05 07:21:23'),
('0feb7d3a-90c0-42b9-be3f-63757088cb9a', 'member', 'Member', '2022-12-05 07:21:23', '2022-12-05 07:21:23'),
('aaf5ab14-a1cd-46c9-9838-84188cd064b6', 'superadmin', 'Superadmin', '2022-12-05 07:21:23', '2022-12-05 07:21:23');

INSERT INTO `tbl_sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('oJgMyvW9YC3iuXjxJibwglO3e3Jb8e59f6omnnqD', NULL, '127.0.0.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRWNoZnh0NTU1U0ZUUkZ5VG1YUENSZGJNMW9VNXNXb3l1bUd0Z0VrMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly9wZW1iYXlhcmFuLXR2LWthYmVsLnRlc3QvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', '1670554247');

INSERT INTO `tbl_team_user` (`id`, `team_id`, `user_id`, `role`, `created_at`, `updated_at`) VALUES
('1', '1', 'e859c822-4bd1-472b-84eb-361799c0d850', 'admin', NULL, NULL),
('2', '1', 'b831b338-7a64-4c5e-a613-b83ddd9b133d', 'member', NULL, NULL);

INSERT INTO `tbl_teams` (`id`, `name`, `personal_team`, `user_id`, `created_at`, `updated_at`) VALUES
('1', 'Superadmin', '1', '963b12db-5dbf-4cd5-91f7-366b2123ccb9', NULL, NULL);

INSERT INTO `tbl_users` (`id`, `name`, `username`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`) VALUES
('963b12db-5dbf-4cd5-91f7-366b2123ccb9', 'Superadmin', 'superadmin', 'superadmin@admin.com', NULL, '$2y$10$1hd6tVpER3iQ0aBHaBrLE.ob1RlARccQQJQ020AOJrSS7eN4Qhvrq', NULL, NULL, NULL, '1', NULL, '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('b831b338-7a64-4c5e-a613-b83ddd9b133d', 'Member', 'member', 'member@admin.com', NULL, '$2y$10$11ehjqlnUu4NVtAe5PsNjO4X3FQxOVU0WD7H6ovzMXY5XtpuOQfKK', NULL, NULL, NULL, '1', NULL, '2022-12-05 07:21:22', '2022-12-05 07:21:22'),
('e859c822-4bd1-472b-84eb-361799c0d850', 'Admin', 'admin', 'admin@admin.com', NULL, '$2y$10$DKaN0tMQnb2upWZOvXPxUulrnvZorfZvr42fk2HIIVrsG8TkNga5y', NULL, NULL, NULL, '1', NULL, '2022-12-05 07:21:22', '2022-12-05 07:21:22');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;