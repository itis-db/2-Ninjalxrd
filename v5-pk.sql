/**
  @author
 */
BEGIN;
SAVEPOINT before_migration;

ALTER TABLE Book ADD COLUMN publisher_name VARCHAR(100);

UPDATE Book b 
SET publisher_name = p.name 
FROM Publisher p 
WHERE b.publisher_id = p.id;

ALTER TABLE Book DROP COLUMN publisher_id;

ALTER TABLE Publisher DROP CONSTRAINT publisher_pkey;
ALTER TABLE Publisher DROP COLUMN id;

ALTER TABLE Publisher ADD PRIMARY KEY (name);

ALTER TABLE Book 
ADD CONSTRAINT fk_book_publisher 
FOREIGN KEY (publisher_name) REFERENCES Publisher(name);

ALTER TABLE Book ADD COLUMN genre_name VARCHAR(50);

UPDATE Book b 
SET genre_name = g.name 
FROM Genre g 
WHERE b.genre_id = g.id;

ALTER TABLE Book DROP COLUMN genre_id;

ALTER TABLE Genre DROP CONSTRAINT genre_pkey;
ALTER TABLE Genre DROP COLUMN id;

ALTER TABLE Genre ADD PRIMARY KEY (name);

ALTER TABLE Book 
ADD CONSTRAINT fk_book_genre 
FOREIGN KEY (genre_name) REFERENCES Genre(name);

ALTER TABLE Book 
ADD COLUMN author_first_name VARCHAR(100),
ADD COLUMN author_last_name VARCHAR(100),
ADD COLUMN author_birth_date DATE;

UPDATE Book b 
SET 
    author_first_name = a.first_name,
    author_last_name = a.last_name,
    author_birth_date = a.birth_date 
FROM Author a 
WHERE b.author_id = a.id;

ALTER TABLE Book DROP COLUMN author_id;

ALTER TABLE Author DROP CONSTRAINT author_pkey;
ALTER TABLE Author DROP COLUMN id;

ALTER TABLE Author 
ADD PRIMARY KEY (first_name, last_name, birth_date);

ALTER TABLE Book 
ADD CONSTRAINT fk_book_author 
FOREIGN KEY (author_first_name, author_last_name, author_birth_date) 
REFERENCES Author(first_name, last_name, birth_date);

ALTER TABLE Reader DROP CONSTRAINT reader_pkey;
ALTER TABLE Reader DROP COLUMN id;

ALTER TABLE Reader ADD PRIMARY KEY (email);

ALTER TABLE Book DROP CONSTRAINT book_pkey;

ALTER TABLE Book ADD PRIMARY KEY (isbn);

COMMIT;

SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public';

-- Откат до savepoint`а
BEGIN;
ROLLBACK TO before_migration;
COMMIT;

-- Откат всей транзакции
BEGIN;
ROLLBACK;
COMMIT;
