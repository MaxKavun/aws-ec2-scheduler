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
      InstanceIds=self.instances
    )
    print(response)
  
  def start(self):
    print('Starting...')
    response = self.aws.start_instances(
      InstanceIds=self.instances,
      DryRun=False
    )
    print(response)

  def collect(self):
    print('Collection instances...')
    filter_name = f"tag:{self.tags['Key']}"
    print(self.tags)
    print(filter_name)
    instances = self.aws.describe_instances(
      Filters=[
        {
           "Name": filter_name,
           "Values": ['dev',]
        },
      ],
    )
    instanceIds = []
    for x in instances['Reservations']:
      for instance in x['Instances']:
        instanceIds.append(instance['InstanceId'])
    return(instanceIds)

