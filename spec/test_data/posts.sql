DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poster` varchar(200) NOT NULL DEFAULT '',
  `poster_id` int(10) unsigned NOT NULL DEFAULT '1',
  `poster_ip` varchar(15) DEFAULT NULL,
  `poster_email` varchar(50) DEFAULT NULL,
  `message` text,
  `hide_smilies` tinyint(1) NOT NULL DEFAULT '0',
  `posted` int(10) unsigned NOT NULL DEFAULT '0',
  `edited` int(10) unsigned DEFAULT NULL,
  `edited_by` varchar(200) DEFAULT NULL,
  `topic_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rt_transaction` int(11) DEFAULT NULL,
  `rt_post_to` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rt_transaction` (`rt_transaction`),
  KEY `posts_topic_id_idx` (`topic_id`),
  KEY `posts_multi_idx` (`poster_id`,`topic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5302 ;

INSERT INTO `posts` (`id`, `poster`, `poster_id`, `poster_ip`, `poster_email`, `message`, `hide_smilies`, `posted`, `edited`, `edited_by`, `topic_id`, `rt_transaction`, `rt_post_to`) VALUES
(64, 'George Clooney', 6, '130.88.234.61', NULL, 'Test Message', 0, 1100872795, NULL, NULL, 19, NULL, NULL),
(65, 'Nigella Lawson', 27, '207.179.75.20', NULL, 'Test Message 2', 0, 1100877698, NULL, NULL, 14, NULL, NULL);
