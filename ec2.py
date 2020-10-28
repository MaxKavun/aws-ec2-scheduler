import boto3

class ManageEc2():
  
  def __init__(self, tags):
    print("Hello")
    self.aws = boto3.client('ec2')
    self.tags = tags
    self.instances = self.collect()

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

  def collect(self):
    print('Collection instances...')
    instances = self.aws.describe_instances(
      Filters=[
        {
           "Name": f"tag:{self.tags['Key']}",
           "Values": [self.tags['Value'],]
        },
      ],
    )
    instanceIds = []
    for x in instances['Reservations']:
      for instance in x['Instances']:
        instanceIds.append(instance['InstanceId'])
    return(instanceIds)

