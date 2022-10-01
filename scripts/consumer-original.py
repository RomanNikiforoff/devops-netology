#!/usr/bin/env python
# coding=utf-8
import pika

#connection = pika.BlockingConnection(pika.ConnectionParameters('62.84.118.1', 5672, '/', 'test_user', 'test'))
#channel = connection.channel()
credentials = pika.PlainCredentials('test_user', 'test')
parameters = pika.ConnectionParameters('62.84.118.1', 5672, '/', credentials)
connection = pika.BlockingConnection(parameters)
channel.queue_declare(queue='hello')

def callback(ch, method, properties, body):
    print(" [x] Received %r" % body)


channel.basic_consume(callback, queue='hello', no_ack=True)
channel.start_consuming()
