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