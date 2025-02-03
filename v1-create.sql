/**
 @author
*/
DROP TABLE IF EXISTS Borrowing;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Reader;
DROP TABLE IF EXISTS Author;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS Publisher;

CREATE TABLE IF NOT EXISTS Publisher (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255),
    phone_number VARCHAR(20),
	email VARCHAR(100) UNIQUE
);

CREATE TABLE IF NOT EXISTS Genre (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS Author (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Reader (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(20) UNIQUE,
    email VARCHAR(100) UNIQUE,
    registration_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE IF NOT EXISTS Book (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author_id INT NOT NULL REFERENCES Author(id),
    genre_id INT REFERENCES Genre(id),
    publisher_id INT REFERENCES Publisher(id),
    publication_year INT,
    isbn VARCHAR(20) UNIQUE,
    pages INT,
    total_copies INT,
    available_copies INT
);

INSERT INTO Publisher (name, address, phone_number, email) VALUES
('Эксмо', 'Москва, ул. Арбат, 1', '+74951234567', 'exmo@mail.ru'),
('АСТ', 'Москва, ул. Тверская, 10', '+74957654321', 'ast@mail.ru'),
('Питер', 'Санкт-Петербург, Невский пр., 20', '+78121112233', 'piter@mail.ru');

INSERT INTO Genre (name) VALUES
('Фантастика'),
('Детектив'),
('Роман'),
('Научная литература'),
('История');

INSERT INTO Author (first_name, last_name, birth_date, nationality) VALUES
('Лев', 'Толстой', '1828-09-09', 'Русский'),
('Александр', 'Пушкин', '1799-06-06', 'Русский'),
('Стивен', 'Кинг', '1947-09-21', 'Американец'),
('Агата', 'Кристи', '1890-09-15', 'Британка'),
('Джоан', 'Роулинг', '1965-07-31', 'Британка');

INSERT INTO Reader (first_name, last_name, address, phone_number, email) VALUES
('Иван', 'Иванов', 'Москва, ул. Ленина, 1', '+79011234567', 'ivanov@mail.ru'),
('Петр', 'Петров', 'Санкт-Петербург, ул. Невский, 2', '+79027654321', 'petrov@mail.ru'),
('Анна', 'Сидорова', 'Казань, ул. Кремлевская, 3', '+79031112233', 'sidorova@mail.ru'),
('Елена', 'Козлова', 'Новосибирск, ул. Советская, 4', '+79044445566', 'kozlova@mail.ru'),
('Дмитрий', 'Морозов', 'Екатеринбург, ул. Малышева, 5', '+79057778899', 'morozov@mail.ru');

INSERT INTO Book (title, author_id, genre_id, publisher_id, publication_year, isbn, pages, total_copies, available_copies) VALUES
('Война и мир', 1, 3, 1, 1869, '978-5-04-089152-1', 1200, 10, 10),
('Евгений Онегин', 2, 3, 2, 1833, '978-5-17-123456-7', 250, 5, 5),
('Оно', 3, 1, 1, 1986, '978-0-670-81302-5', 1138, 7, 7),
('Убийство в Восточном экспрессе', 4, 2, 3, 1934, '978-0-00-711931-4', 256, 3, 3),
('Гарри Поттер и философский камень', 5, 1, 2, 1997, '978-0-7475-3269-9', 320, 12, 12);


SELECT * FROM Book, Author;
