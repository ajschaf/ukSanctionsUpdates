#!/bin/bash
fetch_and_sort_and_commit () {
    curl -O -J -s --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" "https://ofsistorage.blob.core.windows.net/publishlive/2022format/ConList.csv" > "ConList.csv"
    curl -O -J -s --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36" "https://ofsistorage.blob.core.windows.net/publishlive/2022format/InvBan.csv" > "InvBan.csv"
    git add ConList.csv
    git add InvBan.csv
    git commit -m "Updated" && \
    git push -q origin master \
    || true
}

git config --global user.email "SanctionsBot"
git config --global user.name "SanctionsBot"
fetch_and_sort_and_commit
