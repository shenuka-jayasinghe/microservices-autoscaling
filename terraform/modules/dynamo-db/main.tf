resource "aws_dynamodb_table" "lighting_table" {
  name           = "lighting"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }


  global_secondary_index {
    name               = "locationIndex"
    hash_key           = "id"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["status","location"]

  }


  tags = {
    Name        = "lighting-table-1"
    Environment = "production"
  }
}

resource "aws_dynamodb_table" "heating_table" {
  name           = "heating"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "id"

  attribute {
    name = "id"
    type = "N"
  }


  global_secondary_index {
    name               = "locationIndex"
    hash_key           = "id"
    write_capacity     = 10
    read_capacity      = 10
    projection_type    = "INCLUDE"
    non_key_attributes = ["status","location"]
  }


  tags = {
    Name        = "heating-table-1"
    Environment = "production"
  }
}