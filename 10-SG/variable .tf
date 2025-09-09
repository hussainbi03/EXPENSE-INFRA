variable "project" {
    default = "expense"

}

variable "environment" {
    default = "dev"

}


variable "description" {
    default = "security group for mysql"

}

variable "common_tags" {
    default = {
        project = "EXPENSE"
        environment = " dev"
        terraform = "true"
    }
}



