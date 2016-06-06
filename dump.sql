--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: days_of_wk; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE days_of_wk AS ENUM (
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
);


ALTER TYPE days_of_wk OWNER TO fitstr;

--
-- Name: ex_type; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE ex_type AS ENUM (
    'compound',
    'isolation'
);


ALTER TYPE ex_type OWNER TO fitstr;

--
-- Name: experience_lvl; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE experience_lvl AS ENUM (
    'Beginner',
    'Intermediate',
    'Advanced'
);


ALTER TYPE experience_lvl OWNER TO fitstr;

--
-- Name: fitness_goal; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE fitness_goal AS ENUM (
    'Build Muscle',
    'Lose Fat',
    'General Fitness',
    'Increase Strength',
    'Increase Endurance',
    'Sports Performance'
);


ALTER TYPE fitness_goal OWNER TO fitstr;

--
-- Name: gender; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE gender AS ENUM (
    'Male',
    'Female',
    'Male & Female'
);


ALTER TYPE gender OWNER TO fitstr;

--
-- Name: gym_type; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE gym_type AS ENUM (
    'gym',
    'home'
);


ALTER TYPE gym_type OWNER TO fitstr;

--
-- Name: p_type; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE p_type AS ENUM (
    'Single Muscle Group',
    'Split',
    'Full Body',
    'Sports Training',
    'Cardio'
);


ALTER TYPE p_type OWNER TO fitstr;

--
-- Name: s_type; Type: TYPE; Schema: public; Owner: fitstr
--

CREATE TYPE s_type AS ENUM (
    'website',
    'pro'
);


ALTER TYPE s_type OWNER TO fitstr;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: body_part; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE body_part (
    bp_id integer NOT NULL,
    bp_name character varying(40) NOT NULL
);


ALTER TABLE body_part OWNER TO fitstr;

--
-- Name: body_part_bp_id_seq; Type: SEQUENCE; Schema: public; Owner: fitstr
--

CREATE SEQUENCE body_part_bp_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE body_part_bp_id_seq OWNER TO fitstr;

--
-- Name: body_part_bp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fitstr
--

ALTER SEQUENCE body_part_bp_id_seq OWNED BY body_part.bp_id;


--
-- Name: data_source; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE data_source (
    s_id integer NOT NULL,
    s_name character varying(40),
    s_type s_type
);


ALTER TABLE data_source OWNER TO fitstr;

--
-- Name: data_source_s_id_seq; Type: SEQUENCE; Schema: public; Owner: fitstr
--

CREATE SEQUENCE data_source_s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE data_source_s_id_seq OWNER TO fitstr;

--
-- Name: data_source_s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fitstr
--

ALTER SEQUENCE data_source_s_id_seq OWNED BY data_source.s_id;


--
-- Name: equipment; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE equipment (
    eq_id integer NOT NULL,
    eq_name character varying(40) NOT NULL
);


ALTER TABLE equipment OWNER TO fitstr;

--
-- Name: equipment_eq_id_seq; Type: SEQUENCE; Schema: public; Owner: fitstr
--

CREATE SEQUENCE equipment_eq_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE equipment_eq_id_seq OWNER TO fitstr;

--
-- Name: equipment_eq_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fitstr
--

ALTER SEQUENCE equipment_eq_id_seq OWNED BY equipment.eq_id;


--
-- Name: exercise; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE exercise (
    ex_id integer NOT NULL,
    ex_name character varying(40) NOT NULL,
    ex_type ex_type,
    p_bodypart integer[] NOT NULL,
    s_bodypart integer[] NOT NULL,
    eq_id integer[] NOT NULL,
    media text
);


ALTER TABLE exercise OWNER TO fitstr;

--
-- Name: exercise_ex_id_seq; Type: SEQUENCE; Schema: public; Owner: fitstr
--

CREATE SEQUENCE exercise_ex_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exercise_ex_id_seq OWNER TO fitstr;

--
-- Name: exercise_ex_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fitstr
--

ALTER SEQUENCE exercise_ex_id_seq OWNED BY exercise.ex_id;


--
-- Name: exercise_injured; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE exercise_injured (
    ex_id integer NOT NULL,
    bp_id integer NOT NULL
);


ALTER TABLE exercise_injured OWNER TO fitstr;

--
-- Name: fitness_program; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE fitness_program (
    p_id integer NOT NULL,
    p_name text,
    fit_goal fitness_goal,
    author character varying(40),
    days_per_wk integer,
    eq_ids text,
    p_type p_type,
    exp_lvl experience_lvl,
    gender gender,
    p_summary text,
    cover_img text,
    shares integer,
    stars double precision,
    votes integer,
    comment_count integer,
    bodypart_freq jsonb,
    p_schedule jsonb,
    data_source character varying(40)
);


ALTER TABLE fitness_program OWNER TO fitstr;

--
-- Name: fitness_program_p_id_seq; Type: SEQUENCE; Schema: public; Owner: fitstr
--

CREATE SEQUENCE fitness_program_p_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE fitness_program_p_id_seq OWNER TO fitstr;

--
-- Name: fitness_program_p_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fitstr
--

ALTER SEQUENCE fitness_program_p_id_seq OWNED BY fitness_program.p_id;


--
-- Name: user_fitness; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE user_fitness (
    u_id integer NOT NULL,
    current_fitness integer,
    experience integer NOT NULL,
    fit_goal fitness_goal NOT NULL,
    days_available integer,
    busy_days days_of_wk[],
    gym_type gym_type,
    eq_id integer[]
);


ALTER TABLE user_fitness OWNER TO fitstr;

--
-- Name: user_injury; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE user_injury (
    u_id integer NOT NULL,
    bp_id integer NOT NULL
);


ALTER TABLE user_injury OWNER TO fitstr;

--
-- Name: user_preference; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE user_preference (
    u_id integer NOT NULL,
    ex_id integer NOT NULL,
    pref character varying(1) NOT NULL
);


ALTER TABLE user_preference OWNER TO fitstr;

--
-- Name: user_progress_cardio; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE user_progress_cardio (
    u_id integer NOT NULL,
    ex_id integer NOT NULL,
    times integer NOT NULL,
    speed integer NOT NULL,
    distance integer NOT NULL
);


ALTER TABLE user_progress_cardio OWNER TO fitstr;

--
-- Name: user_progress_weight; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE user_progress_weight (
    u_id integer NOT NULL,
    ex_id integer NOT NULL,
    weights integer NOT NULL,
    sets integer NOT NULL,
    reps integer NOT NULL
);


ALTER TABLE user_progress_weight OWNER TO fitstr;

--
-- Name: users; Type: TABLE; Schema: public; Owner: fitstr; Tablespace: 
--

CREATE TABLE users (
    u_id integer NOT NULL,
    uname character varying(40) NOT NULL,
    weight integer,
    height integer,
    gender character varying(1),
    age integer,
    location character varying(40)
);


ALTER TABLE users OWNER TO fitstr;

--
-- Name: users_u_id_seq; Type: SEQUENCE; Schema: public; Owner: fitstr
--

CREATE SEQUENCE users_u_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_u_id_seq OWNER TO fitstr;

--
-- Name: users_u_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: fitstr
--

ALTER SEQUENCE users_u_id_seq OWNED BY users.u_id;


--
-- Name: bp_id; Type: DEFAULT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY body_part ALTER COLUMN bp_id SET DEFAULT nextval('body_part_bp_id_seq'::regclass);


--
-- Name: s_id; Type: DEFAULT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY data_source ALTER COLUMN s_id SET DEFAULT nextval('data_source_s_id_seq'::regclass);


--
-- Name: eq_id; Type: DEFAULT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY equipment ALTER COLUMN eq_id SET DEFAULT nextval('equipment_eq_id_seq'::regclass);


--
-- Name: ex_id; Type: DEFAULT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY exercise ALTER COLUMN ex_id SET DEFAULT nextval('exercise_ex_id_seq'::regclass);


--
-- Name: p_id; Type: DEFAULT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY fitness_program ALTER COLUMN p_id SET DEFAULT nextval('fitness_program_p_id_seq'::regclass);


--
-- Name: u_id; Type: DEFAULT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY users ALTER COLUMN u_id SET DEFAULT nextval('users_u_id_seq'::regclass);


--
-- Data for Name: body_part; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY body_part (bp_id, bp_name) FROM stdin;
\.


--
-- Name: body_part_bp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fitstr
--

SELECT pg_catalog.setval('body_part_bp_id_seq', 1, false);


--
-- Data for Name: data_source; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY data_source (s_id, s_name, s_type) FROM stdin;
\.


--
-- Name: data_source_s_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fitstr
--

SELECT pg_catalog.setval('data_source_s_id_seq', 1, false);


--
-- Data for Name: equipment; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY equipment (eq_id, eq_name) FROM stdin;
1	Barbell
2	Bodyweight
3	Cables
4	Dumbbells
5	Machines
6	EZ Bar
7	Other
8	Kettle Bells
9	Bands
10	Exercise Ball
11	Medicine Ball
12	Foam Roll
13	None
\.


--
-- Name: equipment_eq_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fitstr
--

SELECT pg_catalog.setval('equipment_eq_id_seq', 13, true);


--
-- Data for Name: exercise; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY exercise (ex_id, ex_name, ex_type, p_bodypart, s_bodypart, eq_id, media) FROM stdin;
\.


--
-- Name: exercise_ex_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fitstr
--

SELECT pg_catalog.setval('exercise_ex_id_seq', 1, false);


--
-- Data for Name: exercise_injured; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY exercise_injured (ex_id, bp_id) FROM stdin;
\.


--
-- Data for Name: fitness_program; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY fitness_program (p_id, p_name, fit_goal, author, days_per_wk, eq_ids, p_type, exp_lvl, gender, p_summary, cover_img, shares, stars, votes, comment_count, bodypart_freq, p_schedule, data_source) FROM stdin;
1	 “No Juice” Advanced Bodybuilding Workout Routine	Build Muscle	Pete Khatcherian	6	[1, 2, 3, 4, 5]	Split	Advanced	Male & Female	Avoid plateauing with the "No Juice" routine, which manipulates intensity, frequency, and volume to help you continue progressing in the gym.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/no_juice_feature.jpg	0	4	9	18	\N	\N	\N
2	10 Week Chest Size & Bench Press Strength Workout	Build Muscle	M&S Team	1	[1, 4, 5]	Single Muscle Group	Beginner	Male & Female	This ten week training cycle is designed to not only boost your barbell bench press prowess but also pack on slabs of muscle mass to your upper and lower chest.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/10mass_feature.jpg	0	4.90000000000000036	40	49	\N	\N	\N
3	10 Week Mass Building Program	Build Muscle	M&S Writers	4	[1, 2, 4, 5]	Split	Advanced	Male & Female	This workout is designed to increase your muscle mass as much as possible in 10 weeks. Works each muscle group hard once per week using mostly heavy compound exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/10weekmass.jpg	0	4.79999999999999982	2200	2400	\N	\N	\N
4	100 Rep Hell: A Shocker Muscle Building Workout	Build Muscle	M&S Team	5	[1, 6, 5]	Split	Intermediate	Male & Female	Need a change? You’ve come to the right workout. This one week shocker is meant to break through the boredom and monotony, and beat your body into growth.	\N	0	4.90000000000000036	33	60	\N	\N	\N
5	100 Reps Per Set Shocker Fullbody Workout	Build Muscle	Maik Wiedenbach	2	[1, 2, 3, 4, 6, 5]	Full Body	Intermediate	Male & Female	Blast out of a rut with 100 reps per set. 100 rep sets can be used to shock the entire body for a week or two, or to bring up a lagging part.\n\n	\N	0	5	54	106	\N	\N	\N
6	12 Week Beginners Training Routine	Build Muscle	Doug Lawrenson	2	[1, 2, 3, 4, 5]	Full Body	Beginner	Male & Female	A twelve week full body beginners routine designed to get your body ready for an intense split routine. Includes a detailed week by week plan.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/12feature.jpg	0	5	272	692	\N	\N	\N
7	18 Week Chin Up & Dip Program For An Impressive Upper Body	Build Muscle	Eric Brown	4	[2, 7]	Single Muscle Group	Beginner	Male & Female	Chin ups and dips are 2 overlooked but important bodyweight exercises. This 18 week workout protocol features a single training day dedicated to these movements.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/dipchin.jpg	0	4.79999999999999982	87	165	\N	\N	\N
8	2 Day Simple A/B Split by Steve	Build Muscle	M&S Team	2	[1, 2, 4]	Full Body	Beginner	Male & Female	Effective 2 day per week fullbody routine that is perfect for building muscle and strength. If you don't have time to live in the gym this is the routine for you.	\N	0	4.79999999999999982	97	340	\N	\N	\N
9	2 Day Squat Workout For Improved Size & Strength	Build Muscle	M&S Team	2	[1, 5]	Split	Intermediate	Male & Female	No more weak and small legs. This squat specialization program will have you hammering your wheels twice a week, bringing up both your leg size and squat strength.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/2squat_feature.jpg	0	4.90000000000000036	25	18	\N	\N	\N
10	20 Rep Quad & Hamstring Shock Workout	Build Muscle	M&S Team	1	[1, 4, 5]	Single Muscle Group	Intermediate	Male	Can you handle the leg day pain? Let's find out. This is a no holds barred hardcore workout that will forge your budding twigs into mammoth tree trunks, if you dare try it.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/leg_feature.jpg	0	5	4	13	\N	\N	\N
11	2014 Minutes To A Better Body: 8 Week Fast Start Plan	Build Muscle	Brad Borland	4	[1, 2, 4]	Split	Beginner	Male & Female	Maximize your first 2014 training minutes of the new year and reach your goals with this 8 week better body quick start training program for beginners by Brad Borland. 	\N	0	5	24	12	\N	\N	\N
12	3 Day Fullbody Workout Using Alternative Tools	Build Muscle	Chris Butler	3	[2, 8, 7]	Full Body	Beginner	Male & Female	Make use of non-conventional training tools including kettlebells, sandbags, stones and bodyweight lifts, and build muscle and strength.	\N	0	5	35	11	\N	\N	\N
13	3 Day Hardcore Program	Build Muscle	M&S Writers	3	[1, 2, 3, 4, 5]	Split	Intermediate	Male & Female	This 3 day workout hits all major muscle groups. The first day targets legs/back, second day is chest/shoulders and the last is dedicated to arm training.	\N	0	4.90000000000000036	82	172	\N	\N	\N
14	3 Day Power Muscle Burn Workout Split	Build Muscle	M&S Team	3	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	Finally! A three day workout split variation for the wildly popular Power, Muscle, Burn muscle building system. Thousands of people have used this system successfully.	\N	0	4.79999999999999982	71	145	\N	\N	\N
15	3 Day Workout For Beginners	Build Muscle	M&S Writers	3	[1, 2, 3, 4, 5]	Split	Beginner	Male & Female	New to weight training? This workout is for you. Designed to hit each muscle group with the big compound exercises once per week. Each workout day has 3-5 exercises. 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/beginners-workout.jpg	0	4.90000000000000036	427	1300	\N	\N	\N
16	30 Minute Big Shoulder Workout with David Schachterle	Build Muscle	M&S Team	1	[1, 3, 4]	Single Muscle Group	Intermediate	Male & Female	Build your shoulders with David Schachterle's 30 minute workout that's designed to pack on shoulder mass when you're limited on time.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/david_feature.jpg	0	4	3	6	\N	\N	\N
17	30 Minute Women's Toning Workout With Jenna Webb & Melanie Tillbrook	Lose Fat	M&S Team	3	[2, 3, 4, 5, 7]	Full Body	Beginner	Female	Short on time? MuscleTech athletes Jenna Webb and Melanie Tillbrook designed this quick 30 minute toning routine that works the full body.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/30min_routine_feature.jpg	0	4.09999999999999964	11	0	\N	\N	\N
18	300 Workout: The Rise Of A New You! A Plan To Get Muscular & Ripped	General Fitness	Brad Borland	4	[1, 2, 4, 8, 7]	Full Body	Beginner	Male & Female	Seize your glory by building a Spartan body. This feature presents three new workouts, including a powerful 4 day split designed to shred fat and build muscle.	\N	0	5	55	23	\N	\N	\N
19	4 Advanced Training Techniques to Build Massive Lats	Build Muscle	Nate Palmer	1	[2, 4, 5]	Single Muscle Group	Advanced	Male & Female	When it comes to building massive lats, you need an effective plan. If you've found your gains have stalled, you really need to try out these moves!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/massive-lats-feature.jpg	0	3.79999999999999982	4	0	\N	\N	\N
20	4 Day Bodybuilding Split by Shaun	Build Muscle	Shaun McEwan	4	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	A higher volume 4 day split workout plan for those who want to gain muscle mass and/or gain weight. Workout was developed by Shaun from Muscle and Strength forum.	\N	0	4.90000000000000036	35	80	\N	\N	\N
21	4 Day Maximum Mass Workout	Build Muscle	M&S Team	4	[1, 2, 4, 5]	Split	Intermediate	Male & Female	A mass building routine that features a great combination of effective compound and isolation movements along with intense, high impact five minute burn sets.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/maximum-mass-workout.jpg	0	4.79999999999999982	189	533	\N	\N	\N
22	4 Day Power Muscle Burn Workout Split	Build Muscle	M&S Team	4	[1, 3, 4, 6, 5]	Split	Intermediate	Male & Female	This building workout is designed to maximize Progression and muscle gains by hitting each muscle group with power sets, muscle sets and burn sets.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/pmbheader.jpg	0	5	1100	3000	\N	\N	\N
23	4 Day Rest Pause RP-21 Muscle Building Workout System	Build Muscle	Eric Brown	4	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	RP-21 rest pause training helps you to increase muscle size and aesthetics. This 4 day upper/lower workout split focuses on big compound movements with no fluff.	\N	0	5	87	107	\N	\N	\N
24	4 Day Split Bodybuilding Split Routine	Build Muscle	M&S Writers	4	[1, 2, 3, 4, 6, 5]	Split	Advanced	Male & Female	This 4 day workout routine is aimed at the intermediate to advanced bodybuilder who is currently in their growth cycle. Legs have been split up into 2 separate days.	\N	0	5	94	86	\N	\N	\N
25	4 Day Superset & Timed Set Muscle Building Workout	Build Muscle	Ian Coleman	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male	This is a 4 day workout variation of one of the most popular training systems on M&S. You will hammer your muscles into effective growth using timed sets and supersets.	\N	0	4.79999999999999982	25	15	\N	\N	\N
26	4 Week Beginner Kettlebell Workout For Muscle Growth	Build Muscle	Roger “Rock” Lockridge	4	[8]	Full Body	Beginner	Male & Female	If you're looking to switch up your traditional training, but would still like to burn fat and gain muscle, maybe it's time to consider kettlebell training.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/kettlebell_workout_for_muscle_growth_and_fat_loss.jpg	0	5	2	1	\N	\N	\N
27	5 Day Superset & Timed Set Muscle Building Workout	Build Muscle	Ian Coleman	5	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	A quality change of pace, this routine sets aside squats, deadlifts and flat bench press and hammers your muscles into new growth using timed sets and supersets.	\N	0	4.90000000000000036	26	19	\N	\N	\N
28	5 Killer Arm Workouts for Tank Top Season	Build Muscle	Coach Dustin Myers	2	[9, 1, 2, 3, 4]	Single Muscle Group	Intermediate	Male & Female	With tank top season right around the corner, it's time to get serious about your arm training. Check out Coach Myers' tank top filling arm workouts!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/tank-top-season-feature.jpg	0	4	4	0	\N	\N	\N
29	5,000 Rep Arm Specialization Program	Build Muscle	M&S Writers	3	[1, 2, 3, 4, 6, 5]	Single Muscle Group	Intermediate	Male & Female	Go gonzo and gain insane with this arm building program. You will alternate between blast and cruise weeks, performing a total of 5,000 reps over the course of 10 weeks.	\N	0	4.90000000000000036	33	52	\N	\N	\N
30	6 Day Push, Pull, Legs Powerbuilding Split & Meal Plan	Build Muscle	Nick Ludlow	6	[1, 2, 4, 5]	Split	Intermediate	Male & Female	Hungry for some serious gym time and crazy gains? Nick Ludlow helps you to go heavy, go hard and improve your results with this intense, high volume rest-pause workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/power8.jpg	0	4.20000000000000018	14	28	\N	\N	\N
31	6 Week Arm Builder Workout Plan	Build Muscle	M&S Writers	2	[1, 3, 4, 5]	Single Muscle Group	Beginner	Male & Female	The workout plan helps you build bigger biceps and triceps by increasing exercise effectiveness, volume and intensity over a 6 week period. \n\n	\N	0	5	75	45	\N	\N	\N
32	8 Week Big And Bold Workout: Simple, Brutal Muscle Building	Build Muscle	M&S Writers	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male	So simple, so brutal, so effective. This bodybuilding workout packs a punch and is a great alternative to programs that revolve around 5 rep or low rep sets. Sample meal plan included.	\N	0	4.70000000000000018	25	60	\N	\N	\N
33	8 Week Chest And Back Specialization Workout Routine	Build Muscle	M&S Team	4	[1, 2, 4, 5]	Split	Beginner	Male & Female	This back and chest specialization workout is performed 2 days per week and combines a day of heavy compound movements along with a second rest-pause day.	\N	0	5	49	43	\N	\N	\N
34	8 Week Muscle Building Bodyweight Workout	Build Muscle	Brad Borland	3	[2, 10, 8, 7]	Full Body	Beginner	Male & Female	Build muscle without a gym! This 8-week hypertrophy routine will help you progress from basic to advanced bodyweight exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/8-week-bodyweight-workout-featured.jpg	0	4.79999999999999982	6	10	\N	\N	\N
35	963 Workout System For Muscle Size And Strength	Build Muscle	M&S Team	4	[1, 2, 4, 5]	Split	Beginner	Male & Female	The 963 training system is an upper/lower workout split that helps you to build both size and strength by cycling main lifts between 3 different levels of weight intensity.	\N	0	4.90000000000000036	26	40	\N	\N	\N
36	A Bigger Bench Press & Chest Using Only 135 Pounds - Really	Build Muscle	M&S Writers	1	[1]	Single Muscle Group	Intermediate	Male & Female	No I am not insane - this program really works. Build a bigger chest and improve your bench press by inserting this specialty workout into your current training regimen.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/benchhead.jpg	0	4	41	139	\N	\N	\N
37	Advanced Bodybuilder Workout	Build Muscle	M&S Writers	5	[1, 2, 3, 4, 10, 5]	Split	Advanced	Male & Female	Advanced bodybuilder workout suited to advanced lifters with at least one year of lifting experience. Step up your training and re-ignite big gains!	\N	0	4.90000000000000036	133	237	\N	\N	\N
38	Animal Instincts - The Kurt Weidner 4 Day Split Workout	Build Muscle	Team Scivation	4	[1, 2, 3, 4, 6, 10, 5]	Split	Intermediate	Male & Female	This is the 4 day workout split of Team Scivation sponsored athlete and WNBF pro bodybuilder Kurt "The Animal" Weidner.	\N	0	5	126	261	\N	\N	\N
39	Arm Building Circuits: Bust Through Bicep & Tricep Plateaus	Build Muscle	Mike Samuels	1	[9, 1, 2, 3, 4, 6, 7]	Single Muscle Group	Beginner	Male & Female	If your arms aren't responding to conventional training, it's time for some bicep and tricep blasting circuits. Prepare to pack on arm size and get rid of your old t-shirts.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/man-preacher-curl.jpg	0	5	15	18	\N	\N	\N
40	Balloon Arms Workout By MusclePharm	Build Muscle	Cory Gregory	1	[1, 4, 6, 7]	Single Muscle Group	Beginner	Male & Female	This arm pumping workout from MusclePharm uses a combination of trisets and unique exercise variations to target both biceps and triceps in a single session.	\N	0	5	23	13	\N	\N	\N
41	Beginner Fullbody Workout	Build Muscle	M&S Writers	3	[1, 3, 4, 6]	Full Body	Beginner	Male & Female	This fullbody workout by TitanCT from the Muscle & Strength forum is perfect for absolute beginners who need to develop good exercise form.	\N	0	4.90000000000000036	162	383	\N	\N	\N
42	Bench Most Dayz: Increase Your Bench By 30-50lbs In 6 weeks	Increase Strength	Cory Gregory	4	[1]	Single Muscle Group	Beginner	Male & Female	Cory Gregory's Bench Most Dayz 6 week program is designed to add some serious weight to your bench and muscle mass in your chest!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/bench_most_dayz.jpg	0	4.59999999999999964	11	65	\N	\N	\N
43	Best Chest Workout: The Push & Stretch Method For Killer Chest Gains	Build Muscle	Roger “Rock” Lockridge	1	[1, 2, 3, 4]	Single Muscle Group	Intermediate	Male & Female	Designed to work your chest thoroughly and intensely, the Push & Stretch Method is a killer chest workout routine that will help you effectively develop a solid chest!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/callum_chest_workout_feature.jpg	0	4	16	10	\N	\N	\N
44	Best Morning Workout For Building Muscle Mass	Build Muscle	Brad Borland	4	[1, 2, 3, 4, 5]	Full Body	Beginner	Male & Female	Most workout routines are designed for the evening lifter. If you're an early riser, we've got the perfect morning workout routine and advice for you!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/morning-workout-routine.jpg	0	4	9	28	\N	\N	\N
45	Big Arms Fast: 4 Week Specialization Workout	Build Muscle	Justin Woltering	2	[1, 2, 3, 4, 6, 5, 7]	Split	Beginner	Male & Female	This four week bicep and tricep building specialization routine from transformation expert Justin Woltering is designed to help you bring up your lagging arms, and fast.	\N	0	5	52	39	\N	\N	\N
46	Big Back Workout with Mike Rashid and Cory G	Build Muscle	M&S Team	1	[2, 3, 4]	Single Muscle Group	Intermediate	Male & Female	Can you imagine the type of workout Cory Gregory and Mike Rashid could create together? No need to play make believe, check out this intense workout!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mike-rashid-and-cory-g-feature.jpg	0	3	3	0	\N	\N	\N
47	Big Traps: 2 Day Trapezius Building Workout	Build Muscle	M&S Team	2	[1, 4]	Single Muscle Group	Intermediate	Male & Female	This 2 day per week specialization workout is designed to target lagging traps using unique and demanding exercise variations. A sample 4 day muscle building split is provided.	\N	0	4.79999999999999982	23	5	\N	\N	\N
48	Bill Starr 5x5  Linear Version For Intermediate Lifters	Increase Strength	M&S Writers	3	[1, 2]	Full Body	Intermediate	Male & Female	This highly effective strength and muscle building 5x5 workout by Bill Starr illustrates the importance of making systematic progression to drive gains.	\N	0	5	92	96	\N	\N	\N
49	Body Like A God: A Complete Bodyweight Muscle Building Plan	Build Muscle	Brad Borland	4	[2]	Full Body	Beginner	Male & Female	Get back to basics and build muscle at home with this classic bodyweight training system. This is a flexible training system that focuses on the use of exercise complexes.	\N	0	4.79999999999999982	37	23	\N	\N	\N
50	Branch Warren's Pre Olympia Workout & Sample Diet Plan	Build Muscle	Team MuscleTech	5	[1, 2, 3, 4, 5]	Split	Advanced	Male	Mr. Olympia competitor and Team Muscletech member Branch Warren shares his pre-contest 5 day training split, along with a sample eating and supplementation plan.	\N	0	5	21	14	\N	\N	\N
51	Brutality: A Squat & Deadlift Centered Muscle Building Program	Build Muscle	M&S Team	4	[1, 2, 4, 6]	Split	Intermediate	Male & Female	It's time to get nasty in the gym. This muscle building approach has you working both squats and deadlifts on the same day, alternating between heavy and volume days.	\N	0	5	27	28	\N	\N	\N
52	Build a Bigger Chest With This Intense Mass Building Workout	Build Muscle	Team eFlow	1	[2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Don't be ashamed by your lack of gains at the pool this year. Attack your pecs from all angles and utilize drop sets with this intense chest workout!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/massive-chest-feature.jpg	0	4.90000000000000036	13	0	\N	\N	\N
53	Build A Bigger Upper Body: Back, Shoulders And Traps Workout	Build Muscle	M&S Team	1	[1, 2, 3, 4, 5]	Single Muscle Group	Beginner	Male & Female	Bro: it's time to work the torso. Set aside chest, bicep & abs for a moment. This workout helps you beef up your back, shoulders and traps, and fill out that t-shirt.	\N	0	4.79999999999999982	40	33	\N	\N	\N
54	Build Your Own HLM Full Body Workout	Build Muscle	M&S Team	3	[1, 2, 3, 4, 6, 5]	Full Body	Beginner	Male & Female	Looking for quality full body workout variations? This template system allows you to build hundreds and hundreds of effective training programs from the ground up.	\N	0	5	26	29	\N	\N	\N
55	Building Bigger Pecs: 4 Workouts For Improved Chest Size	Build Muscle	M&S Team	1	[1, 2, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	It's time for a change. These four unique chest workouts provide you with effective, intense and fun training options that will help to increase your pec size and strength.	\N	0	4.59999999999999964	34	76	\N	\N	\N
56	Building The Beginner: Foundation For Muscle & Strength	Build Muscle	Team MuscleTech	5	[1, 2, 3, 4, 10, 8, 5, 11]	Split	Beginner	Male & Female	Building The Beginner is a 6 week program that lays the foundation for heavier lifting. A detailed training plan with instructional videos makes it easy to follow!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/building-the-beginner-featured.jpg	0	4.40000000000000036	8	1	\N	\N	\N
57	Bulldozer Training 3 Day Workout Split	Build Muscle	M&S Team	3	[1, 2, 4, 6, 5]	Split	Intermediate	Male	3 day Bulldozer Training muscle building split. Combines rest-pause sets with progressive resistance. Workouts are shorter but more intense.	\N	0	5	50	121	\N	\N	\N
58	Bulldozer Training 4 Day "Mini-Dozer" Workout Split 	Build Muscle	M&S Team	4	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	4 day "Mini-Dozer" Bulldozer Training muscle building split. Combines rest-pause sets with progressive resistance. Lower volume variation.	\N	0	4.90000000000000036	31	46	\N	\N	\N
59	Bulldozer Training 4 Day Workout Split	Build Muscle	M&S Team	4	[1, 4, 5]	Split	Intermediate	Male & Female	4 day Bulldozer Training muscle building split. Combines rest-pause sets with progressive resistance. Workouts are shorter but more intense.	\N	0	4.29999999999999982	63	189	\N	\N	\N
60	Combat Your Weakness Workout Program	Build Muscle	Charles Cunningham	5	[1, 2, 3, 4, 6, 7]	Full Body	Intermediate	Male & Female	This program combines the concepts of training volume, progressive overload, and muscular tension in order to build strength and muscle while prioritizing lagging body parts.  	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/combat_your_weakness_training_program.jpg	0	4.59999999999999964	11	4	\N	\N	\N
61	Command Your Arms To Grow! 2 Day Arm Building Workout	Build Muscle	L.J. Walker	2	[1, 2, 3, 4, 6, 5]	Single Muscle Group	Beginner	Male & Female	This is an aggressive 2 day per week specialization program for those of you who are tired of having puny guns, and are willing to eat as hard and precise as you train.	\N	0	5	15	14	\N	\N	\N
62	Compound Exercises Only Workout	Build Muscle	M&S Writers	4	[1, 2, 3, 4]	Split	Intermediate	Male & Female	This workout uses only compound exercises. Compound exercises are movements that require more than 1 joint and more than 1 muscle group.	\N	0	4.90000000000000036	194	268	\N	\N	\N
63	Conquering The Giant: Giant Set Workouts For Hypertrophy & Fat Loss	Build Muscle	Mike Samuels	3	[1, 2, 4]	Single Muscle Group	Intermediate	Male & Female	Learn how giant sets and density training can help ignite fat loss and spark new muscle growth. Feature includes sample push, pull, leg and fat burning workouts.	\N	0	5	19	12	\N	\N	\N
64	Core Strength Blueprint Workout v1.2 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 10, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cb2_feature.jpg	0	5	1	3	\N	\N	\N
65	Core Strength Blueprint Workout v1.3 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 10, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/core_1-3_feature.jpg	0	4.5	6	0	\N	\N	\N
66	Core Strength Blueprint Workout v1.4 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/musclepharm_core_strength_workout.jpg	0	5	2	5	\N	\N	\N
67	Cory Gregory's "Make Your Own Brick Soup" Ab Workout	Build Muscle	Cory Gregory	\N	[2, 7]	Single Muscle Group	Beginner	Male & Female	Get the secret ingredients for "Brick Soup" with this killer 4-week program in which MusclePharm's Cory Gregory reveals what he does to build and maintain his rock-solid abs! 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cory_gregory_ab_workout_1_0.jpg	0	3.79999999999999982	18	3	\N	\N	\N
68	Crazy 5 Method: An Intense Rep Scheme For Making Solid Gains	Build Muscle	Coach Dustin Myers	3	[1, 4]	Split	Intermediate	Male & Female	If you're looking for an excellent finisher to your lifts, look no further. Coach Myers' Crazy 5 Method is bound to give you the pump you're looking for.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/crazy-5-method-feature.jpg	0	4	8	2	\N	\N	\N
69	CrossFit vs Weight Training: Which Gives Better Results?	Build Muscle	Team AML	3	[1, 2, 8]	Split	Intermediate	Male & Female	Traditional weightlifters and cross trainers don't see eye to eye on training. However, the best approach to training isn't as black & white as you may think.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/crossfit-feature_0.jpg	0	5	2	1	\N	\N	\N
70	CT Fletcher's Agony Of The Shoulders Workout	Build Muscle	M&S Team	1	[1, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Ready to build the massive shoulders you've always dreamed of? "The Superman from Compton" CT Fletcher is here to show you how to do just that.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/ct_fletcher_agony_workout.jpg	0	4.5	8	6	\N	\N	\N
71	Cut Like Cutler Trainer - Cycle 1	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 1 of the Cut Like Cutler trainer. Week 1 is Heavy training and Week 2 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_1.jpg	0	3.79999999999999982	17	8	\N	\N	\N
72	Cut Like Cutler Trainer - Cycle 2	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 2 of the Cut Like Cutler trainer. Week 3 is Heavy training and Week 4 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_2.jpg	0	4.29999999999999982	3	0	\N	\N	\N
73	Cut Like Cutler Trainer - Cycle 3	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 3 of the Cut Like Cutler trainer. Week 5 is Heavy training and Week 6 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_3.jpg	0	4.29999999999999982	3	1	\N	\N	\N
74	Cut Like Cutler Trainer - Cycle 4	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 4 of the Cut Like Cutler trainer. Week 7 is Heavy training and Week 8 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_4.jpg	0	0	0	0	\N	\N	\N
75	Cut Like Cutler Trainer - Cycle 5	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 5 of the Cut Like Cutler trainer. Week 9 is Heavy training and Week 10 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_5.jpg	0	5	3	0	\N	\N	\N
76	Cut Like Cutler Trainer - Cycle 6	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 6 of the Cut Like Cutler trainer. Week 11 is Heavy training and Week 12 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_6.jpg	0	4	1	3	\N	\N	\N
77	Daily Undulating Periodization (DUP) Muscle Growth Workout	Increase Strength	Mike Wines	4	[9, 1, 3, 4, 5, 7]	Split	Intermediate	Male & Female	Maximize your training with this workout that utilizes an advanced training technique designed to enhance strength, power, and muscle hypertrophy.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/periodization_muscle_growth_workout_feature.jpg	0	5	3	20	\N	\N	\N
78	Dave's Upper/ Lower Split (DULS)	Build Muscle	Dave Herber	4	[1, 3, 4, 6, 5]	Split	Intermediate	Male & Female	This upper/lower body split is designed for growth while avoiding overtraining. If you're an intermediate to advanced lifter, give this workout a shot!	\N	0	5	64	75	\N	\N	\N
79	Dave's V.I.F Mass Building Program	Build Muscle	Dave Herber	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	This program tackles 3 of the 5 different types of workouts that will hopefully keep your body growing in the right direction. Each phase is 4 weeks.	\N	0	5	178	210	\N	\N	\N
80	Diego Sebastian's Arms & Abs Superset Workout	Build Muscle	M&S Team	2	[1, 2, 3, 4, 6]	Single Muscle Group	Beginner	Male & Female	Cover model Diego Sebastian shares his go-to arms and abs superset workout. Watch the video for the secret to cover ready abs, biceps, and triceps!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/diego-sebastian-abs-and-arms.jpg	0	4	6	1	\N	\N	\N
81	Double Down Training: Back-Off Set Muscle Building	Build Muscle	M&S Team	4	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	This upper/lower split allows you to maximize your bodybuilding efforts by pushing for progressive overload using auto-regulation and a myriad of rep ranges and weights.	\N	0	4.90000000000000036	11	13	\N	\N	\N
82	Double Split Training: 3 Month Muscle Building Specialization Program	Build Muscle	Ian Coleman	5	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	It's time to go retro. This 3 month specialization program has you in the gym for 10 workouts each week. Back it with plenty of sleep and food for all kinds of gains!	\N	0	4.90000000000000036	32	25	\N	\N	\N
83	Doug's Mass Building Routine for Ectomorphs	Build Muscle	Doug Lawrenson	4	[1, 2, 4, 5]	Split	Intermediate	Male & Female	Althought this routine is designed for a person who’s body type is described as Ectomorph	 it can be also be used by all body types as a change their current workout.	0	4.90000000000000036	370	0	\N	\N	\N
84	Dougs 4 Day Split Workout	Build Muscle	Doug Lawrenson	4	[1, 3, 4, 6, 5]	Split	Intermediate	Male & Female	This muscle building workout is a tried and tested M&S muscle building staple! This workout was developed by trainer and forum member Doug Lawrenson.	\N	0	4.90000000000000036	704	902	\N	\N	\N
85	Drop 5 System: 4 Day Home Muscle Building Plan	Build Muscle	M&S Team	4	[1, 2, 4]	Split	Intermediate	Male & Female	This 4 day "Drop 5" split is designed for the home trainee. This program is an upper/lower split that utilizes only dumbbell, barbell and bodyweight exercises.	\N	0	4.90000000000000036	15	11	\N	\N	\N
86	Drop 5 System: 4 Day Mass Building Workout Split	Build Muscle	M&S Team	4	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	Blast your body with this potent muscle building workout by Steve Shaw. This four day plan is an upper/lower training split which cycles intensity over a 3 week period.	\N	0	4.70000000000000018	26	53	\N	\N	\N
87	DumbBar Workout: Make Killer Gains With Dumbbell & Barbell Supersets	Build Muscle	Roger “Rock” Lockridge	6	[1, 4]	Split	Beginner	Male & Female	Limited equipment doesn't mean limited gains. Grab some dumbbells and a barbell and get ready to destroy these intense DumbBar supersets.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/dumbbar-supersets.jpg	0	4.5	6	6	\N	\N	\N
88	Dumbbell & Barbell Home Based Workout	Build Muscle	M&S Writers	3	[1, 4]	Split	Intermediate	Male & Female	Dumbbell and barbell home workout. This is a workout you can do at home just using a set of dumbbells and barbells. The workout is designed to build muscle and strength.	\N	0	5	213	472	\N	\N	\N
89	Dumbbell & Barbell Mass Workout	Build Muscle	M&S Writers	5	[1, 2, 4]	Split	Intermediate	Male & Female	Looking to add muscle mass? Using only dumbbells and barbells, this workout hits each muscle group hard once a week over a 5 day schedule.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/barbell800.jpg	0	4.90000000000000036	295	473	\N	\N	\N
90	Dumbbell Only Home Or Gym Full Body Workout	Build Muscle	M&S Team	3	[2, 4]	Full Body	Beginner	Male & Female	Short on equipment? No worries! This dumbbell only workout can be used at home or in the gym for building muscle mass. You can also use this as a muscle shock workout to mix things up.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/dumb800.jpg	0	4.79999999999999982	958	1600	\N	\N	\N
91	Extreme 6 Day Barbell & Bodyweight Conditioning Workout	Increase Endurance	Max Riley	6	[1, 2]	Split	Beginner	Male & Female	You've found the motivation to hit the gym hard. What to do next? Try this extreme program that combines walking, muscle building and complex conditioning workouts.	\N	0	4.90000000000000036	31	12	\N	\N	\N
92	Fast 21 Workout: 3 Weeks To A Lean & Shredded Physique	Build Muscle	Team BPI	6	[9, 1, 2, 3, 4, 5, 7]	Split	Intermediate	Male & Female	The Fast 21 Workout Program is designed to ensure maximum fat loss while gaining lean muscle, all within 3 weeks!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/fast21-header.jpg	0	4.20000000000000018	20	77	\N	\N	\N
93	Fast 4: A Beach Body Workout Program For The College Student	Build Muscle	Andrew Pardue	4	[1, 4, 5]	Split	Beginner	Male & Female	Not everyone wants to be a bodybuilder. This workout is perfect for the college student who wants to build muscle with the primary goal of looking great at the beach.	\N	0	4.90000000000000036	14	30	\N	\N	\N
94	Field Manual: A Training Guide For Those With Little Time & Equipment	Build Muscle	Brad Borland	4	[9, 2, 4]	Split	Beginner	Male & Female	No equipment, no time? No problem! Using only dumbbells, bands and your bodyweight, Brad Borland shows you how to train for gains using supersets.	\N	0	5	31	26	\N	\N	\N
95	Frankoman's Dumbbell Only Split	Build Muscle	M&S Writers	3	[4]	Split	Beginner	Male & Female	A dumbbell only workout for home or the gym that will pack on muscle mass. This routine design by Frankoman from the M&S forum.	\N	0	5	483	965	\N	\N	\N
96	Full Body Dumbbell Strength Workout For Women	General Fitness	Holly Blumenberg	1	[2, 4]	Full Body	Beginner	Female	This dumbbell workout is a metabolic conditioning session as well as a strength workout. If you're getting bored with your current workout, give this fun routine a try.	\N	0	4.90000000000000036	34	8	\N	\N	\N
97	Get Ripped in 8 Weeks! HIET Fat Loss Workout & Nutrition Program	Lose Fat	Team AML	6	[1, 2, 3, 4, 6, 10, 5]	Split	Intermediate	Male & Female	Step your game up and get shredded for summer with this 8 week workout! Combine HIET and HIIT to accelerate your results and get shredded for the beach!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiet-feature1.jpg	0	3.39999999999999991	11	12	\N	\N	\N
98	Get Serious Arm Size With This Biceps & Triceps Workout	Build Muscle	Roger “Rock” Lockridge	1	[1, 3, 4, 6]	Single Muscle Group	Beginner	Male & Female	Build some massively impressive arms with this biceps and triceps superset and triset workout that maximizes your arm training and gaining!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/serious_biceps_triceps.jpg	0	4.40000000000000036	9	2	\N	\N	\N
99	Get Stronger At Squats With This 12 Week Super Squat Workout	Increase Strength	Roger “Rock” Lockridge	1	[1, 2, 3, 5]	Single Muscle Group	Beginner	Male & Female	Work your way to a bigger, more impressive squat with this 12-week program that's designed to improve your squat and get you moving serious weight.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/improving_squats_program_ronnie_coleman_feature.jpg	0	3.79999999999999982	4	1	\N	\N	\N
100	Get Swole: 5 Phase Muscle Building Workout System	Build Muscle	Cory Gregory	4	[1, 2, 4, 6, 5, 7]	Split	Beginner	Male	This is a intense and proven 20 week training program from MusclePharm that uses 5 unique phases to help even the hardest of gainers to build muscle or firm up.	\N	0	5	112	110	\N	\N	\N
101	Giant Sets For Giant Boulder Shoulders In 8 Weeks	Build Muscle	Roger “Rock” Lockridge	1	[1, 4]	Single Muscle Group	Intermediate	Male & Female	Maximize your shoulder muscle growth by incorporating these giant set routines that target every part of the shoulder, plus the traps!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/anton_side_lateral_raise_for_shoulder_muscle.jpg	0	3.29999999999999982	6	7	\N	\N	\N
102	Gordon LaVelle's Short And Intense Bodybuilding Training System	Build Muscle	Gordon LaVelle	4	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Gordon LaVelle's method of training is a highly effective and efficient system for building muscle that focuses of a limited number of sets performed to muscle failure.	\N	0	5	149	277	\N	\N	\N
103	High Volume Chest Workout with IFBB Pros Gerardo Gabriel & Brett Kahn	Build Muscle	M&S Team	1	[2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	IFBB Pros Brett Kahn and Gerardo Gabriel visit the Muscle & Strength HQ and destroy their chests with this high volume chest workout routine. Check it out!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/gerardo-chest-workout-feature2.jpg	0	5	2	0	\N	\N	\N
104	HIML-4 Maximum Muscle Building Workout System	Build Muscle	Ian Coleman	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	HIML-4 is a highly effective four week muscle building workout system that cycles between heavy days, intense workouts, and moderate to light weight training days.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hmil800.jpg	0	5	945	1200	\N	\N	\N
105	HIT Workout - Build Muscle With This High Intensity Training Routine	Build Muscle	Max Riley	3	[1, 2, 3, 4, 6, 5]	Full Body	Beginner	Male & Female	HIT training is unlike any muscle building approach you've ever tried. Workouts are brisk, intense, focusing on moderate volume, training to failure and recovery.	\N	0	4.90000000000000036	22	17	\N	\N	\N
106	Home Or Gym Barbell Workout Routine	Build Muscle	Thomas Schultz	4	[1, 2]	Split	Beginner	Male & Female	This barbell only workout is perfect for someone with limited access to equipment. It can be performed virtually anywhere and requires only a barbell and some hard work.	\N	0	5	26	11	\N	\N	\N
107	How To Gain Mass Fast: 20 Week Quick Start Program	Build Muscle	Ian Coleman	3	[1, 2, 4]	Full Body	Beginner	Male & Female	Build muscle as quickly as possible using this 20 week program that features 3 unique stages: neuromuscular adaptation, conditioning, and a maximization stage.	\N	0	4.79999999999999982	90	70	\N	\N	\N
108	Hugh Jackman's Workout: Strong, Lean & Powerful	Build Muscle	Luke Atchley	4	[1, 2, 3, 4, 5, 11]	Split	Beginner	Male	Get ripped like Wolverine by applying the same underlying training principles Hugh Jackman did while working out in preparation for his role on the big screen.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hugh_jackman_wolverine_body_workout_0.jpg	0	4.40000000000000036	11	20	\N	\N	\N
109	Intense Superset Chest & Biceps Workout With Joe Donnelly	Build Muscle	M&S Team	1	[9, 2, 4]	Single Muscle Group	Intermediate	Male & Female	Looking to burn fat and build muscle, all while never stepping foot on the cardio deck? Try out Joe Donnelly's high intensity resistance training!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/joe-donnelly-feature-image.jpg	0	4.5	4	1	\N	\N	\N
110	Intermediate 4 Day Split Workout	Build Muscle	Troy A. Dolfi	4	[1, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Designed for someone who's been lifting for a while and wants to step up their training. The workout has a 2 days on, 1 day off, 1 day on, 1 day off schedule.	\N	0	5	81	112	\N	\N	\N
111	Intermediate Muscle Building Workout	Build Muscle	M&S Writers	5	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Shock your muscle into growth by rotating this workout with your current routine. This workout hits each major muscle group twice per week. 	\N	0	4.90000000000000036	135	303	\N	\N	\N
112	Introduction To Bodybuilding Workout	Build Muscle	Troy A. Dolfi	3	[1, 2, 3, 4, 5]	Full Body	Beginner	Male & Female	This is a starter workout designed for absolute beginners to muscle building. It is a 3 day a week routine which works all the major muscle groups in 1 session.	\N	0	3.89999999999999991	52	123	\N	\N	\N
113	Jai Courtney Workout: How Jai Got Swole for Terminator Genisys	Lose Fat	Brad Borland	4	[2, 4, 7]	Full Body	Beginner	Male	Are you ripped enough to fight for humanity? Follow this 6 week program based on Jai Courtney's training principles to get shredded like Kyle Reese!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/jai-courtney-workout-terminator-genisys-featured.jpg	0	4.5	6	7	\N	\N	\N
114	Jason Blaha's Ice Cream Fitness 5x5 Novice Program	Build Muscle	Jason Blaha	3	[1, 3, 6]	Full Body	Beginner	Male & Female	A potent and proven novice muscle and strength building program from Jason Blaha & Ice Cream Fitness. Testimonials continue to pour in touting it's effectiveness.	\N	0	2.89999999999999991	734	917	\N	\N	\N
115	Jason Momoa's Workout: Accelerated Results 7 (AR-7) Training	Build Muscle	Brad Borland	5	[1, 2, 3, 4, 7]	Full Body	Intermediate	Male & Female	Learn how the AR-7 program helped Game of Thrones actor Jason Momoa put on the major muscle needed to portray the great Khal Drogo.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/khal_game_of_thrones_workout_routine.jpg	0	4.5	10	37	\N	\N	\N
116	Jason Poston's Giant Set Back Workout Routine	Build Muscle	M&S Team	1	[1, 3, 4, 11]	Single Muscle Group	Intermediate	Male & Female	If you thought your back workout was tough, then you've got to check out IFBB Pro and ProSupps athlete Jason Poston's Giant Set Back Routine!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/poston-prosupps-feature_0.jpg	0	4	2	0	\N	\N	\N
117	Jen Jewell's Summer Countdown: Burn Fat & Build A Bikini Booty	Lose Fat	Jen Jewell	4	[1, 2, 4, 10]	Full Body	Beginner	Female	The time to sculpt your summer body is now! Get lean, healthy, and strong with Jen Jewell's Summer Countdown Workout that combines strength training with cardio bursts for maximum fat loss.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/jen-jewell-summer-countdown-featured.jpg	0	3.5	8	4	\N	\N	\N
118	Joe Ohrablo's Non-Linear Periodization	Build Muscle	Joseph Ohrablo	5	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Build a beastly body by alternating between intensity weeks and power weeks. Mr. NC Joe Ohrablo presents his incredibly effective muscle building system.	\N	0	4.40000000000000036	51	70	\N	\N	\N
119	John Meadows: His Journey to the Arnold, Brand, & Back Workout	Build Muscle	Roger “Rock” Lockridge	1	[1, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	IFBB Pro John Meadows' work ethic is like no other. Read about his humbling journey to competing in front of his home town at this years Arnold Classic.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/john-meadows-feature.jpg	0	4.70000000000000018	3	1	\N	\N	\N
120	Kickbox Your Way To Fit With Francisca Dennis	General Fitness	Team FitMiss	3	[7]	Full Body	Beginner	Female	Mix things up a few times a week by putting on the mitts and incorporating some fun kickboxing to relieve some stress and burn a ton of calories at the same time!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/francisca_dennis_kickboxing.jpg	0	4.29999999999999982	6	0	\N	\N	\N
121	Leg Carnage: Superset Quad & Hamstring Workout	Build Muscle	M&S Team	1	[1, 2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Shock your legs with this brutal and growth-inducing workout designed by Steve Shaw. Featured exercises include paused squats, dumbbell stiff leg deadlifts & reverse hacks.	\N	0	4.59999999999999964	5	6	\N	\N	\N
122	Long Cycle Beginner Muscle And Strength Building Workout	Build Muscle	M&S Team	3	[1, 2, 4, 6, 5]	Full Body	Beginner	Male & Female	The Long Cycle program uses auto-regulation, allowing a lifter to progress on each exercise at a natural rate, while also maximizing muscle mass and strength gains.	\N	0	5	36	44	\N	\N	\N
123	Low Rep Arm And Shoulder Workout By MusclePharm	Build Muscle	Cory Gregory	1	[1, 2, 4, 6]	Split	Beginner	Male & Female	This workout by Cory Gregory and MusclePharm helps you to pack on shoulder, bicep and tricep muscle mass by focusing on high volume, low rep tri-sets. 	\N	0	4.59999999999999964	11	11	\N	\N	\N
124	Mass Performance Program - Day 1: Upper Body	Build Muscle	Team Dymatize	4	[1, 4, 6]	Split	Beginner	Male & Female	Every good training week starts with chest day! Mass Performance Program Day 1 blasts your pecs before moving on to biceps and triceps.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mpp-day-1.jpg	0	4.40000000000000036	8	3	\N	\N	\N
125	Mass Performance Program - Day 2: Lower Body	Build Muscle	Team Dymatize	4	[1, 4, 5, 7]	Split	Beginner	Male & Female	Looking for maximum gains? You better not skip leg day! Your primary lift today is the deadlift which will torch your posterior chain.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mpp_day_2.jpg	0	5	3	4	\N	\N	\N
126	Mass Performance Program - Day 4: Upper Body	Build Muscle	Team Dymatize	4	[1, 4, 6, 5]	Split	Beginner	Male & Female	Get ready for cannonball delts and boulder shoulders! Day 4 training will hit your shoulders from all angles and finish with some arm blasting isolation work.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mpp_day_4.jpg	0	4	2	2	\N	\N	\N
127	Mass Performance Program - Day 5: Lower Body	Build Muscle	Team Dymatize	4	[1, 4, 8, 5]	Split	Beginner	Male & Female	It's the last training day of the week, which means you'd better hit it hard! Lots of squats make this the ultimate quad-blasting leg day.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mpp_day_5.jpg	0	5	4	0	\N	\N	\N
128	Massive Blitz: 4 Week High Rep Muscle Building Cycle	Build Muscle	M&S Team	1	[1, 2, 3, 4, 6, 5]	Single Muscle Group	Intermediate	Male & Female	Looking to "switch up" your training? This workout system focuses on four week blocks that hammer muscle groups into growth using high reps and limited rest.	\N	0	3.79999999999999982	19	9	\N	\N	\N
129	Max Adaptation Upper Lower (MAUL) Workout	Build Muscle	Alain Gonzalez	5	[1, 3, 4, 5]	Split	Beginner	Male & Female	This workout combines the main mechanisms of muscle hypertrophy to help you build some serious muscle. Try this split to put on quality summer mass!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/maul-feature.jpg	0	5	27	0	\N	\N	\N
130	MFT Training: Boost Strength and Build High Performance Muscle	Build Muscle	Eric Weinbrenner	3	[1, 2, 3, 4, 6]	Full Body	Intermediate	Male & Female	Would you like to get stronger and build more muscle while spending less time in the gym? MFT training might be just what you need for big results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mft-training.jpg	0	5	5	22	\N	\N	\N
131	Muscle & Strength Full Body Workout Routine	Build Muscle	M&S Team	3	[1, 2, 4]	Full Body	Beginner	Male & Female	This M&S mass building routine is perfect for lifters who want to give full body workouts a try. All major muscle groups are trained, and the program includes a 20 rep set of squats.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/ms_full_body_workout.jpg	0	4.79999999999999982	78	57	\N	\N	\N
132	Muscle & Strength's 30 Day Workout Plan For Women	Build Muscle	Brad Borland	6	[1, 2, 4, 7]	Full Body	Beginner	Female	Looking for the best place to start working towards a leaner, solid, and stronger body? This thorough workout routine is specifically designed to get you there!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/complete_full_body_womens_workout_routine.jpg	0	4.20000000000000018	14	40	\N	\N	\N
133	Muscle Size, Shape & Definition Workout	Build Muscle	Troy A. Dolfi	5	[1, 3, 4, 5]	Split	Advanced	Male & Female	This advanced workout routine is a 5-day split - Two Days On, 1 Day Off, Two Days On, 1 Day Off. It is aimed at muscle size, definition and tone. 	\N	0	4.90000000000000036	97	173	\N	\N	\N
134	New Year, New Body: Quick Start Workout Guide & Eating Plan	Build Muscle	Brad Borland	3	[1, 2, 4]	Split	Beginner	Male & Female	Build the body you want using the fundamentals. Focus your will to succeed and get bigger, stronger and leaner during the new year with this complete workout & diet plan.	\N	0	3.89999999999999991	30	27	\N	\N	\N
135	Off Season Leg Day Workout With Brandon Beckrich	Build Muscle	M&S Team	1	[9, 1, 5]	Single Muscle Group	Intermediate	Male & Female	If you're in need of a great, quad-dominant leg workout, then you're in luck! Check out Team Allmax's Brandon Beckrich's insane off season leg day routine!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/brandon-legs-feature.jpg	0	5	2	0	\N	\N	\N
136	Old School Chest Workout with Calum von Moger	Build Muscle	M&S Team	1	[1, 2, 3, 4]	Single Muscle Group	Beginner	Male & Female	Mr. Universe Calum von Moger goes back to basics with this old school aesthetic chest workout inspired by Golden Era physiques. 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/old-school-aesthetic-chest-workout.jpg	0	4.90000000000000036	8	0	\N	\N	\N
137	Old School Gains: Build Muscle Like an Iron-Game Legend	Build Muscle	Team Allmax	6	[1, 3, 4, 5]	Split	Intermediate	Male & Female	Is the modern lifter really willing to do what it takes to build major muscle? Try training like an old-school legend for big results!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/old-school-gains.jpg	0	5	15	14	\N	\N	\N
138	Old School Series: 1970s Bodybuilding Routine	Build Muscle	M&S Team	6	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Can you handle training like Arnold Schwarzenegger, Sergio Oliva or Lou Ferrigno? These legends set a new standard for muscle mass and training frequency.	\N	0	4.90000000000000036	37	55	\N	\N	\N
139	Old School Series: 1990s Bodybuilding Routine	Build Muscle	M&S Team	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Time for some blood and guts! Set aside volume training and focus on quality above quantity. This 4 day workout split is based upon the training style of Dorian Yates.	\N	0	4.79999999999999982	9	18	\N	\N	\N
140	OT4 Training System: Minimal Gym Time, Optimal Gains	Build Muscle	Machine Militia	4	[1, 2, 3, 4, 5]	Split	Beginner	Male & Female	OT4 is a complete workout and nutrition system designed to maximize your time in the gym for lean muscle gains. Use this system for 12 weeks for optimal results!	\N	0	3.70000000000000018	27	15	\N	\N	\N
141	PHD 4 - RJ Perkin's Power Hyper Deload Training	Build Muscle	RJ Perkins	5	[1, 2, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Pro bodybuilder RJ Perkins combines aspects of Layne Norton's PHAT, Wendler's 5/3/1 and Westside training into a muscle building system that packs a punch.	\N	0	5	56	141	\N	\N	\N
142	Playground Workouts: Having Fun While Building the Body You Want	Lose Fat	Brad Borland	3	[2]	Split	Beginner	Male & Female	Does work have you trapped indoors all day? Enjoy the sunshine by taking your training to the great outdoors with this playground workout routine!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/playground-feature.jpg	0	5	3	1	\N	\N	\N
143	Power 8 Muscle Building Workout – 3 Day Split	Build Muscle	M&S Team	3	[1, 2, 4, 6, 5]	Split	Intermediate	Male & Female	Power 8 combines a 5x5 protocol with a brutally effective 8x8 exercise. This system is perfect for the intermediate lifter who wants to continue to maximize gains.	\N	0	4.59999999999999964	78	113	\N	\N	\N
144	Power Hypertrophy Upper Lower (P.H.U.L.) Workout	Build Muscle	Brandon Campbell	4	[1, 4, 5]	Split	Intermediate	Male & Female	Build both size and strength in this 4 day split based around basic compound movements. Get the best of both worlds with bodybuilding and powerlifting.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/power-hypertrophy-upper-lower-phul.jpg	0	4.59999999999999964	256	367	\N	\N	\N
145	Power Muscle Burn 5 Day Powerbuilding Split	Build Muscle	M&S Team	5	[1, 3, 4, 5]	Split	Intermediate	Male & Female	Rapidly build size and strength with this powerbuilding 5 day split which focuses on strength building power sets, and crazy-intense burn sets. You have been warned!	\N	0	5	1100	2600	\N	\N	\N
146	Project WHEELS: The Ultimate Hybrid Program for Leg Size and Strength	Build Muscle	Lee Boyce	5	[1, 2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Build both your leg strength and solid legs muscles with this workout program that's heavy on squats, but highly effective at delivering results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/leg_exercises_for_building_strong_legs_feature.jpg	0	4	4	2	\N	\N	\N
147	Pyramid Volume Training	Build Muscle	Brad Farmer	4	[1, 2, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Are you stuck in a plateau? Do you want to increase your strength, size, and muscular definition? Send your body into an anabolic state.	\N	0	5	203	700	\N	\N	\N
148	Quad Destroyer: 10 Sets Of Squats Workout	Build Muscle	Max Riley	1	[1, 4, 5]	Single Muscle Group	Intermediate	Male & Female	This is a specialization workout for lifters with lagging quads. It can be performed in an ongoing manner, and features 2 intense weeks followed by a deload week.	\N	0	3.60000000000000009	9	9	\N	\N	\N
149	Real Results Pull, Squat, Press Fullbody Workout	Build Muscle	M&S Team	3	[1, 2, 4]	Full Body	Beginner	Male & Female	A no nonsense 3 day per week program that will have you gaining muscle and strength quickly. It focuses on compound and bodyweight exercises.	\N	0	3.89999999999999991	56	157	\N	\N	\N
150	Reg Park Beginner Workout	Build Muscle	M&S Writers	3	[1, 2]	Full Body	Beginner	Male & Female	Arnold Schwarzenegger idolized bodybuilding legend Reg Park. This workout, provided by Kaya Park (Reg Park's grandson) was used by Arnold and yielded great results.	\N	0	5	98	187	\N	\N	\N
151	Roger Lockridge's Intense 4 Week Superset Back Workout	Build Muscle	Roger “Rock” Lockridge	1	[1, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Emphasize your back muscles with this 4 week Superset routine that's designed to intensify and maximize your time at the gym for killer results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/intense_4_week_superset_workout_for_back_muscle_2.jpg	0	4.20000000000000018	5	0	\N	\N	\N
152	Santi Aragon's Massive Shoulder Workout	Build Muscle	Team MuscleTech	2	[4, 6]	Single Muscle Group	Beginner	Male & Female	Want to know how IFBB Pro Santi Aragon grew his truly massive shoulders? Check out his 4 favorite moves that blast his delts from all angles.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/santi-aragon-shoulder-workout.jpg	0	4.79999999999999982	6	4	\N	\N	\N
153	Scrutiny's 4 Day Muscle Building Split	Build Muscle	M&S Writers	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	This 4 day split by Scrutiny from the Muscle & Strength forum is an effective muscle building workout that features an arm day sure to provide results.	\N	0	5	387	672	\N	\N	\N
154	Scrutiny's Low Volume High Intensity Workout For Mass And Strength	Build Muscle	M&S Writers	3	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	An intense workout system focusing on training to failure, offering an alternative to the various high volume muscle building workout routines.	\N	0	4.90000000000000036	115	133	\N	\N	\N
155	Sean Sullivan's Power Base Workout	Build Muscle	Sean Sullivan	4	[1, 3, 4, 5, 7]	Split	Intermediate	Male & Female	This 4 day split by natural bodybuilding champion Sean Sullivan relies heavily on 6x6 training to encourage rapid strength and muscle gains.	\N	0	5	24	47	\N	\N	\N
156	Shaun's 3 Day Muscle Building Split Workout	Build Muscle	Shaun McEwan	3	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Shaun's 3 day split workout is a solid routine for those who are looking to pack on some pounds! It features a chest & biceps day as well as a legs & shoulders day.	\N	0	4.90000000000000036	526	1300	\N	\N	\N
157	Shaun's 30 Minute Workout Split Routine	Build Muscle	Shaun McEwan	5	[1, 3, 4, 6, 5]	Split	Intermediate	Male & Female	A 5 day muscle building split routine for those who are pressed for time. Each workout can be completed in 30 minutes.	\N	0	5	49	79	\N	\N	\N
158	Shaun's 4 Day Muscle Building Split Routine	Build Muscle	Shaun McEwan	4	[1, 3, 4, 5]	Split	Intermediate	Male & Female	A solid 4 day split workout that is designed for those who want to build lean muscle mass and/or gain weight. Workout was developed by Shaun from the M & Strength forum.	\N	0	4.90000000000000036	233	354	\N	\N	\N
159	Shaun's 4 Day Progressive Overload Split	Build Muscle	Shaun McEwan	4	[1, 3, 4, 5]	Split	Intermediate	Male & Female	Maximize muscle growth with progressive overload. In this 4 day split by Shaun, you will add more weight to the bar each weight on heavy lifts, and pack on muscle mass.	\N	0	4.90000000000000036	22	48	\N	\N	\N
160	Shredded by Summer: 8 Weeks to Your Best Body Ever	Lose Fat	Eric Bach	3	[9, 1, 3, 8, 11]	Split	Intermediate	Male & Female	It's time to get serious about your summer body. This 8 week workout and nutrition plan will help you get shredded for this years summer vacation.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/8-weeks-to-shred-feature.jpg	0	5	2	0	\N	\N	\N
161	Shrugs Are Overrated: Build a Massive Yoke Without Shrugs	Build Muscle	Ben Johnson	1	[1, 4]	Single Muscle Group	Intermediate	Male & Female	Traps are the true sign of strength. Quit relying on ego-based, half shrug movements and build a serious yoke with this 4 week explosive workout plan!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/massive-yolk-feature.jpg	0	4.20000000000000018	6	2	\N	\N	\N
162	SPLASH Training - Specific Periodized Linear Advanced Strength + Hypertrophy	Build Muscle	Billy Porter	6	[1, 3, 4, 6, 5]	Split	Intermediate	Male	Amplify your gains with SPLASH training, an advanced 6-day muscle building workout system that has you training both your bench press and squat three times per week.	\N	0	4.79999999999999982	33	58	\N	\N	\N
163	Stephen Amell’s Arrow Workout: Strength & Functional Training	Increase Strength	Brad Borland	3	[1, 2, 3, 4, 8, 7]	Full Body	Intermediate	Male & Female	Ready to get superhero shredded? Gain strength, build muscle, and burn fat with this full body routine inspired by Arrow's Stephen Amell.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/stephen-amell-arrow-workout.jpg	0	4.70000000000000018	6	10	\N	\N	\N
164	Steve Kuclo's Powerhouse Shoulder Workout at Muscle & Strength Gym	Build Muscle	M&S Team	1	[3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Steve Kuclo's photo shoot turned into an intense training session. 150lbs overhead presses and machines filled to max capacity	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/steve-feature.jpg	0	5	8	0	\N	\N	\N
165	Steve's Density And Strength 4 Day Split	Build Muscle	M&S Writers	4	[1, 2, 4, 5]	Split	Intermediate	Male & Female	This 4 day split by Steve Shaw is a powerbuilding system designed to propel intermediate lifters towards faster muscle mass and strength gains.	\N	0	4.90000000000000036	227	583	\N	\N	\N
166	Super-8 Three Day Bodybuilding Workout Plan	Build Muscle	M&S Team	3	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Take your gains to a whole new level with this challenging muscle building system. Super-8 training focuses on ramping sets of eight on big compound movements.	\N	0	5	19	37	\N	\N	\N
167	Superset & Triset Chest And Back Workout By MusclePharm	Build Muscle	Cory Gregory	1	[1, 2, 3, 4]	Single Muscle Group	Intermediate	Male & Female	Blast your back and chest in the same workout with this high volume, intense superset and triset-focused training plan from Cory Gregory and MusclePharm.	\N	0	4.79999999999999982	14	8	\N	\N	\N
168	The 12-Week Clear Muscle Challenge Workout	Build Muscle	Team MuscleTech	3	[9, 1, 2, 3, 4, 5]	Full Body	Advanced	Male	Paired with MuscleTech's Clear Muscle, this workout is designed to build muscle through a 3-phase training protocol that focuses on hypertrophy, power, and strength!	\N	0	5	14	33	\N	\N	\N
169	The 15 Minute Total Body Beatdown	Build Muscle	Coach Dustin Myers	1	[1]	Full Body	Intermediate	Male & Female	Got 15 minutes? Then you have time to add Time Frame Training to your routine for a short but intense total body muscle building workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/15-minute-total-body-beatdown.jpg	0	5	2	1	\N	\N	\N
170	The Anti-Hero Training Plan: Build Big, Brutal Muscle & Strength	Build Muscle	Brad Borland	4	[1, 2, 4]	Split	Beginner	Male & Female	Nothing pretty here! You're about to become a big, bad anti-hero behemoth. This no frills, get it done 4 day workout split will help you pack on both muscle and strength.	\N	0	5	53	47	\N	\N	\N
171	The Best Shoulder Workout You've Never Tried	Build Muscle	Roger “Rock” Lockridge	1	[1, 4, 7]	Single Muscle Group	Beginner	Male & Female	This unconventional shoulder workout is perfect if you've hit a plateau or are looking for a challenge. Try it for 8 weeks and marvel at your massive shoulders!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/best-shoulder-workout.jpg	0	4.29999999999999982	7	1	\N	\N	\N
172	The Ex-Hardgainer Workout And Eating Plan	Build Muscle	M&S Team	3	[1, 2, 4]	Full Body	Beginner	Male & Female	Tired of being a hardgainer? This program contains a detailed workout and progression scheme, along with eating advice and a sample daily diet plan.	\N	0	4.90000000000000036	168	705	\N	\N	\N
173	The Giant Set Routine!	Build Muscle	Doug Lawrenson	3	[1, 4, 6, 5]	Split	Advanced	Male & Female	Stuck in a plateau? Blast your muscles with this giant set routine! The routine is short and intense, and hits each muscle group with 3 massive supersets. 	\N	0	5	52	192	\N	\N	\N
174	The LOHILO Muscle Building System	Build Muscle	Brian Turner	6	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	When using LoHiLo you will alternate between intense superset-focused weeks and the 12 to 16 rep range, and strength focused weeks that utilize 2 reps per set.	\N	0	5	11	22	\N	\N	\N
175	The Power Pump Routine	Build Muscle	Jim Brewster	3	[1, 4, 6, 5, 7]	Split	Intermediate	Male & Female	A complete push, pull, legs muscle building workout program. Includes information on recovery, nutritional guidelines and supplement advice.	\N	0	4.09999999999999964	15	31	\N	\N	\N
176	The Punisher Vol. II: A Ruthless Full Body Fat Burning Workout	Build Muscle	Eric Brown	2	[8]	Full Body	Intermediate	Male & Female	Do you have what it takes? Eric Brown's twist on his Punisher workout takes simple kettlebell moves and turns them into an intense total body workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/the-punisher-workout.jpg	0	4.5	11	0	\N	\N	\N
177	The Punisher: A Relentless Better Body Workout	Build Muscle	Eric Brown	1	[2, 4, 7]	Full Body	Intermediate	Male & Female	Eric Brown delivers a workout with a wallop. The Punisher is deceptively simple, comprised of 5 movements: walking lunges, bent-over rows, push ups, burpees and a sprint.	\N	0	5	44	51	\N	\N	\N
178	The Ripped Freak Training Program	Build Muscle	Alex Savva	5	[1, 2, 3, 4, 5]	Full Body	Intermediate	Male & Female	Get the most out of your workout with the The Ripped Freak Training Program and 5-Minute Ripped Solution, designed to help you maximize muscle growth, increase performance, and burn fat! 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/doing_barbell_curls_for_the_ripped_freak_program.jpg	0	4.59999999999999964	9	52	\N	\N	\N
179	The Routine That Blew Up The Machine Marc Lobliner	Build Muscle	Machine Militia	5	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	This workout is not a game! Machine Militia, listen up: this is the exact training routine that helped MTS CEO Marc Lobliner blow up his lagging back and delts.	\N	0	4.90000000000000036	13	9	\N	\N	\N
180	The Squeeze Method For Building A Big Defined Chest	Build Muscle	M&S Team	1	[4, 5]	Single Muscle Group	Intermediate	Male & Female	The Muscle & Strength team travels to Columbus, OH and learns about the squeeze method from MuscleTech Athlete, Santi Aragon. Give this method a shot!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/squeeze-method-feature.jpg	0	5	1	0	\N	\N	\N
181	The Tactical Physique: A Functional Strength & Conditioning Workout	General Fitness	Brad Borland	4	[1, 2, 4, 7]	Split	Intermediate	Male & Female	Build a body that performs as good as it looks. This 5 day program by Brad Borland features functional full body workouts, supersets, bodyweight and conditioning work.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/tact800.jpg	0	4.20000000000000018	43	99	\N	\N	\N
182	The Weekend Warrior Workout	Build Muscle	Brad Borland	3	[1, 2, 4, 8]	Full Body	Beginner	Male & Female	Hoping to be crowned MVP of your intramural team? Gain the edge during the course of the week and become a true weekend warrior with this workout!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/weekend-warrior-feature.jpg	0	3.5	2	0	\N	\N	\N
183	This Workout Just Might Kill You...Or Make You Grow - You Decide	Build Muscle	Roger “Rock” Lockridge	1	[1, 2, 4]	Single Muscle Group	Advanced	Male & Female	1 hour. 1 body part. 50,000 pounds. Are you up for the ultimate high volume workout challenge? This is NOT an ordinary workout, so proceed with caution!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/killer-workout-volume-challenge.jpg	0	4.20000000000000018	5	3	\N	\N	\N
184	Three 10-Minute At Home Upper Body Workouts	Build Muscle	Mike Samuels	1	[9, 2]	Split	Beginner	Male & Female	Don't let the busyness of life hold you back from making progress. Challenge yourself at home with these three brief but effective upper body sessions.	\N	0	4.59999999999999964	14	4	\N	\N	\N
185	Total Body Beatdown: A German Volume Training Routine	Build Muscle	Coach Dustin Myers	3	[1, 2, 3, 4, 5]	Full Body	Intermediate	Male & Female	Whether you only have time to make it to the gym a few times during the week or you want to annihilate your entire body, we've got the workout for you!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/gvt-feature.jpg	0	4.59999999999999964	10	3	\N	\N	\N
186	Train Like An Olympian: Branch Warren's Leg Workout	Build Muscle	Ron Harris	1	[1, 5]	Single Muscle Group	Intermediate	Male & Female	Top Olympian and Team Gaspari member Branch Warren has some of the biggest wheels to ever hit a bodybuilding stage. This feature takes an inside look at his high impact leg workout.	\N	0	5	7	1	\N	\N	\N
187	Training for the Older Athlete: Making Gains After 40	Build Muscle	Brad Borland	4	[1, 2, 3, 4]	Split	Beginner	Male & Female	They say Father Time is undefeated, but that doesn't mean you can't make gains all of your life. Check out these training strategies for older athletes.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/older-athlete-new-feature.jpg	0	4.5	6	0	\N	\N	\N
188	Troy's 3 Day Maintenance Workout	Build Muscle	Troy A. Dolfi	3	[1, 3, 4, 5]	Split	Intermediate	Male & Female	A variation on the classic push, pull, legs split, working shoulders and back on the same day, and biceps with legs. This workout was designed by Troy (tadolfi).	\N	0	5	18	45	\N	\N	\N
189	Ultimate Bench Press Workout: Increase Strength And Chest Size	Build Muscle	Lee Boyce	1	[1, 2, 3]	Single Muscle Group	Beginner	Male & Female	Looking for a way to add size and strength to your chest muscle? This bench press workout is designed to build massive pecs while putting up big numbers on bench!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/ultimate_bench_press_workout.jpg	0	4.70000000000000018	3	2	\N	\N	\N
190	Upper/Lower 4 Day Gym Bodybuilding Split Workout	Build Muscle	M&S Team	4	[1, 2, 3, 4, 6, 5]	Split	Beginner	Male & Female	Reach your muscle building goals with this balanced 4 day training split that mixes heavy compound exercises, machines, cables and incorporates 3 second negatives.	\N	0	4.5	52	65	\N	\N	\N
191	VCS 3 Stage Back Workout - Volume, Cluster & Strength Training	Build Muscle	M&S Team	1	[1, 2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Build a beefy back using 3 distinct and powerful cycles. Lift rotation focuses on heavy strength building exercises, muscle building volume work and pump-inducing cluster sets.	\N	0	4.79999999999999982	5	10	\N	\N	\N
192	VTS - The Complete Venom Training System Program	Build Muscle	Maurice Bright	5	[1, 2, 3, 4, 6, 5, 7]	Split	Intermediate	Male & Female	Unleash your inner beast and reach your bodybuilding goals with this unique and comprehensive five day muscle building split workout from Maurice Bright.	\N	0	5	19	16	\N	\N	\N
193	Wild 20 Powerbuilding Workout: Get Crazy, Get Big & Strong	Build Muscle	M&S Writers	4	[1, 3, 4, 5]	Split	Intermediate	Male & Female	Bust out of your training rut and blast through muscle and strength building plateaus using a unique combination of 5, 10 and 20 rep sets. This program delivers results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/wild_20_feature.jpg	0	4.40000000000000036	37	136	\N	\N	\N
194	Your Complete Blue Print For A Leaner, More Muscular Body	Build Muscle	Brad Borland	3	[1, 2, 4]	Split	Beginner	Male & Female	Life getting in the way of consistent training? Brad Borland presents a flexible system that allows you to workout, 2-4 times per week depending on your schedule.	\N	0	4.79999999999999982	38	6	\N	\N	\N
195	 “No Juice” Advanced Bodybuilding Workout Routine	Build Muscle	Pete Khatcherian	6	[1, 2, 3, 4, 5]	Split	Advanced	Male & Female	Avoid plateauing with the "No Juice" routine, which manipulates intensity, frequency, and volume to help you continue progressing in the gym.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/no_juice_feature.jpg	0	4	9	18	\N	\N	\N
196	10 Week Chest Size & Bench Press Strength Workout	Build Muscle	M&S Team	1	[1, 4, 5]	Single Muscle Group	Beginner	Male & Female	This ten week training cycle is designed to not only boost your barbell bench press prowess but also pack on slabs of muscle mass to your upper and lower chest.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/10mass_feature.jpg	0	4.90000000000000036	40	49	\N	\N	\N
197	100% Powerlifting Workout	Increase Strength	M&S Writers	4	[1, 2, 3, 4, 6, 5]	Split	Intermediate	Male & Female	The 100% powerlifting workout. is specifically designed for someone competing in powerlifting. Also a great choice for someone building general strength.	\N	0	4.79999999999999982	133	217	\N	\N	\N
198	12 Weeks To A Bigger Bench Press	Increase Strength	Jonathan Byrd	3	[1, 2, 4, 6, 5]	Single Muscle Group	Beginner	Male & Female	How much do you bench? If you feel it's never enough, then this 12 week specialization cycle is for you. Give this program a try and beef up your bench in no time.	\N	0	5	18	22	\N	\N	\N
199	18 Week Bench Press Peaking Cycle	Increase Strength	M&S Team	1	[1, 3, 4, 6]	Single Muscle Group	Intermediate	Male & Female	Unsatisfied with your bench press numbers? This effective peaking cycle ramps up the intensity week in and week out, providing you with plenty of bench-building volume.	\N	0	5	5	14	\N	\N	\N
200	2 Day Squat Workout For Improved Size & Strength	Build Muscle	M&S Team	2	[1, 5]	Split	Intermediate	Male & Female	No more weak and small legs. This squat specialization program will have you hammering your wheels twice a week, bringing up both your leg size and squat strength.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/2squat_feature.jpg	0	4.90000000000000036	25	18	\N	\N	\N
201	3 Day Whole Body Football Strength Workout	Increase Strength	M&S Writers	3	[1, 2, 3, 4, 6, 5]	Full Body	Intermediate	Male & Female	Increase your explosive power and strength to help you on the football field. It's a full body workout on a three day schedule - Monday, Wednesday and Friday.	\N	0	4.90000000000000036	188	325	\N	\N	\N
202	3 Week NFL Combine Bench Press Program	Increase Strength	M&S Team	1	[1, 4]	Sports Training	Intermediate	Male	Improve your bench press strength and endurance with this 3 week program. Workouts cycle between 5x5, 5x8 and 3x3 weeks, ending with an all-out 20 rep test.	\N	0	4.40000000000000036	26	40	\N	\N	\N
203	4 Week Beginner Core Strength Trainer	Increase Strength	Coach Dustin Myers	6	[9, 2, 4]	Single Muscle Group	Beginner	Male & Female	Coach Myers has taken a break from extreme core challenges to craft a core strength routine for beginners. You're just 1 month away from a strong core!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/beginner-core-strength-trainer.jpg	0	5	1	5	\N	\N	\N
204	5 Cross Training Workouts For General Conditioning	Sports Performance	Thomas Schultz	1	[1, 2, 8, 7]	Full Body	Beginner	Male & Female	The following 5 cross training daily workout routines that contain a variety of exercises aimed at improving your overall conditioning.	\N	0	4.90000000000000036	13	16	\N	\N	\N
205	6 Day Push, Pull, Legs Powerbuilding Split & Meal Plan	Build Muscle	Nick Ludlow	6	[1, 2, 4, 5]	Split	Intermediate	Male & Female	Hungry for some serious gym time and crazy gains? Nick Ludlow helps you to go heavy, go hard and improve your results with this intense, high volume rest-pause workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/power8.jpg	0	4.20000000000000018	14	28	\N	\N	\N
206	6 Week Navy Seal Workout Routine: Speed, Strength & Endurance	General Fitness	Brad Borland	4	[1, 2, 4, 12]	Full Body	Beginner	Male & Female	Do you have what it takes to tackle this introductory Navy SEAL training plan? You'll build functional strength, speed, and endurance with this 6-week workout routine.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/navy_seal_training_2.jpg	0	4.20000000000000018	5	45	\N	\N	\N
207	8 Week Bench Press Builder	Increase Strength	M&S Team	4	[1, 4, 6]	Single Muscle Group	Intermediate	Male & Female	Build a bigger bench press with this intense and effective 8 week specialization program that features two pressing workouts per week. 	\N	0	5	12	62	\N	\N	\N
208	8 Weeks To A Stronger Deadlift	Increase Strength	Danny Takacs	1	[1, 5]	Single Muscle Group	Intermediate	Male & Female	This 8 week peaking cycle is for experienced pullers who want to beef up their lagging deadlift. Feature includes a sample workout with recommended assistance exercises.	\N	0	4.59999999999999964	7	9	\N	\N	\N
209	963 Workout System For Muscle Size And Strength	Build Muscle	M&S Team	4	[1, 2, 4, 5]	Split	Beginner	Male & Female	The 963 training system is an upper/lower workout split that helps you to build both size and strength by cycling main lifts between 3 different levels of weight intensity.	\N	0	4.90000000000000036	26	40	\N	\N	\N
210	A Bigger Bench Press & Chest Using Only 135 Pounds - Really	Build Muscle	M&S Writers	1	[1]	Single Muscle Group	Intermediate	Male & Female	No I am not insane - this program really works. Build a bigger chest and improve your bench press by inserting this specialty workout into your current training regimen.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/benchhead.jpg	0	4	41	139	\N	\N	\N
211	A Hardcore Look At Wendler's 5/3/1 Powerlifting Routine	Increase Strength	M&S Writers	3	[1, 2, 4]	Split	Intermediate	Male & Female	Jim Wendler's 5/3/1 powerlifting system is popular because it works! Wendler's has you training 3-4 days per week on a rotating wave system.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/wendler800.jpg	0	4.90000000000000036	226	348	\N	\N	\N
212	Beef Up Your Bench Press 10x3 Workout Program	Increase Strength	M&S Team	3	[1, 2, 4, 5]	Split	Intermediate	Male	Bring up your bench press with this intense 10 set x 3 rep bench press specialization workout plan from top powerlifter Steve Shaw	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/bench-press-workout.jpg	0	4.70000000000000018	54	153	\N	\N	\N
213	Bench Most Dayz: Increase Your Bench By 30-50lbs In 6 weeks	Increase Strength	Cory Gregory	4	[1]	Single Muscle Group	Beginner	Male & Female	Cory Gregory's Bench Most Dayz 6 week program is designed to add some serious weight to your bench and muscle mass in your chest!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/bench_most_dayz.jpg	0	4.59999999999999964	11	65	\N	\N	\N
214	Bill Starr 5x5  Linear Version For Intermediate Lifters	Increase Strength	M&S Writers	3	[1, 2]	Full Body	Intermediate	Male & Female	This highly effective strength and muscle building 5x5 workout by Bill Starr illustrates the importance of making systematic progression to drive gains.	\N	0	5	92	96	\N	\N	\N
215	Build a Bigger Chest With This Intense Mass Building Workout	Build Muscle	Team eFlow	1	[2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Don't be ashamed by your lack of gains at the pool this year. Attack your pecs from all angles and utilize drop sets with this intense chest workout!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/massive-chest-feature.jpg	0	4.90000000000000036	13	0	\N	\N	\N
216	Build A Bigger Squat: 8 Week Periodized Workout Plan	Increase Strength	M&S Team	4	[1, 2, 4, 5]	Split	Intermediate	Male & Female	This program is designed to help strength athletes add 10-30 lbs to their squats over an 8 week period. Each week lifters alternate between rep work and heavy sets.	\N	0	5	4	8	\N	\N	\N
217	Build Core Strength! Coach Myers' Top 5 Exercises For Core Stability	Increase Strength	Coach Dustin Myers	3	[9, 2, 10]	Single Muscle Group	Intermediate	Male & Female	Coach Myers' is back at it and just in time to help you build your core for summer! Check out his top 5 core exercises and these progressive core workouts!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/core-stability-feature-1.jpg	0	4.40000000000000036	5	0	\N	\N	\N
218	Build Your Own Cross Training Daily Workouts	General Fitness	Thomas Schultz	1	[1, 2, 8]	Full Body	Beginner	Male & Female	Here is a fun way to come up with your daily cross training workouts. This random generation system has the potential to create up to 100,000 unique workout variations.	\N	0	5	34	12	\N	\N	\N
219	Combat Your Weakness Workout Program	Build Muscle	Charles Cunningham	5	[1, 2, 3, 4, 6, 7]	Full Body	Intermediate	Male & Female	This program combines the concepts of training volume, progressive overload, and muscular tension in order to build strength and muscle while prioritizing lagging body parts.  	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/combat_your_weakness_training_program.jpg	0	4.59999999999999964	11	4	\N	\N	\N
220	Compound Exercises Only Workout	Build Muscle	M&S Writers	4	[1, 2, 3, 4]	Split	Intermediate	Male & Female	This workout uses only compound exercises. Compound exercises are movements that require more than 1 joint and more than 1 muscle group.	\N	0	4.90000000000000036	194	268	\N	\N	\N
221	Core Strength Blueprint Workout v1.1 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 10, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mpfeature.jpg	0	5	2	4	\N	\N	\N
222	Core Strength Blueprint Workout v1.2 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 10, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cb2_feature.jpg	0	5	1	3	\N	\N	\N
223	Core Strength Blueprint Workout v1.3 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 10, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/core_1-3_feature.jpg	0	4.5	6	0	\N	\N	\N
224	Core Strength Blueprint Workout v1.4 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/musclepharm_core_strength_workout.jpg	0	5	2	5	\N	\N	\N
225	Core, Strength And Fat Burn Workout	Lose Fat	Danial Kelly	6	[1, 2, 4, 7]	Full Body	Intermediate	Male & Female	Potent, powerful and anything but boring. This hardcore fat burning, strength and core building workout will leave you looking and feeling great.	\N	0	5	55	142	\N	\N	\N
226	Crazy 5 Method: An Intense Rep Scheme For Making Solid Gains	Build Muscle	Coach Dustin Myers	3	[1, 4]	Split	Intermediate	Male & Female	If you're looking for an excellent finisher to your lifts, look no further. Coach Myers' Crazy 5 Method is bound to give you the pump you're looking for.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/crazy-5-method-feature.jpg	0	4	8	2	\N	\N	\N
227	CrossFit vs Weight Training: Which Gives Better Results?	Build Muscle	Team AML	3	[1, 2, 8]	Split	Intermediate	Male & Female	Traditional weightlifters and cross trainers don't see eye to eye on training. However, the best approach to training isn't as black & white as you may think.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/crossfit-feature_0.jpg	0	5	2	1	\N	\N	\N
228	Daily Undulating Periodization (DUP) Muscle Growth Workout	Increase Strength	Mike Wines	4	[9, 1, 3, 4, 5, 7]	Split	Intermediate	Male & Female	Maximize your training with this workout that utilizes an advanced training technique designed to enhance strength, power, and muscle hypertrophy.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/periodization_muscle_growth_workout_feature.jpg	0	5	3	20	\N	\N	\N
229	Density Giant Set Training v2.0: Stronger And Leaner	Lose Fat	John Matulevich	4	[1, 2, 3, 4, 5]	Split	Intermediate	Male & Female	Get your body stronger and leaner with this two template updated version of the extremely popular Density Giant Set Training workout system.	\N	0	4.90000000000000036	34	88	\N	\N	\N
230	Dougs 4 Day Split Maximum Strength Workout	Increase Strength	Doug Lawrenson	4	[1, 4, 6, 5]	Split	Intermediate	Male & Female	If you are looking to a pure strength training routine, then this routine is for you. This program will increase your strength is the shortest time possible.	\N	0	4.90000000000000036	58	120	\N	\N	\N
231	EKnight's Modified Westside Barbell Strength Workout	Increase Strength	Eric Knight	4	[1, 2, 3, 4, 7]	Split	Intermediate	Male & Female	Eric Knight's modified Westside Barbell workout is beginner friendly and allows for progress without chains and bands. The program is 4 days a week.	\N	0	5	43	97	\N	\N	\N
232	Get Stronger At Squats With This 12 Week Super Squat Workout	Increase Strength	Roger “Rock” Lockridge	1	[1, 2, 3, 5]	Single Muscle Group	Beginner	Male & Female	Work your way to a bigger, more impressive squat with this 12-week program that's designed to improve your squat and get you moving serious weight.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/improving_squats_program_ronnie_coleman_feature.jpg	0	3.79999999999999982	4	1	\N	\N	\N
233	Jason Blaha's Off Season Linear Periodization Intermediate Strength Program #1	Increase Strength	M&S Writers	4	[1, 4]	Split	Intermediate	Male & Female	Jason Blaha presents a twelve week off season strength building program for seasoned intermediate lifters. Accessory work is left open based on needs and weaknesses.	\N	0	4.5	23	15	\N	\N	\N
234	Jason Poston's Giant Set Back Workout Routine	Build Muscle	M&S Team	1	[1, 3, 4, 11]	Single Muscle Group	Intermediate	Male & Female	If you thought your back workout was tough, then you've got to check out IFBB Pro and ProSupps athlete Jason Poston's Giant Set Back Routine!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/poston-prosupps-feature_0.jpg	0	4	2	0	\N	\N	\N
235	Jeremy's 6 Day Hardcore Strength Workout	Increase Strength	Jeremy Wood	6	[1, 2, 4]	Split	Intermediate	Male & Female	Hardcore! This is a hardcore strength building workout that has you in the gym 6 days a week, and focuses on basic strength building lifts.	\N	0	5	54	71	\N	\N	\N
257	The Un-Deadlifter: 4 Deadlift & Trap Workout Variations	Increase Strength	M&S Writers	1	[1, 4]	Single Muscle Group	Intermediate	Male & Female	 Traps are the new abs! Slam your traps into growth and build a colossal deadlift one rep max using these 4 excruciating and devious workout options from Steve Shaw.	\N	0	5	3	9	\N	\N	\N
236	John Meadows: His Journey to the Arnold, Brand, & Back Workout	Build Muscle	Roger “Rock” Lockridge	1	[1, 3, 4, 5]	Single Muscle Group	Intermediate	Male & Female	IFBB Pro John Meadows' work ethic is like no other. Read about his humbling journey to competing in front of his home town at this years Arnold Classic.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/john-meadows-feature.jpg	0	4.70000000000000018	3	1	\N	\N	\N
237	Kelso's Bench Press Training	Increase Strength	M&S Writers	2	[1, 4]	Single Muscle Group	Intermediate	Male & Female	In the middle of a bench press stall? Powerlifting coach and author Paul Kelso has some suggestions of how to boost your bench total.	\N	0	5	17	49	\N	\N	\N
238	Long Cycle Beginner Muscle And Strength Building Workout	Build Muscle	M&S Team	3	[1, 2, 4, 6, 5]	Full Body	Beginner	Male & Female	The Long Cycle program uses auto-regulation, allowing a lifter to progress on each exercise at a natural rate, while also maximizing muscle mass and strength gains.	\N	0	5	36	44	\N	\N	\N
239	Massive Bench Press 16 Week Block Training Cycle	Increase Strength	M&S Team	4	[1, 2, 4]	Split	Intermediate	Male & Female	Get your bench press moving in the right direction with this 2 phase program. Lifters spend 8 weeks building muscle, and 8 weeks peaking towards a new one rep max.	\N	0	5	27	13	\N	\N	\N
240	Matt Kroc's 16 Week Strength Program & Lean Gain Diet Plan	Increase Strength	Team MuscleTech	4	[1, 2, 3, 4, 5]	Split	Beginner	Male & Female	Muscletech and powerlifting/bodybuilding phenom Matt Kroc presents a strength program designed to drive up gains by increasing intensity over a 16 week period.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/matt800.jpg	0	5	36	21	\N	\N	\N
241	Max Adaptation Upper Lower (MAUL) Workout	Build Muscle	Alain Gonzalez	5	[1, 3, 4, 5]	Split	Beginner	Male & Female	This workout combines the main mechanisms of muscle hypertrophy to help you build some serious muscle. Try this split to put on quality summer mass!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/maul-feature.jpg	0	5	27	0	\N	\N	\N
242	MFT Training: Boost Strength and Build High Performance Muscle	Build Muscle	Eric Weinbrenner	3	[1, 2, 3, 4, 6]	Full Body	Intermediate	Male & Female	Would you like to get stronger and build more muscle while spending less time in the gym? MFT training might be just what you need for big results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/mft-training.jpg	0	5	5	22	\N	\N	\N
243	Muscle & Strength Full Body Workout Routine	Build Muscle	M&S Team	3	[1, 2, 4]	Full Body	Beginner	Male & Female	This M&S mass building routine is perfect for lifters who want to give full body workouts a try. All major muscle groups are trained, and the program includes a 20 rep set of squats.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/ms_full_body_workout.jpg	0	4.79999999999999982	78	57	\N	\N	\N
244	Muscle & Strength's 30 Day Workout Plan For Women	Build Muscle	Brad Borland	6	[1, 2, 4, 7]	Full Body	Beginner	Female	Looking for the best place to start working towards a leaner, solid, and stronger body? This thorough workout routine is specifically designed to get you there!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/complete_full_body_womens_workout_routine.jpg	0	4.20000000000000018	14	40	\N	\N	\N
245	Nick Wright NWB Power Training Workout Split	Increase Strength	Nick Wright	4	[1, 2, 3, 4, 5]	Split	Intermediate	Male & Female	With nearly 150,000 Youtube subscribers and 650,000 Facebook followers, Nick Wright is an Internet sensation. In this feature we present his plan for building maximum strength.	\N	0	5	14	12	\N	\N	\N
246	Off Season Leg Day Workout With Brandon Beckrich	Build Muscle	M&S Team	1	[9, 1, 5]	Single Muscle Group	Intermediate	Male & Female	If you're in need of a great, quad-dominant leg workout, then you're in luck! Check out Team Allmax's Brandon Beckrich's insane off season leg day routine!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/brandon-legs-feature.jpg	0	5	2	0	\N	\N	\N
247	Off-Season Baseball Strength Workout	Increase Strength	M&S Writers	3	[1, 2, 6, 5]	Full Body	Intermediate	Male & Female	Increase your strength (esp. upper body strength) in the baseball off-season. This is a full body workout hitting all major muscle groups every workout, 3 times per week.	\N	0	4.90000000000000036	99	229	\N	\N	\N
248	Power Muscle Burn 5 Day Powerbuilding Split	Build Muscle	M&S Team	5	[1, 3, 4, 5]	Split	Intermediate	Male & Female	Rapidly build size and strength with this powerbuilding 5 day split which focuses on strength building power sets, and crazy-intense burn sets. You have been warned!	\N	0	5	1100	2600	\N	\N	\N
249	Project WHEELS: The Ultimate Hybrid Program for Leg Size and Strength	Build Muscle	Lee Boyce	5	[1, 2, 4, 5]	Single Muscle Group	Intermediate	Male & Female	Build both your leg strength and solid legs muscles with this workout program that's heavy on squats, but highly effective at delivering results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/leg_exercises_for_building_strong_legs_feature.jpg	0	4	4	2	\N	\N	\N
250	Rippetoe Wichita Falls Novice Program	Increase Strength	M&S Writers	3	[1, 2]	Full Body	Beginner	Male & Female	This routine is taught by Mark Rippetoe, but isn't available in his book Starting Strength. This 5x5 program is for beginners, and helps to build size and strength.	\N	0	5	56	186	\N	\N	\N
251	Shrugs Are Overrated: Build a Massive Yoke Without Shrugs	Build Muscle	Ben Johnson	1	[1, 4]	Single Muscle Group	Intermediate	Male & Female	Traps are the true sign of strength. Quit relying on ego-based, half shrug movements and build a serious yoke with this 4 week explosive workout plan!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/massive-yolk-feature.jpg	0	4.20000000000000018	6	2	\N	\N	\N
252	Stephen Amell’s Arrow Workout: Strength & Functional Training	Increase Strength	Brad Borland	3	[1, 2, 3, 4, 8, 7]	Full Body	Intermediate	Male & Female	Ready to get superhero shredded? Gain strength, build muscle, and burn fat with this full body routine inspired by Arrow's Stephen Amell.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/stephen-amell-arrow-workout.jpg	0	4.70000000000000018	6	10	\N	\N	\N
253	Steve's Density And Strength 4 Day Split	Build Muscle	M&S Writers	4	[1, 2, 4, 5]	Split	Intermediate	Male & Female	This 4 day split by Steve Shaw is a powerbuilding system designed to propel intermediate lifters towards faster muscle mass and strength gains.	\N	0	4.90000000000000036	227	583	\N	\N	\N
254	Strength And Bulk Beginner Workout - Linear Progression	Increase Strength	M&S Team	3	[1, 2, 4]	Full Body	Beginner	Male	A beginner workout based around linear progression for someone with a good grasp of exercise form. Stop wasting time in the gym and get results.	\N	0	4.90000000000000036	60	268	\N	\N	\N
255	The Anti-Hero Training Plan: Build Big, Brutal Muscle & Strength	Build Muscle	Brad Borland	4	[1, 2, 4]	Split	Beginner	Male & Female	Nothing pretty here! You're about to become a big, bad anti-hero behemoth. This no frills, get it done 4 day workout split will help you pack on both muscle and strength.	\N	0	5	53	47	\N	\N	\N
256	The Tactical Physique: A Functional Strength & Conditioning Workout	General Fitness	Brad Borland	4	[1, 2, 4, 7]	Split	Intermediate	Male & Female	Build a body that performs as good as it looks. This 5 day program by Brad Borland features functional full body workouts, supersets, bodyweight and conditioning work.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/tact800.jpg	0	4.20000000000000018	43	99	\N	\N	\N
258	The Weekend Warrior Workout	Build Muscle	Brad Borland	3	[1, 2, 4, 8]	Full Body	Beginner	Male & Female	Hoping to be crowned MVP of your intramural team? Gain the edge during the course of the week and become a true weekend warrior with this workout!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/weekend-warrior-feature.jpg	0	3.5	2	0	\N	\N	\N
259	Tricep Trifecta: 3 Power Exercises For Tricep & Bench Strength	Increase Strength	Coach Dustin Myers	2	[1, 3, 4]	Single Muscle Group	Beginner	Male & Female	Coach Myers has the answer for two weightlifting woes. This workout will get you past your bench press plateaus and leave you with massive triceps!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/triceps-trifecta.jpg	0	4.59999999999999964	7	0	\N	\N	\N
260	Wild 20 Powerbuilding Workout: Get Crazy, Get Big & Strong	Build Muscle	M&S Writers	4	[1, 3, 4, 5]	Split	Intermediate	Male & Female	Bust out of your training rut and blast through muscle and strength building plateaus using a unique combination of 5, 10 and 20 rep sets. This program delivers results.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/wild_20_feature.jpg	0	4.40000000000000036	37	136	\N	\N	\N
261	 “No Juice” Advanced Bodybuilding Workout Routine	Build Muscle	Pete Khatcherian	6	[1, 2, 3, 4, 5]	Split	Advanced	Male & Female	Avoid plateauing with the "No Juice" routine, which manipulates intensity, frequency, and volume to help you continue progressing in the gym.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/no_juice_feature.jpg	0	4	9	18	\N	\N	\N
262	10 Week Chest Size & Bench Press Strength Workout	Build Muscle	M&S Team	1	[1, 4, 5]	Single Muscle Group	Beginner	Male & Female	This ten week training cycle is designed to not only boost your barbell bench press prowess but also pack on slabs of muscle mass to your upper and lower chest.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/10mass_feature.jpg	0	4.90000000000000036	40	49	\N	\N	\N
263	10 Week Mass Building Program	Build Muscle	M&S Writers	4	[1, 2, 4, 5]	Split	Advanced	Male & Female	This workout is designed to increase your muscle mass as much as possible in 10 weeks. Works each muscle group hard once per week using mostly heavy compound exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/10weekmass.jpg	0	4.79999999999999982	2200	2400	\N	\N	\N
264	100 Rep Hell: A Shocker Muscle Building Workout	Build Muscle	M&S Team	5	[1, 6, 5]	Split	Intermediate	Male & Female	Need a change? You’ve come to the right workout. This one week shocker is meant to break through the boredom and monotony, and beat your body into growth.	\N	0	4.90000000000000036	33	60	\N	\N	\N
265	100 Reps Per Set Shocker Fullbody Workout	Build Muscle	Maik Wiedenbach	2	[1, 2, 3, 4, 6, 5]	Full Body	Intermediate	Male & Female	Blast out of a rut with 100 reps per set. 100 rep sets can be used to shock the entire body for a week or two, or to bring up a lagging part.\n\n	\N	0	5	54	106	\N	\N	\N
266	12 Week Beginners Training Routine	Build Muscle	Doug Lawrenson	2	[1, 2, 3, 4, 5]	Full Body	Beginner	Male & Female	A twelve week full body beginners routine designed to get your body ready for an intense split routine. Includes a detailed week by week plan.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/12feature.jpg	0	5	272	692	\N	\N	\N
267	18 Week Chin Up & Dip Program For An Impressive Upper Body	Build Muscle	Eric Brown	4	[2, 7]	Single Muscle Group	Beginner	Male & Female	Chin ups and dips are 2 overlooked but important bodyweight exercises. This 18 week workout protocol features a single training day dedicated to these movements.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/dipchin.jpg	0	4.79999999999999982	87	165	\N	\N	\N
268	2 Day Simple A/B Split by Steve	Build Muscle	M&S Team	2	[1, 2, 4]	Full Body	Beginner	Male & Female	Effective 2 day per week fullbody routine that is perfect for building muscle and strength. If you don't have time to live in the gym this is the routine for you.	\N	0	4.79999999999999982	97	340	\N	\N	\N
269	The Ultimate 20 Minute Treadmill Workout to Get Shredded	Lose Fat	Coach Dustin Myers	3	[2]	Cardio	Beginner	Male & Female	Tired of those drawn-out cardio sessions that steal your pump? Try out Coach Myers' Pump & Run workout that'll help you shred without losing your pump!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/pump-and-run-feature.jpg	0	3.20000000000000018	9	4	\N	\N	\N
270	5 Best 20 Minute HIIT Cardio Workouts For Rapid Fat Loss	Lose Fat	Brad Borland	2	[2, 8, 7]	Cardio	Beginner	Male & Female	You don't have to spend hours on cardio equipment to burn fat. Try one of these HIIT cardio routines for faster (and less boring!) fat loss.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiit-fat-loss-workouts.jpg	0	4.70000000000000018	3	9	\N	\N	\N
271	Get Shredded For The New Year: 21-Day Fat Loss Workout	Lose Fat	Coach Dustin Myers	7	[1, 3, 4, 11, 7]	Full Body	Beginner	Male & Female	If your physique isn't where you want it to be, start your New Year off right with this intense 21-day fat loss workout from Coach Dustin Myers.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/new-year-fat-loss.jpg	0	5	43	9	\N	\N	\N
272	Love Handle Workouts: 5 Routines That Torch Unwanted Fat	Lose Fat	Brad Borland	3	[2, 4, 8]	Full Body	Beginner	Male & Female	Stuck with some extra holiday flab? Burn it off faster by tackling these intense fat burning workouts. Includes workouts for a variety of different equipment.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/love-handle-workouts.jpg	0	4.79999999999999982	52	5	\N	\N	\N
273	Power Hour Cardio: A Full Body Cardio Workout For Gym Rats	Increase Endurance	Roger “Rock” Lockridge	2	[4, 7]	Cardio	Intermediate	Male & Female	Let me guess. You hate cardio. Well this total body, endurance-building, fat blaster was designed with you in mind. Try Power Hour Cardio if you're up for a challenge!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/power-hour-cardio.jpg	0	4.5	8	1	\N	\N	\N
274	The Punisher Vol. II: A Ruthless Full Body Fat Burning Workout	Build Muscle	Eric Brown	2	[8]	Full Body	Intermediate	Male & Female	Do you have what it takes? Eric Brown's twist on his Punisher workout takes simple kettlebell moves and turns them into an intense total body workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/the-punisher-workout.jpg	0	4.5	11	0	\N	\N	\N
275	Convenient Cardio: Killer 15 Minute Home Workout Plan	General Fitness	Roger “Rock” Lockridge	3	[7]	Cardio	Beginner	Male & Female	If you're looking for a way to make cardio a lot more fun and productive without it taking up too much time, then this Sledgehammer and Sandbag Tabata Workout is for you!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/easy_home_cardio_workout.jpg	0	4.59999999999999964	5	0	\N	\N	\N
276	6 Intense Treadmill Workouts To Get Shredded For Summer	Lose Fat	Coach Dustin Myers	4	[7]	Cardio	Beginner	Male & Female	Start conditioning your body and burn fat with these 6 effective treadmill workouts that are not only designed to be brutal, but to deliver results and get those muscles popping!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiit_treadmill_workouts_for_fat_loss.jpg	0	4.79999999999999982	18	7	\N	\N	\N
302	40 Minute Blast - Abs, Cardio And Resistance Workout	General Fitness	John Gormen	1	[2, 4]	Cardio	Beginner	Male & Female	A cardio, weights and abs workout perfect for those days when you need to do something fun at the gym. Simply grab a heavy and light set of dumbbells and go!	\N	0	4.90000000000000036	43	30	\N	\N	\N
277	Jen Jewell's Summer Countdown: Burn Fat & Build A Bikini Booty	Lose Fat	Jen Jewell	4	[1, 2, 4, 10]	Full Body	Beginner	Female	The time to sculpt your summer body is now! Get lean, healthy, and strong with Jen Jewell's Summer Countdown Workout that combines strength training with cardio bursts for maximum fat loss.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/jen-jewell-summer-countdown-featured.jpg	0	3.5	8	4	\N	\N	\N
278	8 Minute Squat & Push-Up Tabata Workout For Fat Loss	Lose Fat	Brad Borland	3	[2, 4]	Cardio	Beginner	Male & Female	You can burn fat and get ripped in just 8 minutes with this high intensity Tabata circuit that combines push-ups and squats. \n 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/8-minute-tabata-squat-push-up-featured.jpg	0	4.5	4	17	\N	\N	\N
279	Building The Perfect Fat Burning Circuit	Lose Fat	Brad Borland	3	[2, 7]	Cardio	Beginner	Male & Female	Brad Borland presents a 5 element template that enables you to build your own effective fat blasting circuit workout. Benefits and example circuit workouts included.	\N	0	4.59999999999999964	5	3	\N	\N	\N
280	The Punisher: A Relentless Better Body Workout	Build Muscle	Eric Brown	1	[2, 4, 7]	Full Body	Intermediate	Male & Female	Eric Brown delivers a workout with a wallop. The Punisher is deceptively simple, comprised of 5 movements: walking lunges, bent-over rows, push ups, burpees and a sprint.	\N	0	5	44	51	\N	\N	\N
281	Dumbbell & Bodyweight HIIT Workout: A Real Calorie Burner	Lose Fat	Holly Blumenberg	1	[2, 4]	Cardio	Beginner	Male & Female	Torch through calories with this partner-based cardio workout. A series of 12 exercises are performed in a back and forth manner, adding reps with each set.	\N	0	5	31	4	\N	\N	\N
282	Kettlebell Cardio Complex To Smoke Fat And Improve Conditioning	Lose Fat	Arnav Sarkar	1	[8]	Cardio	Beginner	Male & Female	This 4 exercise kettlebell complex and circuit is performed for a total of 4 rounds. You can use this workout 1-3 times per week to burn fat or improve conditioning.	\N	0	4.90000000000000036	15	1	\N	\N	\N
283	Prepare For Boot Camp With This 12 Week Workout	General Fitness	Brad Borland	3	[1, 2, 5]	Full Body	Beginner	Male & Female	So boot camp is only a short time away, and you need to get in shape. This 12 week program will help turn you into a physically fit, running, push up and sit up machine.	\N	0	5	15	4	\N	\N	\N
284	Unique Cardio Workouts: 4 Fun Ways To Burn Calories	Lose Fat	Brad Borland	1	[1, 5]	Cardio	Beginner	Male & Female	Unchain yourself from the boring treadmill and inject some fun into your calorie burning regimen with these 4 cardio suggestions from bodybuilder Brad Borland.	\N	0	4.40000000000000036	5	0	\N	\N	\N
285	MusclePharm Combo Fat Burner Workout	Lose Fat	Cory Gregory	1	[9, 1, 2, 4, 6, 5, 7]	Cardio	Beginner	Male & Female	This fat blasting workout from Cory Gregory and MusclePharm utilizes 4 minute blocks comprised of jumping rope and timed resistance training exercises.	\N	0	5	12	3	\N	\N	\N
286	No Kettlebell, No Problem - Dumbbell HIIT Workout	Lose Fat	Holly Blumenberg	2	[4]	Cardio	Beginner	Male & Female	You don't need the latest craze to get in a good high intensity, fat burning workout. No kettlebell, no problem! All you need for this cardio workout is a set of dumbbells.	\N	0	5	23	19	\N	\N	\N
287	40 Minute Blast - Abs, Cardio And Resistance Workout	General Fitness	John Gormen	1	[2, 4]	Cardio	Beginner	Male & Female	A cardio, weights and abs workout perfect for those days when you need to do something fun at the gym. Simply grab a heavy and light set of dumbbells and go!	\N	0	4.90000000000000036	43	30	\N	\N	\N
288	5 Cross Training Workouts For General Conditioning	Sports Performance	Thomas Schultz	1	[1, 2, 8, 7]	Full Body	Beginner	Male & Female	The following 5 cross training daily workout routines that contain a variety of exercises aimed at improving your overall conditioning.	\N	0	4.90000000000000036	13	16	\N	\N	\N
289	Countdown To Fitness: A Calisthenics And Bodyweight Workout	Increase Endurance	Holly Blumenberg	3	[2]	Full Body	Beginner	Male & Female	A fun and fast fitness challenge, this workout features a combination of calisthenics and bodyweight exercises, and is a great way to burn fat and build conditioning.	\N	0	4.90000000000000036	31	31	\N	\N	\N
290	Core, Strength And Fat Burn Workout	Lose Fat	Danial Kelly	6	[1, 2, 4, 7]	Full Body	Intermediate	Male & Female	Potent, powerful and anything but boring. This hardcore fat burning, strength and core building workout will leave you looking and feeling great.	\N	0	5	55	142	\N	\N	\N
291	Power Building Beginner Hill Sprint Workout Plan	General Fitness	Thomas Schultz	2	[13]	Cardio	Beginner	Male & Female	Go from slug to sprinting machine in only 8 short weeks. This workout plan is designed to help you build power, speed, endurance and burn fat too!	\N	0	5	5	7	\N	\N	\N
292	Kettlebell, Bodyweight And Treadmill Cardio Workout	Lose Fat	John Gormen	4	[2, 8, 7]	Cardio	Beginner	Male & Female	Forget boring cardio workouts! Blast away fat in only 15 minutes per day using only a treadmill, a kettlebell and simple bodyweight exercises.	\N	0	5	11	7	\N	\N	\N
293	The Bear Barbell Complex	Increase Endurance	Thomas Schultz	1	[1]	Full Body	Intermediate	Male & Female	The Bear Complex is an intense barbell complex circuit that can be used several times per week to help build strength and conditioning.	\N	0	4.59999999999999964	27	41	\N	\N	\N
296	12 Week Fat Destroyer: Complete Fat Loss Workout & Diet Program	Lose Fat	Max Riley	6	[1, 2, 3, 4, 8]	Full Body	Beginner	Male & Female	This is a complete 12 week program to help you get ripped. Feature includes detailed diet plan and cardio schedule, along with a 4 day upper/lower muscle building split.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/thumb.jpg	0	4.79999999999999982	135	143	\N	\N	\N
297	2 Day Intense Fat Loss & Muscle Tone Workout	Lose Fat	M&S Writers	2	[1, 2, 3, 4, 6, 5, 7]	Full Body	Intermediate	Male & Female	This intense 2 day full body workout is designed for decreasing fat and increasing muscle tone. This workout was put to the test, and after 4 weeks subjects lost body fat and gained muscle mass!	\N	0	5	271	213	\N	\N	\N
298	3 Day Whole Body Toning Workout	Build Muscle	M&S Writers	3	[1, 2, 3, 4, 5]	Full Body	Intermediate	Male & Female	3 day per week whole body toning workout designed for people who don't want to build up bulk but just want to tone and strengthen their muscles.	\N	0	5	417	477	\N	\N	\N
299	30 Minute Women's Toning Workout With Jenna Webb & Melanie Tillbrook	Lose Fat	M&S Team	3	[2, 3, 4, 5, 7]	Full Body	Beginner	Female	Short on time? MuscleTech athletes Jenna Webb and Melanie Tillbrook designed this quick 30 minute toning routine that works the full body.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/30min_routine_feature.jpg	0	4.09999999999999964	11	0	\N	\N	\N
300	300 Workout: The Rise Of A New You! A Plan To Get Muscular & Ripped	General Fitness	Brad Borland	4	[1, 2, 4, 8, 7]	Full Body	Beginner	Male & Female	Seize your glory by building a Spartan body. This feature presents three new workouts, including a powerful 4 day split designed to shred fat and build muscle.	\N	0	5	55	23	\N	\N	\N
301	4 Day Shred Cycle Fat Loss Workout	Lose Fat	Thomas Schultz	4	[1, 4, 5]	Split	Intermediate	Male & Female	Train insane 4 days a week. Combine your resistance training sessions with short bursts of cardio to maximize fat loss while maintaining existing muscle mass.	\N	0	4.59999999999999964	35	17	\N	\N	\N
303	2 Day Intense Fat Loss & Muscle Tone Workout	Lose Fat	M&S Writers	2	[1, 2, 3, 4, 6, 5, 7]	Full Body	Intermediate	Male & Female	This intense 2 day full body workout is designed for decreasing fat and increasing muscle tone. This workout was put to the test, and after 4 weeks subjects lost body fat and gained muscle mass!	\N	0	5	271	213	\N	\N	\N
304	3 Day Whole Body Toning Workout	Build Muscle	M&S Writers	3	[1, 2, 3, 4, 5]	Full Body	Intermediate	Male & Female	3 day per week whole body toning workout designed for people who don't want to build up bulk but just want to tone and strengthen their muscles.	\N	0	5	417	477	\N	\N	\N
305	30 Minute Women's Toning Workout With Jenna Webb & Melanie Tillbrook	Lose Fat	M&S Team	3	[2, 3, 4, 5, 7]	Full Body	Beginner	Female	Short on time? MuscleTech athletes Jenna Webb and Melanie Tillbrook designed this quick 30 minute toning routine that works the full body.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/30min_routine_feature.jpg	0	4.09999999999999964	11	0	\N	\N	\N
306	300 Workout: The Rise Of A New You! A Plan To Get Muscular & Ripped	General Fitness	Brad Borland	4	[1, 2, 4, 8, 7]	Full Body	Beginner	Male & Female	Seize your glory by building a Spartan body. This feature presents three new workouts, including a powerful 4 day split designed to shred fat and build muscle.	\N	0	5	55	23	\N	\N	\N
307	4 Day Shred Cycle Fat Loss Workout	Lose Fat	Thomas Schultz	4	[1, 4, 5]	Split	Intermediate	Male & Female	Train insane 4 days a week. Combine your resistance training sessions with short bursts of cardio to maximize fat loss while maintaining existing muscle mass.	\N	0	4.59999999999999964	35	17	\N	\N	\N
308	40 Minute Blast - Abs, Cardio And Resistance Workout	General Fitness	John Gormen	1	[2, 4]	Cardio	Beginner	Male & Female	A cardio, weights and abs workout perfect for those days when you need to do something fun at the gym. Simply grab a heavy and light set of dumbbells and go!	\N	0	4.90000000000000036	43	30	\N	\N	\N
309	5 Best 20 Minute HIIT Cardio Workouts For Rapid Fat Loss	Lose Fat	Brad Borland	2	[2, 8, 7]	Cardio	Beginner	Male & Female	You don't have to spend hours on cardio equipment to burn fat. Try one of these HIIT cardio routines for faster (and less boring!) fat loss.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiit-fat-loss-workouts.jpg	0	4.70000000000000018	3	9	\N	\N	\N
310	5 Fat Loss Workouts From Cory Gregory & MusclePharm	Lose Fat	Cory Gregory	3	[9, 1, 2, 4, 5, 7]	Cardio	Beginner	Male & Female	Cory Gregory from MusclePharm presents five unique and incredibly effective fat burning workout variations. Get off the treadmill and start burning more calories.	\N	0	5	6	2	\N	\N	\N
311	50 Rep Fat Loss HIIT Treadmill And Kettlebell Workout	Lose Fat	Ian Coleman	3	[2, 8]	Full Body	Beginner	Male & Female	Blast fat using only a kettlebell, bodyweight exercises and some HIIT treadmill sprinting. Exercises move along in a taxing 10 to 50 rep progression pattern.	\N	0	4.90000000000000036	23	16	\N	\N	\N
312	6 Day Weight/Cardio Cutting Workout	Lose Fat	M&S Writers	6	[1, 2, 3, 4, 6]	Split	Intermediate	Male & Female	A workout for people who have finished bulking and have excess fat to lose. It combines weight training with 3 days of cardio, and 1 day of rest.	\N	0	5	430	615	\N	\N	\N
313	6 Intense Treadmill Workouts To Get Shredded For Summer	Lose Fat	Coach Dustin Myers	4	[7]	Cardio	Beginner	Male & Female	Start conditioning your body and burn fat with these 6 effective treadmill workouts that are not only designed to be brutal, but to deliver results and get those muscles popping!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiit_treadmill_workouts_for_fat_loss.jpg	0	4.79999999999999982	18	7	\N	\N	\N
314	8 Minute Squat & Push-Up Tabata Workout For Fat Loss	Lose Fat	Brad Borland	3	[2, 4]	Cardio	Beginner	Male & Female	You can burn fat and get ripped in just 8 minutes with this high intensity Tabata circuit that combines push-ups and squats. \n 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/8-minute-tabata-squat-push-up-featured.jpg	0	4.5	4	17	\N	\N	\N
315	Build Core Strength! Coach Myers' Top 5 Exercises For Core Stability	Increase Strength	Coach Dustin Myers	3	[9, 2, 10]	Single Muscle Group	Intermediate	Male & Female	Coach Myers' is back at it and just in time to help you build your core for summer! Check out his top 5 core exercises and these progressive core workouts!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/core-stability-feature-1.jpg	0	4.40000000000000036	5	0	\N	\N	\N
316	Building The Beginner: Foundation For Muscle & Strength	Build Muscle	Team MuscleTech	5	[1, 2, 3, 4, 10, 8, 5, 11]	Split	Beginner	Male & Female	Building The Beginner is a 6 week program that lays the foundation for heavier lifting. A detailed training plan with instructional videos makes it easy to follow!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/building-the-beginner-featured.jpg	0	4.40000000000000036	8	1	\N	\N	\N
317	Building The Perfect Fat Burning Circuit	Lose Fat	Brad Borland	3	[2, 7]	Cardio	Beginner	Male & Female	Brad Borland presents a 5 element template that enables you to build your own effective fat blasting circuit workout. Benefits and example circuit workouts included.	\N	0	4.59999999999999964	5	3	\N	\N	\N
318	Cardio And Weights Workout	Lose Fat	Jeremy Wood	1	[1, 2]	Full Body	Beginner	Male & Female	The main goal of this workout is fat loss, but muscle building is possible as well. Great for both men and women. Cardio is HIIT style and incorporates sprinting.	\N	0	5	200	176	\N	\N	\N
319	Cardio Conditioning Workouts: More Fat Burning, Same Gym Time	Lose Fat	Brad Borland	3	[1, 2, 3, 4, 8, 7]	Cardio	Intermediate	Male & Female	Turn your resistance training workouts into muscle building and fat blasting sessions by integrating intense progression conditioning. 3 sample workouts are provided.	\N	0	5	10	12	\N	\N	\N
320	Coconut Cardio: An Early Morning Strategy to Get Super Shredded	Lose Fat	Coach Dustin Myers	7	[5, 11]	Cardio	Intermediate	Male & Female	Need a new and effective approach to your morning cardio? Check out Coach Dustin Myers' coconut cardio and get on the fast track to a shredded six pack!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/coconut-cardio-feature.jpg	0	5	4	13	\N	\N	\N
321	Conquering The Giant: Giant Set Workouts For Hypertrophy & Fat Loss	Build Muscle	Mike Samuels	3	[1, 2, 4]	Single Muscle Group	Intermediate	Male & Female	Learn how giant sets and density training can help ignite fat loss and spark new muscle growth. Feature includes sample push, pull, leg and fat burning workouts.	\N	0	5	19	12	\N	\N	\N
322	Core Strength Blueprint Workout v1.3 With Coach Myers	Increase Strength	Coach Dustin Myers	4	[2, 4, 10, 7]	Full Body	Intermediate	Male & Female	Use this 4-week core training plan that Coach Myers designed to help develop the core strength and stability needed to master more extreme core exercises.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/core_1-3_feature.jpg	0	4.5	6	0	\N	\N	\N
323	Core, Strength And Fat Burn Workout	Lose Fat	Danial Kelly	6	[1, 2, 4, 7]	Full Body	Intermediate	Male & Female	Potent, powerful and anything but boring. This hardcore fat burning, strength and core building workout will leave you looking and feeling great.	\N	0	5	55	142	\N	\N	\N
365	The Punisher: A Relentless Better Body Workout	Build Muscle	Eric Brown	1	[2, 4, 7]	Full Body	Intermediate	Male & Female	Eric Brown delivers a workout with a wallop. The Punisher is deceptively simple, comprised of 5 movements: walking lunges, bent-over rows, push ups, burpees and a sprint.	\N	0	5	44	51	\N	\N	\N
324	Cory Gregory's "Make Your Own Brick Soup" Ab Workout	Build Muscle	Cory Gregory	\N	[2, 7]	Single Muscle Group	Beginner	Male & Female	Get the secret ingredients for "Brick Soup" with this killer 4-week program in which MusclePharm's Cory Gregory reveals what he does to build and maintain his rock-solid abs! 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cory_gregory_ab_workout_1_0.jpg	0	3.79999999999999982	18	3	\N	\N	\N
325	CrossFit vs Weight Training: Which Gives Better Results?	Build Muscle	Team AML	3	[1, 2, 8]	Split	Intermediate	Male & Female	Traditional weightlifters and cross trainers don't see eye to eye on training. However, the best approach to training isn't as black & white as you may think.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/crossfit-feature_0.jpg	0	5	2	1	\N	\N	\N
326	Cut Like Cutler Trainer - Cycle 1	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 1 of the Cut Like Cutler trainer. Week 1 is Heavy training and Week 2 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_1.jpg	0	3.79999999999999982	17	8	\N	\N	\N
327	Cut Like Cutler Trainer - Cycle 2	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 2 of the Cut Like Cutler trainer. Week 3 is Heavy training and Week 4 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_2.jpg	0	4.29999999999999982	3	0	\N	\N	\N
328	Cut Like Cutler Trainer - Cycle 3	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 3 of the Cut Like Cutler trainer. Week 5 is Heavy training and Week 6 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_3.jpg	0	4.29999999999999982	3	1	\N	\N	\N
329	Cut Like Cutler Trainer - Cycle 4	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 4 of the Cut Like Cutler trainer. Week 7 is Heavy training and Week 8 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_4.jpg	0	0	0	0	\N	\N	\N
330	Cut Like Cutler Trainer - Cycle 5	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 5 of the Cut Like Cutler trainer. Week 9 is Heavy training and Week 10 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_5.jpg	0	5	3	0	\N	\N	\N
331	Cut Like Cutler Trainer - Cycle 6	Build Muscle	Team BPI	5	[1, 3, 4, 6, 5]	Split	Beginner	Male & Female	Follow the workout logs for Cycle 6 of the Cut Like Cutler trainer. Week 11 is Heavy training and Week 12 is more Moderate.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/cut_like_cutler_cycle_6.jpg	0	4	1	3	\N	\N	\N
332	Density Giant Set Training v2.0: Stronger And Leaner	Lose Fat	John Matulevich	4	[1, 2, 3, 4, 5]	Split	Intermediate	Male & Female	Get your body stronger and leaner with this two template updated version of the extremely popular Density Giant Set Training workout system.	\N	0	4.90000000000000036	34	88	\N	\N	\N
333	Density Giant Set Training: Maintain Muscle During Fat Loss 	Lose Fat	John Matulevich	3	[1, 2, 4, 11]	Split	Intermediate	Male & Female	The density set training system is a perfect workout for someone looking to drop fat, hold on to muscle, and train hard and heavy. Each session is brief and intense, but extremely effective!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/shredded-man-abs-fat-loss.jpg	0	5	195	432	\N	\N	\N
334	Density Training For Fat Loss: No Cardio Required	Lose Fat	Brad Borland	2	[1, 2, 4, 6, 7]	Split	Beginner	Male & Female	Looking to torch fat but tired of boring cardio sessions? Try density training. This article features intense 20, 30 and 40 minutes twice a week fat loss workout sessions.	\N	0	4.90000000000000036	79	63	\N	\N	\N
335	Doug's 5 Day High Definition Routine	Build Muscle	Doug Lawrenson	5	[1, 2, 3, 4, 5]	Split	Intermediate	Male & Female	This 5 day routine is designed to retain muscle mass while stripping fat! It's a mixture of cardio and weight training.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/def800.jpg	0	4.90000000000000036	960	1800	\N	\N	\N
336	Doug's 6 Day Cutting Routine	Lose Fat	Doug Lawrenson	6	[1, 2, 3, 4, 6, 5]	Split	Advanced	Male & Female	This intense cutting routine hits each muscle group twice a week on a 3 days on, 1 day off schedule. Use this routine to burn fat and get ripped!	\N	0	4.90000000000000036	599	1100	\N	\N	\N
337	Doug's Mega Cutting Routine	Lose Fat	Doug Lawrenson	4	[1, 2, 3, 4, 6]	Split	Intermediate	Male & Female	Doug's mega cutting workout routine is a 4 day split combining weights and cardio designed to lose fat while maintaining muscle mass.	\N	0	4.90000000000000036	221	291	\N	\N	\N
338	Doug's Super Shredding Routine	Lose Fat	Doug Lawrenson	5	[1, 3, 4, 6, 5]	Split	Intermediate	Male & Female	Super shedding routine designed for muscle definition, muscle shaping and fat loss! Hit muscles hard with this ultra slow rep timing!	\N	0	5	167	357	\N	\N	\N
339	Dumbbell & Bodyweight HIIT Workout: A Real Calorie Burner	Lose Fat	Holly Blumenberg	1	[2, 4]	Cardio	Beginner	Male & Female	Torch through calories with this partner-based cardio workout. A series of 12 exercises are performed in a back and forth manner, adding reps with each set.	\N	0	5	31	4	\N	\N	\N
340	Extreme 6 Day Barbell & Bodyweight Conditioning Workout	Increase Endurance	Max Riley	6	[1, 2]	Split	Beginner	Male & Female	You've found the motivation to hit the gym hard. What to do next? Try this extreme program that combines walking, muscle building and complex conditioning workouts.	\N	0	4.90000000000000036	31	12	\N	\N	\N
341	Fast & Furious: 21 Day Shredding Workout Cycle And Diet	Lose Fat	Ian Coleman	4	[1, 2, 3, 4, 6, 5]	Full Body	Intermediate	Male & Female	This 3 week fat burning cycle focuses on low-carb food choices and hardcore workouts that restrict rest between sets, finishing with intense 15 minute cardio sessions.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/21_feature.jpg	0	4.59999999999999964	94	241	\N	\N	\N
342	Fast 21 Workout: 3 Weeks To A Lean & Shredded Physique	Build Muscle	Team BPI	6	[9, 1, 2, 3, 4, 5, 7]	Split	Intermediate	Male & Female	The Fast 21 Workout Program is designed to ensure maximum fat loss while gaining lean muscle, all within 3 weeks!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/fast21-header.jpg	0	4.20000000000000018	20	77	\N	\N	\N
343	Fat Blasting Finishers: Add These to the End of Your Workout	Lose Fat	Brad Borland	3	[2, 7]	Full Body	Beginner	Male & Female	Get one step closer to your ideal physique with these fat-blasters designed to be added onto your existing routine to help maximize fat-burning!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/bsn_fatblaster_1.jpg	0	4.29999999999999982	8	5	\N	\N	\N
344	Full Body Dumbbell Strength Workout For Women	General Fitness	Holly Blumenberg	1	[2, 4]	Full Body	Beginner	Female	This dumbbell workout is a metabolic conditioning session as well as a strength workout. If you're getting bored with your current workout, give this fun routine a try.	\N	0	4.90000000000000036	34	8	\N	\N	\N
345	Get Ripped in 8 Weeks! HIET Fat Loss Workout & Nutrition Program	Lose Fat	Team AML	6	[1, 2, 3, 4, 6, 10, 5]	Split	Intermediate	Male & Female	Step your game up and get shredded for summer with this 8 week workout! Combine HIET and HIIT to accelerate your results and get shredded for the beach!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hiet-feature1.jpg	0	3.39999999999999991	11	12	\N	\N	\N
346	Get Ripped With Supersets & Giant Sets	Lose Fat	Brad Borland	4	[1, 2, 3, 4, 7]	Split	Beginner	Male	This 4 day workout program from bodybuilder Brad Borland utilizes supersets, giant sets and restricted rest to shred fat. Sample 2100 calorie per day eating plan is included.	\N	0	4.79999999999999982	13	16	\N	\N	\N
347	Get Shredded For The New Year: 21-Day Fat Loss Workout	Lose Fat	Coach Dustin Myers	7	[1, 3, 4, 11, 7]	Full Body	Beginner	Male & Female	If your physique isn't where you want it to be, start your New Year off right with this intense 21-day fat loss workout from Coach Dustin Myers.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/new-year-fat-loss.jpg	0	5	43	9	\N	\N	\N
348	Hugh Jackman's Workout: Strong, Lean & Powerful	Build Muscle	Luke Atchley	4	[1, 2, 3, 4, 5, 11]	Split	Beginner	Male	Get ripped like Wolverine by applying the same underlying training principles Hugh Jackman did while working out in preparation for his role on the big screen.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/hugh_jackman_wolverine_body_workout_0.jpg	0	4.40000000000000036	11	20	\N	\N	\N
349	Intense Super Shred: 40 Minute Fat Blast Workout	Lose Fat	L.J. Walker	4	[2, 4]	Split	Beginner	Male & Female	These fast-paced 40 minute calorie-burning sessions will help you to incinerate body fat and get shredded using a combination of interval training and muscle building exercises.	\N	0	4.90000000000000036	53	34	\N	\N	\N
350	Intense Superset Chest & Biceps Workout With Joe Donnelly	Build Muscle	M&S Team	1	[9, 2, 4]	Single Muscle Group	Intermediate	Male & Female	Looking to burn fat and build muscle, all while never stepping foot on the cardio deck? Try out Joe Donnelly's high intensity resistance training!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/joe-donnelly-feature-image.jpg	0	4.5	4	1	\N	\N	\N
351	Jai Courtney Workout: How Jai Got Swole for Terminator Genisys	Lose Fat	Brad Borland	4	[2, 4, 7]	Full Body	Beginner	Male	Are you ripped enough to fight for humanity? Follow this 6 week program based on Jai Courtney's training principles to get shredded like Kyle Reese!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/jai-courtney-workout-terminator-genisys-featured.jpg	0	4.5	6	7	\N	\N	\N
352	Jen Jewell's Summer Countdown: Burn Fat & Build A Bikini Booty	Lose Fat	Jen Jewell	4	[1, 2, 4, 10]	Full Body	Beginner	Female	The time to sculpt your summer body is now! Get lean, healthy, and strong with Jen Jewell's Summer Countdown Workout that combines strength training with cardio bursts for maximum fat loss.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/jen-jewell-summer-countdown-featured.jpg	0	3.5	8	4	\N	\N	\N
353	Kettlebell Cardio Complex To Smoke Fat And Improve Conditioning	Lose Fat	Arnav Sarkar	1	[8]	Cardio	Beginner	Male & Female	This 4 exercise kettlebell complex and circuit is performed for a total of 4 rounds. You can use this workout 1-3 times per week to burn fat or improve conditioning.	\N	0	4.90000000000000036	15	1	\N	\N	\N
354	Kickbox Your Way To Fit With Francisca Dennis	General Fitness	Team FitMiss	3	[7]	Full Body	Beginner	Female	Mix things up a few times a week by putting on the mitts and incorporating some fun kickboxing to relieve some stress and burn a ton of calories at the same time!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/francisca_dennis_kickboxing.jpg	0	4.29999999999999982	6	0	\N	\N	\N
355	Love Handle Workouts: 5 Routines That Torch Unwanted Fat	Lose Fat	Brad Borland	3	[2, 4, 8]	Full Body	Beginner	Male & Female	Stuck with some extra holiday flab? Burn it off faster by tackling these intense fat burning workouts. Includes workouts for a variety of different equipment.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/love-handle-workouts.jpg	0	4.79999999999999982	52	5	\N	\N	\N
356	Muscle & Strength's 30 Day Workout Plan For Women	Build Muscle	Brad Borland	6	[1, 2, 4, 7]	Full Body	Beginner	Female	Looking for the best place to start working towards a leaner, solid, and stronger body? This thorough workout routine is specifically designed to get you there!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/complete_full_body_womens_workout_routine.jpg	0	4.20000000000000018	14	40	\N	\N	\N
357	MusclePharm Combo Fat Burner Workout	Lose Fat	Cory Gregory	1	[9, 1, 2, 4, 6, 5, 7]	Cardio	Beginner	Male & Female	This fat blasting workout from Cory Gregory and MusclePharm utilizes 4 minute blocks comprised of jumping rope and timed resistance training exercises.	\N	0	5	12	3	\N	\N	\N
358	MusclePharm Squats And 1/2 Mile Run Fat Burning Workout	Lose Fat	Cory Gregory	1	[1, 2]	Cardio	Beginner	Male & Female	This fat burning workout from MusclePharm is such to leave you drenched in sweat and gasping for air.	\N	0	4.79999999999999982	13	6	\N	\N	\N
359	No Kettlebell, No Problem - Dumbbell HIIT Workout	Lose Fat	Holly Blumenberg	2	[4]	Cardio	Beginner	Male & Female	You don't need the latest craze to get in a good high intensity, fat burning workout. No kettlebell, no problem! All you need for this cardio workout is a set of dumbbells.	\N	0	5	23	19	\N	\N	\N
360	Playground Workouts: Having Fun While Building the Body You Want	Lose Fat	Brad Borland	3	[2]	Split	Beginner	Male & Female	Does work have you trapped indoors all day? Enjoy the sunshine by taking your training to the great outdoors with this playground workout routine!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/playground-feature.jpg	0	5	3	1	\N	\N	\N
361	Short on Time? Try This Tabata Workout for Fat Loss	Lose Fat	Charlotte Oldbury	3	[2, 4]	Full Body	Beginner	Female	Is being short on time or traveling for work limiting your precious workout time? Fear no more! This Tabata Workout will burn fat in less than an hour!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/tabata-feature.jpg	0	3.39999999999999991	7	0	\N	\N	\N
362	Shredded by Summer: 8 Weeks to Your Best Body Ever	Lose Fat	Eric Bach	3	[9, 1, 3, 8, 11]	Split	Intermediate	Male & Female	It's time to get serious about your summer body. This 8 week workout and nutrition plan will help you get shredded for this years summer vacation.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/8-weeks-to-shred-feature.jpg	0	5	2	0	\N	\N	\N
363	The 15 Minute Total Body Beatdown	Build Muscle	Coach Dustin Myers	1	[1]	Full Body	Intermediate	Male & Female	Got 15 minutes? Then you have time to add Time Frame Training to your routine for a short but intense total body muscle building workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/15-minute-total-body-beatdown.jpg	0	5	2	1	\N	\N	\N
364	The Punisher Vol. II: A Ruthless Full Body Fat Burning Workout	Build Muscle	Eric Brown	2	[8]	Full Body	Intermediate	Male & Female	Do you have what it takes? Eric Brown's twist on his Punisher workout takes simple kettlebell moves and turns them into an intense total body workout.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/the-punisher-workout.jpg	0	4.5	11	0	\N	\N	\N
366	The Ripped Freak Training Program	Build Muscle	Alex Savva	5	[1, 2, 3, 4, 5]	Full Body	Intermediate	Male & Female	Get the most out of your workout with the The Ripped Freak Training Program and 5-Minute Ripped Solution, designed to help you maximize muscle growth, increase performance, and burn fat! 	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/doing_barbell_curls_for_the_ripped_freak_program.jpg	0	4.59999999999999964	9	52	\N	\N	\N
367	The Squeeze Method For Building A Big Defined Chest	Build Muscle	M&S Team	1	[4, 5]	Single Muscle Group	Intermediate	Male & Female	The Muscle & Strength team travels to Columbus, OH and learns about the squeeze method from MuscleTech Athlete, Santi Aragon. Give this method a shot!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/squeeze-method-feature.jpg	0	5	1	0	\N	\N	\N
368	The Ultimate 20 Minute Treadmill Workout to Get Shredded	Lose Fat	Coach Dustin Myers	3	[2]	Cardio	Beginner	Male & Female	Tired of those drawn-out cardio sessions that steal your pump? Try out Coach Myers' Pump & Run workout that'll help you shred without losing your pump!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/pump-and-run-feature.jpg	0	3.20000000000000018	9	4	\N	\N	\N
369	Total Body Beatdown: A German Volume Training Routine	Build Muscle	Coach Dustin Myers	3	[1, 2, 3, 4, 5]	Full Body	Intermediate	Male & Female	Whether you only have time to make it to the gym a few times during the week or you want to annihilate your entire body, we've got the workout for you!	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/gvt-feature.jpg	0	4.59999999999999964	10	3	\N	\N	\N
370	Training for the Older Athlete: Making Gains After 40	Build Muscle	Brad Borland	4	[1, 2, 3, 4]	Split	Beginner	Male & Female	They say Father Time is undefeated, but that doesn't mean you can't make gains all of your life. Check out these training strategies for older athletes.	https://cdn.muscleandstrength.com/sites/default/files/field/feature-image/workout/older-athlete-new-feature.jpg	0	4.5	6	0	\N	\N	\N
371	Your Complete Blue Print For A Leaner, More Muscular Body	Build Muscle	Brad Borland	3	[1, 2, 4]	Split	Beginner	Male & Female	Life getting in the way of consistent training? Brad Borland presents a flexible system that allows you to workout, 2-4 times per week depending on your schedule.	\N	0	4.79999999999999982	38	6	\N	\N	\N
\.


--
-- Name: fitness_program_p_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fitstr
--

SELECT pg_catalog.setval('fitness_program_p_id_seq', 371, true);


--
-- Data for Name: user_fitness; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY user_fitness (u_id, current_fitness, experience, fit_goal, days_available, busy_days, gym_type, eq_id) FROM stdin;
\.


--
-- Data for Name: user_injury; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY user_injury (u_id, bp_id) FROM stdin;
\.


--
-- Data for Name: user_preference; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY user_preference (u_id, ex_id, pref) FROM stdin;
\.


--
-- Data for Name: user_progress_cardio; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY user_progress_cardio (u_id, ex_id, times, speed, distance) FROM stdin;
\.


--
-- Data for Name: user_progress_weight; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY user_progress_weight (u_id, ex_id, weights, sets, reps) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: fitstr
--

COPY users (u_id, uname, weight, height, gender, age, location) FROM stdin;
\.


--
-- Name: users_u_id_seq; Type: SEQUENCE SET; Schema: public; Owner: fitstr
--

SELECT pg_catalog.setval('users_u_id_seq', 1, false);


--
-- Name: body_part_pkey; Type: CONSTRAINT; Schema: public; Owner: fitstr; Tablespace: 
--

ALTER TABLE ONLY body_part
    ADD CONSTRAINT body_part_pkey PRIMARY KEY (bp_id);


--
-- Name: data_source_pkey; Type: CONSTRAINT; Schema: public; Owner: fitstr; Tablespace: 
--

ALTER TABLE ONLY data_source
    ADD CONSTRAINT data_source_pkey PRIMARY KEY (s_id);


--
-- Name: equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: fitstr; Tablespace: 
--

ALTER TABLE ONLY equipment
    ADD CONSTRAINT equipment_pkey PRIMARY KEY (eq_id);


--
-- Name: exercise_pkey; Type: CONSTRAINT; Schema: public; Owner: fitstr; Tablespace: 
--

ALTER TABLE ONLY exercise
    ADD CONSTRAINT exercise_pkey PRIMARY KEY (ex_id);


--
-- Name: fitness_program_pkey; Type: CONSTRAINT; Schema: public; Owner: fitstr; Tablespace: 
--

ALTER TABLE ONLY fitness_program
    ADD CONSTRAINT fitness_program_pkey PRIMARY KEY (p_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: fitstr; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (u_id);


--
-- Name: exercise_injured_bp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY exercise_injured
    ADD CONSTRAINT exercise_injured_bp_id_fkey FOREIGN KEY (bp_id) REFERENCES body_part(bp_id);


--
-- Name: exercise_injured_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY exercise_injured
    ADD CONSTRAINT exercise_injured_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: user_fitness_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_fitness
    ADD CONSTRAINT user_fitness_u_id_fkey FOREIGN KEY (u_id) REFERENCES users(u_id);


--
-- Name: user_injury_bp_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_injury
    ADD CONSTRAINT user_injury_bp_id_fkey FOREIGN KEY (bp_id) REFERENCES body_part(bp_id);


--
-- Name: user_injury_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_injury
    ADD CONSTRAINT user_injury_u_id_fkey FOREIGN KEY (u_id) REFERENCES users(u_id);


--
-- Name: user_preference_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_preference
    ADD CONSTRAINT user_preference_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: user_preference_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_preference
    ADD CONSTRAINT user_preference_u_id_fkey FOREIGN KEY (u_id) REFERENCES users(u_id);


--
-- Name: user_progress_cardio_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_progress_cardio
    ADD CONSTRAINT user_progress_cardio_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: user_progress_cardio_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_progress_cardio
    ADD CONSTRAINT user_progress_cardio_u_id_fkey FOREIGN KEY (u_id) REFERENCES users(u_id);


--
-- Name: user_progress_weight_ex_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_progress_weight
    ADD CONSTRAINT user_progress_weight_ex_id_fkey FOREIGN KEY (ex_id) REFERENCES exercise(ex_id);


--
-- Name: user_progress_weight_u_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: fitstr
--

ALTER TABLE ONLY user_progress_weight
    ADD CONSTRAINT user_progress_weight_u_id_fkey FOREIGN KEY (u_id) REFERENCES users(u_id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

