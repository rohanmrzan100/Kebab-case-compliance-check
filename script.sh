name: Check Kebab Case for Changed Markdown Files in PR

on:
  pull_request:
    paths:
      - '**/*.md' 

jobs:
  kebab-case-check:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        with:
         fetch-depth: 2

      - name: Check filenames for kebab case
        run: |
          echo "Checking changed Markdown files for kebab case..."
          changed_files=$(git diff --name-only --diff-filter=AM HEAD^1 HEAD  | grep '\.md$')
          if [ -z "$changed_files" ]; then
            echo "No changed Markdown files in this PR."
            exit 0
          fi
          echo "Changed Markdown files:"
          echo "$changed_files"

           # Find invalid filenames
          invalid_files=$(echo "$changed_files" | grep -vE '^[a-z0-9]+(-[a-z0-9]+)*\.md$' || true)

          if [ -n "$invalid_files" ]; then
            echo "The following Markdown filenames are not in kebab case:"
            echo "$invalid_files"
            exit 1
          else
            echo "All changed Markdown filenames are in kebab case."
          fi


         