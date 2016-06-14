DROP TYPE IF EXISTS gender CASCADE;
DROP TYPE IF EXISTS goal_type CASCADE;
DROP TYPE IF EXISTS user_challenge_status CASCADE;

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS goals CASCADE;
DROP TABLE IF EXISTS personal_goal CASCADE;
DROP TABLE IF EXISTS challenges CASCADE;
DROP TABLE IF EXISTS user_challenge CASCADE;
DROP TABLE IF EXISTS user_fitbit CASCADE;

CREATE TYPE gender AS ENUM ('Male', 'Female');
CREATE TYPE goal_type AS ENUM ('Activity', 'Body', 'Sleep');
CREATE TYPE user_challenge_status AS ENUM ('Pending', 'Accepted', 'Declined');

CREATE TABLE users
(
    user_id SERIAL PRIMARY KEY,
    uname varchar(30) NOT NULL,
    weight INT,
    height INT,
    bmi REAL, 
    fat REAL,
    gender gender,
    bday DATE,
    user_token TEXT
);

CREATE TABLE goals
(
    goal_id SERIAL PRIMARY KEY,
    goal_type goal_type NOT NULL,
    goal_name VARCHAR(20) NOT NULL
);

CREATE TABLE personal_goal 
(
    personal_goal_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users (user_id),
    goal_id INT NOT NULL REFERENCES goals (goal_id),
    init_value REAL NOT NULL,
    goal_value REAL NOT NULL,
    UNIQUE (user_id, goal_id)
);

CREATE TABLE challenges
(
    challenge_id SERIAL PRIMARY KEY,
    goal_id INT NOT NULL REFERENCES goals (goal_id),
    challenge_start_date DATE NOT NULL,
    challenge_end_date DATE,
    challenge_status INT NOT NULL DEFAULT 0
);

CREATE TABLE user_challenge
(
    challenge_id INT NOT NULL REFERENCES challenges (challenge_id),
    user_id INT NOT NULL REFERENCES users (user_id),
    current_value REAL,
    user_challenge_status user_challenge_status,
    PRIMARY KEY (challenge_id, user_id)
);

CREATE TABLE user_fitbit
(
    user_id INT NOT NULL REFERENCES users (user_id),
    fitbit_user_id INT NOT NULL,
    fitbit_device_id INT
);