#!/bin/bash


rm -rv ./dist/dark-reader || true


mkdir -p ${DISTDIR}/dark-reader/
ls -l ${DISTDIR}/dark-reader/

# save the diff of the index.html file in the dist/dark-reader dir for later inspection
# touch ${DISTDIR}dark-reader/diff-index-html.txt
# diff /usr/local/src/dark-reader/index.html ${DISTDIR}target/usr/share/owntone/htdocs/index.html >> ${DISTDIR}dark-reader/

# and save both the dark-reader index.html (the css tag commented out) file as it is included in the build, and the original index.html
cp ${DISTDIR}/target/usr/share/owntone/htdocs/index.html ${DISTDIR}/dark-reader/index.html.orig
cp /usr/local/src/dark-reader/index.html ${DISTDIR}/dark-reader/

# copy the files into the build
cp -v /usr/local/src/dark-reader/dark-reader-full.css ${DISTDIR}/target/usr/share/owntone/htdocs/assets/dark-reader-full.css
cp -v /usr/local/src/dark-reader/index.html ${DISTDIR}/target/usr/share/owntone/htdocs/index.html

# save ls output of the htdocs/assets dir
ls -l ${DISTDIR}/target/usr/share/owntone/htdocs/assets/ > ${DISTDIR}/dark-reader/ls-htdocs-assets.txt
ls -l ${DISTDIR}/target/usr/share/owntone/htdocs/assets/dark-reader-full.css > ${DISTDIR}/dark-reader/ls-htdocs-assets-dark-reader-full.css.txt
