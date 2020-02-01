CREATE TABLE IF NOT EXISTS hardware (
   id SERIAL PRIMARY KEY,
   provider VARCHAR (255) NOT NULL,
   name VARCHAR (255) NOT NULL
);

INSERT INTO hardware (provider, name) VALUES ('Amazon', 'c5') ON CONFLICT (name) DO NOTHING;
INSERT INTO hardware (provider, name) VALUES ('Azure', 'H16mr') ON CONFLICT (name) DO NOTHING;


