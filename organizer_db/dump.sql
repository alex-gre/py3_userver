BEGIN TRANSACTION;
CREATE TABLE phone_book(id INTEGER PRIMARY KEY AUTOINCREMENT,         name VARCHAR(35) NOT NULL, n_phone VARCHAR(14) NOT NULL, info VARCHAR(125));
DELETE FROM "sqlite_sequence";
INSERT INTO "sqlite_sequence" VALUES('phone_book',2);
COMMIT;