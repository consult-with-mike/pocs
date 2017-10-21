# Overview
A very simple and concise example of how [`TransactionScope`](https://docs.microsoft.com/en-us/dotnet/api/system.transactions.transactionscope?view=netframework-4.5) works in .NET applications.

**NOTE:** the `Distributed Transaction Coordinator` service *must* be running for `TransactionScope` to work.

# Installation

1. Open the project in VS 2015+
2. Publish the `dapper-transaction-scope-db` project to a local SQL Server
3. Execute the `dapper-transaction-scope` console application

You'll notice that 4 records are inserted and then an exception occurs. The exception occurs because of a unique constraint. This proves the ease of use for both a successful and failed (i.e. rolled back) transaction using `TransactionScope` in .NET.