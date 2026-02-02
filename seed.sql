-- SEED DATA
-- 1. Categories
insert into categories (name) values ('Cardio'), ('Strength'), ('Yoga'), ('HIIT'), ('CrossFit');

-- 2. Instructors
insert into instructors (name, rating, bio) values 
('Coach Sarah', 4.9, 'Expert in HIIT and functional training.'),
('Coach Mike', 4.8, 'Certified CrossFit level 3 instructor.'),
('Elena Zen', 5.0, 'Global yoga master with 10 years experience.');

-- 3. Classes
do $$
declare
    cat_cardio uuid;
    cat_strength uuid;
    cat_yoga uuid;
    cat_hiit uuid;
    cat_crossfit uuid;
    inst_sarah uuid;
    inst_mike uuid;
    inst_elena uuid;
begin
    select id into cat_cardio from categories where name = 'Cardio';
    select id into cat_strength from categories where name = 'Strength';
    select id into cat_yoga from categories where name = 'Yoga';
    select id into cat_hiit from categories where name = 'HIIT';
    select id into cat_crossfit from categories where name = 'CrossFit';
    
    select id into inst_sarah from instructors where name = 'Coach Sarah';
    select id into inst_mike from instructors where name = 'Coach Mike';
    select id into inst_elena from instructors where name = 'Elena Zen';

    -- Insert Classes
    insert into classes (name, description, category_id, intensity, duration_minutes) values
    ('HIIT Advanced', 'High intensity interval training for pros.', cat_hiit, 'High', 45),
    ('CrossFit WOD', 'Work of the day - functional movement.', cat_crossfit, 'High', 60),
    ('Power Yoga', 'Serenity through strength.', cat_yoga, 'Medium', 45),
    ('Spin Cycle', 'Pure cardio energy.', cat_cardio, 'Medium', 50);

    -- Insert Schedules for the next few days
    insert into class_schedules (class_id, instructor_id, start_time, end_time, capacity, location_name) values
    ((select id from classes where name = 'HIIT Advanced'), inst_sarah, now() + interval '5 hours', now() + interval '5 hours 45 minutes', 20, 'Studio A'),
    ((select id from classes where name = 'CrossFit WOD'), inst_mike, now() + interval '1 day', now() + interval '1 day 1 hour', 15, 'Main Box'),
    ((select id from classes where name = 'Power Yoga'), inst_elena, now() + interval '2 hours', now() + interval '2 hours 45 minutes', 25, 'Zen Room'),
    ((select id from classes where name = 'Spin Cycle'), inst_sarah, now() + interval '8 hours', now() + interval '8 hours 50 minutes', 18, 'Cycle Studio');
end $$;
