CREATE TABLE hardware (
   id SERIAL PRIMARY KEY,
   provider VARCHAR (255) NOT NULL,
   name VARCHAR (255) NOT NULL
);

INSERT INTO hardware (provider, name) VALUES ('Amazon', 'c5');
INSERT INTO hardware (provider, name) VALUES ('Azure', 'H16mr');


