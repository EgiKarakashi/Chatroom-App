-- users --

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

FROM generate_series(1, 1000) AS "person"

ON CONFLICT ON CONSTRAINT "users_pkey"
DO UPDATE SET
  "user_id" = EXCLUDED."user_id",
  "name" = EXCLUDED."name",
  "email" = EXCLUDED."email",
  "created_at" = EXCLUDED."created_at"



-- chatrooms --

  INSERT INTO "public"."chatrooms" ("chatroom_id", "name", "created_by", "created_at")

SELECT
("chatroom") AS "chatroom_id",
CONCAT('chatroom', "chatroom") AS "name",
("chatroom") AS "created_by",
now() - '30d'::INTERVAL * random() AS "created_at"

FROM generate_series(1, 1000) AS "chatroom"

ON CONFLICT ON CONSTRAINT "chatrooms_pkey"
DO UPDATE SET
  "chatroom_id" = EXCLUDED."chatroom_id",
  "name" = EXCLUDED."name",
  "created_by" = EXCLUDED."created_by",
  "created_at" = EXCLUDED."created_at"




-- messages -- 

INSERT INTO "public"."chatrooms" ("chatroom_id", "name", "created_by", "created_at")

SELECT
("chatroom") AS "chatroom_id",
CONCAT('chatroom', "chatroom") AS "name",
("chatroom") AS "created_by",
now() - '30d'::INTERVAL * random() AS "created_at"

FROM generate_series(1, 1000) AS "chatroom"

ON CONFLICT ON CONSTRAINT "chatrooms_pkey"
DO UPDATE SET
  "chatroom_id" = EXCLUDED."chatroom_id",
  "name" = EXCLUDED."name",
  "created_by" = EXCLUDED."created_by",
  "created_at" = EXCLUDED."created_at"