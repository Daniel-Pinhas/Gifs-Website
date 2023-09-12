import git

# Initialize the Git repo object
repo = git.Repo(".")
changed_files = []

# Iterate through the commits and check for changes in a specific directory
for commit in repo.iter_commits("HEAD"):
    diff = commit.diff("HEAD~1", paths=["App/Flask-Project"])
    if diff:
        changed_files.extend(diff)

# Check if there are any changes in the directory
if changed_files:
    print("Changes detected in the App/Flask-Project directory.")
else:
    print("No changes in the App/Flask-Project directory.")
