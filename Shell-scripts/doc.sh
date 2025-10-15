Here are some real-world examples of using ! in shell scripts to make conditions mean “NOT”:

✅ 1. Check if a process is NOT running
ShellSERVICE="nginx"if ! pgrep -x "$SERVICE" >/dev/null; then    echo "$SERVICE is not running, starting it..."    systemctl start "$SERVICE"fiShow more lines
Meaning: If nginx is NOT running, start it.
SERVICE="nginx"
if ! pgrep -x "$SERVICE" >/dev/null; then
    echo "$SERVICE is not running, starting it..."
    systemctl start "$SERVICE"
fi

✅ 2. Check if a file does NOT exist
Shellif [ ! -f /etc/myapp/config.yaml ]; then    echo "Config file missing! Creating default one..."    cp /etc/myapp/config.default.yaml /etc/myapp/config.yamlfiShow more lines
Meaning: If the file does NOT exist, create it.
if [ ! -f /etc/myapp/config.yaml ]; then
    echo "Config file missing! Creating default one..."
    cp /etc/myapp/config.default.yaml /etc/myapp/config.yaml
fi

✅ 3. Check if a directory does NOT exist
Shellif [ ! -d /var/log/myapp ]; then    mkdir -p /var/log/myappfiShow more lines
Meaning: If the directory does NOT exist, make it.
if [ ! -d /var/log/myapp ]; then
    mkdir -p /var/log/myapp
fi

✅ 4. Check if a command is NOT available
Shellif ! command -v git >/dev/null; then    echo "Git is not installed. Installing..."    dnf install -y gitfiShow more lines
Meaning: If git is NOT installed, install it.
if ! command -v git >/dev/null; then
    echo "Git is not installed. Installing..."
    dnf install -y git
fi

✅ 5. Check if a user is NOT logged in
Shellif ! who | grep -q "john"; then    echo "User john is not logged in."Show more lines
Meaning: If user john is NOT logged in, print a message.
if ! who | grep -q "john"; then
    echo "User john is not logged in."


💡 Rule of thumb:
! in shell means “NOT”. It flips the success/failure of the command or test.