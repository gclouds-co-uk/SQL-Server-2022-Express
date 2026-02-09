---
layout: default
title: Concise Wrap-up
nav_order: 2
---
# SQL Server 2022 Express on Windows Server 2022 Datacenter

## SQL Server 2022 CU23 (KB5078297) – February 2026

| Item                              | Value                                                                                                                                               
                                        |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Release Date**            | 09 February 2026                                                                                                                                          
                                  |
| **Build**                   | 16.0.4236.2                                                                                                                                               
                                  |
| **Analysis Services Build** | 16.0.43.252                                                                                                                                               
                                  |
| **Fixes**                   | 15+ fixes including resolution for Database Mail issues. Detailed in the [official KB](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate23).            
                                     |
| **Link**                    | [https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate23](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate23) |

## Google Cloud Marketplace Image
- **Image Name:** `gclouds-win2022-sql2022-exp-1770597563`
- **Creation Date:** Feb 09, 2026
- **Source Image:** `windows-server-2022-dc-v20260114`

## Post-deployment Checklist on GCP

1. **Enable TCP/IP & Set Port**
   - SQL Config Mgr → SQL Server Network Config → Protocols for SQLEXPRESS
   - IPAll → TCP Port = 1433

2. **Firewall Rules**
   - TCP 1433 (SQL Server)
   - UDP 1434 (SQL Browser)
   > Already pre-configured in the image.

3. **Connect**
   - SSMS: WIN-AUTH to `.\SQLEXPRESS`
   - sqlcmd:
     ```cmd
     sqlcmd -S .\SQLEXPRESS
     ```

4. **Verify**
   ```sql
   SELECT @@VERSION;   -- should show CU23
   GO
   ```

5. **Add sysadmin (if needed)**
   ```sql
   CREATE LOGIN [DOMAIN\User] FROM WINDOWS;
   ALTER SERVER ROLE sysadmin ADD MEMBER [DOMAIN\User];
   GO
   ```

---

## SQL Server 2022 CU22 (KB5068450) – November 2025

| Item                              | Value                                                                                                                                               
                                        |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Release Date**            | 18 November 2025                                                                                                                                          
                                  |
| **Build**                   | 16.0.4225.2                                                                                                                                               
                                  |
| **Analysis Services Build** | 16.0.43.252                                                                                                                                               
                                  |
| **Fixes**                   | cumulative fixes (detailed in the[official KB](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate22))            
                                     |
| **Known Issue**             | `SESSION_CONTEXT` may return wrong results or AV dumps under **parallel plans**.                                                                          
                          |
| **Link**                    | [https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate22](https://learn.microsoft.com/en-us/troubleshoot/sql/releases/sqlserver-2022/cumulativeupdate22) |