variable "project" {
    default = "expense"

}

variable "environment" {
    default = "dev"

}


variable "common_tags" {
    default = {
        project = "EXPENSE"
        environment = " dev"
        terraform = "true"
    }
}

variable "zone_id" {
    default = "Z084046431X0IIGJQE1G7"
}

variable "domain_name" {
    default = "shabbupractice.online"
}


