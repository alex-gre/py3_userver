DROP TABLE IF EXISTS app_access_groups;
DROP TABLE IF EXISTS app_attachments;
DROP TABLE IF EXISTS app_choices_values;
DROP TABLE IF EXISTS app_comments;
DROP TABLE IF EXISTS app_comments_access;
DROP TABLE IF EXISTS app_comments_history;
DROP TABLE IF EXISTS app_configuration;
DROP TABLE IF EXISTS app_entities;
DROP TABLE IF EXISTS app_entities_access;
DROP TABLE IF EXISTS app_entities_configuration;
DROP TABLE IF EXISTS app_entity_1;
DROP TABLE IF EXISTS app_entity_21;
DROP TABLE IF EXISTS app_entity_22;
DROP TABLE IF EXISTS app_entity_23;
DROP TABLE IF EXISTS app_entity_24;
DROP TABLE IF EXISTS app_entity_25;
DROP TABLE IF EXISTS app_entity_26;
DROP TABLE IF EXISTS app_entity_27;
DROP TABLE IF EXISTS app_entity_28;
DROP TABLE IF EXISTS app_entity_29;
DROP TABLE IF EXISTS app_fields;
DROP TABLE IF EXISTS app_fields_access;
DROP TABLE IF EXISTS app_fields_choices;
DROP TABLE IF EXISTS app_forms_tabs;
DROP TABLE IF EXISTS app_global_lists;
DROP TABLE IF EXISTS app_global_lists_choices;
DROP TABLE IF EXISTS app_related_items;
DROP TABLE IF EXISTS app_reports;
DROP TABLE IF EXISTS app_reports_filters;
DROP TABLE IF EXISTS app_sessions;
DROP TABLE IF EXISTS app_user_filters_values;
DROP TABLE IF EXISTS app_users_configuration;
DROP TABLE IF EXISTS app_users_filters;


CREATE TABLE `app_access_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `is_ldap_default` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

INSERT INTO app_access_groups VALUES
('4','Менеджер','1','0','2'),
('5','Разработчик','0','0','1'),
('6','Клиент','0','0','0');

CREATE TABLE `app_attachments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_token` varchar(64) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `date_added` date NOT NULL,
  `container` varchar(16) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_choices_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_items_id` (`items_id`),
  KEY `idx_fields_id` (`fields_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `app_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `description` text,
  `attachments` text NOT NULL,
  `date_added` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_items_id` (`items_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_comments_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `access_groups_id` int(11) NOT NULL,
  `access_schema` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_access_groups_id` (`access_groups_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

INSERT INTO app_comments_access VALUES
('4','21','6','view,create'),
('5','21','5','view,create'),
('6','21','4','view,create,update,delete'),
('7','22','5','view,create'),
('8','22','4','view,create,update,delete'),
('9','23','6','view,create'),
('10','23','4','view,create,update,delete'),
('11','24','5','view,create'),
('12','24','4','view,create,update,delete');

CREATE TABLE `app_comments_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comments_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `fields_value` text,
  PRIMARY KEY (`id`),
  KEY `idx_comments_id` (`comments_id`),
  KEY `idx_fields_id` (`fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `configuration_name` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

INSERT INTO app_configuration VALUES
('9','CFG_APP_NAME','test_crm'),
('10','CFG_APP_SHORT_NAME','Тест crm руководитель'),
('11','CFG_APP_LOGO',NULL),
('12','CFG_EMAIL_USE_NOTIFICATION','1'),
('13','CFG_EMAIL_SUBJECT_LABEL',NULL),
('14','CFG_EMAIL_AMOUNT_PREVIOUS_COMMENTS','2'),
('15','CFG_EMAIL_COPY_SENDER','0'),
('16','CFG_EMAIL_SEND_FROM_SINGLE','0'),
('17','CFG_EMAIL_ADDRESS_FROM',NULL),
('18','CFG_EMAIL_NAME_FROM',NULL),
('19','CFG_EMAIL_USE_SMTP','0'),
('20','CFG_EMAIL_SMTP_SERVER',NULL),
('21','CFG_EMAIL_SMTP_PORT',NULL),
('22','CFG_EMAIL_SMTP_ENCRYPTION',NULL),
('23','CFG_EMAIL_SMTP_LOGIN',NULL),
('24','CFG_EMAIL_SMTP_PASSWORD',NULL),
('25','CFG_LDAP_USE','0'),
('26','CFG_LDAP_SERVER_NAME',NULL),
('27','CFG_LDAP_SERVER_PORT',NULL),
('28','CFG_LDAP_BASE_DN',NULL),
('29','CFG_LDAP_UID',NULL),
('30','CFG_LDAP_USER',NULL),
('31','CFG_LDAP_EMAIL_ATTRIBUTE',NULL),
('32','CFG_LDAP_USER_DN',NULL),
('33','CFG_LDAP_PASSWORD',NULL),
('34','CFG_LOGIN_PAGE_HEADING',NULL),
('35','CFG_LOGIN_PAGE_CONTENT',NULL),
('36','CFG_APP_TIMEZONE','Europe/Moscow'),
('37','CFG_APP_DATE_FORMAT','m/d/Y'),
('38','CFG_APP_DATETIME_FORMAT','m/d/Y H:i'),
('39','CFG_APP_ROWS_PER_PAGE','10'),
('40','CFG_REGISTRATION_EMAIL_SUBJECT',NULL),
('41','CFG_REGISTRATION_EMAIL_BODY',NULL),
('42','CFG_PASSWORD_MIN_LENGTH','5'),
('43','CFG_APP_LANGUAGE','russian.php'),
('44','CFG_APP_SKIN',NULL),
('45','CFG_PUBLIC_USER_PROFILE_FIELDS',NULL);

CREATE TABLE `app_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `display_in_menu` tinyint(1) DEFAULT '0',
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

INSERT INTO app_entities VALUES
('1','0','Пользователи','0','10'),
('21','0','Проекты','0','1'),
('22','21','Задачи','0','1'),
('23','21','Запросы','0','2'),
('24','21','Обсуждения','0','3'),
('25','0','продажи','0','0'),
('26','25','СКЛАД','1','0'),
('27','25','ТОВАР','1','0'),
('28','25','КЛИЕНТ','0','0'),
('29','0','WWW_LINKS','0','0');

CREATE TABLE `app_entities_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `access_groups_id` int(11) NOT NULL,
  `access_schema` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_access_groups_id` (`access_groups_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

INSERT INTO app_entities_access VALUES
('28','21','6','view_assigned'),
('29','21','5','view_assigned,reports'),
('30','21','4','view,create,update,delete,reports'),
('31','22','6',''),
('32','22','5','view,create,update,reports'),
('33','22','4','view,create,update,delete,reports'),
('34','23','6','view_assigned,create,update,reports'),
('35','23','5',''),
('36','23','4','view,create,update,delete,reports'),
('37','24','6',''),
('38','24','5','view_assigned,create,update,delete,reports'),
('39','24','4','view,create,update,delete,reports'),
('40','27','6','view'),
('41','27','5',''),
('42','27','4','view');

CREATE TABLE `app_entities_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `configuration_name` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` text,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

INSERT INTO app_entities_configuration VALUES
('11','1','menu_title','Пользователи'),
('12','1','listing_heading','Пользователи'),
('13','1','window_heading','Информация о пользователе'),
('14','1','insert_button','Добавить пользователя'),
('15','1','use_comments','0'),
('25','21','menu_title',' Проекты'),
('26','21','listing_heading',' Проекты'),
('27','21','window_heading','Информация о проекте'),
('28','21','insert_button','Добавить проект'),
('29','21','email_subject_new_item','Новый проект:'),
('30','21','use_comments','1'),
('31','21','email_subject_new_comment','Новый комментарий к проекту:'),
('32','22','menu_title','Задачи'),
('33','22','listing_heading','Задачи'),
('34','22','window_heading','Информация о задаче'),
('35','22','insert_button','Добавить задачу'),
('36','22','email_subject_new_item','Новая задача'),
('37','22','use_comments','1'),
('38','22','email_subject_new_comment','Новый комментарий к задаче:'),
('39','23','menu_title','Запросы'),
('40','23','listing_heading','Запросы'),
('41','23','window_heading','Информация о запросе'),
('42','23','insert_button','Добавить запрос'),
('43','23','email_subject_new_item','Новый запрос:'),
('44','23','use_comments','1'),
('45','23','email_subject_new_comment','Новый комментарий к запросу'),
('46','24','menu_title','Обсуждения'),
('47','24','listing_heading','Обсуждения'),
('48','24','window_heading','Информация об обсуждении'),
('49','24','insert_button','Добавить обсуждение'),
('50','24','email_subject_new_item','Новое обсуждение:'),
('51','24','use_comments','1'),
('52','24','email_subject_new_comment','Новый комментраий к обсуждению:'),
('53','21','use_editor_in_comments','0'),
('54','22','use_editor_in_comments','0'),
('55','23','use_editor_in_comments','0'),
('56','24','use_editor_in_comments','0'),
('57','22','menu_icon',NULL),
('58','22','email_subject_updated_item',NULL),
('59','22','display_comments_id','0'),
('60','21','menu_icon',NULL),
('61','21','email_subject_updated_item',NULL),
('62','21','display_comments_id','0'),
('63','25','menu_title','продажи'),
('64','25','menu_icon',NULL),
('65','25','listing_heading',NULL),
('66','25','window_heading',NULL),
('67','25','insert_button',NULL),
('68','25','email_subject_new_item',NULL),
('69','25','email_subject_updated_item',NULL),
('70','25','use_comments','0'),
('71','25','display_comments_id','0'),
('72','25','use_editor_in_comments','1'),
('73','25','email_subject_new_comment',NULL),
('74','27','menu_title','ТОВАР'),
('75','27','menu_icon',NULL),
('76','27','listing_heading',NULL),
('77','27','window_heading',NULL),
('78','27','insert_button',NULL),
('79','27','email_subject_new_item',NULL),
('80','27','email_subject_updated_item',NULL),
('81','27','use_comments','0'),
('82','27','display_comments_id','0'),
('83','27','use_editor_in_comments','1'),
('84','27','email_subject_new_comment',NULL),
('85','26','menu_title',NULL),
('86','26','menu_icon',NULL),
('87','26','listing_heading',NULL),
('88','26','window_heading',NULL),
('89','26','insert_button',NULL),
('90','26','email_subject_new_item',NULL),
('91','26','email_subject_updated_item',NULL),
('92','26','use_comments','0'),
('93','26','display_comments_id','0'),
('94','26','use_editor_in_comments','1'),
('95','26','email_subject_new_comment',NULL),
('96','29','menu_title','WWW Ссылки'),
('97','29','menu_icon',NULL),
('98','29','listing_heading',NULL),
('99','29','window_heading',NULL),
('100','29','insert_button',NULL),
('101','29','email_subject_new_item',NULL),
('102','29','email_subject_updated_item',NULL),
('103','29','use_comments','0'),
('104','29','display_comments_id','0'),
('105','29','use_editor_in_comments','1'),
('106','29','email_subject_new_comment',NULL);

CREATE TABLE `app_entity_1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `parent_item_id` int(11) NOT NULL DEFAULT '0',
  `linked_id` int(11) NOT NULL DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT '0',
  `password` varchar(255) NOT NULL,
  `field_5` text,
  `field_6` text,
  `field_7` text,
  `field_8` text,
  `field_9` text,
  `field_10` text,
  `field_12` text,
  `field_13` text,
  `field_14` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

INSERT INTO app_entity_1 VALUES
('19','0','0','0','0',NULL,'0','$P$EwXy1d8WmY8O5Q1cDL2HT4nOJgG/tq.','1','0','alex','marfy','alexstv@inbox.ru',NULL,'admin','russian.php','blue');

CREATE TABLE `app_entity_21` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_156` text NOT NULL,
  `field_157` text NOT NULL,
  `field_158` text NOT NULL,
  `field_159` text NOT NULL,
  `field_160` text NOT NULL,
  `field_161` text NOT NULL,
  `field_162` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_22` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_167` text NOT NULL,
  `field_168` text NOT NULL,
  `field_169` text NOT NULL,
  `field_170` text NOT NULL,
  `field_171` text NOT NULL,
  `field_172` text NOT NULL,
  `field_173` text NOT NULL,
  `field_174` text NOT NULL,
  `field_175` text NOT NULL,
  `field_176` text NOT NULL,
  `field_177` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_23` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_182` text NOT NULL,
  `field_183` text NOT NULL,
  `field_184` text NOT NULL,
  `field_185` text NOT NULL,
  `field_186` text NOT NULL,
  `field_194` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_24` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_191` text NOT NULL,
  `field_192` text NOT NULL,
  `field_193` text NOT NULL,
  `field_195` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_25` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_222` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_26` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_230` text NOT NULL,
  `field_231` text NOT NULL,
  `field_232` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_27` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_226` text NOT NULL,
  `field_227` text NOT NULL,
  `field_228` text NOT NULL,
  `field_229` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_28` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_223` text NOT NULL,
  `field_224` text NOT NULL,
  `field_225` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `app_entity_29` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `parent_item_id` int(11) DEFAULT '0',
  `linked_id` int(11) DEFAULT '0',
  `date_added` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `sort_order` int(11) DEFAULT '0',
  `field_238` text NOT NULL,
  `field_239` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_item_id` (`parent_item_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `app_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `forms_tabs_id` int(11) NOT NULL,
  `type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `short_name` varchar(64) DEFAULT NULL,
  `is_heading` tinyint(1) DEFAULT '0',
  `tooltip` text,
  `tooltip_display_as` varchar(16) NOT NULL DEFAULT '',
  `is_required` tinyint(1) DEFAULT '0',
  `required_message` text,
  `configuration` text,
  `sort_order` int(11) DEFAULT '0',
  `listing_status` tinyint(4) NOT NULL DEFAULT '0',
  `listing_sort_order` int(11) NOT NULL DEFAULT '0',
  `comments_status` tinyint(1) NOT NULL DEFAULT '0',
  `comments_sort_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_form_tabs_id` (`forms_tabs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=240 DEFAULT CHARSET=utf8;

INSERT INTO app_fields VALUES
('1','1','1','fieldtype_action','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','0','0','0'),
('2','1','1','fieldtype_id','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','1','0','0'),
('3','1','1','fieldtype_date_added','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'0','0','0','0'),
('4','1','1','fieldtype_created_by','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'0','0','0','0'),
('5','1','1','fieldtype_user_status','',NULL,NULL,NULL,'',NULL,NULL,NULL,'0','1','7','0','0'),
('6','1','1','fieldtype_user_accessgroups','',NULL,NULL,NULL,'',NULL,NULL,NULL,'1','1','2','0','0'),
('7','1','1','fieldtype_user_firstname','',NULL,NULL,NULL,'',NULL,NULL,'{\"allow_search\":\"1\"}','3','1','4','0','0'),
('8','1','1','fieldtype_user_lastname','',NULL,NULL,NULL,'',NULL,NULL,'{\"allow_search\":\"1\"}','4','1','5','0','0'),
('9','1','1','fieldtype_user_email','',NULL,NULL,NULL,'',NULL,NULL,'{\"allow_search\":\"1\"}','6','1','6','0','0'),
('10','1','1','fieldtype_user_photo','',NULL,NULL,NULL,'',NULL,NULL,NULL,'5','0','0','0','0'),
('12','1','1','fieldtype_user_username','',NULL,'1',NULL,'',NULL,NULL,'{\"allow_search\":\"1\"}','2','1','3','0','0'),
('13','1','1','fieldtype_user_language','',NULL,'0',NULL,'','0',NULL,NULL,'7','0','0','0','0'),
('14','1','1','fieldtype_user_skin','',NULL,'0',NULL,'','0',NULL,NULL,'0','0','0','0','0'),
('152','21','24','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('153','21','24','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','1','0','0'),
('154','21','24','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','6','0','0'),
('155','21','24','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','7','0','0'),
('156','21','24','fieldtype_dropdown','Приоритет',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-medium\"}','0','1','2','1','0'),
('157','21','24','fieldtype_dropdown','Статус',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-medium\"}','1','1','4','1','1'),
('158','21','24','fieldtype_input','Название',NULL,'1',NULL,'','1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','2','1','3','0','0'),
('159','21','24','fieldtype_input_date','Дата начала проекта',NULL,'0',NULL,'','0',NULL,NULL,'3','1','5','0','0'),
('160','21','24','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'','0',NULL,'{\"allow_search\":\"1\"}','4','0','0','0','0'),
('161','21','25','fieldtype_users','Команда',NULL,'0',NULL,'','0',NULL,'{\"display_as\":\"checkboxes\"}','0','0','0','0','0'),
('162','21','24','fieldtype_attachments','Вложения',NULL,'0',NULL,'','0',NULL,NULL,'5','0','0','0','0'),
('163','22','26','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('164','22','26','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','1','0','0'),
('165','22','26','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','10','0','0'),
('166','22','26','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','11','0','0'),
('167','22','26','fieldtype_dropdown','Тип',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-medium\"}','1','1','3','0','0'),
('168','22','26','fieldtype_input','Название',NULL,'1',NULL,'','1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','2','1','4','0','0'),
('169','22','26','fieldtype_dropdown','Статус',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-large\"}','3','1','5','1','0'),
('170','22','26','fieldtype_dropdown','Приоритет',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-medium\"}','4','1','2','1','1'),
('171','22','26','fieldtype_users','Назначен на',NULL,'0',NULL,'','0',NULL,'{\"display_as\":\"checkboxes\"}','5','1','6','0','0'),
('172','22','26','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'','0',NULL,'{\"allow_search\":\"1\"}','6','0','0','0','0'),
('173','22','27','fieldtype_input_numeric','Расчетное время',NULL,'0',NULL,'','0',NULL,NULL,'1','1','7','0','0'),
('174','22','27','fieldtype_input_numeric_comments','Затрачено времени',NULL,'0',NULL,'','0',NULL,NULL,'2','1','8','1','2'),
('175','22','27','fieldtype_input_date','Дата начала',NULL,'0',NULL,'','0',NULL,NULL,'3','0','0','0','0'),
('176','22','27','fieldtype_input_date','Дата окончания',NULL,'0',NULL,'','0',NULL,NULL,'4','1','9','0','0'),
('177','22','26','fieldtype_attachments','Вложения',NULL,'0',NULL,'','0',NULL,NULL,'7','0','0','0','0'),
('178','23','28','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('179','23','28','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','1','0','0'),
('180','23','28','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','6','0','0'),
('181','23','28','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','7','0','0'),
('182','23','28','fieldtype_grouped_users','Отдел',NULL,'0',NULL,'','1',NULL,NULL,'0','1','4','1','0'),
('183','23','28','fieldtype_dropdown','Тип',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-large\"}','2','1','2','1','1'),
('184','23','28','fieldtype_input','Тема',NULL,'1',NULL,'','1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','3','1','3','0','0'),
('185','23','28','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'','0',NULL,'{\"allow_search\":\"1\"}','4','0','0','0','0'),
('186','23','28','fieldtype_dropdown','Статус',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-large\"}','1','1','5','1','2'),
('187','24','29','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('188','24','29','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','1','0','0'),
('189','24','29','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','4','0','0'),
('190','24','29','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','5','0','0'),
('191','24','29','fieldtype_input','Название',NULL,'1',NULL,'','1',NULL,'{\"allow_search\":\"1\",\"width\":\"input-xlarge\"}','1','1','3','0','0'),
('192','24','29','fieldtype_textarea_wysiwyg','Описание',NULL,'0',NULL,'','0',NULL,'{\"allow_search\":\"1\"}','2','0','0','0','0'),
('193','24','29','fieldtype_dropdown','Статус',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-medium\"}','0','1','2','1','0'),
('194','23','28','fieldtype_attachments','Вложения',NULL,'0',NULL,'','0',NULL,NULL,'5','0','0','0','0'),
('195','24','29','fieldtype_attachments','Вложения',NULL,'0',NULL,'','0',NULL,NULL,'3','0','0','0','0'),
('196','1','1','fieldtype_parent_item_id','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','100','0','0'),
('197','21','24','fieldtype_parent_item_id','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','100','0','0'),
('198','22','26','fieldtype_parent_item_id','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','100','0','0'),
('199','23','28','fieldtype_parent_item_id','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','100','0','0'),
('200','24','29','fieldtype_parent_item_id','',NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,'1','100','0','0'),
('201','25','30','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('202','25','30','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'1','1','1','0','0'),
('203','25','30','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'2','1','2','0','0'),
('204','25','30','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'3','1','3','0','0'),
('205','25','30','fieldtype_parent_item_id','',NULL,'0',NULL,'','0',NULL,NULL,'4','1','4','0','0'),
('206','26','31','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('207','26','31','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'1','1','1','0','0'),
('208','26','31','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'2','1','2','0','0'),
('209','26','31','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'3','1','3','0','0'),
('210','26','31','fieldtype_parent_item_id','',NULL,'0',NULL,'','0',NULL,NULL,'4','1','4','0','0'),
('211','27','32','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('212','27','32','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'1','1','1','0','0'),
('213','27','32','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'2','1','2','0','0'),
('214','27','32','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'3','1','3','0','0'),
('215','27','32','fieldtype_parent_item_id','',NULL,'0',NULL,'','0',NULL,NULL,'4','1','4','0','0'),
('216','28','33','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('217','28','33','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'1','1','1','0','0'),
('218','28','33','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'2','1','2','0','0'),
('219','28','33','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'3','1','3','0','0'),
('220','28','33','fieldtype_parent_item_id','',NULL,'0',NULL,'','0',NULL,NULL,'4','1','4','0','0'),
('222','25','30','fieldtype_entity','НАИМЕНОВАНИЕ',NULL,'0',NULL,'','0',NULL,'{\"entity_id\":\"25\",\"display_as\":\"dropdown\",\"width\":\"input-small\",\"fields_in_popup\":\"\"}','6','0','0','0','0'),
('223','28','33','fieldtype_input','ИМЯ',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','5','0','0','0','0'),
('224','28','33','fieldtype_input','ТЕЛЕФОН',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','6','0','0','0','0'),
('225','28','33','fieldtype_input','ПРИМЕЧАНИЕ',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','7','0','0','0','0'),
('226','27','32','fieldtype_input','НАИМЕНОВАНИЕ',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-small\"}','5','0','0','0','0'),
('227','27','32','fieldtype_input','КОЛЛИЧЕСТВО',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-small\"}','6','0','0','0','0'),
('228','27','32','fieldtype_input','ЦЕНА',NULL,'0',NULL,'','1',NULL,'{\"width\":\"input-small\"}','7','0','0','0','0'),
('229','27','32','fieldtype_input','комментарий',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','8','0','0','0','0'),
('230','26','31','fieldtype_input','МЕСТО','адрес хранения товара','0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','5','0','0','0','0'),
('231','26','31','fieldtype_input','ID_BOX','id для товара','0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','6','0','0','0','0'),
('232','26','31','fieldtype_entity','НАИМЕНОВАНИЕ','описание','0',NULL,'','0',NULL,'{\"entity_id\":\"27\",\"display_as\":\"dropdown\",\"width\":\"input-small\",\"fields_in_popup\":\"\"}','7','0','0','0','0'),
('233','29','34','fieldtype_action','',NULL,'0',NULL,'','0',NULL,NULL,'0','1','0','0','0'),
('234','29','34','fieldtype_id','',NULL,'0',NULL,'','0',NULL,NULL,'1','1','1','0','0'),
('235','29','34','fieldtype_date_added','',NULL,'0',NULL,'','0',NULL,NULL,'2','1','2','0','0'),
('236','29','34','fieldtype_created_by','',NULL,'0',NULL,'','0',NULL,NULL,'3','1','3','0','0'),
('237','29','34','fieldtype_parent_item_id','',NULL,'0',NULL,'','0',NULL,NULL,'4','1','4','0','0'),
('238','29','34','fieldtype_input','url',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','5','0','0','0','0'),
('239','29','34','fieldtype_input','descript',NULL,'0',NULL,'','0',NULL,'{\"width\":\"input-small\"}','6','0','0','0','0');

CREATE TABLE `app_fields_access` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `access_groups_id` int(11) NOT NULL,
  `entities_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `access_schema` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_fields_id` (`fields_id`),
  KEY `idx_access_groups_id` (`access_groups_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_fields_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `fields_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `bg_color` varchar(16) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `users` text,
  PRIMARY KEY (`id`),
  KEY `idx_fields_id` (`fields_id`),
  KEY `idx_parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;

INSERT INTO app_fields_choices VALUES
('34','0','156','Срочный','0',NULL,'1',NULL),
('35','0','156','Высокий','0',NULL,'2',NULL),
('37','0','157','Новый','0',NULL,'1',NULL),
('38','0','157','Открытый','0',NULL,'2',NULL),
('39','0','157','В ожидании','0',NULL,'3',NULL),
('40','0','157','Закрытый','0',NULL,'4',NULL),
('41','0','157','Отменён','0',NULL,'5',NULL),
('42','0','167','Задача','1',NULL,'1',NULL),
('43','0','167','Изменение','0',NULL,'2',NULL),
('44','0','167','Ошибка','0','#ff7a00','3',NULL),
('45','0','167','Идея','0',NULL,'0',NULL),
('46','0','169','Новый','1',NULL,'0',NULL),
('47','0','169','Открыт','0',NULL,'2',NULL),
('48','0','169','В ожидании','0',NULL,'3',NULL),
('49','0','169','Готов','0',NULL,'4',NULL),
('50','0','169','Завершен','0',NULL,'5',NULL),
('51','0','169','Оплачен','0',NULL,'6',NULL),
('52','0','169','Отменен','0',NULL,'7',NULL),
('53','0','170','Срочный','0','#ff0000','1',NULL),
('54','0','170','Высокий','0',NULL,'2',NULL),
('55','0','170','Средний','1',NULL,'3',NULL),
('56','0','182','Техническая поддержка','0',NULL,'0','19'),
('57','0','183','Запрос на изменение','0',NULL,'1',NULL),
('58','0','183','Сообщить об ошибке','0',NULL,'2',NULL),
('59','0','183','Задать вопрос','0',NULL,'3',NULL),
('60','0','186','Новый','1',NULL,'0',NULL),
('61','0','186','Открытый','0',NULL,'2',NULL),
('62','0','186','Ожидание ответа','0',NULL,'3',NULL),
('63','0','186','Закрыт','0',NULL,'4',NULL),
('64','0','186','Отменен','0',NULL,'5',NULL),
('65','0','193','Открыт','0',NULL,'1',NULL),
('66','0','193','Закрыт','0',NULL,'2',NULL),
('67','0','193','Новый','1',NULL,'0',NULL);

CREATE TABLE `app_forms_tabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `description` text NOT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

INSERT INTO app_forms_tabs VALUES
('1','1','Информация','','0'),
('24','21','Информация','','0'),
('25','21','Команда','','1'),
('26','22','Информация','','0'),
('27','22','Время','','1'),
('28','23','Информация','','0'),
('29','24','Информация','','0'),
('30','25','Информация','','0'),
('31','26','Информация','','0'),
('32','27','Информация','','0'),
('33','28','Информация','','0'),
('34','29','Информация','','0');

CREATE TABLE `app_global_lists` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_global_lists_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `lists_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `bg_color` varchar(16) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_lists_id` (`lists_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_related_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entities_id` int(11) NOT NULL,
  `items_id` int(11) NOT NULL,
  `related_entities_id` int(11) NOT NULL,
  `related_items_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_items_id` (`items_id`),
  KEY `idx_related_entities_id` (`related_entities_id`),
  KEY `idx_related_items_id` (`related_items_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `entities_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `reports_type` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `menu_icon` varchar(64) NOT NULL DEFAULT '',
  `in_menu` tinyint(1) NOT NULL DEFAULT '0',
  `in_dashboard` tinyint(4) NOT NULL DEFAULT '0',
  `in_header` tinyint(1) NOT NULL DEFAULT '0',
  `dashboard_sort_order` int(11) DEFAULT NULL,
  `listing_order_fields` text NOT NULL,
  `users_groups` text,
  `parent_entity_id` int(11) NOT NULL DEFAULT '0',
  `parent_item_id` int(11) NOT NULL DEFAULT '0',
  `fields_in_listing` text,
  `rows_per_page` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_entities_id` (`entities_id`),
  KEY `idx_created_by` (`created_by`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_parent_entity_id` (`parent_entity_id`),
  KEY `idx_parent_item_id` (`parent_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8;

CREATE TABLE `app_reports_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reports_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `filters_values` text NOT NULL,
  `filters_condition` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reports_id` (`reports_id`),
  KEY `idx_fields_id` (`fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_sessions` (
  `sesskey` varchar(32) NOT NULL,
  `expiry` int(11) unsigned NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`sesskey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_user_filters_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `filters_id` int(11) NOT NULL,
  `reports_id` int(11) NOT NULL,
  `fields_id` int(11) NOT NULL,
  `filters_values` text,
  `filters_condition` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_filters_id` (`filters_id`),
  KEY `idx_reports_id` (`reports_id`),
  KEY `idx_fields_id` (`fields_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_users_configuration` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `users_id` int(11) NOT NULL,
  `configuration_name` varchar(255) NOT NULL DEFAULT '',
  `configuration_value` text,
  PRIMARY KEY (`id`),
  KEY `idx_users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `app_users_filters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reports_id` int(11) NOT NULL,
  `users_id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_reports_id` (`reports_id`),
  KEY `idx_users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

