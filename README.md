# Samples-Aviation

This is the README file for Samples-Aviation. The end of the file has setup instructions for installing the sample using [zpm](https://github.com/intersystems-community/zpm) or plain ObjectScript.

> Use or operation of this code is subject to acceptance of the license available in the code 
> repository for this code.

Samples-Aviation provides sample data for use in exploring InterSystems IRIS Text Analytics capabilities. 
In order to use this sample, you must have an InterSystems IRIS license that includes these capabilities.

After setup, the data is available for use in various ways:
* For use in [InterSystems IRIS Natural Language Processing](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GIKNOW).
  The repo also contains specific samples related to NLP.
* For use with [InterSystems IRIS SQL Search](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GSQLSRCH).
* For use with [Text Analytics options in InterSystems IRIS Business Intelligence](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=D2MODADV_ch_iknow).
  
The repo also contains specific samples related to these options.

## Repo contents

### Data and utility classes

* The `Aviation.Aircraft`, `Aviation.Crew`, and `Aviation.Event` classes are persistent
  classes/tables that collectively represent a selected subset of aviation 
  incidents reported to the U.S. National Transportation Safety Board. 
  The dataset provided in this sample demo is only a small subset of the full NTSB dataset,
  which is available from http://www.ntsb.gov. This data is supplied here for demonstration
  purposes only and neither intended nor warranted to be accurate. (Courtesy: [National Transportation
  Safety Board](http://www.ntsb.gov))
  
* Upon setup (see end), data is loaded from the `src/gbl/aviation-data.xml` file into these
  classes.

* The `Aviation.Utils` class is a helper classes used by the repo setup routine (see end).

### Samples using InterSystems IRIS Natural Language Processing (NLP) 
* The `Aviation.ReportDomain` class defines a sample NLP domain based on the data
  from this repo. You can run NLP queries against this domain. See [Using InterSystems IRIS Natural Language Processing](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GIKNOW).

* The `Aviation.Classification.Utils` class illustrates how to build and test Text 
  Categorization models programmatically. See [Text Categorization](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GIKNOW_textcat).

The InterSystems IRIS Natural Language Processing technology is also available for standalone use. [Click here](https://github.com/intersystems/iknow) to learn more.

### Samples using InterSystems IRIS Business Intelligence (BI)

* The `Aviation.Cubes` package contains BI cube definitions that use Text Analytics features
  and that use the data in this repo. See [Using Text Analytics in Cubes](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page?KEY=D2MODADV_ch_iknow) for details.
* `Aviation.KPI.TopConcepts` contains a BI KPI that uses a Text Analytics query.
* `Aviation.KPI.Actions` defines a KPI action (which is used on a dashboard also in this sample).
* `Aviation.DashboardsEtc` defines Business Intelligence pivot tables and dashboards
  that display the data in this repo and that provide you the ability of performing
  simple analyses of that data.

## Setup instructions

### Installation with ZPM

1. Install ZPM
Get the latest release of the ZPM client from https://pm.community.intersystems.com/packages/zpm/latest/installer

You can download it as a regular ObjectScript package in XML, so it can be installed by the class import feature in the Management Portal, or using the terminal:
```ObjectScript
USER> Do $System.OBJ.Load("/yourpath/zpm.xml","ck")
```

[Click here](https://community.intersystems.com/post/introducing-intersystems-objectscript-package-manager) to learn more about ZPM.

2. After setting up ZPM, install the Samples-Aviation module. You'll need an Internet connection for this:
```ObjectScript
zpm:USER> install samples-aviation
```

### Classic installation

1. Clone or download the repository. 

   * On Windows, you can use the Download button or you can [automatically download the archive file](https://github.com/intersystems/Samples-Aviation/archive/master.zip). Once downloaded, open and save the contents of the archive file.

   * On UNIX or Linux, create a directory called "samples", and then enter the following from the shell:   
     ```Shell
     wget -qO- https://github.com/intersystems/Samples-Aviation/archive/master.tar.gz | tar xvz -C samples  
     ```

2. In the InterSystems IRIS Management Portal, create a namespace called SAMPLES. You will load the sample data into this namespace. If you need help creating the namespace, see [Creating a Namespace and Database to Hold Samples](http://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=ASAMPLES_createns). 
3. To enable the SAMPLES web application for use with InterSystems IRIS Analytics:
    a.  In the Management Portal, click System Administration > Security > Applications > Web Applications.
    b.  Click the `/csp/samples` link in the leftmost column. This assumes that the namespace you created is called SAMPLES.
    c.  In the Enable section, select Analytics.
    d.  Click Save.
4. Open the InterSystems IRIS Terminal. If you used the default SYSTEM account when installing InterSystems IRIS, the username is \_system.
5. Enter the following command, where SAMPLES is the namespace where the sample will be loaded:
   ```ObjectScript
   ZN "SAMPLES"
   ```
6. Enter the following command, replacing *install-dir* with the location where you downloaded the repo:
   ```ObjectScript
   do $system.OBJ.Load("install-dir\buildsample\Build.AviationSample.cls","ck")
   ```
7. Enter the following command:
   ```ObjectScript
   do ##class(Build.AviationSample).Build()
   ```
8. When prompted, enter the full path of the directory that contains the README.md and LICENSE files of the repo you downloaded. The method then loads and compiles the code and performs other needed setup steps.

