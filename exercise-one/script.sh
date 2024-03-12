# Write a shell script that prints a list of all the open pull requests in all the GitHub organizations
# to which you have access.

# 1) get all orgs we have access to
# 2) Get all repos by org
# 3) List PRs for each repo

set -o pipefail

sudo apt-get install jq

orgs=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_PAT" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/organizations)

org_names=$(echo $orgs | jq -r .[].login)

for org_name in $org_names
do
    repos=$(curl -L \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GH_PAT" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/orgs/$org_name/repos)
done

# flatten repos up to org level, so we don't have to make a nested loop, 
org_repo_names=$(echo $repos | jq -r .[].full_name) 

for org_repo in $org_repo_names
do
    pull_requests=$(curl -L \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $GH_PAT" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/$org_repo/pulls?state=open)
done

echo $pull_requests