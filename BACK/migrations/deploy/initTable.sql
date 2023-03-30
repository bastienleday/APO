-- Deploy 3db:initTable to pg

BEGIN;

CREATE TABLE IF NOT EXISTS "user" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "pseudo" TEXT NOT NULL UNIQUE,
    "email" TEXT NOT NULL UNIQUE CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'),
    "password" TEXT NOT NULL,
    "firstname" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "picture" BYTEA,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL
);


CREATE TABLE IF NOT EXISTS "model" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "data" BYTEA NOT NULL,
    "format" TEXT NOT NULL,
    "download" BOOLEAN NOT NULL,
    "description" TEXT NOT NULL,
    "picture" BYTEA,
    "tag" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL REFERENCES "user" ("id") ON DELETE CASCADE,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL
);


CREATE TABLE IF NOT EXISTS "category" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "name" TEXT NOT NULL UNIQUE,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL
);


CREATE TABLE IF NOT EXISTS "comment" (
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "content" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL REFERENCES "user" ("id") ON DELETE CASCADE,
    "model_id" INTEGER NOT NULL REFERENCES "model" ("id") ON DELETE CASCADE,
    "created_at" TIMESTAMP NOT NULL DEFAULT NOW(),
    "updated_at" TIMESTAMP NOT NULL
);

CREATE TABLE IF NOT EXISTS "model_has_category"(
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "model_id" INTEGER NOT NULL REFERENCES "model" ("id"),
    "category_id" INTEGER NOT NULL REFERENCES "category" ("id")
);

CREATE TABLE IF NOT EXISTS "model_has_like"(
    "id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "model_id" INTEGER NOT NULL REFERENCES "model" ("id") ON DELETE CASCADE,
    "user_id" INTEGER NOT NULL REFERENCES "user" ("id") ON DELETE CASCADE
  
);




COMMIT;
