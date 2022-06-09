CREATE SEQUENCE "chatroom_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 2147483647
CACHE 1;

CREATE TABLE "public". "chatrooms" (
  "chatroom_id" INTEGER NOT NULL DEfAULT nextval('chatroom_id_seq'),
  "name" TEXT NOT NULL,
  "user_id" INTEGER NOT NULL,
  "created_at" TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT "chatrooms_pkey" PRIMARY KEY ("chatroom_id")
);

ALTER TABLE ONLY "public". "chatrooms"
ADD CONSTRAINT "chatrooms_id_fkey"
FOREIGN KEY (user_id) REFERENCES users(user_id)
ON UPDATE CASCADE
ON DELETE CASCADE
NOT DEFERRABLE;