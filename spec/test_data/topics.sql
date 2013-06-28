SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

DROP TABLE IF EXISTS `topics`;
CREATE TABLE IF NOT EXISTS `topics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `poster` varchar(200) NOT NULL DEFAULT '',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `posted` int(10) unsigned NOT NULL DEFAULT '0',
  `last_post` int(10) unsigned NOT NULL DEFAULT '0',
  `last_post_id` int(10) unsigned NOT NULL DEFAULT '0',
  `last_poster` varchar(200) DEFAULT NULL,
  `num_views` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `num_replies` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `sticky` tinyint(1) NOT NULL DEFAULT '0',
  `moved_to` int(10) unsigned DEFAULT NULL,
  `forum_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rt_ticket` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rt_ticket` (`rt_ticket`),
  KEY `topics_forum_id_idx` (`forum_id`),
  KEY `topics_moved_to_idx` (`moved_to`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1967 ;

INSERT INTO `topics` (`id`, `poster`, `subject`, `posted`, `last_post`, `last_post_id`, `last_poster`, `num_views`, `num_replies`, `closed`, `sticky`, `moved_to`, `forum_id`, `rt_ticket`) VALUES
(1, 'George Clooney', 'Test Topic', 1100534843, 1100545764, 11, 'Nigella Lawson', 25, 2, 0, 0, NULL, 1, NULL),
(2, 'Peter Stringfellow', 'Test Topic 2', 1100518856, 1100528116, 8, 'Andreas Villas-Boas', 44, 1, 1, 1, NULL, 2, NULL);
