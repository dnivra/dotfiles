# Function to generate gitignore files
function gi() {
    wget https://www.gitignore.io/api/$@ -O - 2>/dev/null | tee -a .gitignore && echo "Done";
}
