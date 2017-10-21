﻿/*
Deployment script for dapper-transaction-scope

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "dapper-transaction-scope"
:setvar DefaultFilePrefix "dapper-transaction-scope"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL12.SQL2014\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Dropping [dbo].[FK_InvoiceItem_Invoice]...';


GO
ALTER TABLE [dbo].[InvoiceItem] DROP CONSTRAINT [FK_InvoiceItem_Invoice];


GO
PRINT N'Dropping [dbo].[FK_InvoiceItem_Item]...';


GO
ALTER TABLE [dbo].[InvoiceItem] DROP CONSTRAINT [FK_InvoiceItem_Item];


GO
PRINT N'Creating [dbo].[FK_InvoiceItem_Invoice]...';


GO
ALTER TABLE [dbo].[InvoiceItem] WITH NOCHECK
    ADD CONSTRAINT [FK_InvoiceItem_Invoice] FOREIGN KEY ([InvoiceId]) REFERENCES [dbo].[Invoice] ([Id]);


GO
PRINT N'Creating [dbo].[FK_InvoiceItem_Item]...';


GO
ALTER TABLE [dbo].[InvoiceItem] WITH NOCHECK
    ADD CONSTRAINT [FK_InvoiceItem_Item] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Item] ([Id]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[InvoiceItem] WITH CHECK CHECK CONSTRAINT [FK_InvoiceItem_Invoice];

ALTER TABLE [dbo].[InvoiceItem] WITH CHECK CHECK CONSTRAINT [FK_InvoiceItem_Item];


GO
PRINT N'Update complete.';


GO
