CREATE TABLE USER (
id INTEGER PRIMARY KEY AUTOINCREMENT,
name VARCHAR(200) NOT NULL,
email VARCHAR(200) NOT NULL,
password VARCHAR(200) NOT NULL)
)


CREATE TABLE ACTIVITY (
id INTEGER PRIMARY KEY AUTOINCREMENT,
title VARCHAR(200) NOT NULL,
description VARCHAR(500) NOT NULL,
date datetime NOT NULL
)

CREATE TABLE USER-ACTIVITY (
userId INTEGER FOREIGN KEY REFERENCES USER(id) NOT NULL,
activityId INTEGER FOREIGN KEY REFERENCES ACTIVITY(id) NOT NULL,
deliver datetime,
grade double
)

-- /

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    email VARCHAR(200) NOT NULL,
    password VARCHAR(200) NOT NULL
);

CREATE TABLE activity (
    id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description VARCHAR(500) NOT NULL,
    "date" TIMESTAMP NOT NULL
);


CREATE TABLE user_activity (
    id SERIAL PRIMARY KEY,
    userId INTEGER REFERENCES "user"(id) NOT NULL,
    activityId INTEGER REFERENCES activity(id) NOT NULL,
    deliver TIMESTAMP,
    grade DOUBLE PRECISION
);


INSERT INTO "user" (name, email, password) VALUES ('teste', 'test@example.com', 'password');

INSERT INTO activity (title, description, "date") VALUES ('Activity 1', 'Description 1', '2022-01-01 10:00:00');

INSERT INTO user_activity (userId, activityId, deliver, grade) VALUES (1, 1, '2022-01-01 12:00:00', 9.5);


