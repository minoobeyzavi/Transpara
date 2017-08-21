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

* Why is default do not persist in persisting mode?
* Why does Stefan’s script set values to NA at connector restart?
* Can hierarchy be non-alphabetical?

#### Correction Necessary to KPI Model Script
```
kpiobj.kpiDisplaySettings.EngineeringUnit = EUU
```

#### Requests for Improvement

*  All functions within the software must run much faster for the software to remain responisve. Significant memory management is likely to be required.
* Default colors shouldn’t be the same in object properties.
* There should be a way to close all tabs per window ( e.g. all history trends) at once.
* inmation shouldn’t generate data to create an interpolate that looks like steps.
* Aggregate column in History Trend should default to Raw Data instead of Average.
* IO model should stay open in the same hierarchy after being refreshed.
* "Right-Click -> Add Children to History Trend" feature should be in working order.
* Software should open with the most recently used workspace by default.
* History Trend should default to Max Resolution.
* The Visiblity column under History Trend chart should be next to the Names column or be the first column.

## Correction of Data Overlap in Stefan's Custom Script

#### QC -> Analect HSS Hydrocarbon System

```
Transference</br>
MSR</br>
Pathlength</br>
E Cell 1</br>
B T Cell 1</br>
Cell 1 temp</br>
Water temp</br>
Cell 1 STOPPED</br>
Solv Level</br>
Tol Level</br>
Azr Encl
```
#### RRX -> Analect HSS Analyzer

```
Positive 15v Supply</br>
DCM Temp</br>
Interferogram</br>
Laser Magnitude</br>
Source Current</br>
Coil Voltage
```
#### H7 -> Analect HSS Hydrocarbon Smart System

```
E Cell 1</br>
B T Cell 1</br>
Cell 1 temp</br>
Water temp</br>
Cell 1 Flow</br>
Solv Level</br>
Tol Level</br>
Azr Encl Overtemp
```
