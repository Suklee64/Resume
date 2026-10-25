-- =============================================================
-- Resume: Suk Lee  (structured dataset)
-- Normalized relational schema (3 tables + education)
-- Dialect: ANSI SQL (works on SQLite / PostgreSQL / MySQL)
-- =============================================================

-- ---------- Schema ----------

CREATE TABLE company (
    company_id   INTEGER PRIMARY KEY,
    name         TEXT NOT NULL
);

CREATE TABLE role (
    role_id      INTEGER PRIMARY KEY,
    company_id   INTEGER NOT NULL REFERENCES company(company_id),
    title        TEXT NOT NULL,
    start_date   TEXT,            -- YYYY-MM
    end_date     TEXT,            -- YYYY-MM or 'Present'
    duration     TEXT,            -- as stated on resume
    location     TEXT,
    is_current   BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE responsibility (
    responsibility_id INTEGER PRIMARY KEY,
    role_id           INTEGER NOT NULL REFERENCES role(role_id),
    description       TEXT NOT NULL
);

CREATE TABLE education (
    education_id INTEGER PRIMARY KEY,
    institution  TEXT NOT NULL,
    degree       TEXT,
    start_date   TEXT,
    end_date     TEXT
);

-- ---------- Data: companies ----------

INSERT INTO company (company_id, name) VALUES
    (1, 'Hughes'),
    (2, 'Tata Consultancy Services'),
    (3, 'Capgemini'),
    (4, 'LG Electronics'),
    (5, 'Computer Associates');

-- ---------- Data: roles ----------

INSERT INTO role (role_id, company_id, title, start_date, end_date, duration, location, is_current) VALUES
    (1, 1, 'Sr Principal Data Science Specialist', '2025-04', 'Present', '1 year 7 months', 'Germantown, Maryland, United States', TRUE),
    (2, 1, 'Principal Data Science Specialist',    '2022-04', '2025-04', '3 years 1 month',  'Germantown, Maryland, United States', FALSE),
    (3, 1, 'Sr Staff Specialist',                  '2019-04', '2022-03', '3 years',          'Germantown, Maryland, United States', FALSE),
    (4, 1, 'Staff Specialist',                     '2016-08', '2019-03', '2 years 8 months', 'Germantown, Maryland, United States', FALSE),
    (5, 2, 'BI Visualization Consultant',          '2016-01', '2016-08', '8 months',         'Washington DC-Baltimore Area',        FALSE),
    (6, 3, 'BI Consultant',                        '2014-11', '2016-01', '1 year 3 months',  'Greater New York City Area',          FALSE),
    (7, 4, 'Manager',                              '2008-07', '2014-06', '6 years',          'Huntsville-Decatur-Albertville Area', FALSE),
    (8, 5, 'Technology Consultant',                '2000-06', '2006-06', '6 years 1 month',  NULL,                                   FALSE);

-- ---------- Data: responsibilities ----------

INSERT INTO responsibility (responsibility_id, role_id, description) VALUES
    -- Tata Consultancy Services
    (1,  5, 'Analysis and documenting the Functional Requirements & Technical Documentation'),
    (2,  5, 'Designing the visual reporting tool acquiring data from multiple data sources'),
    (3,  5, 'Designing Bank IT Operational Job schedule monitoring dashboard'),
    (4,  5, 'Developing Analysis, Visualization, charts and detail tables'),
    (5,  5, 'Managing Tableau Analysis migration process and deployment to production'),
    -- Capgemini
    (6,  6, 'Interact with business stakeholders to gather requirements, analyze systems and built KPIs'),
    (7,  6, 'Develop, maintain and manage advanced reporting, analytics, dashboards using mainly Tableau and Spotfire'),
    -- LG Electronics
    (8,  7, 'Design and implement BI solutions for service operation providing easy access to historical trends in warranty claim, call center, service performance, and product quality analysis'),
    (9,  7, 'Analyze call center, warranty claim, product return data and part supply chain data from global ERP system to define operational problems or product quality issues and develop effective solutions'),
    (10, 7, 'Develop Key Performance Indicators (KPI) to enhance service management capability and evaluate service performance'),
    (11, 7, 'Collaborate with other groups in the organization to ensure successful implementation of problem solutions'),
    (12, 7, 'Handle data mining activities: gather and compile data, extract relevant information and communicate results'),
    (13, 7, 'Conduct HQ meeting management and reporting, correspond business issues with HQ CS management team'),
    -- Computer Associates
    (14, 8, 'Provided project leadership in the implementation of Enterprise System solutions for B2B customers'),
    (15, 8, 'Responsible for providing technical support for Enterprise System solutions in local market'),
    (16, 8, 'Assumed responsibility for the resolution of technical issues for multiple distributors'),
    (17, 8, 'Collaborated in the enhancement of new customer oriented functions for future product releases'),
    (18, 8, 'Managed and trained local distributors in system management and database management solutions');

-- ---------- Data: education ----------

INSERT INTO education (education_id, institution, degree, start_date, end_date) VALUES
    (1, 'Thunderbird School of Global Management', 'MBA', '2006-08', '2008-05');

-- =============================================================
-- Example queries
-- =============================================================
-- All roles, newest first, with company name:
--   SELECT c.name, r.title, r.start_date, r.end_date, r.duration
--   FROM role r JOIN company c ON c.company_id = r.company_id
--   ORDER BY r.start_date DESC;
--
-- Current role:
--   SELECT c.name, r.title FROM role r
--   JOIN company c ON c.company_id = r.company_id
--   WHERE r.is_current = TRUE;
--
-- Responsibilities for a given role:
--   SELECT description FROM responsibility WHERE role_id = 7;
