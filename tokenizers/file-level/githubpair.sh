#!/bin/bash
# TODO: make this general for the dataset

bookkeping=bookkeeping_files/
clonePairLoc=../../clone-detector/output7.0/
cloneList=`cat $clonePairLoc/tokens*`

githubUrlBase=https://github.com/
datasetLocation=/mnt/data/
repoInfoPath=/github/info.json

for line in $cloneList
do
  c1=`echo $line | cut -d, -f1`
  c2=`echo $line | cut -d, -f2`
  # paths
  paths=`grep -e ",\($c1\|$c2\)," $bookkeping/* | cut -d, -f3`
  # github urls
  for path in $paths
  do
    repoId=`echo $path | cut -d/ -f4`
    filePath=`echo $path | cut -d/ -f6-`
    repoWithNameSpace=`awk -F'"' '/full_name/{print $4}' $datasetLocation/$repoId/$repoInfoPath`
    defaultBranch=`awk -F'"' '/default_branch/{print $4}' $datasetLocation/$repoId/$repoInfoPath`
    echo $githubUrlBase$repoWithNameSpace/blob/$defaultBranch/$filePath
  done
  echo "==========="
done

