module "rds_sg" {
  #this module depends on wy_vpc module
  source        = "./rds_sg"
  sg_name       = var.sg_name
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  project_name  = var.project_name
  env_prefix    = var.env_prefix
  vpc_id        = var.vpc_id
}
resource "aws_db_instance" "wy_rds" {
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  allocated_storage      = var.allocated_storage
  max_allocated_storage  = var.max_allocated_storage
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  availability_zone      = var.avail_zone
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  identifier             = "${var.env_prefix}-${var.db_instance_name}"
  #identifier must be lowercase and hyphen must have two subnet(different AZ) in db subnet group
  #The DB cluster identifier is case-insensitive, but is stored as all lowercase (as in "mydbcluster"). 
  #Constraints: 1 to 60 alphanumeric characters or hyphens. First character must be a letter. Can't contain two consecutive hyphens. Can't end with a hyphen.
  multi_az            = false
  skip_final_snapshot = true
  storage_type        = var.storage_type
  lifecycle {
    prevent_destroy = false
  }
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.env_prefix}-${var.db_instance_name}-db-subnet-group"
  subnet_ids = [var.db_subnet_1, var.db_subnet_2]

  tags = {
    Name = "${var.env_prefix}-${var.db_instance_name}-db-subnet-group"
  }
}