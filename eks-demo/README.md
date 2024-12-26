# Setting up AWS EKS (Hosted Kubernetes)

See https://www.terraform.io/docs/providers/aws/guides/eks-getting-started.html for full guide


## Download kubectl
```
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.31.2/2024-11-15/bin/linux/amd64/kubectl
chmod +x kubectl
sudo mv kubectl /usr/local/bin
```

## Gaining Kubeconfig
```
aws eks update-kubeconfig --region region-code --name my-cluster
```

## Modify providers.tf

Choose your region. EKS is not available in every region, use the Region Table to check whether your region is supported: https://aws.amazon.com/about-aws/global-infrastructure/regional-product-services/

Make changes in providers.tf accordingly (region, optionally profile)

## Terraform apply
```
terraform init
terraform apply
```

## Configure config-map-auth-aws
```
terraform output config-map-aws-auth # save output in config-map-aws-auth.yaml
kubectl apply -f config-map-aws-auth.yaml
```

## See nodes coming up
```
kubectl get nodes
```

## Destroy
Make sure all the resources created by Kubernetes are removed (LoadBalancers, Security groups), and issue:
```
terraform destroy
```
