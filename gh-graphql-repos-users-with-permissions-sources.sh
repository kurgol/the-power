.  ./.gh-api-examples.conf

# https://cli.github.com/manual/gh_api
# Demonstrates pagination for gh api

export GH_TOKEN=${GITHUB_TOKEN}

gh api graphql --paginate -F owner="${org}"  -f query='
query($owner: String!, $endCursor: String) {
  organization(login: $owner){
   repositories(first:100, after: $endCursor){
    pageInfo {
        endCursor
        hasNextPage
    }
    nodes{
      nameWithOwner
      collaborators(first:100){
        edges{
          permission 
          node{
            login
          }
          permissionSources {
                sourcePermission: permission
                source {
                  ... on Team {
                    permissionSource: __typename
                    teamName: name
                  }
                  ... on Organization {
                    permissionSource: __typename
                    orgName: name
                  }
                  ... on Repository {
                    permissionSource: __typename
                    repoName: name
                  }
                }
           }
        }
      }
    }
  }
}
}
' 

