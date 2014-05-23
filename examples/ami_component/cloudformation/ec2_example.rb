SparkleFormation.new('ec2_example').load(:ami).overrides do
  description "AWS CloudFormation Sample Template EC2InstanceSample: Create an Amazon EC2 instance running the Amazon Linux AMI. The AMI is chosen based on the region in which the stack is run. This example uses the default security group, so to SSH to the new instance using the KeyPair you enter, you will need to have port 22 open in your default security group. **WARNING** This template an Amazon EC2 instances. You will be billed for the AWS resources used if you create a stack from this template."

  dynamic!(:ec2_instance, :my) do
    properties do
      key_name ref!(:key_name)
      image_id map!(:region_map, 'AWS::Region', :ami)
      user_data base64!('80')
    end
  end

  outputs do
    instance_id do
      description 'InstanceId of the newly created EC2 instance'
      value ref!(:my_ec2_instance)
    end
    az do
      description 'Availability Zone of the newly created EC2 instance'
      value attr!(:my_ec2_instance, :availability_zone)
    end
    public_ip do
      description 'Public IP address of the newly created EC2 instance'
      value attr!(:my_ec2_instance, :public_ip)
    end
    private_ip do
      description 'Private IP address of the newly created EC2 instance'
      value attr!(:my_ec2_instance, :private_ip)
    end
    public_dns do
      description 'Public DNSName of the newly created EC2 instance'
      value attr!(:my_ec2_instance, :public_dns_name)
    end
    private_dns do
      description 'Private DNSName of the newly created EC2 instance'
      value attr!(:my_ec2_instance, :private_dns_name)
    end
  end
end