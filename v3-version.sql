/**
  @author
 */
ALTER TABLE Reader ADD COLUMN age INT;
ALTER TABLE Book ALTER COLUMN publication_year TYPE VARCHAR(4) USING publication_year::VARCHAR;

ALTER TABLE Book ADD CONSTRAINT unique_isbn UNIQUE (isbn);

ALTER TABLE Author ALTER COLUMN birth_date TYPE VARCHAR(10) USING birth_date::VARCHAR;

ALTER TABLE Genre ADD COLUMN description TEXT DEFAULT 'Нет описания';

ALTER TABLE Reader DROP COLUMN age;
ALTER TABLE Genre DROP COLUMN description;

ALTER TABLE Book DROP CONSTRAINT unique_isbn;

ALTER TABLE Book ALTER COLUMN publication_year TYPE INT USING publication_year::INT;
ALTER TABLE Author ALTER COLUMN birth_date TYPE DATE USING birth_date::DATE;
