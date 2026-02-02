const https = require('https');

const token = 'sbp_03a43acd9a88a9861bd24ae6a7b020e1097aadc9';
const projectRef = 'sbljtekgogrkelfhxtxq';
const sql = `
-- 1. EXTENSIONES Y TIPOS PERSONALIZADOS
create type user_role as enum ('admin', 'client');
create type booking_status as enum ('confirmed', 'waitlist', 'cancelled');
create type class_intensity as enum ('Low', 'Medium', 'High');

-- 2. TABLA DE PERFILES
create table profiles (
  id uuid references auth.users on delete cascade primary key,
  full_name text,
  avatar_url text,
  role user_role default 'client'::user_role,
  updated_at timestamp with time zone default timezone('utc'::text, now())
);

-- 3. CATEGORÍAS
create table categories (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  icon_url text
);

-- 4. INSTRUCTORES
create table instructors (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  avatar_url text,
  bio text,
  rating numeric(3,2) default 5.0
);

-- 5. CLASES
create table classes (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  description text,
  image_url text,
  category_id uuid references categories(id),
  intensity class_intensity default 'Medium',
  duration_minutes integer not null,
  base_price numeric(10,2) default 0.00
);

-- 6. HORARIOS
create table class_schedules (
  id uuid default gen_random_uuid() primary key,
  class_id uuid references classes(id) on delete cascade,
  instructor_id uuid references instructors(id),
  start_time timestamp with time zone not null,
  end_time timestamp with time zone not null,
  capacity integer not null,
  location_name text,
  is_live boolean default false
);

-- 7. RESERVAS
create table bookings (
  id uuid default gen_random_uuid() primary key,
  user_id uuid references profiles(id) on delete cascade,
  schedule_id uuid references class_schedules(id) on delete cascade,
  status booking_status default 'confirmed',
  is_present boolean default false,
  created_at timestamp with time zone default timezone('utc'::text, now()),
  unique(user_id, schedule_id)
);

-- 8. MENSAJES
create table messages (
  id uuid default gen_random_uuid() primary key,
  sender_id uuid references profiles(id),
  subject text,
  content text,
  is_read boolean default false,
  category text,
  created_at timestamp with time zone default timezone('utc'::text, now())
);
`;

const data = JSON.stringify({ query: sql });

const options = {
    hostname: 'api.supabase.com',
    port: 443,
    path: `/v1/projects/${projectRef}/query`,
    method: 'POST',
    headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
        'Content-Length': data.length
    }
};

const req = https.request(options, (res) => {
    console.log(`Status: ${res.statusCode}`);
    res.on('data', (d) => {
        process.stdout.write(d);
    });
});

req.on('error', (e) => {
    console.error(e);
});

req.write(data);
req.end();
