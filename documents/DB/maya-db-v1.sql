CREATE TABLE IF NOT EXISTS "users" (
	"id" UUID NOT NULL,
	"username" VARCHAR(31) NOT NULL UNIQUE,
	-- bcrypt hash with 60 characters
	"password" VARCHAR(255) NOT NULL,
	"Email" VARCHAR(255) NOT NULL,
	"photo" VARCHAR(255),
	"signup_date" TIMESTAMPTZ NOT NULL,
	PRIMARY KEY("id")
);

COMMENT ON COLUMN "users"."password" IS 'bcrypt hash with 60 characters';

CREATE TABLE IF NOT EXISTS "bots" (
	"id" UUID NOT NULL,
	"user_id" UUID NOT NULL,
	"name" VARCHAR(128) NOT NULL,
	"description" VARCHAR(255),
	"create_date" TIMESTAMPTZ NOT NULL,
	"update_date" TIMESTAMPTZ,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "BotExecutionLog?" (
	"id" SERIAL NOT NULL,
	"botId" UUID NOT NULL,
	"nodeId" UUID NOT NULL,
	"Log" VARCHAR(255) NOT NULL,
	"date" TIMESTAMPTZ,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "botNodes" (
	"id" UUID NOT NULL,
	"nodeId" VARCHAR(127) NOT NULL,
	"botId" UUID NOT NULL,
	"rootNodeId" SERIAL NOT NULL,
	"name" VARCHAR(100) NOT NULL,
	"nodePosition" POINT NOT NULL,
	"config" JSONB,
	PRIMARY KEY("id")
);

CREATE TABLE IF NOT EXISTS "botEdges" (
	"source" UUID NOT NULL,
	"destination" UUID NOT NULL,
	PRIMARY KEY("source", "destination"),
	CONSTRAINT "botEdges_unique_0" UNIQUE ("source", "destination")
);

ALTER TABLE "bots"
ADD FOREIGN KEY("user_id") REFERENCES "users"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "BotExecutionLog?"
ADD FOREIGN KEY("botId") REFERENCES "bots"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "botNodes"
ADD FOREIGN KEY("botId") REFERENCES "bots"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "botEdges"
ADD FOREIGN KEY("source") REFERENCES "botNodes"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "botEdges"
ADD FOREIGN KEY("source") REFERENCES "botNodes"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE "botEdges"
ADD FOREIGN KEY("destination") REFERENCES "botNodes"("id")
ON UPDATE NO ACTION ON DELETE NO ACTION;