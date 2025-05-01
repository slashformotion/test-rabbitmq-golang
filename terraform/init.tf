terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = ">= 1.7.0" # Use a recent version
    }
  }
}

provider "rabbitmq" {
  endpoint = "http://localhost:15672" # e.g., "amqp://user:password@host:port"
  username = "guest"                  # Alternatively, use username/password
  password = "guest"
}


resource "rabbitmq_vhost" "test_vhost" {
  name = "test_vhost" # Declare a vhost first
}

resource "rabbitmq_queue" "my_queue" {
  name  = "my_queue_name"
  vhost = rabbitmq_vhost.test_vhost.name #  Use the vhost name

  settings {
    durable     = true  #  The queue will survive server restarts
    auto_delete = false #  The queue will not be deleted when the last consumer disconnects
    arguments = {
      # "x-message-ttl" : 60000,
      "x-dead-letter-exchange" : "my_dlx"
    }

    # arguments_json = jsonencode({ # For complex argument types
    #   "x-message-ttl" = 60000
    #   "x-dead-letter-exchange" = "my_dlx"
    # })
  }
}


