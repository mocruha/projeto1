CREATE DATABASE pg_test;

\c pg_test;

CREATE TABLE acc (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR (50) UNIQUE NOT NULL
);