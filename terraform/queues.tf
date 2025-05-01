

resource "rabbitmq_vhost" "email_domain" {
  name = "test_vhost" # Declare a vhost first
}

resource "rabbitmq_queue" "email_to_parse" {
  name  = "email_to_parse"
  vhost = rabbitmq_vhost.email_domain.name #  Use the vhost name

  settings {
    durable     = true  #  The queue will survive server restarts
    auto_delete = false #  The queue will not be deleted when the last consumer disconnects
    arguments = {
      # "x-message-ttl" : 60000,
      "x-dead-letter-exchange" : "failed_email_to_parse"
    }

  }
}


