# Find all .md files excluding node_modules, README.md, and CONTRIBUTING.md, and check filenames for kebab case
   invalid_files=$(find . -type f -name '*.md' \
     -not -path "./node_modules/*" \
     -not -name "README.md" \
     -not -name "CONTRIBUTING.md" \
     -exec basename {} \; | grep -vE '^[a-z0-9]+(-[a-z0-9]+)*\.md$')
   
   if [ -n "$invalid_files" ]; then
       echo "The following Markdown filenames are not in kebab case:"
       echo "$invalid_files"
   
     
   else
       echo "All Markdown filenames are in kebab case."
  
   fi