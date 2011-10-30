#!/bin/bash -e
[ "x$1" != "x" ] || {
    echo "USAGE: $0 source-folder"
    exit 1
}

cd $1

template=$(cat template/template.html)

index_html=""
for file in content/*
do
    name=$(basename $file)
    title=$(head -n 1 $file)
    index_html="<li><a href='$name.html' title='$name'>$title</a></li> $index_html"
done

for file in content/*
do
    html=$(markdown $file)
    title=$(head -n 1 $file)
    name=$(basename $file)

    #Notice the double backslash -> do global subst
    text=${template//__CONTENT__/$html}
    text=${text//__TITLE__/$title }
    text=${text//__LINK__/$name.html}
    text=${text//__INDEX__/$index_html}
    echo $text > $name.html
done

cp $name.html index.html

