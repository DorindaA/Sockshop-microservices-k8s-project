# Create Master Security Group
resource "aws_security_group" "dori_Master_lb_sg" {
  name        = "dori_Master_lb_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id


    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 31090
    to_port     = 31090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dori_Master_lb_sg"
  }
}

### Creating Application Load Balancer master
resource "aws_lb" "master-lb" {
  name               = "master-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dori_Master_lb_sg.id]
  subnets          = var.doripubsub1_id

  # enable_deletion_protection = true

  tags = {
    Environment = "Application_load_balance"
  }
}

## Creating the target group - master
resource "aws_lb_target_group" "master-tg" {
  name     = "master-tg"
  port     = 30001
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    
  }
}
## Create master Load balance target group attachement
resource "aws_lb_target_group_attachment" "master_attachmenet_TG" {
  target_group_arn = aws_lb_target_group.master-tg.arn
  target_id        = var.master_id
    port             = 30001
}

### Create master listener
resource "aws_lb_listener" "master-lb_listener" {
  load_balancer_arn = aws_lb.master-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.master-tg.arn
  }
}


# Create worker1 Security Group
resource "aws_security_group" "dori_worker1_lb_sg" {
  name        = "dori_worker1_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id


    ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 31090
    to_port     = 31090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dori_worker1_sg"
  }
}

### Creating Application Load Balancer worker1
resource "aws_lb" "worker1-lb" {
  name               = "worker1-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dori_worker1_lb_sg.id]
  subnets         = var.doripubsub1_id

  # enable_deletion_protection = true

  tags = {
    Environment = "Application_load_balance"
  }
}

## Creating the target group - worker1
resource "aws_lb_target_group" "worker1-tg" {
  name     = "worker1-tg"
  port     = 30001
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    
  }
}
## Create worker1 Load balance target group attachement
resource "aws_lb_target_group_attachment" "worker1_attachmenet_TG" {
  target_group_arn = aws_lb_target_group.worker1-tg.arn
  target_id        = var.worker1_id
    port             = 30001
}

### Create worker1 listener
resource "aws_lb_listener" "worker1-lb_listener" {
  load_balancer_arn = aws_lb.worker1-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.worker1-tg.arn
  }
}

# Create worker2 Security Group
resource "aws_security_group" "dori_worker2_lb_sg" {
  name        = "dori_worker2_sg"
  description = "Allow inbound traffic"
  vpc_id      = var.vpc_id


    ingress {

    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  ingress {
    from_port   = 30001
    to_port     = 30001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 31090
    to_port     = 31090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "dori_worker2_sg"
  }
}

### Creating Application Load Balancer worker2
resource "aws_lb" "worker2-lb" {
  name               = "worker2-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dori_worker2_lb_sg.id]
  subnets = var.doripubsub1_id

  # enable_deletion_protection = true

  tags = {
    Environment = "Application_load_balance"
  }
}

## Creating the target group - worker2
resource "aws_lb_target_group" "worker2-tg" {
  name     = "worker2-tg"
  port     = 30001
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    
  }
}
## Create worker2 Load balance target group attachement
resource "aws_lb_target_group_attachment" "worker2_attachmenet_TG" {
  target_group_arn = aws_lb_target_group.worker2-tg.arn
  target_id        = var.worker2_id
    port             = 30001
}

### Create worker2 listener
resource "aws_lb_listener" "worker2-lb_listener" {
  load_balancer_arn = aws_lb.worker2-lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.worker2-tg.arn
  }
}
