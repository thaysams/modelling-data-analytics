# 🎬 CineTrack – Independent Film Festival Database

> A database consulting project by **Enrique Bruno da Costa Soares** & **Thaysa Mendes da Silva**

---

## Overview

CineTrack is a relational database system designed for an independent film festival that receives submissions from filmmakers around the world. The festival previously relied on spreadsheets and email to manage its operations — a process that was error-prone and difficult to scale.

As database consultants, we identified the client's needs, modelled a custom solution from the ground up, implemented it in SQL, and demonstrated its value through targeted business queries.

---

## The Problem

The festival had no centralised system for tracking:
- Which films were submitted and whether they were accepted
- Which directors were behind each film
- How judges evaluated submissions
- Where and when screenings were scheduled
- Which films received awards

CineTrack replaces those manual processes with a fully normalised relational database.

---

## Database Design

The schema follows **Third Normal Form (3NF)** and is built around nine tables:

| Table | Description |
|---|---|
| `films` | Core film records |
| `directors` | Director profiles |
| `film_director` | M:N junction — films and directors |
| `submissions` | Festival submission records per film |
| `judges` | Judge profiles |
| `judge_scores` | M:N junction — judge evaluations per film |
| `venues` | Screening venue details |
| `screenings` | Scheduled screenings linking films and venues |
| `awards` | Awards presented to films at the festival |

---

## Repository Structure

```
cinetrack-db/
├── README.md
├── diagrams/
│   └── cinetrack_erd.drawio.png       # ER Diagram
├── sql/
│   ├── cinetrack_modelling_schema.sql            # DDL – CREATE TABLE statements
│   └── cinetrack_modelling_data.sql              # DML – INSERT sample data
└── docs/
    └── business_questions.md # 5 business queries with results
```

---

## Getting Started

**Requirements:** MySQL 8.0+ / MySQL Workbench

```bash
# 1. Clone the repository
git clone https://github.com/your-username/cinetrack-db.git

# 2. Open MySQL Workbench and run the scripts in order:
#    sql/schema.sql  →  then  sql/data.sql
```

---

## Business Questions

The five queries below demonstrate the value of the database and cover a range of SQL skills.

| # | Question | SQL Feature |
|---|---|---|
| Q1 | Which films were screened, at what venues and times? | JOIN across 3 tables |
| Q2 | What is the average judge score per film, ranked? | AVG + GROUP BY |
| Q3 | How many screenings did each venue host? | COUNT + GROUP BY |
| Q4 | Which directors had more than one accepted film? | GROUP BY + HAVING |
| Q5 | Which film received the highest average judge score? | Subquery |

Full queries and results are in [`docs/business_questions.md`](docs/business_questions.md).

---

## Authors

| Name | GitHub |
|---|---|
| Enrique Bruno da Costa Soares | [@enriquebruno12](https://github.com/enriquebruno12) |
| Thaysa Mendes da Silva | [@thaysams](https://github.com/thaysams) |
