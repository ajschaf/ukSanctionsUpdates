#!/bin/bash
fetch_and_sort_and_commit () {
    # $1 is the table name, $2 is the URL
    local table=$1
    local csv="$1.csv"
    local commit_txt="$1.commit.txt"
    wget --no-check-certificate --progress=dot -O 'ConList.csv' 'https://ofsistorage.blob.core.windows.net/publishlive/ConList.csv'
    wget --no-check-certificate --progress=dot -O 'InvBan.csv' 'https://ofsistorage.blob.core.windows.net/publishlive/InvBan.csv'
    mv ConList.csv ConList.csv.old
    mv InvBan.csv InvBan.csv.old
    echo "Updated" > $commit_txt
    echo $'\n[skip ci]' >> $commit_txt
    git add ConList.csv
    git add InvBan.csv
    git commit -F $commit_txt && \
        git push -q origin master \
        || true
}

git config --global user.email "SanctionsBot@example.com"
git config --global user.name "SanctionsBot"
fetch_and_sort_and_commit