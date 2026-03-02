-- Enhanced Database Schema for City Helper

-- Users Table
CREATE TABLE IF NOT EXISTS `users` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `username` VARCHAR(50) UNIQUE NOT NULL,
  `email` VARCHAR(100) UNIQUE NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `phone` VARCHAR(15),
  `address` VARCHAR(255),
  `profile_pic` VARCHAR(255),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Issues Table
CREATE TABLE IF NOT EXISTS `issues` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NOT NULL,
  `category` VARCHAR(50) NOT NULL,
  `priority` VARCHAR(20) DEFAULT 'medium',
  `location` VARCHAR(255) NOT NULL,
  `latitude` DECIMAL(10, 8),
  `longitude` DECIMAL(11, 8),
  `image` VARCHAR(255),
  `resolution_photo` VARCHAR(255),
  `status` VARCHAR(20) DEFAULT 'pending',
  `assigned_to` INT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `resolved_date` DATETIME,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`assigned_to`) REFERENCES `users`(`id`) ON DELETE SET NULL
);

-- Comments Table
CREATE TABLE IF NOT EXISTS `comments` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `issue_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `comment_text` TEXT NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`issue_id`) REFERENCES `issues`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
);

-- Ratings Table
CREATE TABLE IF NOT EXISTS `ratings` (
  `id` INT PRIMARY KEY AUTO_INCREMENT,
  `issue_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `rating` INT CHECK (rating >= 1 AND rating <= 5),
  `feedback` TEXT,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`issue_id`) REFERENCES `issues`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  UNIQUE KEY `unique_rating` (`issue_id`, `user_id`)
);

-- Create indexes for better performance
CREATE INDEX idx_user_id ON issues(user_id);
CREATE INDEX idx_status ON issues(status);
CREATE INDEX idx_category ON issues(category);
CREATE INDEX idx_created_at ON issues(created_at);