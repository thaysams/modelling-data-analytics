# CineTrack – Business Questions & SQL Queries

**Authors:** Enrique Bruno da Costa Soares & Thaysa Mendes da Silva

---

## Q1 – JOIN across multiple tables

**Business Question:**  
Which films were screened, and at what venues and times were they shown?

**SQL Query:**
```sql
SELECT
    f.title                  AS film_title,
    f.genre,
    v.name                   AS venue_name,
    v.city,
    s.screening_date,
    s.screening_time
FROM screenings s
JOIN films   f ON s.film_id  = f.film_id
JOIN venues  v ON s.venue_id = v.venue_id
ORDER BY s.screening_date, s.screening_time;
```

**Expected Result:**

| film_title         | genre         | venue_name           | city   | screening_date | screening_time |
|--------------------|---------------|----------------------|--------|----------------|----------------|
| The Last Signal    | Sci-Fi        | Grand Cinema Hall    | Dublin | 2024-03-15     | 18:00:00       |
| Vidas Cruzadas     | Drama         | Grand Cinema Hall    | Dublin | 2024-03-15     | 20:30:00       |
| Vidas Cruzadas     | Drama         | Open Air Theatre     | Galway | 2024-03-16     | 19:00:00       |
| Desert Bloom       | Documentary   | Studio Screen        | Cork   | 2024-03-16     | 14:00:00       |
| The Last Signal    | Sci-Fi        | The Arthouse         | Dublin | 2024-03-17     | 20:30:00       |
| Neon Solitude      | Thriller      | Grand Cinema Hall    | Dublin | 2024-03-17     | 19:00:00       |
| Desert Bloom       | Documentary   | Open Air Theatre     | Galway | 2024-03-18     | 17:00:00       |
| Circo de Sonhos    | Animation     | Grand Cinema Hall    | Dublin | 2024-03-18     | 15:00:00       |
| Neon Solitude      | Thriller      | Studio Screen        | Cork   | 2024-03-19     | 20:00:00       |
| Circo de Sonhos    | Animation     | The Arthouse         | Dublin | 2024-03-20     | 16:00:00       |

---

## Q2 – Aggregate function (AVG) with GROUP BY

**Business Question:**  
What is the average judge score for each accepted film, ranked from highest to lowest?

**SQL Query:**
```sql
SELECT
    f.title                          AS film_title,
    COUNT(js.score_id)               AS total_scores,
    ROUND(AVG(js.score), 2)          AS avg_score
FROM judge_scores js
JOIN films f ON js.film_id = f.film_id
GROUP BY f.film_id, f.title
ORDER BY avg_score DESC;
```

**Expected Result:**

| film_title         | total_scores | avg_score |
|--------------------|--------------|-----------|
| The Last Signal    | 3            | 9.23      |
| Circo de Sonhos    | 3            | 8.83      |
| Vidas Cruzadas     | 3            | 8.33      |
| Desert Bloom       | 3            | 8.17      |
| Neon Solitude      | 3            | 7.87      |

---

## Q3 – GROUP BY with COUNT

**Business Question:**  
How many screenings did each venue host during the festival?

**SQL Query:**
```sql
SELECT
    v.name                       AS venue_name,
    v.city,
    v.capacity,
    COUNT(s.screening_id)        AS total_screenings
FROM venues v
LEFT JOIN screenings s ON v.venue_id = s.venue_id
GROUP BY v.venue_id, v.name, v.city, v.capacity
ORDER BY total_screenings DESC;
```

**Expected Result:**

| venue_name           | city   | capacity | total_screenings |
|----------------------|--------|----------|-----------------|
| Grand Cinema Hall    | Dublin | 500      | 4               |
| Open Air Theatre     | Galway | 800      | 2               |
| Studio Screen        | Cork   | 150      | 2               |
| The Arthouse         | Dublin | 200      | 2               |

---

## Q4 – GROUP BY with HAVING

**Business Question:**  
Which directors had more than one film accepted into the festival?

**SQL Query:**
```sql
SELECT
    d.first_name,
    d.last_name,
    d.nationality,
    COUNT(DISTINCT fd.film_id)   AS accepted_films
FROM directors d
JOIN film_director fd ON d.director_id = fd.director_id
JOIN submissions   s  ON fd.film_id    = s.film_id
WHERE s.status = 'Accepted'
GROUP BY d.director_id, d.first_name, d.last_name, d.nationality
HAVING COUNT(DISTINCT fd.film_id) > 1;
```

**Expected Result:**

| first_name | last_name | nationality | accepted_films |
|------------|-----------|-------------|----------------|
| Lucas      | Ferreira  | Brazilian   | 2              |

---

## Q5 – Subquery

**Business Question:**  
Which film received the single highest average judge score at the festival?

**SQL Query:**
```sql
SELECT
    f.title                       AS film_title,
    ROUND(AVG(js.score), 2)       AS avg_score
FROM films f
JOIN judge_scores js ON f.film_id = js.film_id
GROUP BY f.film_id, f.title
HAVING AVG(js.score) = (
    SELECT MAX(avg_s)
    FROM (
        SELECT AVG(score) AS avg_s
        FROM judge_scores
        GROUP BY film_id
    ) AS film_averages
);
```

**Expected Result:**

| film_title      | avg_score |
|-----------------|-----------|
| The Last Signal | 9.23      |
