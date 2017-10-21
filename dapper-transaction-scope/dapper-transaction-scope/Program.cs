using Dapper;
using System;
using System.Data.SqlClient;
using System.Transactions;

namespace dapper_transaction_scope
{
    class Program
    {
        const string connectionString = @"Data Source=CWM001\SQL2014;Initial Catalog=dapper-transaction-scope;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=True";
        const string INSERT_CUSTOMER = "INSERT INTO Customer (Name) VALUES (@Name); SELECT CAST(SCOPE_IDENTITY() as int)";
        const string INSERT_ITEM = "INSERT INTO Item (Name) VALUES (@Name); SELECT CAST(SCOPE_IDENTITY() as int)";
        const string INSERT_INVOICE = "INSERT INTO Invoice (CustomerId) VALUES (@CustomerId); SELECT CAST(SCOPE_IDENTITY() as int)";
        const string INSERT_INVOICE_ITEM = "INSERT INTO InvoiceItem (InvoiceId, ItemId, Qty) VALUES (@InvoiceId, @ItemId, @Qty); SELECT CAST(SCOPE_IDENTITY() as int)";
        private const string CUSTOMER_NAME = "Test Customer";
        private const string ITEM_NAME = "Test Item";

        static void Main(string[] args)
        {
            try
            {
                InsertStack();
                InsertStack();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }

        static void InsertStack()
        {
            using (var transactionScope = new TransactionScope())
            {
                var customerId = InsertCustomer(CUSTOMER_NAME);
                Console.WriteLine("Inserted customer {0} with id {1}.", CUSTOMER_NAME, customerId);

                var itemId = InsertItem(ITEM_NAME);
                Console.WriteLine("Inserted item {0} with id {1}.", ITEM_NAME, itemId);

                var invoiceId = InsertInvoice(customerId);
                Console.WriteLine("Inserted invoice {0} for customer {1}.", invoiceId, customerId);

                var invoiceItemId = InsertInvoiceItem(invoiceId, itemId, 10);
                Console.WriteLine("Inserted invoice item {0} for invoice {1} with id {2}.", itemId, invoiceId, invoiceItemId);

                transactionScope.Complete();
            }
        }

        static int InsertCustomer(string name)
        {
            using (var sqlConnection = new SqlConnection(connectionString))
            {
                return sqlConnection.ExecuteScalar<int>(INSERT_CUSTOMER, new { Name = name });
            }
        }

        static int InsertItem(string name)
        {
            using (var sqlConnection = new SqlConnection(connectionString))
            {
                return sqlConnection.ExecuteScalar<int>(INSERT_ITEM, new { Name = name });
            }
        }

        static int InsertInvoice(int customerId)
        {
            using (var sqlConnection = new SqlConnection(connectionString))
            {
                return sqlConnection.ExecuteScalar<int>(INSERT_INVOICE, new { CustomerId = customerId });
            }
        }

        static int InsertInvoiceItem(int invoiceId, int itemId, int qty)
        {
            using (var sqlConnection = new SqlConnection(connectionString))
            {
                return sqlConnection.ExecuteScalar<int>(INSERT_INVOICE_ITEM, new { InvoiceId = invoiceId, ItemId = itemId, Qty = qty });
            }
        }
    }
}
