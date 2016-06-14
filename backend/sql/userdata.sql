-- user 
INSERT INTO users (uname, weight, height, gender, bday) 
VALUES ('Eric',63,177,'Male','1994-09-20');

-- goal
INSERT INTO goals (goal_type, goal_name)
VALUES ('Activity', 'calariessOut');

-- personal_goal
INSERT INTO personal_goal (user_id,goal_id,init_value,goal_value)
VALUES (1,1,1643,2500);

-- challenges
INSERT INTO challenges (goal_id, challenge_start_date)
VALUES (1, CURRENT_DATE);

-- user_challenge
INSERT INTO user_challenge (challenge_id, user_id, user_challenge_status)
VALUES (1,1,'Pending');

