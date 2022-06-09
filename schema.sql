-- user --

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


-- chatrooms --

CREATE SEQUENCE "chatroom_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 2147483647
CACHE 1;

CREATE TABLE "public". "chatrooms" (
  "chatroom_id" INTEGER NOT NULL DEfAULT nextval('chatroom_id_seq'),
  "name" TEXT NOT NULL,
  "created_by" INTEGER NOT NULL,
  "created_at" TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT "chatrooms_pkey" PRIMARY KEY ("chatroom_id")
);


ALTER TABLE ONLY "public". "chatrooms"
ADD CONSTRAINT "chatrooms_id_fkey"
FOREIGN KEY (created_by) REFERENCES users(user_id)
ON UPDATE CASCADE
ON DELETE CASCADE
NOT DEFERRABLE;

-- messages --

CREATE SEQUENCE "message_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 2147483647
CACHE 1;

CREATE TABLE "public". "messages" (
  "message_id" INTEGER NOT NULL DEfAULT nextval('message_id_seq'),
  "data" TEXT NOT NULL,
  "chatroom_id" INTEGER NOT NULL,
  "created_by" INTEGER NOT NULL,
  "sent_to" INTEGER NOT NULL,
  "sent_at" TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT "messages_pkey" PRIMARY KEY ("message_id")
);

ALTER TABLE ONLY "public". "messages"
ADD CONSTRAINT "messagecreated_id_fkey"
FOREIGN KEY (created_by) REFERENCES users(user_id)
ON UPDATE CASCADE
ON DELETE CASCADE
NOT DEFERRABLE;

ALTER TABLE ONLY "public". "messages"
ADD CONSTRAINT "messagesent_id_fkey"
FOREIGN KEY (sent_to) REFERENCES users(user_id)
ON UPDATE CASCADE
ON DELETE CASCADE
NOT DEFERRABLE;

ALTER TABLE ONLY "public". "messages"
ADD CONSTRAINT "messagechatrooms_id_fkey"
FOREIGN KEY (chatroom_id) REFERENCES chatrooms(chatroom_id)
ON UPDATE CASCADE
ON DELETE CASCADE
NOT DEFERRABLE;