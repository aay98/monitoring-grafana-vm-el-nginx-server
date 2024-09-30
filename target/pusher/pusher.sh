#!/bin/bash
OBSERVER="http://vmauth:8427"
while true
do
    #node exporter
    #curl -s http://node-exporter:9100/metrics | grep -E 'node_cpu_seconds_total|node_memory_*|node_disk_*|node_filesystem_*' > metrics.log
    curl -s http://node-exporter:9100/metrics > metrics.log
    curl -T metrics.log -X POST https://$OBSERVER/api/v1/import/prometheus?extra_label=host=$HOST -u "$LOGIN:$PASS"
    sleep 10
done