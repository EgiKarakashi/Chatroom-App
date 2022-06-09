INSERT INTO "public"."users" ("user_id", "name", "email", "created_at")

SELECT 
  ("person") AS "user_id",
  CONCAT('person', "person") AS "name",
  CONCAT('person' || person || '@' ||
  (case (random() * 2)::integer
    when 0 then 'gmail'
    when 1 then 'hotmail'
    when 2 then 'yahoo'
  end) || '.com') AS "email",
  now() - '30d'::INTERVAL * random() AS "created_at"

FROM generate_series(1, 100) AS "person"

ON CONFLICT ON CONSTRAINT "users_pkey"
DO UPDATE SET
  "user_id" = EXCLUDED."user_id",
  "name" = EXCLUDED."name",
  "email" = EXCLUDED."email",
  "created_at" = EXCLUDED."created_at";


INSERT INTO "public"."chatrooms" ("chatroom_id", "name", "user_id", "created_at")

SELECT
("chatroom") AS "chatroom_id",
CONCAT('chatroom', "chatroom") AS "name",
("chatroom") AS "user_id",
now() - '30d'::INTERVAL * random() AS "created_at"

FROM generate_series(1, 100) AS "chatroom"

ON CONFLICT ON CONSTRAINT "chatrooms_pkey"
DO UPDATE SET
  "chatroom_id" = EXCLUDED."chatroom_id",
  "name" = EXCLUDED."name",
  "user_id" = EXCLUDED."user_id",
  "created_at" = EXCLUDED."created_at";


INSERT INTO "public"."messages" ("message_id", "data", "chatroom_id", "user_id", "sent_to", "sent_at")

SELECT
("message") AS "message_id",
md5(random()::text) AS "data",
("message") AS "chatroom_id",
("message") AS "user_id",
floor(random() * 100 + 1)::int AS "sent_to",
now() - '30d'::INTERVAL * random() AS "sent_at"


FROM generate_series(1, 100) AS "message"

ON CONFLICT ON CONSTRAINT "messages_pkey"
DO UPDATE SET
  "message_id" = EXCLUDED."message_id",
  "data" = EXCLUDED."data",
  "chatroom_id" = EXCLUDED."chatroom_id",
  "user_id" = EXCLUDED."user_id",
  "sent_to" = EXCLUDED."sent_to",
  "sent_at" = EXCLUDED."sent_at";