#!/bin/bash
fetch_and_sort () {
    # $1 is the table name, $2 is the URL
    local table=$1
    local csv="$1.csv"
    local csv_unsorted="$1.csv.unsorted"
    local csv_old="$1.csv.old"
    local commit_txt="$1.commit.txt"
    mv $csv $csv_old
    curl -s -o $csv $1
    # This should have created the .csv file
    mv $csv $csv_unsorted
    # Construct new CSV with heading line + sorted other lines
    # python sort_csv.py $csv_unsorted > $csv
    echo "Updated $csv" > $commit_txt
    echo $'\n[skip ci]' >> $commit_txt
}

fetch_and_diff () {
    fetch_and_sort $1 $2
    local csv_diff_args=$3
    local csv="$1.csv"
    local csv_old="$1.csv.old"
    local commit_txt="$1.commit.txt"
    csv-diff $csv_old $csv $csv_diff_args > $commit_txt
    echo $'\n[skip ci]' >> $commit_txt
}

add_and_commit () {
    local csv="$1.csv"
    local commit_txt="$1.commit.txt"
    git add $csv
    git commit -F $commit_txt && \
        git push -q origin master \
        || true
}

git config --global user.email "SanctionsBot@example.com"
git config --global user.name "SanctionsBot"

fetch_and_sort ConList "https://ofsistorage.blob.core.windows.net/publishlive/ConList.csv"
fetch_and_sort InvBan "https://ofsistorage.blob.core.windows.net/publishlive/InvBan.csv"
add_and_commit ConList
add_and_commit InvBan