import boto3

class ManageEc2():
  
  def __init__(self):
    print("Hello")
    self.aws = boto3.client('ec2')

  def stop(self):
    print('Stopping...')
    response = self.aws.stop_instances(
      InstanceIds=[
        'i-0e3dbccdc9b8d2348',
      ]
    )
    print(response)
  
  def start(self):
    print('Starting...')
    response = self.aws.start_instances(
      InstanceIds=[
        'i-0e3dbccdc9b8d2348',
      ],
      DryRun=False
    )
    print(response)


server = ManageEc2()
server.stop()
