USE leetcode ;
/*
| Pattern  | Meaning                        | Example                     |
| -------- | ------------------------------ | --------------------------- |
| `^`      | Start of string                | `^A` → starts with A        |
| `$`      | End of string                  | `a$` → ends with a          |
| `.`      | Any single character           | `b.t` → bat, bit, but       |
| `*`      | 0 or more occurrences          | `bo*` → b, bo, boo, booo    |
| `+`      | 1 or more occurrences          | `bo+` → bo, boo, booo       |
| `?`      | 0 or 1 occurrence              | `bo?` → b or bo             |
| `[abc]`  | Match any character a, b, or c | `[ch]at` → cat, hat         |
| `[^abc]` | Not a, b, or c                 | `[^ch]at` → mat, rat        |
| `[a-z]`  | Any lowercase letter           | `[a-z]ing` → doing, going   |
| `[0-9]`  | Any digit                      | `[0-9]{3}` → 3 digits       |
| `{n}`    | Exactly n repetitions          | `[0-9]{4}` → 4-digit number |
| `{n,}`   | n or more repetitions          | `[0-9]{2,}`                 |
| `{n,m}`  | Between n and m repetitions    | `[A-Z]{2,4}`                |
*/

DROP TABLE IF EXISTS users;
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    mail VARCHAR(100)
);

TRUNCATE TABLE users;
INSERT INTO Users (user_id, name, mail) VALUES
(1, 'Winston', 'winston@leetcode.com'),
(2, 'Jonathan', 'jonathanisgreat'),
(3, 'Annabelle', 'bella-@leetcode.com'),
(4, 'Sally', 'sally.come@leetcode.com'),
(5, 'Marwan', 'quarz#2020@leetcode.com'),
(6, 'David', 'david69@gmail.com'),
(7, 'Shapiro', '.shapo@leetcode.com'),
(8,  'Brock' , 'B@leetcode.com' ),
(9, 'Winston' ,'winston@leetcode.COM'); 



--Leetcode
SELECT *
FROM Users
WHERE mail COLLATE utf8mb3_bin REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode[.]com$';


--Mysql
SELECT *
FROM Users
WHERE mail COLLATE utf8mb4_bin REGEXP '^[a-zA-Z][a-zA-Z0-9._-]*@leetcode[.]com$';

