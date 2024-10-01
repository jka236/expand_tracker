using { expense.tracker as et } from '../db/schema';

service ExpenseService {
    entity Users as projection on et.Users;
    entity Categories as projection on et.Categories;
    entity Expenses as projection on et.Expenses;
    entity Budgets as projection on et.Budgets;

    action GenerateReport(dateFrom: Date, dateTo: Date, userId: UUID) returns array of {
        category: String;
        totalAmount: Decimal(10,2);
    };

    action GetMonthlySpending(userId: UUID, month: String) returns Decimal(10,2);
}
