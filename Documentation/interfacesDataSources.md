#### Interfaces & Data Sources

"Interfaces & Data Sources" sounds like a story title. It could be "Create Interfaces with Data Sources" which sounds like a manual or "Visual KPI Interfaces" which sounds more technical.
Double digit subsections must be too many. #5 & #6 chould be a subsection of 

1 [Interfacing Visual KPI with Data Sources](http://betadocs.transpara.com/knowledge-base/interfaces-data-sources/)<b> Links!</b></br>
2 [Getting Started with Visual KPI Interfaces](http://betadocs.transpara.com/knowledge-base/interfaces-getting-started/)<b> -> Fix the Links</b></br>
3 [Visual KPI Interface Prerequisites](http://betadocs.transpara.com/knowledge-base/interface-prerequisites/)<b> -> Not necessairly prerequisites, part of the instrcutions/requirements. Could be a subsection of another article.</b></br>
4 [Interface Security & Encryption](http://betadocs.transpara.com/knowledge-base/interface-security/)</br>
5 [Supported Data Sources](http://betadocs.transpara.com/knowledge-base/interface-data-sources/)<b> -> Links are 404</b></br>
6 [Data Source Time Zones & Units](http://betadocs.transpara.com/knowledge-base/interface-time-zones-units/)</br>
7 [JSON & XML Interfaces](http://betadocs.transpara.com/knowledge-base/json-xml-interface/)</br>
8 [Working with a REST (JSON) Interface](http://betadocs.transpara.com/knowledge-base/rest-json-interface/)</br>
9 [Install and Configure JSON Interface](http://betadocs.transpara.com/knowledge-base/install-json-interface/)</br>
10 [Using Manual Data Entry Sources](http://betadocs.transpara.com/knowledge-base/manual-interfaces/)</br>
11 [Using Specialized Data Sources](http://betadocs.transpara.com/knowledge-base/specialized-data-interfaces/)</br>
12 [SQL Interfaces](http://betadocs.transpara.com/knowledge-base/sql-interfaces/)</br>
13 [Connecting to SQL Databases](http://betadocs.transpara.com/knowledge-base/connect-sql-databases/)</br>
14 [Working with ODBC Interfaces](http://betadocs.transpara.com/knowledge-base/odbc-interfaces/)</br>
15 [Install and Configure ODBC Interface](http://betadocs.transpara.com/knowledge-base/install-olap-interface/)</br>
16 [Working with OLAP Interfaces](http://betadocs.transpara.com/knowledge-base/olap-interfaces/)<b> -> Links</b></br>
17 [Install and Configure OLAP Interface](http://betadocs.transpara.com/knowledge-base/install-olap-interface/)</br>
18 [Historian Interfaces](http://betadocs.transpara.com/knowledge-base/historian-interfaces/)</br>
19 [Install and Configure PI Interface](http://betadocs.transpara.com/knowledge-base/install-pi-interface/)</br>
20 [Integrate Visual KPI RCS with OSIsoft PI AF Attributes](http://betadocs.transpara.com/knowledge-base/integrate-osisoft-pi-af-attrubutes/)<b>-> Integrating Remote Context Services or Integrating with OSISoft PI</b></br>
21 [Configure Interfaces for a KPI](http://betadocs.transpara.com/knowledge-base/designer-configure-interfaces/)</br>
22 [Using Microsoft Excel as a Database](http://betadocs.transpara.com/knowledge-base/microsoft-excel-interface-tips/)</br>
23 [Working with a Microsoft Excel Interface](http://betadocs.transpara.com/knowledge-base/microsoft-excel-interface/)</br>
24 [Install and Configure a Microsoft Excel Interface](http://betadocs.transpara.com/knowledge-base/install-microsoft-excel-interface/)</br>
25 [Use Connect Strings with the Interfaces](http://betadocs.transpara.com/knowledge-base/slug-interface-connect-strings/)</br>
26 [Troubleshoot Interface Connection Errors](http://betadocs.transpara.com/knowledge-base/troubleshoot-interface-connection-errors/)<b>-> Troubleshooting</b></br>

## Interfacing Visual KPI with Data Sources

Interfacing with data sources allows the Visual KPI Server to communicate with and retrieve data from almost any data source. <b>"from almost every data source."</b> By connecting to various databases or third-party platforms, Visual KPI can import select portions of the source data. <b>"Visual KPI can import select portions of the data."</b>

A Visual KPI interface is a required component that acts as the data connector </b>"A Visual KPI interface is a required component that acts as the data connector"</b> between the external databases and the Visual KPI server. The image below shows you the architecture of the various components of Visual KPI and how they interact.

 

Visual KPI components - data sources
Visual KPI Product Architecture
 

An interface specifies the type of technology used to communicate with the system (OLAP, JSON, SQL, etc.), any login credentials to the database, and the queries needed to extract the desired data. It establishes a connection to a database using a URL. An interface also specifies event logging levels and regional and time zone settings.

<b>"An interface specifies the type of technology used to communicate with the system (JSON, SQL, etc.), login credentials to database, and the queries needed to extract desired data. It establishes a connection to the database using a URL. An interface also specifies event logging levels and time zone settings."</b>

Interfaces read data from foreign systems in a read-only and lightweight fashion so there is no worry about impacting the original data.

Once an interface is created, you should never have to go back to it for maintenance (except upgrading to a newer version of Visual KPI).

FROM DATA TO KPI VISUALIZATIONS
The interfaces component of Visual KPI allows you to establish a data connection, one for each KPI, to many different potential data sources. The interface specifies which data to obtain without worrying about how the data is presented. Visual KPI takes care of how data is expressed using visualizations.

Using the Visual KPI Designer, an admin decides how this data will “look” in the Visual KPI website. This allows you to create data connections to many different database types (SQL, OLDB, Oracle) or database locations (Facility 1, Facility 2), or both, and present them with the same types of visualizations. You can mash up data from a wide variety of databases without needing to build more complicated data extracts or dumps.

VISUAL KPI INTERFACE COMPONENTS
The basic components of a Visual KPI interface include the connection to the source (how to connect), several queries (what can be asked of the data and what the system expects to get back), and security or authentication information to access the data.
Note: Visual KPI includes several pre-packaged interfaces to historian data sources like OSIsoft PI & AF, GE Proficy, Rockwell FactoryTalk, Wonderware and others. These interfaces contain all of the components above and are configured with a simple wizard (no need for the queries).

Connection
The connection string (in the case of SQL-based sources) or URLs (in the case of JSON/Odata/XML/Web services) determines how you connect to the data source. You specify the Internet address of the database you are connecting to as well as any particular database time zone or date time format. Finally, you specify the location where the data will reside locally so the Visual KPI server can consume it.

Security
A second aspect of the interface connection is the security information for authentication. You may have to specify a username/password or use a trust system. (See Interface Security and Encryption for recommendations about the account used for data access.)

Queries
The third part of the interface includes up to four data queries. The queries specify the data to be retrieved:

Current value – the most recent or current value in the database.
Historical value – a value within a specific time stamp in the past. If you specify a specific time and there is no value, the query returns the data with the nearest earlier time stamp.
Trend data – is a sequence of data between two different time stamps. To make the trend line look smoother at either end, data is also retrieved for the data point previous to the beginning of the trend and the data point following the end of the trend.
Historical data – is optional and only needed for more complex data analysis when all the data points are needed rather than less granular running averages. For example, data may be collected every second, but for visual display purposes, a less granular average is calculated for every 10 seconds.
TYPES OF DATA SOURCES
Visual KPI can read from thousands of data sources. Below are some examples:

industrial or enterprise historians (OSIsoft PI, GE Proficy, Rockwell, Honeywell, etc.)
relational databases (Microsoft SQL Server, Oracle, MySQL, Access, Etc.)
external web services (weather, market pricing, supplier data, etc.)
manually entered data (Excel, forms applications and even direct in Visual KPI)
business applications (ERP, CRM, vertical industry applications, etc.)
devices (sensors, IoT, IIoT, controls systems (DCS/PLC)
See Supported Data Sources

CONFIGURING INTERFACES
In order to access these systems, you must install an appropriate interface and configure it using the Visual KPI Server Manager. Visual KPI Designer then uses this interface to build KPIs against the data in the interface query.

REMOTE CONTEXT SERVICE
In addition to interfaces, Visual KPI also has the concept of a Remote Context Service. An interface is designed to access raw data from a data source for KPIs visualizations (e.g. a temperature, speed, price or sales volume). A Remote Context Service, however, is designed to accesses configuration data or metadata from external sources. This configuration data includes things such as group membership and hierarchy, KPI attributes including targets and limits, geolocation, security information and many other attributes.

Learn more:
Visual KPI Interface Prerequisites

Getting Started with Visual KPI Interfaces

## GETTING STARTED WITH VISUAL KPI INTERFACES

Visual KPI Interfaces allow the Visual KPI Server to communicate with and retrieve data from external data sources, such as a PI Server, a SQL database, or a SmartSignal system. To access these systems, you must install an appropriate interface and define the system using the Visual KPI Designer.

To access these systems, or create the interface: 

Install an appropriate interface using Visual KPI Server Manager. A Visual KPI Interface defines how to retrieve the required data from the external data source.
Define the interface using Visual KPI Designer. The Visual KPI Designer is used to define how to access the data source. 
If the system is external to the Visual KPI Server, credentials may be required to access the system. You can specify the credentials when defining the Interfaces.

INTERFACES TASK FLOW 
Setting up a Visual KPI interface involves these common procedures, no matter what the data source:

Install data source native client tools on Visual KPI Server. See Prerequisites and Downloads for links to the vendor drivers and other required software.
PI: PI SDK
SQL: SQL Management Studio or SQL connectivity driver. Note: The SQL interface feature is no longer available. It is included here for users that have existing SQL interfaces. Use ODBC interfaces instead. 
Oracle: Oracle Drivers with ODAC and test them with Toad
Wonderware: Wonderware SDK
GE SDK
Aspen: SQL driver
Inmotion: No drivers
JSON: Nodrivers
Using Visual KPI Server Manager, install the interface
Use Visual KPI Server Manager to onfigure the connection
Verify the connection
Test the connection
Use the Visual KPI Designer to define an interface for a KPI
See Interfaces & Data Sources for articles on how to install, configure, verify and test each type of Interface.


