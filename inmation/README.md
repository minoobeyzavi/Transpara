## inmation

### Correction of Data Overlap in Stefan's Custom Script

Allocation of data from file to corresponding I/O elements is outlined below:

#### QC -> Analect HSS Hydrocarbon System

```
Transference
MSR
Pathlength
E Cell 1
B T Cell 1
Cell 1 temp
Water temp
Cell 1 STOPPED
Solv Level
Tol Level
Azr Encl
```
#### RRX -> Analect HSS Analyzer

```
Positive 15v Supply
DCM Temp
Interferogram
Laser Magnitude
Source Current
Coil Voltage
```
#### H7 -> Analect HSS Hydrocarbon Smart System

```
E Cell 1
B T Cell 1
Cell 1 temp
Water temp
Cell 1 Flow
Solv Level
Tol Level
Azr Encl Overtemp
```

Current folder name is instrument ID.
App ID may have other meta data in it.

#### What inmation does:

Mathematical Operations on Data
  * Execute Simple calculation e.g. add tow inputs to create a new value.
  * Execute Advanced Calculation e.g. run a matrix calculation for equipment analytics.
  
Configuration operations on system: inmation
  * Create/Update/Delete objects in all system:inmation model trees.

Scripts are attached to objects that exist in the different models.
Scripts are hosted by properties of objects.

```
They should clearly and simply articulate on a high level what inmation is and what they do.
```
"Software infrastructure... allows you to aggregate... wrap your hardware around the world...
Do big data analytics around operational assets.
Abstract a way around...
Unified way to bring data...
Do something intelligent with data in a uniform way. Website that screams value."

#### Key Words

Contextualize, Consolidate, Standardize, Historization, Aggregation, Trends, The Inside API, Simulation

[inmation Wiki](https://inmation.com/wiki/index.php?title=Main_Page)</br>
[Industries Animation](https://www.inmation.com/industries_animations/energy_and_utilities/energy_and_utilities.html)

#### Questions

* Why is persistency mode set to "do not persist" by default?
* Why does Stefan’s script set values to NA at connector restart?

#### Correction Necessary to KPI Model Script
```
kpiobj.kpiDisplaySettings.EngineeringUnit = EUU
```

#### Suggested Improvements

*  All functions within the software must run significantly faster for the software to remain responisve. Proper memory management is required.
* Default colors shouldn’t be the same in object properties.
* There should be a way to close all tabs per window ( e.g. all history trends) at once.
* inmation shouldn’t generate data to create an interpolate that looks like steps.
* Aggregate column in History Trend should default to Raw Data instead of Average.
* IO model should stay open in the same hierarchy after being refreshed.
* "Right-Click -> Add Children to History Trend" feature should be in working order.
* Software should open with the most recently used workspace by default.
* History Trend should default to Max Resolution.
* The Visiblity column under History Trend chart should be next to the Names column or be the first column.
* Types of objects or Class Names such as "Enterprise", "Division", etc. should be have more generic names.
* KPI model hierarchy could be designed manually and ordered according to importance as opposed to sorted alphabetically.
