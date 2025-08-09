variable "aws_ec2_instance_type" {
    default= "t2.medium"
    type = string
}

variable "ec2_ami" {
    default = "ami-020cba7c55df1f615"
    type = string
}

variable "ebs_volume_size" {
    default = 20
    type = number
}

variable "cluster_name" {
  description = "bg-eks-cluster"
  type        = string
  default     = "my-eks-cluster"
}

// pass - bg