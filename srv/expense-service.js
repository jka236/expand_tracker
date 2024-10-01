const cds = require("@sap/cds");

module.exports = async function () {
  const { Expenses, Categories, Budgets } = this.entities;

  this.on("GenerateReport", async (req) => {
    const { dateFrom, dateTo, userId } = req.data;

    const expenses = await SELECT.from(Expenses)
      .columns("category_ID", "SUM(amount) as totalAmount")
      .where({ user_ID: userId, date: { ">=": dateFrom, "<=": dateTo } })
      .groupBy("category_ID");

    const categoryNames = await SELECT.from(Categories)
      .columns("ID", "name")
      .where({ ID: expenses.map((e) => e.category_ID) });

    return expenses.map((e) => ({
      category: categoryNames.find((c) => c.ID === e.category_ID).name,
      totalAmount: e.totalAmount,
    }));
  });

  this.on("GetMonthlySpending", async (req) => {
    const { userId, month } = req.data;
    const expenses = await SELECT.from(Expenses)
      .columns("SUM(amount) as totalAmount")
      .where({ user_ID: userId, date: { like: `${month}%` } });

    return expenses[0].totalAmount || 0;
  });
};
