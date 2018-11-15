#!/bin/bash
mkdir -p /tmp/logdir
output_dir="/tmp/logdir"
kubectl get po,svc,pvc --all-namespaces > $output_dir/kubectl-get-po-svc-pvc-all-namespace_output
IFS=$'\n'
for i in $(cat $output_dir/kubectl-get-po-svc-pvc-all-namespace_output | grep -i pravega)
do
echo $i
if [[ $i == *"pod"* ]];
then 
    if [ `echo $i | awk '{print $5}'` != 0 ]
        then     
            kubectl -n `echo $i | awk '{print $1}'` logs `echo $i | awk '{print $2}'` -p > $output_dir/log_`echo $i | awk 'gsub(/\//,"_") {print $2}'`_previous.log
    fi
    kubectl -n `echo $i | awk '{print $1}'` logs `echo $i | awk '{print $2}'` > $output_dir/log_`echo $i | awk 'gsub(/\//,"_") {print $2}'`.log
fi
kubectl -n `echo $i | awk '{print $1}'` describe `echo $i | awk '{print $2}'` > $output_dir/describe_`echo $i | awk 'gsub(/\//,"_") {print $2}'`_output
done
cd $output_dir
tar zcvf pravega-k8s-logging-`date '+%Y-%m-%d-%H-%M-%S'`.tgz *
ls *.tgz
