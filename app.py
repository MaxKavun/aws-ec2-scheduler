import os

from ec2 import ManageEc2

def lambda_handler(event, context):
    tags = {"Key": os.getenv("TAG_KEY"), "Value": os.getenv("TAG_VALUE")}
    schedule_action = os.getenv("SCHEDULE_ACTION")
    ec2_handler = os.getenv("EC2_SCHEDULE")
    ec2_manager = ManageEc2(tags)
    if(schedule_action == "start"):
      ec2_manager.start()
    elif(schedule_action == "stop"):
      ec2_manager.stop()

lambda_handler("lol","kek")
