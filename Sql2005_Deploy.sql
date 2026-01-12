IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
CREATE TABLE [Companies] (
    [CompanyId] int NOT NULL IDENTITY,
    [CompanyName] nvarchar(max) NOT NULL,
    [Address] nvarchar(max) NOT NULL,
    [Phone] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [Website] nvarchar(max) NOT NULL,
    [TaxCode] nvarchar(max) NOT NULL,
    [IsDefault] bit NOT NULL,
    [RecordStatus] nvarchar(max) NULL,
    [Remark] nvarchar(max) NULL,
    [CreatedBy] nvarchar(max) NULL,
    [CreatedDate] datetime2 NULL,
    [ModifiedBy] nvarchar(max) NULL,
    [ModifiedDate] datetime2 NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedBy] nvarchar(max) NULL,
    [DeletedDate] datetime2 NULL,
    CONSTRAINT [PK_Companies] PRIMARY KEY ([CompanyId])
);

CREATE TABLE [GoldPriceLogs] (
    [GoldPriceLogId] int NOT NULL IDENTITY,
    [GoldPriceId] int NOT NULL,
    [OldBuyPrice] decimal(18,2) NOT NULL,
    [OldSellPrice] decimal(18,2) NOT NULL,
    [NewBuyPrice] decimal(18,2) NOT NULL,
    [NewSellPrice] decimal(18,2) NOT NULL,
    [RecordStatus] nvarchar(max) NULL,
    [Remark] nvarchar(max) NULL,
    [CreatedBy] nvarchar(max) NULL,
    [CreatedDate] datetime2 NULL,
    [ModifiedBy] nvarchar(max) NULL,
    [ModifiedDate] datetime2 NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedBy] nvarchar(max) NULL,
    [DeletedDate] datetime2 NULL,
    CONSTRAINT [PK_GoldPriceLogs] PRIMARY KEY ([GoldPriceLogId])
);

CREATE TABLE [GoldTypes] (
    [GoldTypeId] int NOT NULL IDENTITY,
    [GoldTypeName] nvarchar(max) NOT NULL,
    [RecordStatus] nvarchar(max) NULL,
    [Remark] nvarchar(max) NULL,
    [CreatedBy] nvarchar(max) NULL,
    [CreatedDate] datetime2 NULL,
    [ModifiedBy] nvarchar(max) NULL,
    [ModifiedDate] datetime2 NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedBy] nvarchar(max) NULL,
    [DeletedDate] datetime2 NULL,
    CONSTRAINT [PK_GoldTypes] PRIMARY KEY ([GoldTypeId])
);

CREATE TABLE [GoldPrices] (
    [GoldPriceId] int NOT NULL IDENTITY,
    [CompanyId] int NOT NULL,
    [GoldTypeId] int NOT NULL,
    [ApplyDate] datetime2 NOT NULL,
    [SellPrice] decimal(18,2) NOT NULL,
    [BuyPrice] decimal(18,2) NOT NULL,
    [RecordStatus] nvarchar(max) NULL,
    [Remark] nvarchar(max) NULL,
    [CreatedBy] nvarchar(max) NULL,
    [CreatedDate] datetime2 NULL,
    [ModifiedBy] nvarchar(max) NULL,
    [ModifiedDate] datetime2 NULL,
    [IsDeleted] bit NOT NULL,
    [DeletedBy] nvarchar(max) NULL,
    [DeletedDate] datetime2 NULL,
    CONSTRAINT [PK_GoldPrices] PRIMARY KEY ([GoldPriceId]),
    CONSTRAINT [FK_GoldPrices_Companies_CompanyId] FOREIGN KEY ([CompanyId]) REFERENCES [Companies] ([CompanyId]) ON DELETE CASCADE,
    CONSTRAINT [FK_GoldPrices_GoldTypes_GoldTypeId] FOREIGN KEY ([GoldTypeId]) REFERENCES [GoldTypes] ([GoldTypeId]) ON DELETE CASCADE
);

CREATE INDEX [IX_GoldPrices_CompanyId] ON [GoldPrices] ([CompanyId]);

CREATE INDEX [IX_GoldPrices_GoldTypeId] ON [GoldPrices] ([GoldTypeId]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251005175449_Init', N'9.0.9');

DECLARE @var sysname;
SELECT @var = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'Remark');
IF @var IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [Remark] nvarchar(500) NULL;

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'RecordStatus');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [RecordStatus] nvarchar(250) NULL;

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'ModifiedBy');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [ModifiedBy] nvarchar(250) NULL;

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'GoldTypeName');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [GoldTypeName] nvarchar(250) NOT NULL;

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'DeletedBy');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [DeletedBy] nvarchar(250) NULL;

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'CreatedBy');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [CreatedBy] nvarchar(250) NULL;

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'SellPrice');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [SellPrice] money NOT NULL;

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'Remark');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [Remark] nvarchar(500) NULL;

DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'RecordStatus');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var8 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [RecordStatus] nvarchar(250) NULL;

DECLARE @var9 sysname;
SELECT @var9 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'ModifiedBy');
IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var9 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [ModifiedBy] nvarchar(250) NULL;

DECLARE @var10 sysname;
SELECT @var10 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'DeletedBy');
IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var10 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [DeletedBy] nvarchar(250) NULL;

DECLARE @var11 sysname;
SELECT @var11 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'CreatedBy');
IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var11 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [CreatedBy] nvarchar(250) NULL;

DECLARE @var12 sysname;
SELECT @var12 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'BuyPrice');
IF @var12 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var12 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [BuyPrice] money NOT NULL;

DECLARE @var13 sysname;
SELECT @var13 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'Remark');
IF @var13 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var13 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [Remark] nvarchar(500) NULL;

DECLARE @var14 sysname;
SELECT @var14 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'RecordStatus');
IF @var14 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var14 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [RecordStatus] nvarchar(250) NULL;

DECLARE @var15 sysname;
SELECT @var15 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'OldSellPrice');
IF @var15 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var15 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [OldSellPrice] money NOT NULL;

DECLARE @var16 sysname;
SELECT @var16 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'OldBuyPrice');
IF @var16 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var16 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [OldBuyPrice] money NOT NULL;

DECLARE @var17 sysname;
SELECT @var17 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'NewSellPrice');
IF @var17 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var17 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [NewSellPrice] money NOT NULL;

DECLARE @var18 sysname;
SELECT @var18 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'NewBuyPrice');
IF @var18 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var18 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [NewBuyPrice] money NOT NULL;

DECLARE @var19 sysname;
SELECT @var19 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'ModifiedBy');
IF @var19 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var19 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [ModifiedBy] nvarchar(250) NULL;

DECLARE @var20 sysname;
SELECT @var20 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'DeletedBy');
IF @var20 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var20 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [DeletedBy] nvarchar(250) NULL;

DECLARE @var21 sysname;
SELECT @var21 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'CreatedBy');
IF @var21 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var21 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [CreatedBy] nvarchar(250) NULL;

DECLARE @var22 sysname;
SELECT @var22 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Website');
IF @var22 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var22 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Website] nvarchar(250) NOT NULL;

DECLARE @var23 sysname;
SELECT @var23 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'TaxCode');
IF @var23 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var23 + '];');
ALTER TABLE [Companies] ALTER COLUMN [TaxCode] nvarchar(250) NOT NULL;

DECLARE @var24 sysname;
SELECT @var24 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Remark');
IF @var24 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var24 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Remark] nvarchar(500) NULL;

DECLARE @var25 sysname;
SELECT @var25 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'RecordStatus');
IF @var25 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var25 + '];');
ALTER TABLE [Companies] ALTER COLUMN [RecordStatus] nvarchar(250) NULL;

DECLARE @var26 sysname;
SELECT @var26 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Phone');
IF @var26 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var26 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Phone] nvarchar(250) NOT NULL;

DECLARE @var27 sysname;
SELECT @var27 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'ModifiedBy');
IF @var27 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var27 + '];');
ALTER TABLE [Companies] ALTER COLUMN [ModifiedBy] nvarchar(250) NULL;

DECLARE @var28 sysname;
SELECT @var28 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Email');
IF @var28 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var28 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Email] nvarchar(250) NOT NULL;

DECLARE @var29 sysname;
SELECT @var29 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'DeletedBy');
IF @var29 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var29 + '];');
ALTER TABLE [Companies] ALTER COLUMN [DeletedBy] nvarchar(250) NULL;

DECLARE @var30 sysname;
SELECT @var30 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'CreatedBy');
IF @var30 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var30 + '];');
ALTER TABLE [Companies] ALTER COLUMN [CreatedBy] nvarchar(250) NULL;

DECLARE @var31 sysname;
SELECT @var31 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'CompanyName');
IF @var31 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var31 + '];');
ALTER TABLE [Companies] ALTER COLUMN [CompanyName] nvarchar(250) NOT NULL;

DECLARE @var32 sysname;
SELECT @var32 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Address');
IF @var32 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var32 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Address] nvarchar(250) NOT NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251005180518_Init1', N'9.0.9');

ALTER TABLE [GoldPrices] ADD [IsBuyUpdating] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [GoldPrices] ADD [IsSellUpdating] bit NOT NULL DEFAULT CAST(0 AS bit);

ALTER TABLE [GoldPrices] ADD [SortOrder] int NOT NULL DEFAULT 0;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'CompanyId', N'Address', N'CompanyName', N'CreatedBy', N'CreatedDate', N'DeletedBy', N'DeletedDate', N'Email', N'IsDefault', N'IsDeleted', N'ModifiedBy', N'ModifiedDate', N'Phone', N'RecordStatus', N'Remark', N'TaxCode', N'Website') AND [object_id] = OBJECT_ID(N'[Companies]'))
    SET IDENTITY_INSERT [Companies] ON;
INSERT INTO [Companies] ([CompanyId], [Address], [CompanyName], [CreatedBy], [CreatedDate], [DeletedBy], [DeletedDate], [Email], [IsDefault], [IsDeleted], [ModifiedBy], [ModifiedDate], [Phone], [RecordStatus], [Remark], [TaxCode], [Website])
VALUES (1, N'1 Nguyễn Huệ, Q1, TP.HCM', N'Công ty Vàng SJC', N'admin', '2025-10-06T01:13:14.8445551+07:00', NULL, NULL, N'info@sjc.com.vn', CAST(0 AS bit), CAST(0 AS bit), N'admin', '2025-10-06T01:13:14.8465530+07:00', N'02723889110', N'Active', NULL, N'0301234567', N'https://sjc.com.vn');
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'CompanyId', N'Address', N'CompanyName', N'CreatedBy', N'CreatedDate', N'DeletedBy', N'DeletedDate', N'Email', N'IsDefault', N'IsDeleted', N'ModifiedBy', N'ModifiedDate', N'Phone', N'RecordStatus', N'Remark', N'TaxCode', N'Website') AND [object_id] = OBJECT_ID(N'[Companies]'))
    SET IDENTITY_INSERT [Companies] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GoldTypeId', N'CreatedBy', N'CreatedDate', N'DeletedBy', N'DeletedDate', N'GoldTypeName', N'IsDeleted', N'ModifiedBy', N'ModifiedDate', N'RecordStatus', N'Remark') AND [object_id] = OBJECT_ID(N'[GoldTypes]'))
    SET IDENTITY_INSERT [GoldTypes] ON;
INSERT INTO [GoldTypes] ([GoldTypeId], [CreatedBy], [CreatedDate], [DeletedBy], [DeletedDate], [GoldTypeName], [IsDeleted], [ModifiedBy], [ModifiedDate], [RecordStatus], [Remark])
VALUES (1, N'admin', '2025-10-06T01:13:14.8480962+07:00', NULL, NULL, N'SJC 9999', CAST(0 AS bit), N'admin', '2025-10-06T01:13:14.8479948+07:00', N'Active', NULL),
(2, N'admin', '2025-10-06T01:13:14.8481536+07:00', NULL, NULL, N'PNJ 24K', CAST(0 AS bit), N'admin', '2025-10-06T01:13:14.8481533+07:00', N'Active', NULL),
(3, N'admin', '2025-10-06T01:13:14.8481540+07:00', NULL, NULL, N'DOJI 18K', CAST(0 AS bit), N'admin', '2025-10-06T01:13:14.8481539+07:00', N'Active', NULL);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GoldTypeId', N'CreatedBy', N'CreatedDate', N'DeletedBy', N'DeletedDate', N'GoldTypeName', N'IsDeleted', N'ModifiedBy', N'ModifiedDate', N'RecordStatus', N'Remark') AND [object_id] = OBJECT_ID(N'[GoldTypes]'))
    SET IDENTITY_INSERT [GoldTypes] OFF;

IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GoldPriceId', N'ApplyDate', N'BuyPrice', N'CompanyId', N'CreatedBy', N'CreatedDate', N'DeletedBy', N'DeletedDate', N'GoldTypeId', N'IsBuyUpdating', N'IsDeleted', N'IsSellUpdating', N'ModifiedBy', N'ModifiedDate', N'RecordStatus', N'Remark', N'SellPrice', N'SortOrder') AND [object_id] = OBJECT_ID(N'[GoldPrices]'))
    SET IDENTITY_INSERT [GoldPrices] ON;
INSERT INTO [GoldPrices] ([GoldPriceId], [ApplyDate], [BuyPrice], [CompanyId], [CreatedBy], [CreatedDate], [DeletedBy], [DeletedDate], [GoldTypeId], [IsBuyUpdating], [IsDeleted], [IsSellUpdating], [ModifiedBy], [ModifiedDate], [RecordStatus], [Remark], [SellPrice], [SortOrder])
VALUES (1, '0001-01-01T00:00:00.0000000', 7800000.0, 1, N'admin', '2025-10-06T01:13:14.8482786+07:00', NULL, NULL, 1, CAST(0 AS bit), CAST(0 AS bit), CAST(0 AS bit), N'admin', '2025-10-06T01:13:14.8482791+07:00', N'Active', NULL, 7850000.0, 1);
IF EXISTS (SELECT * FROM [sys].[identity_columns] WHERE [name] IN (N'GoldPriceId', N'ApplyDate', N'BuyPrice', N'CompanyId', N'CreatedBy', N'CreatedDate', N'DeletedBy', N'DeletedDate', N'GoldTypeId', N'IsBuyUpdating', N'IsDeleted', N'IsSellUpdating', N'ModifiedBy', N'ModifiedDate', N'RecordStatus', N'Remark', N'SellPrice', N'SortOrder') AND [object_id] = OBJECT_ID(N'[GoldPrices]'))
    SET IDENTITY_INSERT [GoldPrices] OFF;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251005181316_Init2', N'9.0.9');

UPDATE [Companies] SET [CreatedDate] = '2025-01-01T00:00:00.0000000', [ModifiedDate] = '2025-01-01T00:00:00.0000000'
WHERE [CompanyId] = 1;
SELECT @@ROWCOUNT;


UPDATE [GoldPrices] SET [CreatedDate] = '2025-01-01T00:00:00.0000000', [ModifiedDate] = '2025-01-01T00:00:00.0000000'
WHERE [GoldPriceId] = 1;
SELECT @@ROWCOUNT;


UPDATE [GoldTypes] SET [CreatedDate] = '2025-01-01T00:00:00.0000000', [ModifiedDate] = '2025-01-01T00:00:00.0000000'
WHERE [GoldTypeId] = 1;
SELECT @@ROWCOUNT;


UPDATE [GoldTypes] SET [CreatedDate] = '2025-01-01T00:00:00.0000000', [ModifiedDate] = '2025-01-01T00:00:00.0000000'
WHERE [GoldTypeId] = 2;
SELECT @@ROWCOUNT;


UPDATE [GoldTypes] SET [CreatedDate] = '2025-01-01T00:00:00.0000000', [ModifiedDate] = '2025-01-01T00:00:00.0000000'
WHERE [GoldTypeId] = 3;
SELECT @@ROWCOUNT;


INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251005181849_UpdateModel_2025', N'9.0.9');

CREATE TABLE [AspNetRoles] (
    [Id] nvarchar(450) NOT NULL,
    [Name] nvarchar(256) NULL,
    [NormalizedName] nvarchar(256) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoles] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetUsers] (
    [Id] nvarchar(450) NOT NULL,
    [UserName] nvarchar(256) NULL,
    [NormalizedUserName] nvarchar(256) NULL,
    [Email] nvarchar(256) NULL,
    [NormalizedEmail] nvarchar(256) NULL,
    [EmailConfirmed] bit NOT NULL,
    [PasswordHash] nvarchar(max) NULL,
    [SecurityStamp] nvarchar(max) NULL,
    [ConcurrencyStamp] nvarchar(max) NULL,
    [PhoneNumber] nvarchar(max) NULL,
    [PhoneNumberConfirmed] bit NOT NULL,
    [TwoFactorEnabled] bit NOT NULL,
    [LockoutEnd] datetimeoffset NULL,
    [LockoutEnabled] bit NOT NULL,
    [AccessFailedCount] int NOT NULL,
    CONSTRAINT [PK_AspNetUsers] PRIMARY KEY ([Id])
);

CREATE TABLE [AspNetRoleClaims] (
    [Id] int NOT NULL IDENTITY,
    [RoleId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserClaims] (
    [Id] int NOT NULL IDENTITY,
    [UserId] nvarchar(450) NOT NULL,
    [ClaimType] nvarchar(max) NULL,
    [ClaimValue] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserLogins] (
    [LoginProvider] nvarchar(450) NOT NULL,
    [ProviderKey] nvarchar(450) NOT NULL,
    [ProviderDisplayName] nvarchar(max) NULL,
    [UserId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY ([LoginProvider], [ProviderKey]),
    CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserRoles] (
    [UserId] nvarchar(450) NOT NULL,
    [RoleId] nvarchar(450) NOT NULL,
    CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY ([UserId], [RoleId]),
    CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY ([RoleId]) REFERENCES [AspNetRoles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [AspNetUserTokens] (
    [UserId] nvarchar(450) NOT NULL,
    [LoginProvider] nvarchar(450) NOT NULL,
    [Name] nvarchar(450) NOT NULL,
    [Value] nvarchar(max) NULL,
    CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY ([UserId], [LoginProvider], [Name]),
    CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY ([UserId]) REFERENCES [AspNetUsers] ([Id]) ON DELETE CASCADE
);

CREATE INDEX [IX_GoldPriceLogs_GoldPriceId] ON [GoldPriceLogs] ([GoldPriceId]);

CREATE INDEX [IX_AspNetRoleClaims_RoleId] ON [AspNetRoleClaims] ([RoleId]);

CREATE UNIQUE INDEX [RoleNameIndex] ON [AspNetRoles] ([NormalizedName]) WHERE [NormalizedName] IS NOT NULL;

CREATE INDEX [IX_AspNetUserClaims_UserId] ON [AspNetUserClaims] ([UserId]);

CREATE INDEX [IX_AspNetUserLogins_UserId] ON [AspNetUserLogins] ([UserId]);

CREATE INDEX [IX_AspNetUserRoles_RoleId] ON [AspNetUserRoles] ([RoleId]);

CREATE INDEX [EmailIndex] ON [AspNetUsers] ([NormalizedEmail]);

CREATE UNIQUE INDEX [UserNameIndex] ON [AspNetUsers] ([NormalizedUserName]) WHERE [NormalizedUserName] IS NOT NULL;

ALTER TABLE [GoldPriceLogs] ADD CONSTRAINT [FK_GoldPriceLogs_GoldPrices_GoldPriceId] FOREIGN KEY ([GoldPriceId]) REFERENCES [GoldPrices] ([GoldPriceId]) ON DELETE CASCADE;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251220024116_AddIdentity', N'9.0.9');

ALTER TABLE [AspNetUsers] ADD [FullName] nvarchar(max) NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251220033554_AddFullNameToAspNetUsers', N'9.0.9');

DECLARE @var33 sysname;
SELECT @var33 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Website');
IF @var33 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var33 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Website] nvarchar(250) NULL;

DECLARE @var34 sysname;
SELECT @var34 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'TaxCode');
IF @var34 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var34 + '];');
ALTER TABLE [Companies] ALTER COLUMN [TaxCode] nvarchar(250) NULL;

DECLARE @var35 sysname;
SELECT @var35 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Phone');
IF @var35 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var35 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Phone] nvarchar(250) NULL;

DECLARE @var36 sysname;
SELECT @var36 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Email');
IF @var36 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var36 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Email] nvarchar(250) NULL;

DECLARE @var37 sysname;
SELECT @var37 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'Address');
IF @var37 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var37 + '];');
ALTER TABLE [Companies] ALTER COLUMN [Address] nvarchar(250) NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20251221095443_AllowNullOnCompanyTable', N'9.0.9');

DECLARE @var38 sysname;
SELECT @var38 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'ModifiedDate');
IF @var38 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var38 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [ModifiedDate] datetime NULL;

DECLARE @var39 sysname;
SELECT @var39 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'DeletedDate');
IF @var39 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var39 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [DeletedDate] datetime NULL;

DECLARE @var40 sysname;
SELECT @var40 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldTypes]') AND [c].[name] = N'CreatedDate');
IF @var40 IS NOT NULL EXEC(N'ALTER TABLE [GoldTypes] DROP CONSTRAINT [' + @var40 + '];');
ALTER TABLE [GoldTypes] ALTER COLUMN [CreatedDate] datetime NULL;

DECLARE @var41 sysname;
SELECT @var41 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'ModifiedDate');
IF @var41 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var41 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [ModifiedDate] datetime NULL;

DECLARE @var42 sysname;
SELECT @var42 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'DeletedDate');
IF @var42 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var42 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [DeletedDate] datetime NULL;

DECLARE @var43 sysname;
SELECT @var43 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'CreatedDate');
IF @var43 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var43 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [CreatedDate] datetime NULL;

DECLARE @var44 sysname;
SELECT @var44 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPrices]') AND [c].[name] = N'ApplyDate');
IF @var44 IS NOT NULL EXEC(N'ALTER TABLE [GoldPrices] DROP CONSTRAINT [' + @var44 + '];');
ALTER TABLE [GoldPrices] ALTER COLUMN [ApplyDate] datetime NOT NULL;

DECLARE @var45 sysname;
SELECT @var45 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'ModifiedDate');
IF @var45 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var45 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [ModifiedDate] datetime NULL;

DECLARE @var46 sysname;
SELECT @var46 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'DeletedDate');
IF @var46 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var46 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [DeletedDate] datetime NULL;

DECLARE @var47 sysname;
SELECT @var47 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[GoldPriceLogs]') AND [c].[name] = N'CreatedDate');
IF @var47 IS NOT NULL EXEC(N'ALTER TABLE [GoldPriceLogs] DROP CONSTRAINT [' + @var47 + '];');
ALTER TABLE [GoldPriceLogs] ALTER COLUMN [CreatedDate] datetime NULL;

DECLARE @var48 sysname;
SELECT @var48 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'ModifiedDate');
IF @var48 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var48 + '];');
ALTER TABLE [Companies] ALTER COLUMN [ModifiedDate] datetime NULL;

DECLARE @var49 sysname;
SELECT @var49 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'DeletedDate');
IF @var49 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var49 + '];');
ALTER TABLE [Companies] ALTER COLUMN [DeletedDate] datetime NULL;

DECLARE @var50 sysname;
SELECT @var50 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Companies]') AND [c].[name] = N'CreatedDate');
IF @var50 IS NOT NULL EXEC(N'ALTER TABLE [Companies] DROP CONSTRAINT [' + @var50 + '];');
ALTER TABLE [Companies] ALTER COLUMN [CreatedDate] datetime NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20260101030215_Sql2005_Compatible', N'9.0.9');

COMMIT;
GO

