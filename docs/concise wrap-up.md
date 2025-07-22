---
layout: default
title: Concise Wrap-up
nav_order: 2
---
# SQL Server 2022 Express on Windows Server 2022 Datacenter

## SQL Server 2022 CU20 (KB5059390) – July 2025

| Item                              | Value                                                                                                                                                                                         |
| --------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Release Date**            | 10 July 2025                                                                                                                                                                                  |
| **Build**                   | 16.0.4205.1                                                                                                                                                                                   |
| **Analysis Services Build** | 16.0.43.247                                                                                                                                                                                   |
| **Fixes**                   | 10 cumulative fixes (detailed in the [official KB](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate20#improvements-and-fixes-included-in-this-update)) |
| **Known Issue**             | `SESSION_CONTEXT` may return wrong results or AV dumps under **parallel plans**.                                                                                                      |
| **Link**                    | [https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate20](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate20)   |

## Google Cloud Marketplace Image

| Item                    | Value                                                   |
| ----------------------- | ------------------------------------------------------- |
| **OS**            | Windows Server 2022 Datacenter (10.0.20348)             |
| **SQL Edition**   | **Express** RTM-CU20 (KB5059390)                  |
| **Version**       | 16.0.4205.1                                             |
| **Features**      | Database Engine, Replication, Machine Learning Services |
| **Instance Name** | `SQLEXPRESS`                                          |
| **Clustered**     | No                                                      |

## Post-deployment Checklist on GCP

1. Enable TCP/IP & Set Port

   - SQL Config Mgr → SQL Server Network Config → Protocols for SQLEXPRESS
   - IPAll → TCP Port = 1433

2. Firewall Rules

   - TCP 1433 (SQL Server)
   - UDP 1434 (SQL Browser)

   > Already pre-configured in the image.

3. Connect

   - SSMS: WIN-AUTH to .\SQLEXPRESS
   - sqlcmd:

   ```cmd
       sqlcmd -S .\SQLEXPRESS
   ```

4. Verify

   ```sql
       SELECT @@VERSION;   -- should show CU20
   ```

5. Add sysadmin (if needed)

   ```sql
       CREATE LOGIN [DOMAIN\User] FROM WINDOWS;
       ALTER SERVER ROLE sysadmin ADD MEMBER [DOMAIN\User];
   ```