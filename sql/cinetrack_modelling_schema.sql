# CineTrack: Independent Film Festival Database
# Students: Enrique Bruno da Costa Soares & Thaysa Mendes da Silva
# Module: Modelling for Data Analytics - ANL410

CREATE DATABASE IF NOT EXISTS cinetrack;
USE cinetrack;

# 1. FILMS - Core entity representing each submitted film.

CREATE TABLE IF NOT EXISTS films (
    film_id       INT            AUTO_INCREMENT PRIMARY KEY,
    title         VARCHAR(255)   NOT NULL,
    genre         VARCHAR(100)   NOT NULL,
    duration_min  INT            NOT NULL,
    release_year  YEAR           NOT NULL,
    country       VARCHAR(100)   NOT NULL,
    synopsis      TEXT
);

# 2. DIRECTORS - Independent entity linked to films via film_director.

CREATE TABLE IF NOT EXISTS directors (
    director_id  INT           AUTO_INCREMENT PRIMARY KEY,
    first_name   VARCHAR(100)  NOT NULL,
    last_name    VARCHAR(100)  NOT NULL,
    nationality  VARCHAR(100),
    email        VARCHAR(255)  NOT NULL UNIQUE
);

# 3. FILM_DIRECTOR - A film may have many directors, and a director may have many films.

CREATE TABLE IF NOT EXISTS film_director (
    film_id      INT  NOT NULL,
    director_id  INT  NOT NULL,
    PRIMARY KEY (film_id, director_id),
    CONSTRAINT fk_fd_film     FOREIGN KEY (film_id)     REFERENCES films(film_id),
    CONSTRAINT fk_fd_director FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

# 4. SUBMISSIONS - Each submission ties one film to the festival and submission is related to only one film.

CREATE TABLE IF NOT EXISTS submissions (
    submission_id    INT            AUTO_INCREMENT PRIMARY KEY,
    film_id          INT            NOT NULL,
    submission_date  DATE           NOT NULL,
    status           ENUM('Pending','Accepted','Rejected') NOT NULL DEFAULT 'Pending',
    submission_fee   DECIMAL(8,2)   NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_sub_film FOREIGN KEY (film_id) REFERENCES films(film_id)
);

# 5. JUDGES - Independent entity, evaluates films via judge_scores.

CREATE TABLE IF NOT EXISTS judges (
    judge_id   INT           AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100)  NOT NULL,
    last_name  VARCHAR(100)  NOT NULL,
    expertise  VARCHAR(150),
    email      VARCHAR(255)  NOT NULL UNIQUE
);

# 6. JUDGE_SCORES - a film may have many evaluations by judges, judge's score is related to only one film and one judge.
# UNIQUE constraint on (judge_id, film_id) ensures one score per judge per film.

CREATE TABLE IF NOT EXISTS judge_scores (
    score_id    INT             AUTO_INCREMENT PRIMARY KEY,
    film_id     INT             NOT NULL,
    judge_id    INT             NOT NULL,
    score       DECIMAL(4,2)    NOT NULL,   -- range 0.00 – 10.00
    comments    TEXT,
    scored_at   DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_judge_film  UNIQUE (judge_id, film_id),
    CONSTRAINT chk_score      CHECK  (score >= 0 AND score <= 10),
    CONSTRAINT fk_js_film     FOREIGN KEY (film_id)  REFERENCES films(film_id),
    CONSTRAINT fk_js_judge    FOREIGN KEY (judge_id) REFERENCES judges(judge_id)
);

# 7. VENUES - Locations where screenings are held.

CREATE TABLE IF NOT EXISTS venues (
    venue_id  INT           AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(255)  NOT NULL,
    city      VARCHAR(100)  NOT NULL,
    capacity  INT           NOT NULL,
    address   VARCHAR(255)
);

# 8. SCREENINGS - A venue may have many screenings, a screening is at one venue.
# A film may have many screenings and a screening is of one film.

CREATE TABLE IF NOT EXISTS screenings (
    screening_id    INT   AUTO_INCREMENT PRIMARY KEY,
    film_id         INT   NOT NULL,
    venue_id        INT   NOT NULL,
    screening_date  DATE  NOT NULL,
    screening_time  TIME  NOT NULL,
    CONSTRAINT fk_scr_film  FOREIGN KEY (film_id)  REFERENCES films(film_id),
    CONSTRAINT fk_scr_venue FOREIGN KEY (venue_id) REFERENCES venues(venue_id)
);

# 9. AWARDS - A film may receive zero, one, or many awards.

CREATE TABLE IF NOT EXISTS awards (
    award_id      INT           AUTO_INCREMENT PRIMARY KEY,
    film_id       INT           NOT NULL,
    award_name    VARCHAR(255)  NOT NULL,
    category      VARCHAR(150)  NOT NULL,
    awarded_date  DATE          NOT NULL,
    CONSTRAINT fk_awd_film FOREIGN KEY (film_id) REFERENCES films(film_id)
);