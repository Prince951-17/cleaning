# --- !Ups
CREATE TABLE "GenderCodes" ("id" SERIAL NOT NULL PRIMARY KEY,"name" VARCHAR NOT NULL, "code" VARCHAR NOT NULL, UNIQUE(code));
CREATE TABLE "EducationCodes" ("id" SERIAL NOT NULL PRIMARY KEY,"name" VARCHAR NOT NULL, "code" VARCHAR NOT NULL, UNIQUE(code));
CREATE TABLE "Role" ("id" SERIAL NOT NULL PRIMARY KEY, "role" VARCHAR NOT NULL, UNIQUE(role));

CREATE TABLE "Workers" (
  "id" SERIAL NOT NULL PRIMARY KEY,
  "surname" VARCHAR NOT NULL,
  "firstName" VARCHAR NOT NULL,
  "lastName" VARCHAR NULL,
  "address" VARCHAR NOT NULL,
  "phone" VARCHAR NOT NULL,
  "passportSeriesAndNumber" VARCHAR NOT NULL,
  "dayGettingPassport" TIMESTAMP NOT NULL,
  "photoName" VARCHAR NOT NULL,
  "photoHash" VARCHAR NOT NULL,
  "warnings" jsonb NULL,
  "pensionNumber" INTEGER NULL,
  "itn" BIGINT NOT NULL,
  "genderId" INTEGER CONSTRAINT "workersFkGenderCodeId" REFERENCES "GenderCodes" ON update CASCADE ON DELETE CASCADE,
  "birthDay" TIMESTAMP NOT NULL,
  "birthPlace" VARCHAR NOT NULL,
  "educationId" INTEGER CONSTRAINT  "educationFkEducationCodeId" REFERENCES  "EducationCodes" ON UPDATE CASCADE ON DELETE CASCADE,
  "password" VARCHAR NOT NULL,
  "role" INTEGER CONSTRAINT  "roleFkRoleId" REFERENCES  "Role" ON UPDATE CASCADE ON DELETE CASCADE,
  UNIQUE ("passportSeriesAndNumber", "pensionNumber", "itn", "password")
);

INSERT INTO "GenderCodes" ("name", "code") VALUES ('erkak', 'male');
INSERT INTO "GenderCodes" ("name", "code") VALUES ('ayol', 'female');

INSERT INTO "EducationCodes" ("name", "code") VALUES ('yoq', 'absent');
INSERT INTO "EducationCodes" ("name", "code") VALUES ('orta', 'secondary');
INSERT INTO "EducationCodes" ("name", "code") VALUES ('oliy', 'high');

INSERT INTO "Role" ("role") VALUES ('Worker');
INSERT INTO "Role" ("role") VALUES ('Manager');

# --- !Downs
DROP TABLE "Workers";
DROP TABLE "Role";
DROP TABLE "EducationCodes";
DROP TABLE "GenderCodes";
