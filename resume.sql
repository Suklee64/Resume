-- =============================================================
-- Resume: Suk Lee  (structured dataset)
-- Normalized relational schema
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
    department   TEXT,
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

-- Tools used in a role (e.g., Tableau Desktop, Tableau Prep)
CREATE TABLE tool (
    tool_id   INTEGER PRIMARY KEY,
    role_id   INTEGER NOT NULL REFERENCES role(role_id),
    name      TEXT NOT NULL
);

-- Data sources worked with in a role
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
    (12, 1, 'Kiro IDE'),
    (13, 1, 'n8n (workflow automation)'),
    (3,  2, 'Tableau Desktop'),
    (4,  2, 'Tableau Prep'),
    (5,  3, 'Tableau Desktop'),
    (6,  3, 'Tableau Prep'),
    (7,  4, 'Tableau Desktop'),
    (8,  4, 'Tableau Prep'),
    (9,  5, 'Tableau'),
    (10, 6, 'Tableau'),
    (11, 6, 'Spotfire');

-- ---------- Data: data sources ----------

INSERT INTO data_source (data_source_id, role_id, name) VALUES
    -- Hughes (role 1 & 2 full stack)
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
    (39, 1, 'External Web Sources (unstructured)'),
    (40, 1, 'AI Agent Knowledge Base (GCP structured)'),
    (11, 2, 'DSS Order'),
    (12, 2, 'Install Portal'),
    (13, 2, 'Salesforce Customer Care'),
    (14, 2, 'Billing & Account'),
    (15, 2, 'Engineering Network Data'),
    (16, 2, 'SAP Part Supply'),
    (17, 2, 'Procurement'),
    (18, 2, 'Oracle DB'),
    (19, 2, 'Google Cloud Platform (GCP)'),
    (20, 2, 'Tableau Data Sources'),
    (21, 3, 'DSS Order'),
    (22, 3, 'Install Portal'),
    (23, 3, 'Salesforce Customer Care'),
    (24, 3, 'Billing & Account'),
    (25, 3, 'Engineering Network Data'),
    (26, 3, 'SAP Part Supply'),
    (27, 3, 'Procurement'),
    (28, 3, 'Oracle DB'),
    (29, 3, 'Google Cloud Platform (GCP)'),
    (30, 3, 'Tableau Data Sources'),
    (31, 4, 'DSS Order'),
    (32, 4, 'Install Portal'),
    (33, 4, 'Salesforce Customer Care'),
    (34, 4, 'Billing & Account'),
    (35, 4, 'Engineering Network Data'),
    (36, 4, 'Oracle DB'),
    (37, 4, 'Tableau Data Sources'),
    -- LG Electronics
    (38, 7, 'Global ERP System');

-- ---------- Data: responsibilities ----------

INSERT INTO responsibility (responsibility_id, role_id, description) VALUES
    -- Hughes Network Systems: Sr Principal Data Science Specialist (role 1, current)
    (1,  1, 'Set the enterprise data and analytics strategy for Consumer Operations, owning the end-to-end integration and visualization of operational data across DSS order, Install Portal, Salesforce Customer Care, billing/account, engineering network, and SAP part supply and procurement'),
    (2,  1, 'Design and build customized ETL pipelines in Tableau Prep and publish interactive Tableau dashboards consumed organization-wide for daily, weekly, and monthly operational reporting'),
    (3,  1, 'Develop and maintain internal KPIs and trend analytics that measure operational health and support Marketing, Sales, and Quality teams'),
    (4,  1, 'Deliver insights that drive quality control, new product development, churn reduction, and new product line initiatives'),
    (5,  1, 'Act as the organization-wide authority on operational analytics, advising leadership and mentoring teams while translating broad, disparate data sources into decision-ready visual content'),
    (36, 1, 'Architected and developed AI agents using Kiro IDE and the n8n automation platform to ingest unstructured data from multiple external websites, normalize it, and persist it as structured datasets in Google Cloud Platform (GCP)'),
    (37, 1, 'Designed and implemented end-to-end automated workflows in n8n that trigger downstream actions based on the collected and structured data, reducing manual effort and accelerating operational response'),
    (38, 1, 'Engineered a unified, best-practice data workflow that consolidates multiple operational data sources (Install Portal, Billing, Order, Salesforce Customer Care) into a single conversational AI agent, enabling natural-language answers to operations questions across the business'),
    -- Principal Data Science Specialist (role 2) -- expert / lead: drives strategy, mentors, cross-functional partner
    (6,  2, 'Led the operational analytics function across Consumer Operations, setting direction for how order, install, customer care, billing, engineering network, and SAP supply-chain data were integrated and analyzed'),
    (39, 2, 'Served as the key liaison between business and IT/engineering, translating business operational requirements into technical data specifications and, in turn, communicating engineering and system constraints back to business stakeholders'),
    (40, 2, 'Partnered with IT and engineering teams on data architecture, source-system integration, and data-quality governance to ensure analytics accurately reflected underlying operational systems'),
    (7,  2, 'Defined ETL and dashboard standards in Tableau Prep and Tableau, mentoring analysts and ensuring consistent, reusable data pipelines published organization-wide'),
    (8,  2, 'Partnered with Marketing, Sales, and Quality leadership to translate business questions into KPI frameworks and trend analytics that guided operational decisions'),
    (9,  2, 'Drove data-informed initiatives in quality control, churn reduction, and new product development, bridging business priorities with engineering execution'),
    -- Sr Staff Specialist (role 3) -- experienced professional: designs recurring solutions, owns KPIs
    (10, 3, 'Designed and owned end-to-end analytics solutions integrating operational data from order, install, customer care, billing, engineering network, and SAP supply-chain systems'),
    (11, 3, 'Developed standardized, reusable ETL and Tableau visualizations published for organization-wide operational reporting'),
    (12, 3, 'Established and maintained a suite of KPIs to monitor operational performance and surface trends proactively'),
    (13, 3, 'Delivered actionable analytics that Marketing, Sales, and Quality teams relied on for recurring operational reviews'),
    -- Staff Specialist (role 4) -- entry professional: executes, builds, supports requests
    (14, 4, 'Prepared and analyzed operational data from order, install, customer care, billing, and engineering network systems to fulfill reporting needs'),
    (15, 4, 'Built ETL routines and Tableau dashboards to visualize operational metrics for internal stakeholders'),
    (16, 4, 'Developed foundational KPIs and recurring trend reports to track day-to-day operational health'),
    (17, 4, 'Supported Marketing, Sales, and Quality teams by responding to data and reporting requests with accurate, timely analysis'),
    -- Tata Consultancy Services (role 5)
    (18, 5, 'Analysis and documenting the Functional Requirements & Technical Documentation'),
    (19, 5, 'Designing the visual reporting tool acquiring data from multiple data sources'),
    (20, 5, 'Designing Bank IT Operational Job schedule monitoring dashboard'),
    (21, 5, 'Developing Analysis, Visualization, charts and detail tables'),
    (22, 5, 'Managing Tableau Analysis migration process and deployment to production'),
    -- Capgemini (role 6)
    (23, 6, 'Interact with business stakeholders to gather requirements, analyze systems and built KPIs'),
    (24, 6, 'Develop, maintain and manage advanced reporting, analytics, dashboards using mainly Tableau and Spotfire'),
    -- LG Electronics (role 7)
    (25, 7, 'Design and implement BI solutions for service operation providing easy access to historical trends in warranty claim, call center, service performance, and product quality analysis'),
    (26, 7, 'Analyze call center, warranty claim, product return data and part supply chain data from global ERP system to define operational problems or product quality issues and develop effective solutions'),
    (27, 7, 'Develop Key Performance Indicators (KPI) to enhance service management capability and evaluate service performance'),
    (28, 7, 'Collaborate with other groups in the organization to ensure successful implementation of problem solutions'),
    (29, 7, 'Handle data mining activities: gather and compile data, extract relevant information and communicate results'),
    (30, 7, 'Conduct HQ meeting management and reporting, correspond business issues with HQ CS management team'),
    -- Computer Associates (role 8)
    (31, 8, 'Provided project leadership in the implementation of Enterprise System solutions for B2B customers'),
    (32, 8, 'Responsible for providing technical support for Enterprise System solutions in local market'),
    (33, 8, 'Assumed responsibility for the resolution of technical issues for multiple distributors'),
    (34, 8, 'Collaborated in the enhancement of new customer oriented functions for future product releases'),
    (35, 8, 'Managed and trained local distributors in system management and database management solutions');

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
-- Tools used in the current role:
--   SELECT t.name FROM tool t JOIN role r ON r.role_id = t.role_id
--   WHERE r.is_current = TRUE;
--
-- All data sources ever worked with (distinct):
--   SELECT DISTINCT name FROM data_source ORDER BY name;
--
-- Responsibilities for a given role:
--   SELECT description FROM responsibility WHERE role_id = 1;
