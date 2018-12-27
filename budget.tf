resource "aws_budgets_budget" "cost" {
  budget_type  = "COST"
  limit_amount = "${var.max-spend}"
  limit_unit   = "USD"
}
