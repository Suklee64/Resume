-- =============================================================
-- Resume: Suk Lee  (structured dataset)
-- Normalized relational schema
-- Dialect: ANSI SQL (works on SQLite / PostgreSQL / MySQL)
-- IDs are clean and sequential within each table.
-- =============================================================

-- ---------- Schema ----------

CREATE TABLE company (
    company_id   INTEGER PRIMARY KEY,
    name         TEXT NOT NULL
);

CREATE TABLE role (
    role_id      INTEGER PRIMARY KEY,
    company_id   INTEGER NOT NULL REFERENCES company(company_id),
    department   TEXT,
    title        TEXT NOT NULL,
    start_date   TEXT,            -- YYYY-MM
    end_date     TEXT,            -- YYYY-MM or 'Present'
    duration     TEXT,
    location     TEXT,
    is_current   BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE responsibility (
    responsibility_id INTEGER PRIMARY KEY,
    role_id           INTEGER NOT NULL REFERENCES role(role_id),
    description       TEXT NOT NULL
);

CREATE TABLE tool (
    tool_id   INTEGER PRIMARY KEY,
    role_id   INTEGER NOT NULL REFERENCES role(role_id),
    name      TEXT NOT NULL
);

CREATE TABLE data_source (
    data_source_id INTEGER PRIMARY KEY,
    role_id        INTEGER NOT NULL REFERENCES role(role_id),
    name           TEXT NOT NULL
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
    (1, 'Hughes Network Systems'),
    (2, 'Tata Consultancy Services'),
    (3, 'Capgemini'),
    (4, 'LG Electronics'),
    (5, 'Computer Associates');

-- ---------- Data: roles ----------

INSERT INTO role (role_id, company_id, department, title, start_date, end_date, duration, location, is_current) VALUES
    (1, 1, 'Consumer Operations', 'Sr Principal Data Science Specialist', '2025-04', 'Present', '1 year 7 months', 'Germantown, Maryland, United States', TRUE),
    (2, 1, 'Consumer Operations', 'Principal Data Science Specialist',    '2022-04', '2025-04', '3 years 1 month',  'Germantown, Maryland, United States', FALSE),
    (3, 1, 'Consumer Operations', 'Sr Staff Specialist',                  '2019-04', '2022-03', '3 years',          'Germantown, Maryland, United States', FALSE),
    (4, 1, 'Consumer Operations', 'Staff Specialist',                     '2016-08', '2019-03', '2 years 8 months', 'Germantown, Maryland, United States', FALSE),
    (5, 2, NULL,                  'BI Visualization Consultant',          '2016-01', '2016-08', '8 months',         'Washington DC-Baltimore Area',        FALSE),
    (6, 3, NULL,                  'BI Consultant',                        '2014-11', '2016-01', '1 year 3 months',  'Greater New York City Area',          FALSE),
    (7, 4, NULL,                  'Manager',                              '2008-07', '2014-06', '6 years',          'Huntsville-Decatur-Albertville Area', FALSE),
    (8, 5, NULL,                  'Technology Consultant',                '2000-06', '2006-06', '6 years 1 month',  NULL,                                   FALSE);

-- ---------- Data: tools ----------

INSERT INTO tool (tool_id, role_id, name) VALUES
    (1,  1, 'Tableau Desktop'),
    (2,  1, 'Tableau Prep'),
    (3,  1, 'Kiro IDE'),
    (4,  1, 'n8n'),
    (5,  2, 'Tableau Desktop'),
    (6,  2, 'Tableau Prep'),
    (7,  3, 'Tableau Desktop'),
    (8,  3, 'Tableau Prep'),
    (9,  4, 'Tableau Desktop'),
    (10, 4, 'Tableau Prep'),
    (11, 5, 'Tableau'),
    (12, 6, 'Tableau'),
    (13, 6, 'Spotfire');

-- ---------- Data: data sources ----------

INSERT INTO data_source (data_source_id, role_id, name) VALUES
    -- R1 Sr Principal (full stack + AI/web)
    (1,  1, 'DSS Order'),
    (2,  1, 'Install Portal'),
    (3,  1, 'Salesforce Customer Care'),
    (4,  1, 'Billing & Account'),
    (5,  1, 'Engineering Network Data'),
    (6,  1, 'SAP Part Supply'),
    (7,  1, 'Procurement'),
    (8,  1, 'Oracle DB'),
    (9,  1, 'Google Cloud Platform (GCP)'),
    (10, 1, 'Tableau Data Sources'),
    (11, 1, 'External Web Sources (unstructured)'),
    (12, 1, 'AI Agent Knowledge Base (GCP structured)'),
    -- R2 Principal
    (13, 2, 'DSS Order'),
    (14, 2, 'Install Portal'),
    (15, 2, 'Salesforce Customer Care'),
    (16, 2, 'Billing & Account'),
    (17, 2, 'Engineering Network Data'),
    (18, 2, 'SAP Part Supply'),
    (19, 2, 'Procurement'),
    (20, 2, 'Oracle DB'),
    (21, 2, 'Google Cloud Platform (GCP)'),
    (22, 2, 'Tableau Data Sources'),
    -- R3 Sr Staff
    (23, 3, 'DSS Order'),
    (24, 3, 'Install Portal'),
    (25, 3, 'Salesforce Customer Care'),
    (26, 3, 'Billing & Account'),
    (27, 3, 'Engineering Network Data'),
    (28, 3, 'SAP Part Supply'),
    (29, 3, 'Procurement'),
    (30, 3, 'Oracle DB'),
    (31, 3, 'Google Cloud Platform (GCP)'),
    (32, 3, 'Tableau Data Sources'),
    -- R4 Staff
    (33, 4, 'DSS Order'),
    (34, 4, 'Install Portal'),
    (35, 4, 'Salesforce Customer Care'),
    (36, 4, 'Billing & Account'),
    (37, 4, 'Engineering Network Data'),
    (38, 4, 'Oracle DB'),
    (39, 4, 'Tableau Data Sources'),
    -- R7 LG Electronics
    (40, 7, 'Global ERP System');

-- ---------- Data: responsibilities ----------
-- Progression: Staff (executes) -> Sr Staff (owns solutions)
--              -> Principal (leads, bridges business & IT) -> Sr Principal (sets strategy, innovates)

INSERT INTO responsibility (responsibility_id, role_id, description) VALUES
    -- R1  Sr Principal Data Science Specialist (strategic authority + AI innovation)
    (1,  1, 'Set the enterprise analytics strategy for Consumer Operations across all operational data domains'),
    (2,  1, 'Own end-to-end ETL and Tableau dashboards delivered organization-wide for daily, weekly, and monthly operations'),
    (3,  1, 'Define the KPIs and trend analytics that measure operational health for Marketing, Sales, and Quality'),
    (4,  1, 'Drive insights for quality control, churn reduction, and new product development'),
    (5,  1, 'Advise leadership and mentor teams as the organization-wide authority on operational analytics'),
    (6,  1, 'Architect AI agents with Kiro IDE and n8n that collect unstructured web data and store it as structured datasets in GCP'),
    (7,  1, 'Automate downstream operational actions through event-driven n8n workflows'),
    (8,  1, 'Build a unified conversational AI agent over Install Portal, Billing, Order, and Salesforce Customer Care data to answer operations questions in natural language'),
    -- R2  Principal Data Science Specialist (leader + business/IT bridge)
    (9,  2, 'Led the operational analytics function and set direction for integrating all source systems'),
    (10, 2, 'Bridged business and IT/engineering, translating operational needs into data specifications and system constraints back to the business'),
    (11, 2, 'Partnered with engineering on data architecture, source-system integration, and data-quality governance'),
    (12, 2, 'Established ETL and dashboard standards and mentored analysts on reusable pipelines'),
    (13, 2, 'Shaped KPI frameworks with Marketing, Sales, and Quality leadership to guide operational decisions'),
    (14, 2, 'Drove quality, churn, and new-product initiatives, aligning business priorities with engineering execution'),
    -- R3  Sr Staff Specialist (owns end-to-end solutions)
    (15, 3, 'Designed and owned end-to-end analytics integrating all operational source systems'),
    (16, 3, 'Built standardized, reusable ETL and Tableau visualizations for organization-wide reporting'),
    (17, 3, 'Established and maintained a KPI suite that surfaced operational trends proactively'),
    (18, 3, 'Delivered analytics relied on by Marketing, Sales, and Quality for recurring reviews'),
    -- R4  Staff Specialist (executes)
    (19, 4, 'Prepared and analyzed operational data from core order, install, billing, and network systems'),
    (20, 4, 'Built ETL routines and Tableau dashboards for internal stakeholders'),
    (21, 4, 'Developed foundational KPIs and recurring trend reports'),
    (22, 4, 'Fulfilled Marketing, Sales, and Quality reporting requests with accurate, timely analysis'),
    -- R5  BI Visualization Consultant (Tata Consultancy Services)
    (23, 5, 'Gathered and documented functional and technical requirements'),
    (24, 5, 'Designed visual reporting tools integrating multiple data sources'),
    (25, 5, 'Built a Bank IT operational job-schedule monitoring dashboard'),
    (26, 5, 'Developed analyses, visualizations, charts, and detail tables'),
    (27, 5, 'Managed Tableau migration and production deployment'),
    -- R6  BI Consultant (Capgemini)
    (28, 6, 'Partnered with stakeholders to gather requirements, analyze systems, and define KPIs'),
    (29, 6, 'Built and maintained advanced reporting and dashboards in Tableau and Spotfire'),
    -- R7  Manager (LG Electronics)
    (30, 7, 'Designed BI solutions exposing historical trends in warranty, call center, service, and product quality'),
    (31, 7, 'Analyzed call center, warranty, returns, and supply-chain data from the global ERP to resolve operational and quality issues'),
    (32, 7, 'Developed KPIs to strengthen and evaluate service performance'),
    (33, 7, 'Collaborated across groups to implement effective solutions'),
    (34, 7, 'Led data mining to extract and communicate actionable insights'),
    (35, 7, 'Managed HQ reporting and resolved business issues with the HQ CS team'),
    -- R8  Technology Consultant (Computer Associates)
    (36, 8, 'Led the implementation of Enterprise System solutions for B2B customers'),
    (37, 8, 'Delivered technical support for Enterprise System solutions in the local market'),
    (38, 8, 'Resolved complex technical issues across multiple distributors'),
    (39, 8, 'Contributed customer-oriented enhancements for future product releases'),
    (40, 8, 'Managed and trained distributors on system and database management solutions');

-- ---------- Data: education ----------

INSERT INTO education (education_id, institution, degree, start_date, end_date) VALUES
    (1, 'Thunderbird School of Global Management', 'MBA', '2006-08', '2008-05');

-- =============================================================
-- Example queries
-- =============================================================
-- All roles, newest first:
--   SELECT c.name, r.title, r.start_date, r.end_date
--   FROM role r JOIN company c ON c.company_id = r.company_id
--   ORDER BY r.start_date DESC;
--
-- Tools for the current role:
--   SELECT t.name FROM tool t JOIN role r ON r.role_id = t.role_id WHERE r.is_current = TRUE;
--
-- Responsibilities for a role:
--   SELECT description FROM responsibility WHERE role_id = 1;
