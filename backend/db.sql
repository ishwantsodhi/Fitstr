DROP TYPE if exists fitness_goal cascade;
DROP TYPE if exists etype cascade;
DROP TYPE if exists experience_lvl cascade;
DROP TABLE if exists users cascade;
DROP TABLE if exists user_fitness cascade;
DROP TABLE if exists user_injury cascade;
DROP TABLE if exists exercise cascade;
DROP TABLE if exists equipments cascade;
DROP TABLE if exists fitness_program cascade;

CREATE TABLE users
(
    u_id integer NOT NUll PRIMARY KEY,
    uname varchar(40) NOT NULL,
    weight integer,
    height integer,
    gender varchar(1),
    age integer,
    location varchar(40)
);

CREATE TYPE fitness_goal AS ENUM ('build_muscle', 'lose_weight', 'stay_fit');

CREATE TABLE user_fitness
(
    u_id integer NOT NULL,
    current_fitness integer,
    experience integer NOT NULL,
    fit_goal fitness_goal,
    days_available integer,
    busy_days varchar(3),
    gym_type varchar(1),
    cooks integer,
    equipment varchar(40)
);

CREATE TABLE user_injury
(
    u_id integer NOT NULL,
    bodypart varchar(40)
);

CREATE TYPE etype AS ENUM ('compound', 'isolation');

CREATE TABLE exercise
(
    e_id integer NOT NULL PRIMARY KEY,
    ename varchar(40) NOT NULL,
    etype etype,
    p_muscle varchar(40) NOT NULL,
    s_muscle varchar(40) NOT NULL,
    eq_id integer NOT NULL,
    edemo text
);

CREATE TABLE equipments
(
    eq_id integer NOT NULL PRIMARY KEY,
    eq_name varchar(40) NOT NULL,
    eq_brand varchar(40)
);

CREATE TYPE experience_lvl AS ENUM ('beginner', 'intermediate', 'experienced', 'pro');

CREATE TABLE fitness_program
(
    f_id integer NOT NULL PRIMARY KEY,
    p_name varchar(40) NOT NULL,
    author varchar(40),
    data_source varchar(40),
    fit_goal fitness_goal NOT NULL,
    exp_lvl experience_lvl NOT NULL,
    gender varchar(1) NOT NULL,
    days_per_wk integer NOT NULL,
    eq_id integer,
    bodypart_freq jsonb NOT NULL,
    training_split jsonb NOT NULL
);
