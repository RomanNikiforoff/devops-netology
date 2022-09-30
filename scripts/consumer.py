#!/usr/bin/env python3
# -*- encoding: utf-8 -*-

import pika

credentials = pika.PlainCredentials('username', 'userpass')
parameters = pika.ConnectionParameters('IP', 5672, 'test_host', credentials)
connection = pika.BlockingConnection(parameters)

channel = connection.channel()
channel.queue_declare(queue='hello')

def callback(ch, method, properties, body):
    print("Received %r" % body)

channel.basic_consume(queue='hello', auto_ack=True, on_message_callback=callback)

channel.start_consuming()

print('To exit press CTRL+C')
connection.close()
