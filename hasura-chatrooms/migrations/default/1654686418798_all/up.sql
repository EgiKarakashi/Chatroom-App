SET check_function_bodies = false;
CREATE SEQUENCE public.chatroom_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147488947
    CACHE 1;
CREATE VIEW public.chatroom_messages AS
SELECT
    NULL::integer AS chatroom_id,
    NULL::text AS chatroom_name,
    NULL::bigint AS tot_message,
    NULL::timestamp with time zone AS last_message_created_at,
    NULL::integer AS last_message_user_name,
    NULL::text AS last_message_content;
CREATE TABLE public.chatrooms (
    chatroom_id integer DEFAULT nextval('public.chatroom_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147983647
    CACHE 1;
CREATE TABLE public.messages (
    message_id integer DEFAULT nextval('public.message_id_seq'::regclass) NOT NULL,
    data text NOT NULL,
    chatroom_id integer NOT NULL,
    user_id integer NOT NULL,
    sent_to integer NOT NULL,
    sent_at timestamp with time zone DEFAULT now() NOT NULL
);


CREATE SEQUENCE "full-schema_id_seq"
INCREMENT 1
MINVALUE 1
MAXVALUE 2147483647
CACHE 1;

CREATE TABLE "public". "full-schema" (
  "schema-id" INTEGER NOT NULL DEfAULT nextval('full-schema_id_seq'),
  "schema-name" TEXT NOT NULL,
  "created_at" TIMESTAMPTZ DEFAULT NOW() NOT NULL,
  CONSTRAINT "fullschema_pkey" PRIMARY KEY ("schema-id")
);

CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483947
    CACHE 1;
CREATE TABLE public.users (
    user_id integer DEFAULT nextval('public.user_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    email text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);
ALTER TABLE ONLY public.chatrooms
    ADD CONSTRAINT chatrooms_pkey PRIMARY KEY (chatroom_id);
CREATE MATERIALIZED VIEW public.chatroom_messages_materialized AS
 SELECT c.chatroom_id,
    c.name AS chatroom_name,
    count(m.message_id) AS tot_message,
    m.sent_at AS last_message_created_at,
    m.user_id AS last_message_user_name,
    m.data AS last_message_content
   FROM (public.chatrooms c
     LEFT JOIN public.messages m ON ((c.chatroom_id = m.chatroom_id)))
  GROUP BY c.chatroom_id, m.sent_at, m.user_id, m.data
  ORDER BY m.sent_at DESC
 LIMIT 1
  WITH NO DATA;
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (message_id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
CREATE OR REPLACE VIEW public.chatroom_messages AS
 SELECT c.chatroom_id,
    c.name AS chatroom_name,
    count(m.message_id) AS tot_message,
    m.sent_at AS last_message_created_at,
    m.user_id AS last_message_user_name,
    m.data AS last_message_content
   FROM (public.chatrooms c
     LEFT JOIN public.messages m ON ((c.chatroom_id = m.chatroom_id)))
  GROUP BY c.chatroom_id, m.sent_at, m.user_id, m.data
  ORDER BY m.sent_at DESC
 LIMIT 1;
ALTER TABLE ONLY public.chatrooms
    ADD CONSTRAINT chatrooms_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messagechatrooms_id_fkey FOREIGN KEY (chatroom_id) REFERENCES public.chatrooms(chatroom_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messagecreated_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messagesent_id_fkey FOREIGN KEY (sent_to) REFERENCES public.users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
