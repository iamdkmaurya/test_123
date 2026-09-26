# 1. Make sure you're in the repo folder
cd your-repo-name

# 2. Check current status
git status

# 3. Make a small change (or just touch a test file)
echo "test" >> test-integration.txt

# 4. Stage the change
git add test-integration.txt

# 5. Commit it
git commit -m "test: verify ServiceNow webhook integration"

# 6. Push to GitHub
git push origin <branch-name>
