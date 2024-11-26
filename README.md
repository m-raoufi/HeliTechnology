# 1.CloudFormation Template: S3 Bucket Creation

This CloudFormation template will create an S3 bucket named HeliTechnology in the default region.

### CloudFormation Template (YAML format):
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Resources:
  S3HeliTechnologyBucket:
    Type: 'AWS::S3::Bucket'
    Properties:
      BucketName: 'HeliTechnology'
      VersioningConfiguration:
        Status: 'Enabled'
      Tags:
        - Key: 'Environment'
          Value: 'Production'
```
### Steps to Use the CloudFormation Template:
#### 1. Create a CloudFormation Stack:

- Go to the AWS Management Console.
- Navigate to CloudFormation.
- Click Create Stack → With new resources (standard).
- Select Template is ready and choose Upload a template file.
- Upload the YAML file and follow the prompts to create the stack.
#### 2.Monitor the Stack Creation:

- Once the stack is created, it will provision an S3 bucket with the name `HeliTechnology`, versioning enabled, and a `Production` tag.

---

### 2. AWS CDK Script to Create an S3 Bucket
To create an S3 bucket using AWS CDK, you first need to set up a basic AWS CDK project.

#### Steps for CDK Creation:
#### 1. Install AWS CDK (if you haven’t already): Ensure you have Node.js and npm installed, and then install AWS CDK globally:

```
npm install -g aws-cdk
```

#### 2.Set Up a New CDK Project:
- Create a new directory for the project:
```
mkdir cdk-s3-bucket
cd cdk-s3-bucket
```
#### 3.Initialize a new CDK app:
- Install the `@aws-cdk/aws-s3` module, which allows you to create S3 buckets:
```
npm install @aws-cdk/aws-s3
```
#### 4.Update the `lib/cdk-s3-bucket-stack.ts` File:
Replace the default stack with this code to create the S3 bucket:
```
import * as cdk from 'aws-cdk-lib';
import * as s3 from 'aws-cdk-lib/aws-s3';

export class CdkS3BucketStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new s3.Bucket(this, 'HeliTechnology', {
      bucketName: 'HeliTechnology', // Ensure the bucket name is unique globally
      versioned: true,              // Enable versioning for the bucket
      removalPolicy: cdk.RemovalPolicy.DESTROY, // This will delete the bucket when the stack is deleted
      autoDeleteObjects: true,      // Automatically deletes objects when the stack is deleted
      lifecycleRules: [
        {
          enabled: true,
          expiration: cdk.Duration.days(365),  // Automatically delete objects after 365 days
        },
      ],
      tags: {
        Environment: 'Production',
      },
    });
  }
}
```
#### 5.Deploy the CDK Stack:
- Run the following commands to deploy the stack:
```
cdk bootstrap         # Only needed once to set up the environment
cdk deploy            # Deploys the stack and creates the S3 bucket
```
#### 6.Monitor the Deployment:

- After deployment, the stack will create the S3 bucket named `HeliTechnology`, with versioning enabled and the specified lifecycle rules.

### 3.Summary of Steps for CDK Creation
##### 1. Install AWS CDK: npm install -g aws-cdk.
##### 2. Initialize Project: cdk init app --language=typescript.
##### 3. Install S3 Module: npm install @aws-cdk/aws-s3.
##### 4. Create the Stack: Define the S3 bucket in cdk-s3-bucket-stack.ts.
##### 5. Deploy the Stack: Use cdk deploy.

## Conclusion
- CloudFormation provides a declarative way to create infrastructure but requires YAML or JSON for configuration.

- AWS CDK provides a more programmatic approach, allowing you to define resources in familiar programming languages like TypeScript, Python, or Java.

Both approaches will create the same HeliTechnology S3 bucket with versioning and the necessary tags.