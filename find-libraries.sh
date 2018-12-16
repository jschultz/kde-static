search_library () {
    match=$(nm $1 2>/dev/null | egrep " $2$" | grep -v ' U ')
    if [ "$match" != "" ]; then
        fulllib=$(realpath $1)
        baselib=$(basename $1)
        shortlib=$(echo $baselib | sed -n -E "s/^lib(.+)\.a/\1/p")
        if [ "$3/$baselib" == "$fulllib" ] && [ "$shortlib" != "" ]; then
            extra="-l$shortlib"
        else
            extra=$fulllib
        fi
        echo "Adding $extra to KDE_STANDARD_LIBRARIES"
        echo KDE_STANDARD_LIBRARIES=\"$KDE_STANDARD_LIBRARIES $extra\" > /tmp/find-libraries
    fi;
}
export -f search_library

while true; do
    echo "Building with KDE_STANDARD_LIBRARIES=$KDE_STANDARD_LIBRARIES"
    ~/kdesrc-build/kdesrc-build --rc-file=$HOME/kde/kdesrc-buildrc --build-only --refresh-build $1
    sym=$(sed -n -E "s/^.+undefined reference to \`(.+)'/\1/p" $HOME/kde/source/log/latest/$1/error.log | head -1)
    if [ "$sym" != "" ]; then
        echo Searching for definition of symbol: $sym
        IFS=':'
        extra=""
        for path in $LIBRARY_PATH; do
            find $path -name "*\.a" -exec bash -c "search_library {} $sym $path" \;
        done
        source /tmp/find-libraries
    else
        break
    fi
done