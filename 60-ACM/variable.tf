
variable "project_name" {
    default = "expense"
}

variable "environment" {
    default = "dev"
}

variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
    }
}

variable "domain_name" {
    default = "shabbupractice.online"
}

variable "zone_id" {
    default = "Z084046431X0IIGJQE1G7"
}
