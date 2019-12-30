create database file_upload
use file_upload


create table Users (users_id int primary key identity(1,1), users_name nvarchar(80), email varchar(60), pass nvarchar(20), users_type nvarchar(1))
create table Coursses (course_id int primary key, course_name nvarchar(50))
create table Files (files_id int primary key identity, title nvarchar(120), upload_date datetime, course_id int foreign key references Coursses(course_id) on Update cascade  on Delete cascade , users_id int foreign key references Users(users_id) on Update cascade  on Delete cascade, path varchar(100), downloads int)
