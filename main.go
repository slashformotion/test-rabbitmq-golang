package main

import (
	"fmt"

	amqp "github.com/rabbitmq/amqp091-go"
)

func main() {
	conn, err := amqp.Dial("amqp://guest:guest@localhost:5672/")
	defer conn.Close()
	if err != nil {
		panic(err)
	}
	fmt.Println("hello")
}
