## Load Batch Data to Druid on Linux :: Query with Postman on Windows

Notes: The following specifically installs Druid 0.10.0 (the latest version as of April 2017), rather than using the latest version link in Druid's Quickstart. Please make sure to have installed Oracle JDK 8 and not OpenJDK 8.

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
[//]: # (Note: You only need to start Zookeeper once in the Linux server and it will always be avaiable.)

To check Zookeeper is running:

```
echo stat | nc localhost 2181 | grep Mode
```
You should see: "Mode: standalone".

Return to druid-0.10.0 directory and issue the command:

```
bin/init
```

#### Start Druid

To use Druid's services, they should always be up and running in the server. Run each service in a separate terminal window:

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

#### JSON-Based Query (testing on Linux)

Basic format:
```
curl -X POST '<queryable_host>:<port>/druid/v2/?pretty' -H 'Content-Type:application/json' -d @<query_json_file>
```
Note: For further explanation see <b>Reference</b> at the bottom of the page.

Example:
```
curl -L -H'Content-Type: application/json' -XPOST --data-binary @quickstart/wikiticker-top-pages.json http://localhost:8082/druid/v2/?pretty
```
Finds the most edited articles in this dataset:
```
{
    "edits" : 15,
    "page" : "Anthony Martial"
  }, {
    "edits" : 13,
    "page" : "Template talk:Connected contributor"
  }, {
    "edits" : 12,
    "page" : "Chronologie de la Lorraine"
  }, {
    "edits" : 12,
    "page" : "Wikipedia:Files for deletion/2015 September 12"
  }, {
    "edits" : 12,
    "page" : "Гомосексуальный образ жизни"
  }, {
    "edits" : 11,
    "page" : "Constructive vote of no confidence"
  }, {
    "edits" : 11,
    "page" : "Homo naledi"
  }, {
    "edits" : 11,
    "page" : "Kim Davis (county clerk)"
  }, {
    "edits" : 11,
    "page" : "Vorlage:Revert-Statistik"
  }, {
    "edits" : 11,
    "page" : "Конституция Японской империи"
  }, {
    "edits" : 10,
    "page" : "The Naked Brothers Band (TV series)"
  }, {
    "edits" : 10,
    "page" : "User talk:Buster40004"
  }, {
    "edits" : 10,
    "page" : "User:Valmir144/sandbox"
  }
  ```
(Note: Upon completeing this experiment, make sure to Ctrl+C on each terminal window that is running a druid service to stop services before exiting server.)

#### Postman Extension

```
Base Address: http://172.0.1.8:8082/druid/v2/
Method: POST
Body: binary
Choose Files: wikiticker-top-pages.json

```
<a href="https://github.com/druid-io/druid/raw/master/examples/quickstart/wikiticker-top-pages.json">wikiticker-top-pages.json</a> finds the most edited articles in the <a href="https://github.com/druid-io/druid/raw/master/examples/quickstart/wikiticker-index.json">wikiticker-index.json</a> dataset which was loaded once into Druid in the above section for loading batch data and now is always available when Druid services are running.

<div align="center"><img src="https://github.com/minoobeyzavi/Visual-KPI/blob/master/Images/postman.png"></img></div>

#### Reference
```
Depending on what druid.storage.type is set to, Druid will upload segments to some Deep Storage.
Local disk is used as the default deep storage.

-L              If server has been moved, redo request on the new location.
-H              Extra header to include in the request.
-X              Custom request method.
Post            Post request.
--data-binary   Post data exactly as specified with no extra processing.
@               What comes after @ is the file name.
```
