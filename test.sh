#!/bin/bash

# Initialize metrics
build_success=0
artifact_creation=0
deployment_success=0
total_score=0

# Path to the downloaded logs
log_file="workflow_logs.txt"
report_file="yes.txt"

# Step 1: Check Build Success (30%)
echo "Checking Build Success..."
if grep -q "Successfully built" "$log_file"; then
    build_success=30
else
    build_success=0
fi

# Step 2: Check Artifact Creation and Upload (40%)
echo "Checking Artifact Creation and Upload..."
if grep -q "Upload Artifact" "$log_file" && grep -q "artifact uploaded" "$log_file"; then
    artifact_creation=40
else
    artifact_creation=0
fi

# Step 3: Check Deployment Success (30%)
echo "Checking Deployment Success..."
if grep -q "Running container with image" "$log_file"; then
    deployment_success=30
else
    deployment_success=0
fi

# Calculate Total Score
total_score=$((build_success + artifact_creation + deployment_success))

# Generate Report
echo "Generating Report..."
cat <<EOF > "$report_file"
CI/CD Workflow Evaluation Report
===============================
Build Success (%): $build_success
Artifact Creation and Upload (%): $artifact_creation
Deployment Success (%): $deployment_success

Total Score (%): $total_score
EOF

echo "Report generated: $report_file"
