-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for cinema
CREATE DATABASE IF NOT EXISTS `cinema` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cinema`;

-- Dumping structure for table cinema.movie_nowplay
CREATE TABLE IF NOT EXISTS `movie_nowplay` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `trailer` varchar(255) DEFAULT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `rating` varchar(10) DEFAULT NULL,
  `ageRating` varchar(10) DEFAULT NULL,
  `synopsis` text,
  `poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table cinema.movie_nowplay: ~10 rows (approximately)
INSERT IGNORE INTO `movie_nowplay` (`id`, `title`, `trailer`, `duration`, `rating`, `ageRating`, `synopsis`, `poster`) VALUES
	(6, 'INSIDE OUT 2', 'https://www.youtube.com/embed/LEjhY15eCx0?start=1', '96 min', '4.5 *', 'SU', 'This adventure will take you into the complicated world of emotions. Along with the emotions of Joy, Sadness, Anger, Fear, and Disgust, Riley now also faces Anxiety, a new emotion with an orange color. The presence of Anxiety in Riley\'s headquarters adds drama to the emotionalÂ controlÂ room.', 'images/insideout2.png'),
	(7, 'BAD BOYS: RIDE OR DIE', 'https://www.youtube.com/embed/hRFY_Fesa9Q?si=JfNaHIVtx8fOhasP', '93 min', '4 *', '17+', 'Detectives Mike Lowrey (Will Smith) and Marcus Burnett (Martin Lawrence) are back in action.The two heroes are now living on the run after their late captain Conrad Howard (Joe Pantoliano) was accused of corruption. However, a video message from the captain suggests that there is a bigger crime going on within the MiamiÂ policeÂ force.', 'images/badboys.png'),
	(8, 'DILAN 1983 : WO AI NI', 'https://www.youtube.com/embed/-TqgMfZg4Po?si=EcieR2v05_GVUmy0', '116 min', '3.5 *', '13+', 'Dilan\'s childhood when he was 12 years old. When he was 12 years old, Dilan joined his father on duty in Timor Leste, which was previously called East Timor. Dilan spent around 1.5 years in East Timor and returned to Bandung and went to school at his old place. In 1983, Dilan met a new ethnic Chinese student from Semarang named Mei Lien. Mei Lien\'s presence at Dilan\'s school makes him feel like he likes Mei so he wants to learn Mandarin. Dilan\'s desire to learn Mandarin surprisedÂ hisÂ family.', 'images/dilan.png'),
	(9, 'HOW TO MAKE MILLIONS BEFORE GRANDMA DIES', 'https://www.youtube.com/embed/QTx4eY-jIo8?si=DyVi4vpPY0QH7iyq', '126 min', '5 *', '13+', 'The story of this film centers on a young man named M. He chooses to leave his job to take care of his grandmother, Amah, who has cancer. However, M\'s intention to care for Amah is not out of love. Rather, it is to target Amah\'s inheritance. Driven by the desire to get a million-dollar inheritance, M put aside his dreams as a game caster. He returned home to his terminally ill grandmother to care for her. However, winning Amah\'s heart was no easy feat. Amah is a tough woman who is difficult to conquer. She is demanding and very difficultÂ toÂ satisfy.', 'images/grandma.png'),
	(10, 'THE GARFELD MOVIE', 'https://www.youtube.com/embed/IeFWNtMo1Fs?si=tdsaomzzSL7hd--a', '98min', '4 *', 'SU', 'Garfield (voiced by Chris Pratt), the world-famous, Monday-hating, lasagna-loving indoor cat, is about to have a wild outdoor adventure. After an unexpected reunion with his long-lost father - scruffy street cat Vic (voiced by Samuel L. Jackson) - Garfield and his canine friend Odie are forced from their perfectly pampered life into joining Vic in a hilarious, high-stakesÂ heist.', 'images/garfield.png'),
	(11, 'PAKU TANAH JAWA', 'https://www.youtube.com/embed/VOt7xvjPv0Q?si=f9_K3ele9jAjPIac', '100 min', '4 *', '17+', 'Ningrum has had to face negative views from local residents since childhood because her mother, Handini, was always accused of having sex with many men. The death of one of Handini\'s close friends further plunges her family into local gossip. Ningrum\'s life becomes increasingly uneasy when the man she secretly loves, named Jalu, is trapped as Handini\'s new sacrifice. Ningrum has to face various supernatural terrors. Finally, Ningrum got a clue and asked for help from a Kyai who gave him a powerful spear to destroy blackÂ magicÂ onÂ earth.', 'images/pakutanahjawa.png'),
	(12, 'HAIKYU!! THE DUMPSTER BATTLE', 'https://www.youtube.com/embed/OQu2orbv_KA?si=4Tyolj2KsuLQqNPn', '86 min', '4 *', '13+', 'Karasuno High School made it through the Miyagi prefecture preliminaries for the Harutaka Volleyball Tournament, which was crowded with strong teams, and advanced to the third round by defeating Hyogo Prefecture representative Inarizaki High School, which was considered one of the favorites for the championship. Their opponent, Nekoma High School, used to have a rivalry with Karasuno, and although their interactions with each other decreased at one point, after Hinata and the others joined the club, they once again became good friends, working out together at training camps and practice games.', 'images/haikyu.png'),
	(13, 'THE STRANGERS : CHAPTER 1', 'https://www.youtube.com/embed/3pZUQmZdOi4?si=rj4VBaZAEYckeGWb', '116 min', '3 *', '13+', 'After their car breaks down in an eerie small town, a young couple (Madelaine Petsch and Froy Gutierrez) are forced to spend the night in a remote cabin. Panic ensues as they are terrorized by three masked strangers who strike with no mercy and seemingly no motive in THE STRANGERS: CHAPTER 1, the chilling first entry of this upcoming horror featureÂ filmÂ series.', 'images/strangers.png'),
	(14, 'DETECTIVE CONAN VS KID THE PHANTOM THIEF', 'https://www.youtube.com/embed/DHJrkN_GeX8?si=Y9IS5m5BQwRXUY3n', '167 min', '4 *', 'SU', 'High school student Kuroha Kaido discovers his late father\'s secret life as the Phantom Thief Kid, inherits his costume, and embarks on a quest to uncover the mysterious organization behind his father\'sÂ murder.', 'images/conan.png'),
	(15, 'THE PLOT', 'https://www.youtube.com/embed/NZ6kuHyiSEU?si=bI1c-93HALeWbvr2', '85 min', '3 *', '13+', 'The story is about a hitman named Brain who suffers an accident during a murder and struggles to survive while suspecting everyone around him to find out who is behind the accident after barelyÂ surviving.', 'images/theplot.png');

-- Dumping structure for table cinema.movie_upcome
CREATE TABLE IF NOT EXISTS `movie_upcome` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `trailer` varchar(255) DEFAULT NULL,
  `releaseDate` varchar(50) DEFAULT NULL,
  `movieType` varchar(100) DEFAULT NULL,
  `production` varchar(100) DEFAULT NULL,
  `casts` text,
  `synopsis` text,
  `poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table cinema.movie_upcome: ~6 rows (approximately)
INSERT IGNORE INTO `movie_upcome` (`id`, `title`, `trailer`, `releaseDate`, `movieType`, `production`, `casts`, `synopsis`, `poster`) VALUES
	(1, 'THE EXORCISM', 'https://www.youtube.com/embed/I1lNNd_klK4?si=NlZcVu2GYQULPtlX', 'June 2024', 'Horror, Thriller', 'Miramax', 'Russell Crowe, Ryan Simpkins, Sam Worthington, Chloe Bailey, Adam Goldberg, Adrian Pasdar, David Hyde Pierce, Tracey Bonner, Marcenae Lynette, Joshua John Miller', 'A troubled actor begins to exhibit a disruptive behavior while shooting a horror film. His estranged daughter wonders if he\'s slipping back into his past addictions or if there\'s something more sinister at play.', 'images/exorcism.jpg'),
	(2, 'DESPICABLE ME 4', 'https://www.youtube.com/embed/qQlr9-rF32A?si=E_eWWcQ1CEBEQ-d-', 'July 2024', 'Animation, Comedy', 'Universal Pictures', 'Steve Carell, Kristen Wiig, Joey King, Will Ferrell, Sofia Vergara, Miranda Cosgrove, Dana Gaier, Madison Skyy Polan, Pierre Coffin, Steve Coogan, Stephen Colbert, Chloe Fineman', 'Gru, Lucy, Margo, Edith, dan Agnes siap menyambut anggota baru di keluarga. Di tengah kebahagiaan, Gru harus menghadapi penjahat bernama Maxime Le Mal yang berniat membalas dendam kepada Gru. Apakah Gru bisa menyelamatkan keluarga kecilnya?', 'images/despicableme4.jpg'),
	(3, 'TWISTERS', 'https://www.youtube.com/embed/Jm27YjLnPHc?si=8KM8iDQImYbY6z5C', 'July 2024', 'Action, Adventure', 'Warner Bros. Pictures', 'Glen Powell, Daisy Edgar-Jones, Maura Tierney, Kiernan Shipka, Katy O Brian, David Corenswet, Anthony Ramos, Sasha Lane, Paul Scheer, Daryl McCormack, Brandon Perea', 'Tyler Owens (Glen Powell) and Kate Cooper (Daisy Edgar-Jones) are hurricane researchers and storm chasers who put their lives on the line in an effort to test a warning system that can mitigate Oklahoma\'s frequent hurricanes.', 'images/twisters.png'),
	(4, 'DEADPOOL VS WOLVERINE', 'https://www.youtube.com/embed/73_1biulkYk?si=gLPK0bBiTr73G6V8', 'July 2024', 'Action, Sci-Fi', 'Walt Disney Pictures', 'Ryan Reynolds, Hugh Jackman, Emma Corrin, Morena Baccarin, Rob Delaney, Karan Soni, Leslie Uggams, Matthew Macfadyen', 'The irresponsible Deadpool or Wade Wilson (Ryan Reynolds) is trusted to change the history of the Marvel Cinematic Universe (MCU) with Wolverine (Hugh Jackman). They work together to defeat a common enemy.', 'images/deadpool.jpg'),
	(5, 'MY BOO', 'https://www.youtube.com/embed/saBiD7UJt00?si=kp8-Wk86mLpeqCG_', 'July 2024', 'Romance, Comedy, Horror', 'RA Pictures', 'Maylada Susri, Sutthirak Subvijitra, Chalermpol Thikampornteerawong, Tatchaya Supatanyasatit, Dharmthai Plangsilp, Punyawee Jungcharoen, Narttida Pitakwararat, Arunphong Naraphan, Kittiphong Boonprakh', 'Joe (Sutthirak Subvijitra), a gamer, inherits a haunted house and its resident ghosts. However, neither the humans nor the ghosts want to leave the house. Eventually Joe and the ghosts decide to work together to run a haunted house ride to attract visitors for money. As time goes by Joe finds the ghosts there very charming, especially Anong (Maylada Susri), who intrigues him. Will these two people from two different worlds be able to overcome their differences and be together?', 'images/myboo.png'),
	(6, 'ABCD', 'https://www.youtube.com/embed/qQlr9-rF32A?si=E_eWWcQ1CEBEQ-d-', '2024-12-17', 'SCI-FI', 'Warner Bross', 'kanda', 'kandansjdnasjkdnaksj jasndijadsiojads jasiojoadisj ndasioiadsoj jdasiojioad ajdsoijioads nadsioiodas ioadsiojads ndasjiad nidasnijads', 'images/twisters.png');

-- Dumping structure for table cinema.reviews
CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `movie_id` int NOT NULL,
  `rating` int NOT NULL,
  `feedback` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie_nowplay` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table cinema.reviews: ~12 rows (approximately)
INSERT IGNORE INTO `reviews` (`id`, `user_id`, `movie_id`, `rating`, `feedback`, `created_at`) VALUES
	(1, 1, 6, 5, 'KEREN BGTT', '2024-07-18 14:08:35'),
	(2, 1, 6, 5, 'KEREN BGTT', '2024-07-18 14:09:07'),
	(3, 1, 6, 3, 'hai', '2024-07-18 14:13:02'),
	(4, 1, 6, 5, 'sadasdasdas', '2024-07-18 14:16:47'),
	(5, 1, 6, 4, 'woww', '2024-07-18 14:18:28'),
	(6, 1, 7, 3, 'sadasdasdas', '2024-07-18 18:23:42'),
	(7, 3, 6, 4, 'love this film', '2024-07-19 03:37:00'),
	(8, 1, 6, 5, 'cool', '2024-07-19 08:17:46'),
	(9, 1, 6, 5, 'abcde', '2024-07-19 14:41:17'),
	(10, 2, 6, 2, 'test', '2024-07-24 04:24:35'),
	(11, 1, 6, 5, 'qwerty', '2024-07-24 17:00:00'),
	(13, 2, 7, 1, 'bkhjasdbjkasdnas', '2024-07-24 18:25:33');

-- Dumping structure for table cinema.theaters
CREATE TABLE IF NOT EXISTS `theaters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city` varchar(50) DEFAULT NULL,
  `cinema` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table cinema.theaters: ~22 rows (approximately)
INSERT IGNORE INTO `theaters` (`id`, `city`, `cinema`) VALUES
	(1, 'JAKARTA', 'Plaza Indonesia'),
	(2, 'JAKARTA', 'Kota Kasablanka'),
	(3, 'JAKARTA', 'Senayan City'),
	(4, 'JAKARTA', 'Mall Kelapa Gading'),
	(5, 'JAKARTA', 'Pondok Indah Mall'),
	(6, 'JAKARTA', 'Taman Anggrek'),
	(7, 'JAKARTA', 'Blok M Plaza'),
	(8, 'BOGOR', 'Botani Square'),
	(9, 'BOGOR', 'Bogor Trade Mall'),
	(10, 'BOGOR', 'Cibinong City Mall'),
	(11, 'DEPOK', 'Depok Town Square'),
	(12, 'DEPOK', 'Margo City'),
	(13, 'DEPOK', 'Pesona Square'),
	(14, 'TANGERANG', 'AEON Mall BSD City'),
	(15, 'TANGERANG', 'Summarecon Mall Serpong'),
	(16, 'TANGERANG', 'Living World'),
	(17, 'TANGERANG', 'Supermal Karawaci'),
	(18, 'BEKASI', 'Summarecon Mall Bekasi'),
	(19, 'BEKASI', 'Metropolitan Mall Bekasi'),
	(20, 'BEKASI', 'Grand Galaxy Park'),
	(21, 'BEKASI', 'Lagoon Avenue Mall'),
	(22, 'BEKASI', 'Living World 2');

-- Dumping structure for table cinema.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table cinema.users: ~3 rows (approximately)
INSERT IGNORE INTO `users` (`id`, `username`, `email`, `password`, `role`) VALUES
	(1, 'techi', 'techi@techi', 'techi', 'user'),
	(2, 'admin', 'admin@admin', 'admin', 'admin'),
	(3, 'leann', 'le@n', 'lean', 'user');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
