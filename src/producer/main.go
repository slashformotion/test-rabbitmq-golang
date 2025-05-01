package main

import (
	"log"
	"os"
	"time"

	"log/slog"

	"github.com/go-faker/faker/v4"
	"github.com/google/uuid"
	amqp "github.com/rabbitmq/amqp091-go"
)

func envDefault(key string, d string) string {
	k := os.Getenv(key)
	if k != "" {
		return k
	}
	return d
}

func main() {
	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))

	x := envDefault(
		"BROKER",
		"amqp://guest:guest@localhost:5672/",
	)
	conn, err := amqp.Dial(x)
	if err != nil {
		logger.Error("fail to dial cluster", "url", x, "err", err)
	}

	mail_to_parse := envDefault("QUEUE_MAIL_TO_PARSE", "mail_to_parse")
	channeln, err := conn.Channel()
	if err != nil {
		logger.Error("no channel open ", "err", err)
	}
	defer channeln.Close()
	for {
		time.Sleep(time.Millisecond * 1000)
		err = channeln.Publish("", mail_to_parse, false, false, amqp.Publishing{
			Headers:       map[string]interface{}{},
			ContentType:   "text/plain",
			CorrelationId: uuid.NewString(),
			MessageId:     uuid.NewString(),
			Body:          []byte(faker.Email()),
		})
		if err != nil {
			log.Printf("Push failed: %s\n", err)
		} else {
			log.Println("Push succeeded!")
		}

	}
}
