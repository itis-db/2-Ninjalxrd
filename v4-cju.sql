/**
  @author
 */
WITH recent_books AS (
    SELECT 
        title, 
        publication_year 
    FROM 
        Book 
    WHERE 
        publication_year::INT > 2000
)
SELECT 
    title, 
    publication_year 
FROM 
    recent_books;

SELECT 
    Book.title AS book_title, 
    Author.first_name AS author_first_name, 
    Author.last_name AS author_last_name, 
    Publisher.name AS publisher_name
FROM 
    Book
INNER JOIN 
    Author ON Book.author_id = Author.id
INNER JOIN 
    Publisher ON Book.publisher_id = Publisher.id;

SELECT 
    first_name AS name, 
    'Reader' AS role 
FROM 
    Reader
UNION ALL
SELECT 
    first_name AS name, 
    'Author' AS role 
FROM 
    Author;
