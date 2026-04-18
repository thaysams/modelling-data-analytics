# CineTrack: Independent Film Festival Database
# Students: Enrique Bruno da Costa Soares & Thaysa Mendes da Silva
# Module: Modelling for Data Analytics - ANL410
# Insert data statements

USE cinetrack;

#. FILMS  

INSERT INTO films (title, genre, duration_min, release_year, country, synopsis) VALUES
('The Last Signal',     'Sci-Fi',       92,  2024, 'Brazil',   'A radio astronomer intercepts a mysterious signal that reshapes humanity\'s understanding of existence.'),
('Vidas Cruzadas',      'Drama',        105, 2023, 'Portugal', 'Three strangers in Lisbon discover their fates are linked by a single forgotten letter from the 1970s.'),
('Desert Bloom',        'Documentary',  78,  2024, 'Morocco',  'A portrait of Saharan women who transformed arid land into thriving community gardens over two decades.'),
('Neon Solitude',       'Thriller',     88,  2023, 'Japan',    'A forensic accountant uncovers a billion-dollar fraud hidden inside Tokyo\'s neon-lit night economy.'),
('The Forgotten Shore', 'Drama',        110, 2024, 'Ireland',  'A fisherman returns to his coastal hometown after 20 years, confronting secrets buried beneath the tides.'),
('Circo de Sonhos',     'Animation',    82,  2024, 'Brazil',   'A young girl discovers a magical travelling circus that only appears in dreams, blending folklore and wonder.');

# DIRECTORS  
# Lucas Ferreira (id=1) directs films 1 AND 6 as we will use this to demonstrate the HAVING query (>1 accepted film).

INSERT INTO directors (first_name, last_name, nationality, email) VALUES
('Lucas',    'Ferreira',  'Brazilian',  'lucas.ferreira@cinemail.com'),
('Ana',      'Lima',      'Portuguese', 'ana.lima@cinemail.com'),
('Fatima',   'Okafor',    'Moroccan',   'fatima.okafor@cinemail.com'),
('Kenji',    'Tanaka',    'Japanese',   'kenji.tanaka@cinemail.com'),
('Siobhan',  'Murphy',    'Irish',      'siobhan.murphy@cinemail.com'),
('Rafael',   'Sousa',     'Brazilian',  'rafael.sousa@cinemail.com');

# FILM_DIRECTOR  (Film 6 has to 2 directors on porpose to demonstrate relationships)

INSERT INTO film_director (film_id, director_id) VALUES
(1, 1),   -- The Last Signal       → Lucas Ferreira
(2, 2),   -- Vidas Cruzadas        → Ana Lima
(3, 3),   -- Desert Bloom          → Fatima Okafor
(4, 4),   -- Neon Solitude         → Kenji Tanaka
(5, 5),   -- The Forgotten Shore   → Siobhan Murphy
(6, 1),   -- Circo de Sonhos       → Lucas Ferreira (co-director)
(6, 6);   -- Circo de Sonhos       → Rafael Sousa   (co-director)

# SUBMISSIONS 
# Films 1,2,3,4,6 = Accepted | Film 5 = Rejected

INSERT INTO submissions (film_id, submission_date, status, submission_fee) VALUES
(1, '2024-01-10', 'Accepted',  75.00),
(2, '2024-01-15', 'Accepted',  75.00),
(3, '2024-01-18', 'Accepted',  50.00),
(4, '2024-01-20', 'Accepted',  75.00),
(5, '2024-01-22', 'Rejected',  75.00),
(6, '2024-01-25', 'Accepted',  50.00);

# JUDGES 

INSERT INTO judges (first_name, last_name, expertise, email) VALUES
('Maria',   'Chen',    'Narrative Cinema',     'maria.chen@festival.org'),
('James',   'O\'Brien', 'Documentary Film',    'james.obrien@festival.org'),
('Priya',   'Nair',    'Animation & VFX',      'priya.nair@festival.org'),
('Stefan',  'Müller',  'International Cinema', 'stefan.muller@festival.org');

# JUDGE_SCORES

INSERT INTO judge_scores (film_id, judge_id, score, comments, scored_at) VALUES
# Film 1: The Last Signal (avg 9.23 – highest)
(1, 1, 9.50, 'Exceptional world-building and emotional depth.',           '2024-03-05 10:00:00'),
(1, 2, 9.00, 'Original premise, tight pacing throughout.',               '2024-03-05 11:30:00'),
(1, 4, 9.20, 'A rare sci-fi that prioritises character over spectacle.',  '2024-03-05 14:00:00'),

# Film 2: Vidas Cruzadas (avg 8.33)
(2, 1, 8.50, 'Beautiful cinematography; some pacing issues mid-act.',     '2024-03-06 10:00:00'),
(2, 3, 8.00, 'Strong performances and authentic Lisbon atmosphere.',      '2024-03-06 11:00:00'),
(2, 4, 8.50, 'The non-linear structure rewards patient viewers.',         '2024-03-06 14:00:00'),

# Film 3: Desert Bloom (avg 8.17)
(3, 1, 7.80, 'Important subject told with warmth and respect.',           '2024-03-07 10:00:00'),
(3, 2, 8.50, 'Visually stunning; strong use of archival footage.',        '2024-03-07 11:30:00'),
(3, 4, 8.20, 'Could benefit from a tighter edit in the final third.',     '2024-03-07 13:00:00'),

# Film 4: Neon Solitude (avg 7.87)
(4, 1, 8.00, 'Slick thriller with outstanding production design.',        '2024-03-08 10:00:00'),
(4, 2, 7.50, 'Genre mechanics are solid; character depth is thinner.',    '2024-03-08 11:00:00'),
(4, 4, 8.10, 'The Tokyo night palette is unforgettable.',                 '2024-03-08 14:00:00'),

# Film 6: Circo de Sonhos (avg 8.83)
(6, 1, 8.80, 'Gorgeous animation; a deeply imaginative debut.',           '2024-03-09 10:00:00'),
(6, 3, 9.20, 'World-class animation quality; folklore is well-handled.',  '2024-03-09 11:30:00'),
(6, 4, 8.50, 'The emotional payoff in the final act is truly moving.',    '2024-03-09 14:00:00');

# VENUES 

INSERT INTO venues (name, city, capacity, address) VALUES
('Grand Cinema Hall',  'Dublin', 500, '14 Parnell Square, Dublin 1'),
('Studio Screen',      'Cork',   150, '8 Lavitt\'s Quay, Cork City'),
('Open Air Theatre',   'Galway', 800, 'Eyre Square, Galway City'),
('The Arthouse',       'Dublin', 200, '6 Temple Bar, Dublin 2');

# SCREENINGS - multiple films & venues)
# Grand Cinema Hall hosts the most (4) – relevant for Q3 HAVING.

INSERT INTO screenings (film_id, venue_id, screening_date, screening_time) VALUES
(1, 1, '2024-03-15', '18:00:00'),   -- The Last Signal    @ Grand Cinema Hall
(1, 4, '2024-03-17', '20:30:00'),   -- The Last Signal    @ The Arthouse
(2, 1, '2024-03-15', '20:30:00'),   -- Vidas Cruzadas     @ Grand Cinema Hall
(2, 3, '2024-03-16', '19:00:00'),   -- Vidas Cruzadas     @ Open Air Theatre
(3, 2, '2024-03-16', '14:00:00'),   -- Desert Bloom       @ Studio Screen
(3, 3, '2024-03-18', '17:00:00'),   -- Desert Bloom       @ Open Air Theatre
(4, 1, '2024-03-17', '19:00:00'),   -- Neon Solitude      @ Grand Cinema Hall
(4, 2, '2024-03-19', '20:00:00'),   -- Neon Solitude      @ Studio Screen
(6, 1, '2024-03-18', '15:00:00'),   -- Circo de Sonhos    @ Grand Cinema Hall
(6, 4, '2024-03-20', '16:00:00');   -- Circo de Sonhos    @ The Arthouse

# AWARDS

INSERT INTO awards (film_id, award_name, category, awarded_date) VALUES
(1, 'Best Film',             'Grand Jury',       '2024-03-21'),
(3, 'Best Documentary',      'Documentary',      '2024-03-21'),
(6, 'Best Debut Director',   'Direction',        '2024-03-21'),
(2, 'Audience Choice Award', 'Audience Vote',    '2024-03-21');