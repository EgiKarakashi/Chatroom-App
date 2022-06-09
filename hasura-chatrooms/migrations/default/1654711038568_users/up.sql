CREATE SEQUENCE "user_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 2147483647
CACHE 1;

CREATE TABLE "public". "users" (
  "user_id" INTEGER NOT NULL DEfAULT nextval('user_id_seq'),
  "name" TEXT NOT NULL,
  "email" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT "users_pkey" PRIMARY KEY ("user_id")
);