/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50711
Source Host           : localhost:3308
Source Database       : teacher

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2016-08-27 16:47:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_awarding
-- ----------------------------
DROP TABLE IF EXISTS `t_awarding`;
CREATE TABLE `t_awarding` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACHIEVE_DATE` date NOT NULL,
  `AWARD_LEVEL` varchar(255) NOT NULL,
  `AWARDS` varchar(255) NOT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `COURSE` varchar(255) NOT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `TEACHER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_in513vp5vlioejtnxf8x7ydra` (`TEACHER_ID`),
  CONSTRAINT `FK_in513vp5vlioejtnxf8x7ydra` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_awarding
-- ----------------------------

-- ----------------------------
-- Table structure for t_book
-- ----------------------------
DROP TABLE IF EXISTS `t_book`;
CREATE TABLE `t_book` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_DATE` datetime DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `IS_EDITOR` int(11) NOT NULL,
  `PUBLISH_DATE` date NOT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `STYLE` varchar(255) NOT NULL,
  `TITLE` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `WORD_COUNT` float NOT NULL,
  `TEACHER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_rpbnavipj2cxmtpda6ykww1bs` (`TEACHER_ID`),
  CONSTRAINT `FK_rpbnavipj2cxmtpda6ykww1bs` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_book
-- ----------------------------

-- ----------------------------
-- Table structure for t_calendar
-- ----------------------------
DROP TABLE IF EXISTS `t_calendar`;
CREATE TABLE `t_calendar` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ALL_DAY` tinyint(1) DEFAULT NULL,
  `BEGIN_DATE` datetime DEFAULT NULL,
  `CONTENT` varchar(255) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `END_DATE` datetime DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `TEACHER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_o3hlowyoqdrm2iwm9ktsc3aur` (`TEACHER_ID`),
  CONSTRAINT `FK_o3hlowyoqdrm2iwm9ktsc3aur` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_calendar
-- ----------------------------

-- ----------------------------
-- Table structure for t_depatment
-- ----------------------------
DROP TABLE IF EXISTS `t_depatment`;
CREATE TABLE `t_depatment` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_DATE` datetime DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `NAME` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_depatment
-- ----------------------------
INSERT INTO `t_depatment` VALUES ('1', '2016-08-27 16:31:55', '0', '信息工程学院');

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONTENT` varchar(255) NOT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `FROM_USER_ID` varchar(255) DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `REVIEW` int(11) DEFAULT NULL,
  `TITLE` varchar(255) NOT NULL,
  `TO_USER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CONTENT` varchar(255) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `TITLE` varchar(255) NOT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `VIEW` int(11) DEFAULT NULL,
  `TEACHER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_a17429l3x0nv2im8fowsbji8o` (`TEACHER_ID`),
  CONSTRAINT `FK_a17429l3x0nv2im8fowsbji8o` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_news
-- ----------------------------

-- ----------------------------
-- Table structure for t_paper
-- ----------------------------
DROP TABLE IF EXISTS `t_paper`;
CREATE TABLE `t_paper` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `AUTHOR` varchar(255) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `PERIODICAL_LEVEL` varchar(255) NOT NULL,
  `PERIODICAL_NAME` varchar(255) NOT NULL,
  `PUBLISH_DATE` date NOT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `TITLE` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `WORD_COUNT` float NOT NULL,
  `TEACHER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_64l5b6ir75p1ikty93qs58v4b` (`TEACHER_ID`),
  CONSTRAINT `FK_64l5b6ir75p1ikty93qs58v4b` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_paper
-- ----------------------------

-- ----------------------------
-- Table structure for t_subject
-- ----------------------------
DROP TABLE IF EXISTS `t_subject`;
CREATE TABLE `t_subject` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `CREATE_DATE` datetime DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `SUB_DATE` date NOT NULL,
  `SUB_ID` varchar(255) DEFAULT NULL,
  `SUB_LEVEL` varchar(255) NOT NULL,
  `SUB_NAME` varchar(255) NOT NULL,
  `TYPE` varchar(255) DEFAULT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `TEACHER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_t24qbcei2bf7504ukh1icp2ve` (`TEACHER_ID`),
  CONSTRAINT `FK_t24qbcei2bf7504ukh1icp2ve` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_subject
-- ----------------------------

-- ----------------------------
-- Table structure for t_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher` (
  `TEACHER_ID` varchar(255) NOT NULL,
  `IP_ADDRESS` varchar(255) DEFAULT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `LOGIN_DATE` datetime DEFAULT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `REG_DATE` date DEFAULT NULL,
  `ROLE` varchar(255) NOT NULL COMMENT '角色  teacher  manager  admin (教师、系部管理员、管理员)',
  `TEACHER_NAME` varchar(255) NOT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `DEPT_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`TEACHER_ID`),
  KEY `FK_9hfxwyehdkitfpg1un74mh3o3` (`DEPT_ID`),
  CONSTRAINT `FK_9hfxwyehdkitfpg1un74mh3o3` FOREIGN KEY (`DEPT_ID`) REFERENCES `t_depatment` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher
-- ----------------------------
INSERT INTO `t_teacher` VALUES ('1', '0:0:0:0:0:0:0:1', null, '0', '2016-08-27 16:42:38', '123', '2016-08-27', 'admin', '张三', '2016-08-27 16:34:25', '1');

-- ----------------------------
-- Table structure for t_teacher_archive
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher_archive`;
CREATE TABLE `t_teacher_archive` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_NUMBER` varchar(18) NOT NULL,
  `ARCHIVE_NUMBER` varchar(255) DEFAULT NULL,
  `BIRTHDAY` date NOT NULL,
  `CREATE_DATE` datetime DEFAULT NULL,
  `DEGREE` varchar(255) NOT NULL,
  `EDUCATION1` varchar(255) NOT NULL,
  `EDUCATION2` varchar(255) NOT NULL,
  `EMAIL` varchar(255) NOT NULL,
  `EVIDENCE_NUMBER` varchar(255) NOT NULL,
  `GET_DEGREE` date NOT NULL,
  `GET_EDUCATION1` date NOT NULL,
  `GET_EDUCATION2` date NOT NULL,
  `GRADUATE_SCHOOL1` varchar(255) NOT NULL,
  `GRADUATE_SCHOOL2` varchar(255) NOT NULL,
  `IS_BACKBONE` int(11) NOT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `IS_DOUBLE_TEACHERS` int(11) NOT NULL,
  `IS_PASS` varchar(255) DEFAULT NULL,
  `IS_SUBJECT_LEADER` int(11) NOT NULL,
  `MANDARIN_LEVEL` varchar(255) NOT NULL,
  `NATIVE_PLACE` varchar(255) NOT NULL,
  `PHONE_NUMBER` varchar(255) NOT NULL,
  `POLITICL_STATUS` varchar(255) NOT NULL,
  `PROFESSION_AREA` varchar(255) NOT NULL,
  `REMARK` varchar(255) DEFAULT NULL,
  `SEX` int(11) NOT NULL,
  `TEACHER_NAME` varchar(255) DEFAULT NULL,
  `TEACHER_PICTURE` varchar(255) DEFAULT NULL,
  `TECHNICAL_POSITION` varchar(255) NOT NULL,
  `UPDATE_DATE` datetime DEFAULT NULL,
  `WORK_DATE` date NOT NULL,
  `TEACHER_ID` varchar(255) NOT NULL,
  `UPDATE_USER_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_ic6gvafsmngldfjyhelq43ncv` (`TEACHER_ID`),
  KEY `FK_rffak61l6nqsdvh8jvu1aebay` (`UPDATE_USER_ID`),
  CONSTRAINT `FK_ic6gvafsmngldfjyhelq43ncv` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`),
  CONSTRAINT `FK_rffak61l6nqsdvh8jvu1aebay` FOREIGN KEY (`UPDATE_USER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teacher_archive
-- ----------------------------

-- ----------------------------
-- Table structure for t_teaching
-- ----------------------------
DROP TABLE IF EXISTS `t_teaching`;
CREATE TABLE `t_teaching` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `COURSE` varchar(255) NOT NULL,
  `IS_DELETE` int(11) DEFAULT NULL,
  `PERIOD` varchar(255) NOT NULL,
  `REMINDER` varchar(255) DEFAULT NULL,
  `SCHOOL_YEAR` varchar(255) NOT NULL,
  `TEACHER_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_fymvk9cfor3e4o9qhq62fhjlp` (`TEACHER_ID`),
  CONSTRAINT `FK_fymvk9cfor3e4o9qhq62fhjlp` FOREIGN KEY (`TEACHER_ID`) REFERENCES `t_teacher` (`TEACHER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_teaching
-- ----------------------------
