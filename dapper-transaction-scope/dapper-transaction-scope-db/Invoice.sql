CREATE TABLE [dbo].[Invoice]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY(1, 1), 
    [CustomerId] INT NOT NULL, 
    CONSTRAINT [FK_Invoice_Customer] FOREIGN KEY ([Id]) REFERENCES [Customer]([Id])
)
