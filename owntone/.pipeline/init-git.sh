#!/bin/bash

if [ -d "./${OWNTONE_SRC_REPO_NAME}/.git" ]; then
    echo "clone of the ${OWNTONE_SRC_REPO_NAME} repo exists, updating branch '${OWNTONE_SRC_REPO_BRANCH}'."
    (
        cd ${OWNTONE_SRC_REPO_NAME}/
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

if [ -d "./${OWNTONE_APT_REPO_NAME}/.git" ]; then
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


