DROP TYPE if exists fitness_goal cascade;
DROP TYPE if exists days_of_wk cascade;
DROP TYPE if exists gym_type cascade;
DROP TYPE if exists ex_type cascade;
DROP TYPE if exists s_type cascade;
DROP TYPE if exists experience_lvl cascade;
DROP TYPE if exists p_type cascade;

DROP TABLE if exists users cascade;
DROP TABLE if exists user_fitness cascade;
DROP TABLE if exists user_injury cascade;
DROP TABLE if exists exercise cascade;
DROP TABLE If exists exercise_injured cascade;
DROP TABLE if exists equipment cascade;
DROP TABLE if exists fitness_program cascade;
DROP TABLE if exists body_part cascade;
DROP TABLE if exists data_source cascade;
DROP TABLE if exists user_progress_weight cascade;
DROP TABLE if exists user_progress_cardio cascade;
DROP TABLE if exists user_preference cascade;

CREATE TABLE users
(
    u_id SERIAL PRIMARY KEY,
    uname varchar(40) NOT NULL,
    weight integer,
    height integer,
    gender varchar(1),
    age integer,
    location varchar(40)
);

CREATE TABLE equipment
(
    eq_id SERIAL PRIMARY KEY,
    eq_name varchar(40) NOT NULL
);

CREATE TYPE fitness_goal AS ENUM ('Build Muscle', 'Lose Fat', 'General Fitness', 'Increase Strength', 'Increase Endurance');
CREATE TYPE days_of_wk AS ENUM ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');
CREATE TYPE gym_type AS ENUM ('gym', 'home');

CREATE TABLE user_fitness
(
    u_id integer NOT NULL REFERENCES users (u_id),
    current_fitness integer,
    experience integer NOT NULL,
    fit_goal fitness_goal NOT NULL,
    days_available integer,
    busy_days days_of_wk[],
    gym_type gym_type,
    eq_id integer[]
);

CREATE TABLE body_part
(
    bp_id SERIAL PRIMARY KEY,
    bp_name varchar(40) NOT NULL
);

CREATE TABLE user_injury
(
    u_id integer NOT NULL REFERENCES users (u_id),
    bp_id integer NOT NULL REFERENCES body_part (bp_id)
);

CREATE TYPE ex_type AS ENUM ('compound', 'isolation');

CREATE TABLE exercise
(
    ex_id SERIAL PRIMARY KEY,
    ex_name varchar(40) NOT NULL,
    ex_type ex_type,
    p_bodypart integer[] NOT NULL,
    s_bodypart integer[] NOT NULL,
    eq_id integer[] NOT NULL,
    media text
);

CREATE TABLE exercise_injured
(
    ex_id integer NOT NULL REFERENCES exercise (ex_id),
    bp_id integer NOT NULL REFERENCES body_part (bp_id)
);

CREATE TYPE s_type AS ENUM ('website', 'pro');

CREATE TABLE data_source
(
    s_id SERIAL PRIMARY KEY,
    s_name varchar(40),
    s_type s_type
);

CREATE TYPE experience_lvl AS ENUM ('Beginner', 'Intermediate', 'Advanced');
CREATE TYPE p_type AS ENUM ('Single Muscle Group', 'Split', 'Full Body');

CREATE TABLE fitness_program
(
    P_id SERIAL PRIMARY KEY,
    p_name varchar(40) NOT NULL,
    p_type p_type,
    author varchar(40),
    data_source varchar(40),
    fit_goal fitness_goal NOT NULL,
    exp_lvl experience_lvl NOT NULL,
    gender varchar(1) NOT NULL,
    days_per_wk integer NOT NULL,
    eq_id integer[],
    bodypart_freq jsonb NOT NULL,
    p_schedule jsonb NOT NULL,
    cover_img text,
    p_summary text,
    shares integer,
    stars integer,
    votes integer,
    comment_count integer
);

CREATE TABLE user_progress_weight
(
    u_id integer NOT NULL REFERENCES users (u_id),
    ex_id integer NOT NULL REFERENCES exercise (ex_id),
    weights integer NOT NULL,
    sets integer NOT NULL,
    reps integer NOT NULL
);

CREATE TABLE user_progress_cardio
(
    u_id integer NOT NULL REFERENCES users (u_id),
    ex_id integer NOT NULL REFERENCES exercise (ex_id),
    times integer NOT NULL,
    speed integer NOT NULL,
    distance integer NOT NULL
);

CREATE TABLE user_preference
(
    u_id integer NOT NULL REFERENCES users (u_id),
    ex_id integer NOT NULL REFERENCES exercise (ex_id),
    pref varchar(1) NOT NULL
);

INSERT INTO equipment (eq_name) 
VALUES ('Barbell'), ('Bodyweight'), ('Cables'), ('Dumbbells'), ('Machines'), ('EZ Bar'), ('Other'), ('Kettle Bells'), ('Bands'), ('Exercise Ball'), ('Medicine Ball');
