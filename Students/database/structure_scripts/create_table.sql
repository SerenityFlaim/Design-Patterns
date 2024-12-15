CREATE TABLE student (
		id serial PRIMARY KEY,
		surname varchar(50) NOT NULL,
		name varchar(50) NOT NULL,
		patronymic varchar(50) NOT NULL,
		birthdate date,
		telegram varchar(50),
		email varchar(50),
		phone varchar(50),
		github varchar(50)
);