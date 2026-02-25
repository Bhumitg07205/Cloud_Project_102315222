#!/bin/bash

# Expense Tracker Backend - EC2 Deployment Script
# Run this on your EC2 instance

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Expense Tracker Backend Deployment ===${NC}\n"

# Step 1: Update system
echo -e "${YELLOW}Step 1: Updating system...${NC}"
sudo apt update && sudo apt upgrade -y
echo -e "${GREEN}✓ System updated${NC}\n"

# Step 2: Install Docker
echo -e "${YELLOW}Step 2: Installing Docker...${NC}"
sudo apt install -y docker.io
echo -e "${GREEN}✓ Docker installed${NC}\n"

# Step 3: Install Docker Compose
echo -e "${YELLOW}Step 3: Installing Docker Compose...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo -e "${GREEN}✓ Docker Compose installed${NC}\n"

# Step 4: Verify installations
echo -e "${YELLOW}Step 4: Verifying installations...${NC}"
docker --version
docker-compose --version
echo -e "${GREEN}✓ Installations verified${NC}\n"

# Step 5: Add user to docker group
echo -e "${YELLOW}Step 5: Adding user to docker group...${NC}"
sudo usermod -aG docker $USER
echo -e "${GREEN}✓ User added to docker group${NC}"
echo -e "${YELLOW}Note: You may need to log out and log back in for this to take effect${NC}\n"

# Step 6: Create app directory
echo -e "${YELLOW}Step 6: Setting up application directory...${NC}"
APP_DIR="/home/ubuntu/expense-tracker"
mkdir -p $APP_DIR
cd $APP_DIR
echo -e "${GREEN}✓ Application directory ready: $APP_DIR${NC}\n"

# Step 7: Instructions for next steps
echo -e "${GREEN}=== Deployment Setup Complete ===${NC}\n"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. Clone your repository:"
echo "   git clone <your-repo-url>"
echo "   cd ocr+aws/backend"
echo ""
echo "2. Create .env file with your credentials:"
echo "   nano .env"
echo ""
echo "3. Add these environment variables:"
echo "   TABLE_NAME=expense-tracker-stack-ExpenseTable-8LYNNT1YLLXA"
echo "   UPLOAD_BUCKET=expense-tracker-receipts-247006162678-us-east-1"
echo "   SNS_TOPIC_ARN=arn:aws:sns:us-east-1:247006162678:monthly-expense-summary"
echo "   COGNITO_USER_POOL_ID=us-east-1_ABceXgGSa"
echo "   COGNITO_CLIENT_ID=3u5q66p8p8a4amncvouesakb1l"
echo "   PORT=3001"
echo "   JWT_SECRET=your-production-secret-key"
echo "   AWS_REGION=us-east-1"
echo "   AWS_ACCESS_KEY_ID=your-access-key-id"
echo "   AWS_SECRET_ACCESS_KEY=your-secret-access-key"
echo ""
echo "4. Start the backend:"
echo "   docker-compose up -d"
echo ""
echo "5. Check status:"
echo "   docker-compose ps"
echo ""
echo "6. View logs:"
echo "   docker-compose logs -f expense-tracker-backend"
echo ""
echo "7. Test health endpoint:"
echo "   curl http://localhost:3001/health"
echo ""
