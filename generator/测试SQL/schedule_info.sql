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

 Date: 07/09/2024 19:11:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for schedule_info
-- ----------------------------
DROP TABLE IF EXISTS `schedule_info`;
CREATE TABLE `schedule_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '名称',
  `peoples` int(0) NOT NULL COMMENT '人数',
  `file` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件',
  `image` varchar(2550) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `user_id` bigint(0) NOT NULL COMMENT '创建人',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_info
-- ----------------------------
INSERT INTO `schedule_info` VALUES (9, '1212', 10, 'http://localhost:8080/profile/upload/2024/08/10/28add00844771e7336d5dac760a5776_20240810224224A008.jpg,http://localhost:8080/profile/upload/2024/08/10/00001699_20240810224224A009.JPG,http://localhost:8080/profile/upload/2024/08/10/00001697_20240810224224A010.JPG', 'http://localhost:8080/profile/upload/2024/08/27/28add00844771e7336d5dac760a5776_20240827213907A005.jpg,http://localhost:8080/profile/upload/2024/08/27/SlideShow2_20240827213907A006.png,http://localhost:8080/profile/upload/2024/08/27/SlideShow4_20240827213907A007.jpg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-0qompd_20240827213907A008.jpg,http://localhost:8080/profile/upload/2024/08/27/pexels-photo-14471335_20240827213907A009.jpeg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-2yx5og_20240827213907A011.jpg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-l8qy8l_20240827213907A010.jpg,http://localhost:8080/profile/upload/2024/08/27/00001699_20240827213907A012.JPG,http://localhost:8080/profile/upload/2024/08/27/00001697_20240827213907A013.JPG', '1', '312', 1, '2024-08-10 22:44:03', '2024-08-29 17:43:13');
INSERT INTO `schedule_info` VALUES (10, 'A', 1, 'http://localhost:8080/profile/upload/2024/08/10/wallhaven-0qompd_20240810230806A013.jpg', 'http://localhost:8080/profile/upload/2024/08/27/SlideShow2_20240827222716A033.png,http://localhost:8080/profile/upload/2024/08/27/28add00844771e7336d5dac760a5776_20240827222716A034.jpg,http://localhost:8080/profile/upload/2024/08/27/SlideShow4_20240827222716A032.jpg,http://localhost:8080/profile/upload/2024/08/27/pexels-photo-14471335_20240827222716A035.jpeg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-0qompd_20240827222716A036.jpg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-l8qy8l_20240827222716A037.jpg,http://localhost:8080/profile/upload/2024/08/27/wallhaven-2yx5og_20240827222716A038.jpg,http://localhost:8080/profile/upload/2024/08/27/00001699_20240827222716A039.JPG,http://localhost:8080/profile/upload/2024/08/27/00001697_20240827222716A040.JPG', '1', '1', 1, '2024-08-10 23:08:11', '2024-08-27 23:13:07');
INSERT INTO `schedule_info` VALUES (11, 'A', 1, 'http://localhost:8080/profile/upload/2024/08/10/SlideShow2_20240810230841A014.png', 'http://localhost:8080/profile/upload/2024/08/27/5dQA2u6cwPdLdc06f3446dc0b4b9b1294046c0622d10_20240827222302A023.jpg,http://localhost:8080/profile/upload/2024/08/27/7xYluYMWZtgt6cfdb1fd86547ff24c1994b59d84b364_20240827222302A024.png,http://localhost:8080/profile/upload/2024/08/27/TVFhT4KtP7PF8704b70212c58bfc4fb0107c462c0d3d_20240827222302A025.jpeg,http://localhost:8080/profile/upload/2024/08/27/87PqD3Kv7PZJ55c2b677bc15a444d0e6bad300e0f334_20240827222302A026.jpg,http://localhost:8080/profile/upload/2024/08/27/jsw3WpGgTXFh6d17ce18bde97c0e1a499c2aa51865f2_20240827222302A027.jpg,http://localhost:8080/profile/upload/2024/08/27/0FRtLLS2RdMr148c52e83cc07ba3b0ffb9441734404e_20240827222303A028.jpg,http://localhost:8080/profile/upload/2024/08/27/FI8ef98LGZsWd4c45e9238fc53ba0a50ea36b12f20e7_20240827222303A030.jpg,http://localhost:8080/profile/upload/2024/08/27/wAK0E4WbL9tr819039b8ce791703dadf2715d32a9f74_20240827222303A029.JPG,http://localhost:8080/profile/upload/2024/08/27/pu63pkmn8RK84a3d08624a4055d1e1d115b37ce60166_20240827222303A031.JPG', '0', '121', 1, '2024-08-10 23:08:48', '2024-08-27 22:23:05');
INSERT INTO `schedule_info` VALUES (12, '1', 1, 'http://localhost:8080/profile/upload/2024/08/10/28add00844771e7336d5dac760a5776_20240810231738A001.jpg', 'http://localhost:8080/profile/upload/2024/08/27/hvUYad05ZeNddc06f3446dc0b4b9b1294046c0622d10_20240827222226A014.jpg,http://localhost:8080/profile/upload/2024/08/27/FbbWjclbgs4d6cfdb1fd86547ff24c1994b59d84b364_20240827222226A015.png,http://localhost:8080/profile/upload/2024/08/27/0LVNG9Ovr5Rk55c2b677bc15a444d0e6bad300e0f334_20240827222226A016.jpg,http://localhost:8080/profile/upload/2024/08/27/btwzpUC8NmWN6d17ce18bde97c0e1a499c2aa51865f2_20240827222227A017.jpg,http://localhost:8080/profile/upload/2024/08/27/mbaBpl7dXWJx8704b70212c58bfc4fb0107c462c0d3d_20240827222227A018.jpeg,http://localhost:8080/profile/upload/2024/08/27/fTUfYszdIhhC148c52e83cc07ba3b0ffb9441734404e_20240827222227A019.jpg,http://localhost:8080/profile/upload/2024/08/27/FbqrnnkMUPBOd4c45e9238fc53ba0a50ea36b12f20e7_20240827222227A020.jpg,http://localhost:8080/profile/upload/2024/08/27/2gXqr8I128mN4a3d08624a4055d1e1d115b37ce60166_20240827222227A021.JPG,http://localhost:8080/profile/upload/2024/08/27/hTtTeZh6mjuf819039b8ce791703dadf2715d32a9f74_20240827222227A022.JPG', '0', '21', 1, '2024-08-10 23:17:45', '2024-08-27 22:22:32');
INSERT INTO `schedule_info` VALUES (13, '111', 111, 'http://localhost:8080/profile/upload/2024/08/10/SlideShow4_20240810232601A003.jpg,http://localhost:8080/profile/upload/2024/08/10/wallhaven-0qompd_20240810232921A005.jpg', 'http://localhost:8080/profile/upload/2024/08/27/R-A_20240827213843A001.jpg,http://localhost:8080/profile/upload/2024/08/27/pexels-photo-14471335_20240827213843A002.jpeg,http://localhost:8080/profile/upload/2024/08/27/00001699_20240827213843A003.JPG,http://localhost:8080/profile/upload/2024/08/27/00001697_20240827213843A004.JPG', '0', '<p style=\"text-align: justify; line-height: 2;\">231321321312231</p><p style=\"text-align: justify; line-height: 2;\">31231<strong>3123</strong></p><h2 style=\"text-align: justify; line-height: 2;\"><img src=\"http://localhost:8080/profile/upload/2024/08/17/NVvts17z7u5A55c2b677bc15a444d0e6bad300e0f334_20240817224647A001.jpg\" alt=\"图像\"></h2><h2 style=\"text-align: justify; line-height: 2;\"><br></h2>', 1, '2024-08-10 23:30:38', '2024-08-27 21:38:46');
INSERT INTO `schedule_info` VALUES (14, '1', 1, '', 'http://localhost:8080/profile/upload/2024/08/17/Xs1RLlb0mWqs6d17ce18bde97c0e1a499c2aa51865f2_20240817232124A003.jpg', '0', '<p style=\"line-height: 2;\">2313<img src=\"http://localhost:8080/profile/upload/2024/08/29/wallhaven-0qompd_20240829170553A007.jpg\" alt=\"图像\">12312</p>', 1, '2024-08-11 23:00:17', '2024-08-29 17:05:55');
INSERT INTO `schedule_info` VALUES (17, '132', 312, NULL, 'http://localhost:8080/profile/upload/2024/08/29/OIP-C_20240829164013A002.jpg,http://localhost:8080/profile/upload/2024/08/29/28add00844771e7336d5dac760a5776_20240829164718A003.jpg', '0', '<p>312<img src=\"http://localhost:8080/profile/upload/2024/08/29/SlideShow2_20240829170520A006.png\" alt=\"图像\"></p>', 312, '2024-08-29 16:40:19', '2024-08-29 17:05:30');
INSERT INTO `schedule_info` VALUES (18, '1', 1, 'http://localhost:8080/profile/upload/2024/08/29/SlideShow4_20240829171335A008.jpg', 'http://localhost:8080/profile/upload/2024/08/29/00001699_20240829171339A009.JPG', '0', '<p>eqw</p>', 1, '2024-08-29 17:13:42', NULL);
INSERT INTO `schedule_info` VALUES (19, '321', 312, '', '', '0', '<p>213</p>', 312, '2024-08-29 17:32:27', NULL);
INSERT INTO `schedule_info` VALUES (20, '31', 321, '', '', '0', '<p>312</p>', 312, '2024-08-29 17:32:46', NULL);
INSERT INTO `schedule_info` VALUES (21, '321', 321, '', '', '0', '<p>31231</p>', 1, '2024-08-29 17:33:15', NULL);
INSERT INTO `schedule_info` VALUES (22, '1', 1, '', '', '0', '<p>312</p>', 312, '2024-08-29 17:33:38', NULL);
INSERT INTO `schedule_info` VALUES (23, '1', 1, '', '', '0', '<p>312</p>', 1, '2024-08-29 17:34:20', NULL);
INSERT INTO `schedule_info` VALUES (24, '12', 21, '', '', '1', '<p>2`</p>', 1, '2024-08-29 17:42:28', NULL);

SET FOREIGN_KEY_CHECKS = 1;
