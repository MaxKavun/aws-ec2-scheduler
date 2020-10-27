import boto3

class CollectResources():

  def __init__(self, resource, tag):
    self.resource = resource
    self.tag = tag
    self.aws = boto3.client(resource)

  def collect(self):
    print("Hello")
