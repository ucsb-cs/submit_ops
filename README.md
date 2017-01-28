# Submit CS

The purpose of this repository is to facilitate building and launching new
instances of the submission service.

## Prerequisites

In order to talk with Amazon, please create or add to an existing
`~/.aws/credentials` file. Its contents should contain a `submit` section with
your aws credentials similar to the following:

```ini
[submit]
aws_access_key_id = AKIQWERTYUIOPASDFGHJ
aws_secret_access_key = ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcd
```

### References

* https://www.packer.io/docs/builders/amazon.html#specifying-amazon-credentials

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

## Cleaning Up

Cleaning up AMI instances is a two part process. See the instructions
pertaining to AMI removal at:
https://www.packer.io/intro/getting-started/build-image.html#managing-the-image
