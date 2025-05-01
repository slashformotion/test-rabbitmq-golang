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

