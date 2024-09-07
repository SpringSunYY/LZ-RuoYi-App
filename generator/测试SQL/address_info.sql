/*
 Navicat Premium Data Transfer

 Source Server         : Windows
 Source Server Type    : MySQL
 Source Server Version : 80033
 Source Host           : localhost:3306
 Source Schema         : syy_generateruoyi

 Target Server Type    : MySQL
 Target Server Version : 80033
 File Encoding         : 65001

 Date: 07/09/2024 19:10:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_info
-- ----------------------------
DROP TABLE IF EXISTS `address_info`;
CREATE TABLE `address_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `parent_id` bigint(0) NOT NULL COMMENT '父级编号',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '位置名称',
  `address_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型',
  `image_info` varchar(5012) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `file_info` varchar(5012) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '备注',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `user_id` bigint(0) NOT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '位置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address_info
-- ----------------------------
INSERT INTO `address_info` VALUES (1, 0, '121', '0', 'http://localhost:8080/profile/upload/2024/08/27/SlideShow2_20240827213907A006.png,http://localhost:8080/profile/upload/2024/08/27/SlideShow4_20240827213907A007.jpg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-0qompd_20240827213907A008.jpg,http://localhost:8080/profile/upload/2024/08/27/pexels-photo-14471335_20240827213907A009.jpeg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-2yx5og_20240827213907A011.jpg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-l8qy8l_20240827213907A010.jpg,http://localhost:8080/profile/upload/2024/08/27/00001699_20240827213907A012.JPG,http://localhost:8080/profile/upload/2024/08/27/00001697_20240827213907A013.JPG,http://localhost:8080/profile/upload/2024/08/31/SlideShow4_20240831143404A001.jpg', NULL, '312', '1', 312, '2024-08-28 18:18:15', '2024-09-07 16:27:07');
INSERT INTO `address_info` VALUES (2, 1, '312', '0', 'http://localhost:8080/profile/upload/2024/08/27/28add00844771e7336d5dac760a5776_20240827213907A005.jpg', NULL, '321', '1', 312, '2024-08-28 18:23:11', NULL);
INSERT INTO `address_info` VALUES (3, 0, '312312', '0', 'http://localhost:8080/profile/upload/2024/08/29/Java-Debugging-Tips-1280x720_20240829160316A001.jpg', NULL, '312', '0', 312, '2024-08-29 16:03:21', '2024-08-31 15:16:59');
INSERT INTO `address_info` VALUES (4, 5, '312', '5', 'http://localhost:8080/profile/upload/2024/08/31/00001697_20240831151527A001.JPG,http://localhost:8080/profile/upload/2024/08/31/00001699_20240831151527A003.JPG,http://localhost:8080/profile/upload/2024/08/31/pexels-photo-14471335_20240831151527A002.jpeg', 'http://localhost:8080/profile/upload/2024/08/31/wallhaven-2yx5og_20240831151532A004.jpg', '312', '0', 1, '2024-08-31 15:15:46', '2024-08-31 15:41:01');
INSERT INTO `address_info` VALUES (5, 3, '321A', '5', '', '', '12', '0', 1, '2024-08-31 15:27:44', '2024-08-31 15:27:54');
INSERT INTO `address_info` VALUES (6, 0, 'AAAA', '0', 'http://localhost:8080/profile/upload/2024/09/07/28add00844771e7336d5dac760a5776_20240907152112A002.jpg,http://localhost:8080/profile/upload/2024/09/07/00001697_20240907152112A001.JPG', '', '21', '0', 1, '2024-09-07 15:21:16', NULL);

SET FOREIGN_KEY_CHECKS = 1;
