# Resume as Structured Data — Suk Lee

Work experience converted from the PDF resume into a structured dataset, so each
role at each company is a row with consistent columns.

## Files

| File | Format | Use |
|------|--------|-----|
| `experience.csv` | Flat table (one row per role) | Open in Excel / Google Sheets, import into any DB |
| `resume.sql` | Normalized relational schema + inserts | Load into SQLite / PostgreSQL / MySQL |

## CSV columns (`experience.csv`)

| Column | Description |
|--------|-------------|
| `role_id` | Unique id for the position |
| `company` | Employer name |
| `title` | Job title |
| `start_date` | Start, normalized to `YYYY-MM` |
| `end_date` | End, `YYYY-MM` or `Present` |
| `duration` | Tenure as stated on the resume |
| `location` | Work location |
| `is_current` | `TRUE` for the active role |
| `responsibilities` | Bullet points joined by ` \| ` |

## Relational schema (`resume.sql`)

Four tables, linked by foreign keys:

- **company** — one row per employer
- **role** — one row per position (FK → company)
- **responsibility** — one row per bullet point (FK → role)
- **education** — degrees

```
company (1) ──< role (1) ──< responsibility
```

## Quick start

```bash
# Load into a SQLite database and query
sqlite3 resume.db ".read resume.sql"
sqlite3 resume.db "SELECT c.name, r.title, r.start_date, r.end_date
                   FROM role r JOIN company c ON c.company_id = r.company_id
                   ORDER BY r.start_date DESC;"
```

## Summary

- **5 companies**, **8 roles**, **18 responsibility items**
- Date range: June 2000 – Present
- Current role: Sr Principal Data Science Specialist at Hughes
- Education: MBA, Thunderbird School of Global Management (2006–2008)
