# #!/bin/bash

# # AWS CLI Profile Name
# AWS_PROFILE_NAME="default"

# # AWS Credentials (Modify to take input dynamically if needed)
# AWS_ACCESS_KEY_ID="AKIA4SYAMBWQNCHWSSUX"
# AWS_SECRET_ACCESS_KEY="A5aRyIqjx1Qk5Ngc/1t1CFuRvdiJfxpsNxtwtvs"
# AWS_REGION="us-east-1"  # Change to your desired AWS region

# # Configure AWS CLI profile
# aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile "$AWS_PROFILE_NAME"
# aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$AWS_PROFILE_NAME"
# aws configure set region "$AWS_REGION" --profile "$AWS_PROFILE_NAME"

# # Export AWS profile to be used in subsequent commands
# export AWS_PROFILE="$AWS_PROFILE_NAME"

# echo "AWS Profile '$AWS_PROFILE_NAME' configured successfully!"


#!/bin/bash

mkdir -p ~/.aws

cat > ~/.aws/credentials <<EOL
[default]
aws_access_key_id=AKIA4SYAMBWQNCHWSSUX
aws_secret_access_key=A5aRyIqjx1Qk5Ngc/1t1CFuRvdiJfxpsNxtwtvs
region=us-east-1
EOL

cat > ~/.aws/config <<EOL
[default]
region=us-east-1
output=json
EOL

echo "AWS credentials configured successfully!"
