#!/usr/bin/env python
import pika
for i in range(1, 10000):
  credentials = pika.PlainCredentials('test_user', 'test')
  #parameters = pika.ConnectionParameters('localhost', 5672, 'test_host', credentials)
  #connection = pika.BlockingConnection(parameters)
  connection = pika.BlockingConnection(pika.ConnectionParameters('62.84.118.1', 5672, '/', credentials))
  channel = connection.channel()
  channel.queue_declare(queue='hello')
  channel.basic_publish(exchange='', routing_key='hello', body='Hello Netology!')
connection.close()
