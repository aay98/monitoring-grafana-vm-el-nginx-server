# ENG
# monitoring-grafana-vm-el-nginx-server
### Description
This monitoring system is based on the VictoriaMetrics repository and represents an enhanced monitoring system with an integrated piece of the ELK stack, specifically filebeat-logstash-elasticsearch.

### Why is this needed?
This modification is implemented to read additional logs from Nginx, such as RTPS (Response Time Per Second), RPS(M) (Requests Per Second (Minute)), and others. This implementation does not require reinstalling Nginx, using Nginx+, or installing additional modules for Nginx. To make it work, it's enough to add logging to the nginx.conf file.
*An example of nginx.conf is located at ./target/nginx.conf*

### What does the repository consist of?
The repository consists of 3 main folders:
- backup-data - repository with dashboards
- observer - server-side of the monitoring
- target - client-side of the monitoring

## ATTENTION: MONITORING WORKS ON A PUSH MODEL!

### Service interaction
On the client side, the following services are launched:
- node-exporter - a standard exporter for the Grafana+Prometheus or Grafana+VM stack
- filebeat - tracks changes in the Nginx log file and sends metrics to Logstash
- pusher - a script that collects metrics from localhost and pushes them to VMAUTH - an authenticator for VM

On the server side, the following services are launched:
- vmagent - a metrics collection agent working with VictoriaMetrics
- VM (VictoriaMetrics) - a high-performance time-series database
- Grafana - a tool for visualizing metrics and creating dashboards
- vmalert - a tool for creating and sending alerts based on VictoriaMetrics data
- Alertmanager - manages alerts from Prometheus or VictoriaMetrics
- vmauth - a proxy for authentication with VictoriaMetrics
- Elasticsearch - used as storage for Nginx logs with full-text search capabilities
- Logstash - a tool for collecting, processing, and forwarding logs to Elasticsearch
- socks5 proxy - a proxy server for transmitting network data from Filebeat to Logstash

The main feature of this implementation is that when the Nginx log file changes, Filebeat sends logs through a socks5 proxy (used for authentication and secure connection) to Logstash, which processes these logs and sends them for storage in Elasticsearch. Grafana is connected to Elasticsearch as a data source, allowing it to retrieve metrics for visualizing Nginx data. An example Nginx dashboard is located in the folder ```./backup-data/nginx.json```.

#### Replace all passwords before using outside the test environment!
p.s. The command ```grep -r "password"``` will show the locations of all passwords that need to be replaced.

# RUS
# monitoring-grafana-vm-el-nginx-server
### Описание
Данная система мониторинга основана на репозитории VictoriaMetrics. И представляет собой доработанную систему мониторинга с интегрированным кусочком ELK стека. А именно filebeat-logstash-elasticsearch.
### Для чего это нужно?
Данная модификация выполнена для чтения дополнительных логов с nginx, таких как RTPS (Response Time Per Second), RPS(M) (Request Per Second (Minute)) и других. Данная реализация не требует перестановки nginx, nginx +  или установки дополнительных модулей для nginx. Для работы достаточно лишь добавление логирования в файл nginx.conf.
*пример nginx.conf находится по пути ./target/nginx.conf*
### Из чего состоит репозиторий?
Репозиторий состоит из 3х основных папок:
- backup-data - репозиторий с дашбордами
- observer - серверная часть мониторинга
- target - клиентская часть мониторинга

## ВНИМАНИЕ МОНИТОРИНГ РАБОТАЕТ ПО PUSH-МОДЕЛИ!

### Взаимодействие сервисов
На клиенте запускается клиентская часть сервиса, в которую входит: 
- node-exporter - стандартный экспортер для стека Grafana+Prometheus или Grafana+VM
- filebeat - который отслеживает изменение файла с логами nginx и отправляет метрики в logstash
- pusher - скрипт который забирает метрики с localhost и пушит их в VMAUTH - аутентификатор для VM

На Сервере запускается серверная часть, в которую входит:
- vmagent - агент для сбора метрик, работающий с VictoriaMetrics
- VM (VictoriaMetrics) - высокопроизводительная база данных для хранения временных рядов
- Grafana - Инструмент для визуализации метрик и создания дашбордов
- vmalert - Инструмент для создания и отправки алертов на основе данных VictoriaMetrics.
- Alertmanager -управляет алертами из Prometheus или VictoriaMetrics.
- vmauth - прокси-авторизации для VictoriaMetrics
- Elasticsearch - используется как место хранения логов Nginx с возможностью полнотекстового поиска
- Logstash - инструмент для сбора, обработки и пересылки логов в Elasticsearch.
- socks5 proxy - Прокси-сервер для передачи сетевых данных от Filebeat к Logstash

Основная особенность реализации заключается в следующем:
при изменении файла с логами nginx файлбит отправляет логи через socks5 proxy (используется для аутентификации и обеспечения безопасности соединения) к Logstash который занимается обработкой этих логов и отправкох их на хранение в ElasticSearch. К Grafana подключен как источник данных Elasticsearch, таким образом Grafana забирает метрики для визуализации метрик nginx. Пример nginx дашборда представлен в папке ```./backup-data/nginx.json```.

#### Перед использованием вне тестового стенда заменить все пароли!
p.s. команда ```grep -r "password"``` выведет местонахождение всех паролей которые требуют замены.