/*
 Navicat Premium Data Transfer

 Source Server         : nbymysql
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : manager

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 25/12/2023 21:23:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activate_info
-- ----------------------------
DROP TABLE IF EXISTS `activate_info`;
CREATE TABLE `activate_info`  (
  `ainfo_num` int NOT NULL AUTO_INCREMENT,
  `code_num` int NULL DEFAULT NULL,
  `activation_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `start_time_num` bigint NULL DEFAULT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `valid_time_num` bigint NULL DEFAULT NULL,
  `expiration_time_num` bigint NULL DEFAULT NULL,
  `expiration_time` datetime NULL DEFAULT NULL,
  `is_work` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ainfo_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1234567891 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for activation
-- ----------------------------
DROP TABLE IF EXISTS `activation`;
CREATE TABLE `activation`  (
  `activation_num` int NOT NULL AUTO_INCREMENT,
  `user_num` int NULL DEFAULT NULL,
  `code_num` int NULL DEFAULT NULL,
  `func_num` int NULL DEFAULT NULL,
  `ainfo_num` int NULL DEFAULT NULL,
  `userlog_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`activation_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for activation_code
-- ----------------------------
DROP TABLE IF EXISTS `activation_code`;
CREATE TABLE `activation_code`  (
  `code_num` int NOT NULL AUTO_INCREMENT,
  `activation_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  PRIMARY KEY (`code_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 47 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_login_detection
-- ----------------------------
DROP TABLE IF EXISTS `admin_login_detection`;
CREATE TABLE `admin_login_detection`  (
  `adminlogin_num` int NOT NULL,
  `admin_num` int NOT NULL,
  `adminlogin_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `adminlogin_date` datetime NULL DEFAULT NULL,
  `adminlog_num` int NOT NULL,
  PRIMARY KEY (`adminlogin_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for admin_logs
-- ----------------------------
DROP TABLE IF EXISTS `admin_logs`;
CREATE TABLE `admin_logs`  (
  `adminlog_num` int NOT NULL AUTO_INCREMENT,
  `adminlog_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `admin_num` int NOT NULL,
  `adminlog_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `adminlog_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`adminlog_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 153 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for change
-- ----------------------------
DROP TABLE IF EXISTS `change`;
CREATE TABLE `change`  (
  `change_num` int NOT NULL AUTO_INCREMENT,
  `c_type_num` int NULL DEFAULT NULL,
  `old_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `new_value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `ainfo_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`change_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for conadmin
-- ----------------------------
DROP TABLE IF EXISTS `conadmin`;
CREATE TABLE `conadmin`  (
  `admin_num` int NOT NULL AUTO_INCREMENT,
  `admin_pwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  `root_num` int NOT NULL,
  PRIMARY KEY (`admin_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1234543214 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for decision
-- ----------------------------
DROP TABLE IF EXISTS `decision`;
CREATE TABLE `decision`  (
  `decision_num` int NOT NULL AUTO_INCREMENT,
  `root_num` int NOT NULL,
  `change_num` int NOT NULL,
  `adminlog_num` int NOT NULL,
  PRIMARY KEY (`decision_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for function
-- ----------------------------
DROP TABLE IF EXISTS `function`;
CREATE TABLE `function`  (
  `func_num` int NOT NULL AUTO_INCREMENT,
  `func_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `is_free` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  PRIMARY KEY (`func_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for generate_one
-- ----------------------------
DROP TABLE IF EXISTS `generate_one`;
CREATE TABLE `generate_one`  (
  `generate1_num` int NOT NULL AUTO_INCREMENT,
  `root_num` int NOT NULL,
  `code_num` int NOT NULL,
  `adminlog_num` int NOT NULL,
  PRIMARY KEY (`generate1_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for generate_two
-- ----------------------------
DROP TABLE IF EXISTS `generate_two`;
CREATE TABLE `generate_two`  (
  `generate2_num` int NOT NULL AUTO_INCREMENT,
  `admin_num` int NOT NULL,
  `code_num` int NOT NULL,
  `adminlog_num` int NOT NULL,
  PRIMARY KEY (`generate2_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for initiate
-- ----------------------------
DROP TABLE IF EXISTS `initiate`;
CREATE TABLE `initiate`  (
  `initiate_num` int NOT NULL AUTO_INCREMENT,
  `admin_num_one` int NOT NULL,
  `admin_num_two` int NULL DEFAULT NULL,
  `change_num` int NOT NULL,
  `adminlog_num` int NOT NULL,
  PRIMARY KEY (`initiate_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for root
-- ----------------------------
DROP TABLE IF EXISTS `root`;
CREATE TABLE `root`  (
  `root_num` int NOT NULL AUTO_INCREMENT,
  `root_pwd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NOT NULL,
  PRIMARY KEY (`root_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1432256126 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for trust
-- ----------------------------
DROP TABLE IF EXISTS `trust`;
CREATE TABLE `trust`  (
  `trust_num` int NOT NULL AUTO_INCREMENT,
  `root_num` int NOT NULL,
  `admin_num` int NOT NULL,
  `adminlog_num` int NOT NULL,
  PRIMARY KEY (`trust_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `user_num` int NOT NULL AUTO_INCREMENT,
  `user_pwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_login_detection
-- ----------------------------
DROP TABLE IF EXISTS `user_login_detection`;
CREATE TABLE `user_login_detection`  (
  `userlogin_num` int NOT NULL AUTO_INCREMENT,
  `user_num` int NULL DEFAULT NULL,
  `ainfo_num` int NULL DEFAULT NULL,
  `userlogin_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `userlogin_date` datetime NULL DEFAULT NULL,
  `userlog_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`userlogin_num`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_logs
-- ----------------------------
DROP TABLE IF EXISTS `user_logs`;
CREATE TABLE `user_logs`  (
  `userlog_num` int NOT NULL AUTO_INCREMENT,
  `userlog_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `user_num` int NULL DEFAULT NULL,
  `userlog_result` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_520_ci NULL DEFAULT NULL,
  `userlog_date` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`userlog_num`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 83 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_520_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for 查看普通管理员日志
-- ----------------------------
DROP VIEW IF EXISTS `查看普通管理员日志`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `查看普通管理员日志` AS select `admin_logs`.`adminlog_num` AS `adminlog_num`,`admin_logs`.`adminlog_type` AS `adminlog_type`,`admin_logs`.`admin_num` AS `admin_num`,`admin_logs`.`adminlog_result` AS `adminlog_result`,`admin_logs`.`adminlog_date` AS `adminlog_date` from `admin_logs` where `admin_logs`.`admin_num` in (select `root`.`root_num` from `root`) is false;

SET FOREIGN_KEY_CHECKS = 1;
