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