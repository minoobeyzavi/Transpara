## Working Instructions to Load Batch Data and Query on Linux

Notes: The following specifically installs Druid 0.10.0 (the latest version as of April 2017), rather than using the latest version link in Druid's Quickstart. Please make sure to use Oracle JDK 8 and not OpenJDK 8.

#### Install Druid

```
curl -O http://static.druid.io/artifacts/releases/druid-0.10.0-bin.tar.gz
tar -xzf druid-0.10.0-bin.tar.gz
cd druid-*
```

#### Start Zookeeper

```
curl http://www.gtlib.gatech.edu/pub/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz -o zookeeper-3.4.6.tar.gz
tar -xzf zookeeper-3.4.6.tar.gz
cd zookeeper-3.4.6
cp conf/zoo_sample.cfg conf/zoo.cfg
./bin/zkServer.sh start
```
To check Zookeeper is running:

```
echo stat | nc localhost 2181 | grep Mode
```
You should see: "Mode: standalone".

Return to druid-0.10.0 directory and issue the command:

```
bin/init
```
[//]: # (Note: The above command is required everytime before starting a Druid service when no other Druid services are running but after the first time, the log directory inside druid-0.10.0 directory should be removed before running this command.)

#### Start Druid

In different terminal windows:

```
java `cat conf-quickstart/druid/historical/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/historical:lib/*" io.druid.cli.Main server historical
java `cat conf-quickstart/druid/broker/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/broker:lib/*" io.druid.cli.Main server broker
java `cat conf-quickstart/druid/coordinator/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/coordinator:lib/*" io.druid.cli.Main server coordinator
java `cat conf-quickstart/druid/overlord/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/overlord:lib/*" io.druid.cli.Main server overlord
java `cat conf-quickstart/druid/middleManager/jvm.config | xargs` -cp "conf-quickstart/druid/_common:conf-quickstart/druid/middleManager:lib/*" io.druid.cli.Main server middleManager
```

#### Load batch data

Submit an <i>ingestion</i> task in a new terminal window from the druid-0.10.0 directory:

```
curl -X 'POST' -H 'Content-Type:application/json' -d @quickstart/wikiticker-index.json localhost:8090/druid/indexer/v1/task
```
(If required) to allow connection to Localhost port 8090 through the firewall:

```
sudo ufw disable
sudo ufw allow 8090
```

Successful submission prints the task ID:

```
{"task":"index_hadoop_wikiticker_2017-04-29T01:07:37.247Z"}
```
[//]: # (<div align="center"><img src="https://github.com/minoobeyzavi/Visual-KPI/blob/master/Images/taskID.png"></div>)

Status of your ingestion task: http://localhost:8090/console.html
Refresh the console periodically, and you should see a "SUCCESS" status for the task.

Progress of loading data: http://localhost:8081/#/
You should see datasource "wikiticker" with a blue circle indicating "fully available".

(Note: Upon completeing this experiment, make sure to Ctrl+C on each terminal window that is running a druid service to stop services before exiting server.)
