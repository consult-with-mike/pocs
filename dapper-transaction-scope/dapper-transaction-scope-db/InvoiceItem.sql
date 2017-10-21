CREATE TABLE [dbo].[InvoiceItem]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1), 
    [InvoiceId] INT NOT NULL, 
    [ItemId] INT NOT NULL, 
    [Qty] INT NOT NULL, 
    CONSTRAINT [FK_InvoiceItem_Invoice] FOREIGN KEY ([InvoiceId]) REFERENCES [Invoice]([Id]), 
    CONSTRAINT [FK_InvoiceItem_Item] FOREIGN KEY ([ItemId]) REFERENCES [Item]([Id])
)
