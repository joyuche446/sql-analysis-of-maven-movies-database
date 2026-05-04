# SQL-Business-Intelligence-Analysis-of-Maven-Movies-Database
## Project Overview:
This project analyzes the Maven Movies database using SQL to answer key business questions from a potential investor. It explores store operations, inventory, customer behavior, and revenue performance. It uses multi-table joins and aggregations to generate insights that support business decison-making.
## Business Context:
Maven Movies is a DVD rental business with multiple stores, customers, and a large film inventory. The analysis simulates questions from a potential buyer evaluating the company’s performance and value.
## Dataset Source & Overview:
## Methodology:
- **Data Exploration:** Reviewed tables to understand structure and relationships.
- **Data Integration:** Joined multiple tables using JOINS to connect key data and gain insights.
- **Aggregation:** Used COUNT, SUM, and AVG with GROUP BY for summaries.
- **Data Transformation:** Created metrics like customer lifetime value and award counts.
- **Advanced Queries:** Applied subqueries and UNION for complex analysis.
## SQL Queries:
![View Full SQL Queries](maven_movies_queries.sql)
## Key Insights & Recommendations:
### Insights
- The business operates 2 stores managed by 2 store managers, with a total inventory of 4,581 films across both stores (Store 1: 2,270 | Store 2: 2,311), showing a relatively even distribution.
- Inventory is unevenly distributed across film ratings, with PG-13 films having the highest count in both stores (Store 1: 525 | Store 2: 493).
- Customer 526 (Karl Seal) and Customer 148 (Eleanor Hunt) as the most valuable customers, with total lifetime rentals and payments of 45 rentals / $221.55 and 46 rentals / $216.54 respectively.
- The company has a governance structure consisting of 4 advisors and 3 investors, providing strategic oversight and investment support.
### Recommendations
## Skills Demonstrated:
- **Advanced SQL:** Multi-table joins, subqueries, UNION, and query optimization
- **Data Aggregation:** GROUP BY with COUNT, SUM, AVG
- **Data Modeling:** Understanding relational schema, keys, and table relationships
- **Data Transformation:** Derived metrics and string manipulation functions
- **Query Validation:** Cross-checking outputs for accuracy and consistency
## Next Steps:
- Build a dashboard (e.g., in Power BI or Tableau) to visualize key metrics and support ongoing business monitoring.

