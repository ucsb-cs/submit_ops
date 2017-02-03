# Submit CS

The purpose of this repository is to facilitate building and launching new
instances of the submission service.

## Prerequisites

### Local AWS Credentials

In order to talk with Amazon, please create or add to an existing
`~/.aws/credentials` file. Its contents should contain a `submit` section with
your aws credentials similar to the following:

```ini
[submit]
aws_access_key_id = AKIQWERTYUIOPASDFGHJ
aws_secret_access_key = ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcd
```

### AWS Key Pair

In order to SSH into your launched instances, you will need to have imported
your SSH public key to AWS. Visit the following URL, and click the "Import Key
Pair" button to add your SSH public key:

https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:sort=keyName

Provide the keypair with a unique name, which will later be referred to as
`KEYNAME`.

### References

* https://www.packer.io/docs/builders/amazon.html#specifying-amazon-credentials
* https://www.terraform.io/docs/providers/aws/index.html#shared-credentials-file

## Build AMI

To build AMIs you first need to setup the packer tool. The first part of its
quick start guide should be sufficient:
https://www.packer.io/intro/getting-started/setup.html

Once the tool is installed you should be able to run:

```sh
packer build submit.json
```

Following the run keep note of the created AMI image, which should be provided
in the last line of the output.

## Launch Service

To deploy the service to AWS you need to setup the terraform tool. Its
installation guide should be sufficient:
https://www.terraform.io/intro/getting-started/install.html

### Planning

Once installed, the first thing we want to do is see what resources will be
created. We can do that by running:

```sh
TF_VAR_ami=AMI_VALUE TF_VAR_key_name=KEYNAME terraform plan
```

Replace `AMI_VALUE` with the AMI output provided by `packer`. The value should
start with `ami-`. Similarly replace `KEYNAME` with the name you provided to
your imported ssh public key.

The output of the command should end with a summary like:

> Plan: 4 to add, 0 to change, 0 to destroy.

If you already have an instace of the service running, it might not have
anything to do, or if you've made some changes the effect of running terraform
should be properly summarized.

### Applying

Run the following to actually launch/update your serice:

```sh
TF_VAR_ami=AMI_VALUE TF_VAR_key_name=KEYNAME terraform apply
```

Again replace `AMI_VALUE`, and `KEYNAME` with the AMI that you would like to
use, and public key respectively.

## Connecting

The IP address of the running server should be output at the end of `terraform
apply`. You can use that IP address to connect both via the web, and ssh:

* http://ipaddress
* ssh ec2-user@ipaddress

__TODO__: At the moment you need to ssh into the machine and run
`update_submit` before it is properly reachable via http.

## Setting Up Users

When the submit service starts up, no users are able to connect because none
exist. SSH into the instance, and execute `submit_shell` to drop into the
application's shell. From there create a new admin user:

```python
s.add(user(name='Admin User', username='admin', password='PASSWORD', is_admin=True))
t.commit()
```

Then you can exit the shell, or create more users.

## Cleaning Up

To terminate your running AWS resources run:

```sh
TF_VAR_ami=AMI_VALUE TF_VAR_key_name=KEYNAME terraform destroy
```

__Note__: You can use any non-empty value in place of `AMI_VALUE` and `KEYNAME`
when destroying resources.

For more information on destroy please see:
https://www.terraform.io/intro/getting-started/destroy.html

Cleaning up AMI instances is a two part process. See the instructions
pertaining to AMI removal at:
https://www.packer.io/intro/getting-started/build-image.html#managing-the-image
