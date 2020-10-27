import boto3

class Scheduler():

  def __init__(self, action, tag):
    
    self.tag = tag
    self.action = action
