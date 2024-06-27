#!/bin/bash
JOURNAL_PATH="${HOME}/.config/journal"

cd ${JOURNAL_PATH} &&
    git add . &&
    git commit -m "feat: journal update" &&
    git push
