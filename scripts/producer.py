#!/usr/bin/env python
import pika
for i in range(1, 10000):
  credentials = pika.PlainCredentials('username', 'userpass')
  #parameters = pika.ConnectionParameters('localhost', 5672, 'test_host', credentials)
  #connection = pika.BlockingConnection(parameters)
  connection = pika.BlockingConnection(pika.ConnectionParameters('IP', 5672, 'test_host', credentials))
  channel = connection.channel()
  channel.queue_declare(queue='hello')
  channel.basic_publish(exchange='', routing_key='hello', body='Hello Netology!')
connection.close()
