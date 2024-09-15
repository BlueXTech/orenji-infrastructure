# ------------ Security group for Application Load Balancer ------------
resource "aws_security_group" "sg_alb_allow_all_https" {
  name        = "SG_ALB_AllowAllHttps-${var.environment}"
  description = "Security group that allows HTTPS traffic from anywhere"
}

resource "aws_security_group_rule" "sgr_alb_allow_https_inbound" {
  security_group_id = aws_security_group.sg_alb_allow_all_https.id
  description       = "Allow HTTPS traffic from anywhere"
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  to_port           = 443
}

resource "aws_security_group_rule" "sgr_alb_allow_all_outbound" {
  security_group_id = aws_security_group.sg_alb_allow_all_https.id
  description       = "Allow all outbound traffic"
  type              = "egress"
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = -1
  to_port           = -1
}
# ---------------------------------------------------------------------- 

# ------------------ Security group for EC2 instances ------------------
resource "aws_security_group" "sg_ec2_allow_alb_and_ssh" {
  name        = "SG_EC2_AllowAlbAndSSH-${var.environment}"
  description = "Security group that allows traffic from ALB and SSH access"
}

resource "aws_security_group_rule" "sgr_ec2_allow_ssh" {
  security_group_id = aws_security_group.sg_ec2_allow_alb_and_ssh.id
  description       = "Allow SSH access on port 22 from anywhere"
  type              = "ingress"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
}

resource "aws_security_group_rule" "sgr_ec2_allow_alb" {
  security_group_id        = aws_security_group.sg_ec2_allow_alb_and_ssh.id
  description              = "Allow traffic on port 8080 from ALB"
  type                     = "ingress"
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_alb_allow_all_https.id
  from_port                = 8080
  to_port                  = 8080
}

resource "aws_security_group_rule" "sgr_ec2_all_outbound" {
  security_group_id = aws_security_group.sg_ec2_allow_alb_and_ssh.id
  description       = "Allow all outbound traffic"
  type              = "egress"
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = -1
  to_port           = -1
}
