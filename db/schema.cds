namespace expense.tracker;

entity Users {
    key ID : UUID;
    username : String(100);
    email : String(100);
}

entity Categories {
    key ID : UUID;
    name : String(100);
    description : String(255);
}

entity Expenses {
    key ID : UUID;
    amount : Decimal(10,2);
    category : Association to Categories;
    date : Date;
    paymentMethod : String(20); // E.g., "Credit Card", "Cash"
    user : Association to Users;
    description : String(255);
}

entity Budgets {
    key ID : UUID;
    user : Association to Users;
    category : Association to Categories;
    amount : Decimal(10,2);
    month : String(7); // E.g., "2024-09" for monthly budgeting
}
