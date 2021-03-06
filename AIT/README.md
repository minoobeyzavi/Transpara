## Analect Concentration File Format

The difference between the lab results and the online results at the time the sample was taken are the primary performance measurement of the analyzer.  The closer they match, the better.   The lab reference data comes from the site Lab Information Management System (LIMS) - not the analyzer, so would have to be mocked up somehow.
 
This will be a typical gasoline blending demo application and the analyzer produces the following data types over OPC:

#### ANALYZER RESULTS
The actual measurements the analyzer is making:  Grade#, RON, MON, T10, T50, T90, EP, E200, E300, AROMATICS, OLEFINS, BENZENE, API, RVPE10, TVLE10

#### ANALYZER ALARMS
For each measurement the following alarms are set or clear based on several criteria:

System Warning:  Analyzer needs attention, but data is valid (things like low toluene in the validation solvent tank)
System Failure: Analyzer needs immediate attention, condition exists that renders data invalid ( like low flow)
Data Valid: Conditions exists that renders data invalid (like a high outlier statistic)

#### ANALYZER VALIDATION RESULTS
Periodically (typically once a day), the analyzer is automatically validated by measuring a solvent standard.  The result from this measurement must be below a limit to ensure the analyzer is operating properly.

#### ANALYZER RESULTS QUALITY
With each measurement, each of the results has two associated “Outlier” statistics – Mean Squared Residual (MSR) and Mahalanobis Distance (MD).  A value over 1 indicates the current measurement is not well represented in the model and may not be valid. 

#### ANALYZER / SAMPLE SYSTEM HEALTH
With each measurement, several analyzer / sample system “health” results are updated - ENERGY CELL1, Bubble Test CELL1, Cell 1 temperature, Cooling Water Temperature, Cell 1 Flow Low Alarm, Solvent Level Low Alarm, Toluene Level Low Alarm, Analyzer Cabinet Overtemp Alarm

#### INSTRUMENT HEALTH
These signals can be read from the FTIR instrument inside the analyzer as an indication of instrument health:  Positive 15V Supply, Negative 15V Supply, Positive 5V Supply, DCM Temperature, InterferogramPlus, InterferogramMinus, Laser1Magnitude, Laser2Magnitude,, SourceCurrent, SourceVoltage, CoilVoltage, CoilCurrent, Positive 12V Analog, Negative 12V Analog, Positive 5V Analog, Negative 5V Analog


xx – is the grade number for the gasoline stream number (unfortunately, no leading zero)

MMM – is three character month abbreviation

dd – day (with leading zero)

A – is a “shift” number if more than one of these files exists for a day, it will have B, C, D, etc. 

2 different analyzers measuring the same stream. They might aslo add a virtual stream into analyzers.

RON - Research Octane Number</br>
MON - Motor Octane Number

G, H6 & H7 report files are measurements from normal monitoring of gasoline stream. QC is for when they switch in once a day to measure the stream. H7 is automated & QC is human-entered. Limits for MON & RON are +/- 0.1 for the deviation. Limits for T50 are +/- 5 degrees. T10 means 10%. If MSR is less than 1, we're confident that results are valid; green line. Between 1 and 2 is yellow line; above 2, red line.

High Limit 1:
High High Limit: 2

Transference Value - Analyzer validation against a standard sample. This is the most important value to look at.
