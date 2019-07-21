#! /bin/sh

rails db:migrate 2>/dev/null || rails db:setup
echo "Ready!"