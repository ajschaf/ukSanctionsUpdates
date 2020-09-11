#!/bin/bash
fetch_and_sort_and_commit () {
    # $1 is the table name, $2 is the URL
    local table=$1
    local csv="$1.csv"
    local commit_txt="$1.commit.txt"
    mv ConList.csv ConList.csv.old
    mv InvBan.csv InvBan.csv.old
    curl -O -J -s --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" "https://ofsistorage.blob.core.windows.net/publishlive/ConList.csv"
    curl -O -J -s --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" "https://ofsistorage.blob.core.windows.net/publishlive/InvBan.csv"
    echo "Updated" > $commit_txt
    echo $'\n[skip ci]' >> $commit_txt
    git add ConList.csv
    git add InvBan.csv
    git commit -F $commit_txt && \
        git push -q origin master \
        || true
}

git config --global user.email "SanctionsBot"
git config --global user.name "SanctionsBot"
fetch_and_sort_and_commit