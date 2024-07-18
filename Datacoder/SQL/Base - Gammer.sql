CREATE TABLE `CLASS` (
  `id_level` int NOT NULL,
  `id_class` int NOT NULL,
  `description` varchar(200) NOT NULL
);

CREATE TABLE `COMMENT` (
  `id_game` int NOT NULL,
  `id_system_user` int NOT NULL,
  `first_date` date NOT NULL,
  `last_date` date
);

CREATE TABLE `COMMENTARY` (
  `id_commentary` int NOT NULL,
  `id_game` int NOT NULL,
  `id_system_user` int NOT NULL,
  `comment_date` date NOT NULL,
  `commentary` varchar(200) NOT NULL
);

CREATE TABLE `GAME` (
  `id_game` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(300) NOT NULL,
  `id_level` int NOT NULL,
  `id_class` int NOT NULL
);

CREATE TABLE `LEVEL_GAME` (
  `id_level` int NOT NULL,
  `description` varchar(200) NOT NULL
);

CREATE TABLE `PLAY` (
  `id_game` int NOT NULL,
  `id_system_user` int NOT NULL,
  `completed` bool NOT NULL
);

CREATE TABLE `SUGGEST` (
  `id_suggest` int NOT NULL,
  `email` varchar(30) NOT NULL,
  `id_game` int NOT NULL,
  `id_system_user` int NOT NULL
);

CREATE TABLE `SYSTEM_USER` (
  `id_system_user` int NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `id_user_type` int NOT NULL
);

CREATE TABLE `USER_TYPE` (
  `id_user_type` int NOT NULL,
  `description` varchar(200) NOT NULL
);

CREATE TABLE `VOTE` (
  `id_vote` int NOT NULL,
  `value` int NOT NULL,
  `id_game` int NOT NULL,
  `id_system_user` int NOT NULL
);
