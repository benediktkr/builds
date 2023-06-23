#!/bin/bash

if [[ -d "./${OWNTONE_SRC_REPO_NAME}/.git" ]]; then
    echo "clone of the ${OWNTONE_SRC_REPO_NAME} repo exists, updating branch '${OWNTONE_SRC_REPO_BRANCH}'."
    (
        cd ${OWNTONE_SRC_REPO_NAME}/
        git checkout ${OWNTONE_SRC_REPO_BRANCH}
        git checkout .
        git clean -fd
        git remote rm origin
        git remote add origin ${OWNTONE_SRC_REPO_ORIGIN}
        git pull origin ${OWNTONE_SRC_REPO_BRANCH}
        git checkout ${OWNTONE_SRC_REPO_BRANCH}

    )
else
    echo "clone of the ${OWNTONE_SRC_REPO_NAME} does not exist, cloning ${OWNTONE_SRC_REPO_ORIGIN}"
    git clone ${OWNTONE_SRC_REPO_ORIGIN}
fi

if [[ -d "./${OWNTONE_APT_REPO_NAME}/.git" ]]; then
    echo "clone of the ${OWNTONE_APT_REPO_NAME} repo exists, updating branch '${OWNTONE_APT_REPO_BRANCH}'."
    (
        cd ${OWNTONE_APT_REPO_NAME}/
        git checkout .
        git clean -fd
        git remote rm origin
        git remote add origin ${OWNTONE_APT_REPO_ORIGIN}
        git pull origin ${OWNTONE_APT_REPO_BRANCH}
        git checkout ${OWNTONE_APT_REPO_BRANCH}
    )
else
    echo "clone of the ${OWNTONE_APT_REPO_NAME} does not exist, cloning ${OWNTONE_APT_REPO_ORIGIN}"
    git clone ${OWNTONE_APT_REPO_ORIGIN}
fi


echo "pulling and rebasing the branch for the partial filescans PR: https://github.com/owntone/owntone-server/pull/1179"
(
    set -e

    cd ${OWNTONE_SRC_REPO_NAME}/
    git checkout ${OWNTONE_SRC_REPO_BRANCH}

    # cleanup and return to the main branch
    git branch -D file-scan-dir-path || true
    git remote rm whatdoineed2d || true

    # add the repo with the PR branch
    git remote add whatdoineed2d https://github.com/whatdoineed2do/forked-daapd
    git fetch whatdoineed2d

    #git rebase file-scan-dir-path

    # check out the PR branch and rebase the main branch onto it (works now at least)
    git checkout file-scan-dir-path
    git rebase ${OWNTONE_SRC_REPO_BRANCH}
)
