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
