-- Assignments 1.2

Create a table named automagic with the following fields:
An id field that is an auto incrementing serial field.
A name field that allows up to 32 characters but no more This field is required. (PostgreSQL Constraints)
A height field that is a floating point number that is required.

-- Answer 1.2:

create table automagic (
id serial,
name varchar(32) not null,
height real not null,
primary key (id)
);

-- The command ' ls -l ' is used to list directory contents in a detailed (long) format.

-- wget dan curl -O berfungsi untuk mengupload csv file, contohnya:
-- wget https://www.pg4e.com/tools/sql/library.csv
-- curl -O https://www.pg4e.com/tools/sql/library.csv

-- ' vi library.csv ' is used to open and edit the file named library.csv
-- To quit: Press ctr + C, the type :qa -> enter

-- \d = Menampilkan semua objek dalam skema, seperti tabel, indeks, urutan (sequences), dan tampilan (views).
-- \dt = Menampilkan hanya tabel-tabel biasa (ordinary tables) dalam skema.	
-- \r = membatalkan query yg sedang ditulis


-- Assignments 1.3

CREATE TABLE make (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE model (
  id SERIAL,
  name VARCHAR(128),
  make_id INTEGER REFERENCES make(id) ON DELETE CASCADE,
  PRIMARY KEY(id)
);


Insert the following data into your database separating it appropriately into the make and model tables 
and setting the make_id foreign key to link each model to its corresponding make.

To grade this assignment, the program will run a query like this on your database and look for the data above:

SELECT make.name, model.name
    FROM model
    JOIN make ON model.make_id = make.id
    ORDER BY make.name LIMIT 5;

-- Answer 1.3:

insert into make (name) values ('Kia');
insert into make (name) values ('Mercury');

insert into model (name, make_id) values ('Spectra 2.0L', 1);
insert into model (name, make_id) values ('Sportage 2WD', 1);
insert into model (name, make_id) values ('Sportage 4WD', 1);
insert into model (name, make_id) values ('Lynx Wagon', 2);
insert into model (name, make_id) values ('Marauder', 2);

-- Assignments 1.4

CREATE TABLE student (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE course (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE roster (
    id SERIAL,
    student_id INTEGER REFERENCES student(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course(id) ON DELETE CASCADE,
    role INTEGER,
    UNIQUE(student_id, course_id),
    PRIMARY KEY (id)
);

You will normalize the following data (each user gets different data), and insert the following data items into your database, 
creating and linking all the foreign keys properly. Encode instructor with a role of 1 and a learner with a role of 0.

Laurie, si106, Instructor
Arnav, si106, Learner
Nadeem, si106, Learner
Neema, si106, Learner
Sukhman, si106, Learner
Wojciech, si110, Instructor
Cameryn, si110, Learner
Jeannie, si110, Learner
Sabriyah, si110, Learner
Shayne, si110, Learner
Karhys, si206, Instructor
Aahron, si206, Learner
Hamani, si206, Learner
Kadey, si206, Learner
Torrin, si206, Learner

You can test to see if your data has been entered properly with the following SQL statement.

SELECT student.name, course.title, roster.role
    FROM student 
    JOIN roster ON student.id = roster.student_id
    JOIN course ON roster.course_id = course.id
    ORDER BY course.title, roster.role DESC, student.name;

-- Answer 1.4:

insert into student (name) values ('Laurie');
insert into student (name) values ('Arnav');
insert into student (name) values ('Nadeem');
insert into student (name) values ('Neema');
insert into student (name) values ('Sukhman');
insert into student (name) values ('Wojciech');
insert into student (name) values ('Cameryn');
insert into student (name) values ('Jeannie');
insert into student (name) values ('Sabriyah');
insert into student (name) values ('Shayne');
insert into student (name) values ('Karhys');
insert into student (name) values ('Aahron');
insert into student (name) values ('Hamani');
insert into student (name) values ('Kadey');
insert into student (name) values ('Torrin');

insert into course (title) values ('si106');
insert into course (title) values ('si110');
insert into course (title) values ('si206');

insert into roster (student_id, course_id, role) values (1,1,1);
insert into roster (student_id, course_id, role) values (2,1,0);
insert into roster (student_id, course_id, role) values (3,1,0);
insert into roster (student_id, course_id, role) values (4,1,0);
insert into roster (student_id, course_id, role) values (5,1,0);
insert into roster (student_id, course_id, role) values (6,2,1);
insert into roster (student_id, course_id, role) values (7,2,0);
insert into roster (student_id, course_id, role) values (8,2,0);
insert into roster (student_id, course_id, role) values (9,2,0);
insert into roster (student_id, course_id, role) values (10,2,0);
insert into roster (student_id, course_id, role) values (11,3,1);
insert into roster (student_id, course_id, role) values (12,3,0);
insert into roster (student_id, course_id, role) values (13,3,0);
insert into roster (student_id, course_id, role) values (14,3,0);
insert into roster (student_id, course_id, role) values (15,3,0);




















