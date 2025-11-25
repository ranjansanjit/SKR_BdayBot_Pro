CREATE DATABASE skr_bdaybot;
USE skr_bdaybot;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    birthday DATE NOT NULL
);

INSERT INTO users (name, birthday) VALUES
('Sanjit', '2000-01-01'),
('SKR', '1995-01-18');
