# pravega-k8-log-collection
Pravega K8 based deployment log collection tool

The shell script (`pravega-k8s-log.sh`) which will do below stuff:
1. list all pod, services and persistent volumes running in the K8 deployment
2. Check all Pravega components associated
3. If component is a pod it will collect log from that container, It will check whether container had been restarted due to any reason and would take logs from previous deployment as well (if any).
4. Take details of all pod, service and pvcs (describe)
5. Create a tarball with time stamp under `/tmp/logdir`

Sample Usage:

`# chmod +x pravega-k8s-log.sh`

`# ./pravega-k8s-log.sh`

Logs collected in /tmp/logdir

Sample log output:
/tmp/logdir/pravega-k8s-logging-2018-11-14-11-14-23.tgz

Note:
1. Script assumes valid kubernetes configuration present in the node where it is invoked.
2. `kubectl` should be present in the system
