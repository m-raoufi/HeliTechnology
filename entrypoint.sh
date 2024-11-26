#!/bin/bash

# Generate the dynamic static page with restart date and optional title
PAGE_TITLE=${STATIC_PAGE_TITLE:-"Default Title"}
RESTART_DATE=$(date)

cat <<EOF > /usr/share/nginx/html/index.html
<html>
    <head><title>$PAGE_TITLE</title></head>
    <body>
        <h1>$PAGE_TITLE</h1>
        <p>Date: $RESTART_DATE</p>
    </body>
</html>
EOF

# Start Nginx
exec "$@"
