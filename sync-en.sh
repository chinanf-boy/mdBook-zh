SKIPS=""

cat './.mds-list' | while read line || [[ -n ${line} ]]
do
    testseq="zh.md"
    removeDirPath="/book-example"
    if [[ $line =~ $testseq || "$line" == "" ]]; then
        SKIPS="$SKIPS \n Skip $line"
    else
        lowline=`echo "$line" | awk '{print tolower($0)}'` # lowwer string

        zh=${line//source\//src\/}
        dir=$(dirname $zh)
        
        source_readme="./source/readme.md"
        if [[ $lowline == $source_readme ]];then
        # source/[readme|REAMDE].md => en.md
        filename="en.md"
        else 
        # source/other.md => ./other.md
        filename=$(basename $zh)
        fi
        dir=${dir/$removeDirPath/}
        echo "$line >> $dir/$filename"
        mkdir -p $dir && cp $line "$_/$filename"
    fi
done

echo $SKIPS