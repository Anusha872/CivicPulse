-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 21, 2026 at 01:24 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `neighborly`
--

-- --------------------------------------------------------

--
-- Table structure for table `contactmessages`
--

CREATE TABLE `contactmessages` (
  `contact_id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `subject` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `document_applications`
--

CREATE TABLE `document_applications` (
  `document_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `document_type` varchar(100) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `date_of_birth` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `additional_info` text DEFAULT NULL,
  `status` enum('Pending','Approved','Rejected') NOT NULL DEFAULT 'Pending',
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `document_applications`
--

INSERT INTO `document_applications` (`document_id`, `user_id`, `document_type`, `full_name`, `date_of_birth`, `address`, `phone`, `additional_info`, `status`, `submitted_at`) VALUES
(1, 21, 'National Identity Card', 'bhnj', '2026-05-04', 'Tokha', '9874563210', '', 'Approved', '2026-05-20 04:21:35'),
(2, 21, 'Passport', 'bhnj', '2026-05-04', 'Tokha', '9874563210', 'dasdas', 'Pending', '2026-05-20 04:21:51'),
(3, 21, 'Citizenship', 'gvhbjnklm', '2026-05-20', 'ghhjkl', '9874563210', '', 'Pending', '2026-05-20 09:45:50'),
(7, 22, 'National Identity Card', 'Rikesh Adhikari', '2005-07-01', 'Lalitpur', '9841959546', '', 'Approved', '2026-05-21 05:27:17'),
(9, 25, 'National Identity Card', 'Yogesh Pant', '2026-05-21', 'TOKHA', '9813860792', 'hello world', 'Pending', '2026-05-21 10:50:09');

-- --------------------------------------------------------

--
-- Table structure for table `feed_posts`
--

CREATE TABLE `feed_posts` (
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_content` text NOT NULL,
  `post_type` varchar(50) NOT NULL,
  `post_image` varchar(255) DEFAULT NULL,
  `post_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feed_posts`
--

INSERT INTO `feed_posts` (`post_id`, `user_id`, `post_content`, `post_type`, `post_image`, `post_created_at`) VALUES
(1, 21, 'I am very happy hehe ', 'general', 'post_21_1779244307291.png', '2026-05-20 02:31:47'),
(2, 21, 'Ayush', 'alert', 'post_21_1779263084934.jpg', '2026-05-20 07:44:44'),
(3, 22, 'Post', 'general', 'post_22_1779337303522.jpg', '2026-05-21 04:21:43');

-- --------------------------------------------------------

--
-- Table structure for table `feed_post_votes`
--

CREATE TABLE `feed_post_votes` (
  `vote_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `vote_type` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feed_post_votes`
--

INSERT INTO `feed_post_votes` (`vote_id`, `post_id`, `user_id`, `vote_type`) VALUES
(1, 1, 21, 'down'),
(3, 2, 21, 'up');

-- --------------------------------------------------------

--
-- Table structure for table `feed_saved_posts`
--

CREATE TABLE `feed_saved_posts` (
  `save_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feed_saved_posts`
--

INSERT INTO `feed_saved_posts` (`save_id`, `post_id`, `user_id`) VALUES
(3, 2, 21);

-- --------------------------------------------------------

--
-- Table structure for table `fines`
--

CREATE TABLE `fines` (
  `fine_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `violation_type` varchar(100) NOT NULL,
  `fine_amount` decimal(10,2) NOT NULL,
  `violation_date` date NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `fine_status` enum('Unpaid','Paid','Deleted') DEFAULT 'Unpaid',
  `issued_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fines`
--

INSERT INTO `fines` (`fine_id`, `user_id`, `violation_type`, `fine_amount`, `violation_date`, `reason`, `fine_status`, `issued_at`, `deleted_at`) VALUES
(1, 2, 'Speeding', 1000.00, '2006-05-05', 'something idk ', 'Paid', '2026-05-18 09:46:01', NULL),
(2, 1, 'Speeding', 1000.00, '2026-05-18', 'he was speeding fam', 'Deleted', '2026-05-18 10:25:04', NULL),
(3, 18, 'No helmet', 10000.00, '2026-04-28', 'sfhsdjfhds', 'Unpaid', '2026-05-19 14:56:04', NULL),
(4, 18, 'No helmet', 10000.00, '2026-04-28', 'sfhsdjfhds', 'Deleted', '2026-05-19 14:56:37', NULL),
(5, 1, 'No helmet', 10000.00, '2026-05-14', 'this is a vio ', 'Deleted', '2026-05-19 18:17:10', NULL),
(6, 3, 'No helmet', 10000.00, '2026-05-14', 'hhh', 'Deleted', '2026-05-19 18:17:28', NULL),
(7, 2, 'Wrong parking', 10000.00, '2026-05-14', 'yess', 'Deleted', '2026-05-19 18:21:11', NULL),
(8, 3, 'Speeding', 10000.00, '2026-04-29', 'aaa', 'Deleted', '2026-05-19 18:22:53', NULL),
(9, 3, 'Speeding', 10000.00, '2026-04-29', 'aaa', 'Unpaid', '2026-05-19 18:22:58', NULL),
(10, 14, 'No helmet', 10000.00, '2026-04-29', 'aaaaa', 'Deleted', '2026-05-19 18:23:20', NULL),
(11, 14, 'No helmet', 10000.00, '2026-04-29', 'aaaaa', 'Deleted', '2026-05-19 18:24:32', NULL),
(12, 16, 'No helmet', 10000.00, '2026-04-29', 'He was speeding ', 'Paid', '2026-05-19 18:25:23', NULL),
(13, 22, 'No helmet', 500.00, '2026-05-19', 'Riding a motorcycle without wearing a helmet, which is a clear breach of traffic safety rules.', 'Unpaid', '2026-05-20 14:30:57', NULL),
(14, 22, 'Wrong parking', 1000.00, '2026-05-20', 'Parking', 'Paid', '2026-05-21 04:18:28', NULL),
(15, 25, 'No seatbelt', 10000.00, '2026-05-12', 'dia dia ekco', 'Paid', '2026-05-21 05:56:41', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `issuereports`
--

CREATE TABLE `issuereports` (
  `report_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `category` varchar(100) NOT NULL,
  `location` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `reportPhoto` varchar(500) DEFAULT NULL,
  `status` enum('pending','in_progress','resolved') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `staff_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `issuereports`
--

INSERT INTO `issuereports` (`report_id`, `user_id`, `title`, `category`, `location`, `description`, `reportPhoto`, `status`, `created_at`, `staff_notes`) VALUES
(2, 1, 'Large pothole on main road', 'Infrastructure', 'Baneshwor, Kathmandu', 'There is a large pothole near the intersection that is causing accidents.', NULL, 'resolved', '2026-05-19 02:45:19', 'ok there was a pothole i fixed it '),
(3, 1, 'Broken streetlight', 'Utilities', 'Thamel, Kathmandu', 'The streetlight near the park has been broken for 2 weeks.', NULL, 'in_progress', '2026-05-19 02:45:19', NULL),
(4, 1, 'Garbage not collected', 'Sanitation', 'Lazimpat, Kathmandu', 'Garbage has not been collected for 5 days. It is causing a health hazard.', NULL, 'resolved', '2026-05-19 02:45:19', NULL),
(5, 1, 'Tis is a big issue sir', 'roads', 'Shankamul', 'maybe haha', 'report_1779242186611.jpg', 'pending', '2026-05-20 01:56:26', NULL),
(6, 21, 'Water Leakage', 'waste', 'Thamel', 'Water go brrrr', NULL, 'pending', '2026-05-20 12:52:04', NULL),
(7, 22, 'Toilet', 'waste', 'Nagarkot', 'Bad', NULL, 'pending', '2026-05-20 13:11:56', NULL),
(8, 22, 'Water Leakage', 'waste', 'Basantapur', 'I am writing to report a persistent water leakage problem that has been causing serious inconvenience. The leakage appears to be coming from the ceiling/wall near the bathroom area and has been ongoing for several days. The water is continuously dripping, creating damp patches, foul odor, and risk of mold growth.', NULL, 'in_progress', '2026-05-20 14:28:08', ''),
(9, 22, 'Flood', 'safety', 'Nepal', 'Flood', NULL, 'resolved', '2026-05-21 04:19:28', '');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `news_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `news_title` varchar(255) NOT NULL,
  `news_content` text NOT NULL,
  `news_created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `news_category` varchar(20) NOT NULL DEFAULT 'normal',
  `news_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`news_id`, `user_id`, `news_title`, `news_content`, `news_created_at`, `news_category`, `news_image`) VALUES
(31, 23, 'New News', 'This is new news', '2026-05-21 11:14:19', 'featured', '1779362059441.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `notice_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notice_title` varchar(255) NOT NULL,
  `notice_description` text NOT NULL,
  `notice_category` varchar(100) NOT NULL,
  `notice_posted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`notice_id`, `user_id`, `notice_title`, `notice_description`, `notice_category`, `notice_posted_at`) VALUES
(17, 23, 'Urgent Flood', 'Flood', 'Safety', '2026-05-21 05:34:54'),
(18, 23, 'Meeting in Tokha', 'meetin in tokha in 5 min', 'General', '2026-05-21 05:56:14');

-- --------------------------------------------------------

--
-- Table structure for table `polls`
--

CREATE TABLE `polls` (
  `poll_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `poll_question` varchar(255) NOT NULL,
  `poll_description` text DEFAULT NULL,
  `poll_option1` varchar(100) NOT NULL,
  `poll_option2` varchar(100) NOT NULL,
  `poll_status` varchar(50) NOT NULL,
  `poll_created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `polls`
--

INSERT INTO `polls` (`poll_id`, `user_id`, `poll_question`, `poll_description`, `poll_option1`, `poll_option2`, `poll_status`, `poll_created_at`) VALUES
(11, 23, 'Should Singha Durbar be Renovated?', 'Singha Durbar, or \"Lion\'s Palace,\" is a historic palace in Kathmandu that serves as the central hub of Nepal’s government and a symbol of the nation’s political and architectural heritage.', 'Yes', 'No, demolish it', 'Active', '2026-05-20 13:14:17'),
(12, 23, 'Poll', 'Poll', '1', '2', 'Active', '2026-05-21 04:20:34');

-- --------------------------------------------------------

--
-- Table structure for table `pollvote`
--

CREATE TABLE `pollvote` (
  `vote_id` int(11) NOT NULL,
  `poll_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `voted_option` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pollvote`
--

INSERT INTO `pollvote` (`vote_id`, `poll_id`, `user_id`, `voted_option`) VALUES
(1, 2, 21, 'option1'),
(4, 11, 22, 'option1'),
(6, 12, 22, 'option2');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `number` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','citizen') DEFAULT 'citizen',
  `registration_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` enum('Active','Inactive') DEFAULT 'Inactive',
  `suspension_reason` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `username`, `dob`, `gender`, `email`, `number`, `password`, `role`, `registration_date`, `status`, `suspension_reason`, `image`) VALUES
(22, 'Rikesh', 'Adhikari', 'rikesh', '2005-07-01', 'Male', 'rikesh@gmail.com', '9874563210', '$2a$10$DC8nyET8FkMSD10q3snJCOU9USoOIDfBB8VZe7OoJDBMgLq/ie3YO', 'citizen', '2026-05-20 13:11:05', 'Active', NULL, 'rikesh.jpg'),
(23, 'admin', 'admin', 'admin', '2000-01-01', 'Male', 'admin@gmail.com', '9999999999', '$2a$10$7toG09Ncg189dpihEKKxCuxfK4HNg9J7iA2NY7AFNGMxGEikh7h06', 'admin', '2026-05-20 13:12:58', 'Active', NULL, 'admin.JPG'),
(25, 'user', 'user', 'user', '2000-01-01', 'Male', 'user@user.com', '9874563120', '$2a$10$vOae8tHpXhbhyl7mNK51UuiXE4NH5ngk6bTe2Pe6BwmXJMxvsT8G6', 'citizen', '2026-05-21 04:23:41', 'Active', NULL, 'user.JPG'),
(26, 'Arjan ', 'Regmi ', 'Arjan', '2026-05-10', 'Male', 'arjanregmi2006@gmail.com', '9813860791', '$2a$10$jjV6w/4paX8Ja0GTWWvcZetsMaQbtW73XIH4Y3wJVFXZ00BGuGe.G', 'citizen', '2026-05-21 05:58:47', 'Active', NULL, 'Arjan.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contactmessages`
--
ALTER TABLE `contactmessages`
  ADD PRIMARY KEY (`contact_id`);

--
-- Indexes for table `document_applications`
--
ALTER TABLE `document_applications`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `fk_docapp_user` (`user_id`);

--
-- Indexes for table `feed_posts`
--
ALTER TABLE `feed_posts`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `feed_post_votes`
--
ALTER TABLE `feed_post_votes`
  ADD PRIMARY KEY (`vote_id`),
  ADD UNIQUE KEY `unique_user_post` (`post_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `feed_saved_posts`
--
ALTER TABLE `feed_saved_posts`
  ADD PRIMARY KEY (`save_id`),
  ADD UNIQUE KEY `unique_user_save` (`post_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `fines`
--
ALTER TABLE `fines`
  ADD PRIMARY KEY (`fine_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `issuereports`
--
ALTER TABLE `issuereports`
  ADD PRIMARY KEY (`report_id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`),
  ADD KEY `admin_id` (`user_id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`notice_id`),
  ADD KEY `admin_id` (`user_id`);

--
-- Indexes for table `polls`
--
ALTER TABLE `polls`
  ADD PRIMARY KEY (`poll_id`),
  ADD KEY `polls_ibfk_1` (`user_id`);

--
-- Indexes for table `pollvote`
--
ALTER TABLE `pollvote`
  ADD PRIMARY KEY (`vote_id`),
  ADD UNIQUE KEY `unique_vote` (`poll_id`,`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `number` (`number`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contactmessages`
--
ALTER TABLE `contactmessages`
  MODIFY `contact_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `document_applications`
--
ALTER TABLE `document_applications`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `feed_posts`
--
ALTER TABLE `feed_posts`
  MODIFY `post_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feed_post_votes`
--
ALTER TABLE `feed_post_votes`
  MODIFY `vote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feed_saved_posts`
--
ALTER TABLE `feed_saved_posts`
  MODIFY `save_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `fines`
--
ALTER TABLE `fines`
  MODIFY `fine_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `issuereports`
--
ALTER TABLE `issuereports`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `news_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `notice_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `polls`
--
ALTER TABLE `polls`
  MODIFY `poll_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pollvote`
--
ALTER TABLE `pollvote`
  MODIFY `vote_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
