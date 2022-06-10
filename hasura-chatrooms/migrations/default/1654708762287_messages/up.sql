CREATE SEQUENCE "message_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 214748390
CACHE 1;

CREATE TABLE "public". "messages" (
  "message_id" INTEGER NOT NULL DEfAULT nextval('message_id_seq'),
  "data" TEXT NOT NULL,
  "chatroom_id" INTEGER NOT NULL,
  "user_id" INTEGER NOT NULL,
  "sent_to" INTEGER NOT NULL,
  "sent_at" TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT "messages_pkey" PRIMARY KEY ("message_id")
);

ALTER TABLE ONLY "public". "messages"
ADD CONSTRAINT "messagecreated_id_fkey"
FOREIGN KEY (user_id) REFERENCES users(user_id)
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