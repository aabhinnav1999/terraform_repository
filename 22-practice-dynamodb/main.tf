resource "aws_dynamodb_table" "my-table" {
    name = "emp"
    billing_mode = "PROVISIONED"
    read_capacity = 1
    write_capacity = 1
    hash_key = "deptno"
    range_key = "empid"

    attribute {
      name = "empid"
      type = "N"
    }

    attribute {
      name = "deptno"
      type = "N"
    }
}

resource "aws_dynamodb_table_item" "my-item" {
  table_name = aws_dynamodb_table.my-table.name
  hash_key   = aws_dynamodb_table.my-table.hash_key

  item = <<ITEM
{
  "deptno": {"N": "19"},
  "empid": {"N": "1904"},
  "ename": {"S": "aabhinnav"},
  "dept": {"S": "Cloud Computing"}

}
ITEM
}