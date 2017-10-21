namespace dapper_transaction_scope.Models
{
    public class InvoiceItem
    {
        public int Id { get; set; }

        public int InvoiceId { get; set; }

        public int ItemId { get; set; }

        public int Qty { get; set; }
    }
}
