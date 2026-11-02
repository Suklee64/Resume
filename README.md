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
| `department` | Business unit / department (e.g., Consumer Operations) |
| `title` | Job title |
| `start_date` | Start, normalized to `YYYY-MM` |
| `end_date` | End, `YYYY-MM` or `Present` |
| `duration` | Tenure as stated on the resume |
| `location` | Work location |
| `is_current` | `TRUE` for the active role |
| `tools` | Tools used, joined by ` \| ` |
| `data_sources` | Data sources worked with, joined by ` \| ` |
| `responsibilities` | Bullet points joined by ` \| ` |

## Relational schema (`resume.sql`)

Six tables, linked by foreign keys:

- **company** — one row per employer
- **role** — one row per position (FK → company); includes `department`
- **responsibility** — one row per bullet point (FK → role)
- **tool** — one row per tool used in a role (FK → role)
- **data_source** — one row per data source used in a role (FK → role)
- **education** — degrees

```
company (1) ──< role ──< responsibility
                   ├──< tool
                   └──< data_source
```

## Quick start

```bash
# Load into a SQLite database and query
sqlite3 resume.db ".read resume.sql"
sqlite3 resume.db "SELECT c.name, r.department, r.title, r.start_date, r.end_date
                   FROM role r JOIN company c ON c.company_id = r.company_id
                   ORDER BY r.start_date DESC;"
```

## Summary

- **5 companies**, **8 roles**, **38 responsibility items**, **13 tool entries**, **40 data-source entries**
- Date range: June 2000 – Present
- Current role: Sr Principal Data Science Specialist, Consumer Operations, Hughes Network Systems
- Primary tools: Tableau Desktop, Tableau Prep (customized ETL + published visual content); Kiro IDE and n8n for AI-agent development and workflow automation
- Key data sources at Hughes: DSS Order, Install Portal, Salesforce Customer Care, Billing & Account,
  Engineering Network, SAP Part Supply, Procurement, Oracle DB, Google Cloud Platform (GCP), Tableau Data Sources
- Education: MBA, Thunderbird School of Global Management (2006–2008)
