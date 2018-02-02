# Samples-Aviation
This is the README file for SAMPLES-AVIATION. 
The end of the file has setup instructions.

---
Use or operation of this code is subject to acceptance of the license available in the code 
repository for this code.

---

SAMPLES-AVIATION provides sample data for use in exploring InterSystems IRIS Text Analytics capabilities. 
In order to use this sample, you must have an InterSystems IRIS license that includes these capabilities.

After setup, the data is available for use in various ways:
* For use in InterSystems IRIS Natural Language Processing. See [documentation](http://docs.intersystems.com/irislatest?KEY=GIKNOW)
  
  The repo also contains specific samples related to NLP.
* For use with InterSystems IRIS SQL Search. See [documentation](http://docs.intersystems.com/irislatest?KEY=GSQLSRCH)
* For use with Text Analytics options in InterSystems IRIS Business Intelligence.
  See [documentation](http://docs.intersystems.com/irislatest?KEY=D2MODADV_ch_iknow)
  
  The repo also contains specific samples related to these options.

## Repo items related to the data

* The `Aviation.Aircraft`, `Aviation.Crew`, and `Aviation.Event` classes are persistent
  classes/tables that collectively represent a selected subset of aviation 
  incidents reported to the U.S. National Transportation Safety Board. 
  
* Upon setup (see below), data is loaded from the `gbl/Aviation.xml` file into these
  classes.

* The `Aviation.Utils` class is a helper classes used by the repo setup routine (see below).


Repo items for use with InterSystems IRIS Natural Language Processing (NLP) 

* The `Aviation.ReportDomain` class defines a sample NLP domain based on the data from this repo. You can run NLP queries against this domain. See [documentation](http://docs.intersystems.com/irislatest?KEY=GIKNOW)
* The `Aviation.Classification.Utils` class illustrates how to build and test Text Categorization models programmatically. See [documentation](http://docs.intersystems.com/irislatest?KEY=GIKNOW_textcat)
* The `Aviation.Metrics.Builder` and `Aviation.Metrics.Definition` classes demonstrate how to customize NLP by adding custom metrics. See [documentation](http://docs.intersystems.com/irislatest?KEY=GIKNOW_metrics)
* The `Aviation.UI` package contains two sample classes that you can use to perform NLP queries and visualize the results.


Repo items for use with Text Analytics options in InterSystems IRIS Business Intelligence (BI)

* The `Cubes` package contains BI cube definitions that use Text Analytics features and that use the data in this repo. See [documentation](http://docs.intersystems.com/irislatest?KEY=D2MODADV_ch_iknow) for details.
* `KPI.TopConcepts` contains a BI KPI that uses a Text Analytics query.
* `KPI.Actions` defines a KPI action (which is used on a dashboard also in this sample).
* `Aviation.DashboardsEtc` defines Business Intelligence pivot tables and dashboards
  that display the data in this repo and that provide you the ability of performing
  simple analyses of that dat.

## Setup instructions

1. Download the repo to your local disk and uncompress it.
2. Open the InterSystems IRIS Terminal.
3. Enter the following command (replacing `<namespace>` with the namespace where you want to load the sample):
```
   ZN "<namespace>"
```
4. Enter the following commands (replacing with the full path of the file buildsample/buildsampleaviation.mac):
```
   do $system.OBJ.Load("full-path-to-buildsampleaviation.rtn","ck")
   do ^buildsampleaviation
```
5. Then answer any prompts.
6. After the routine has finished running, create a web application for use in this namespace and 
   enable that web app for use with analytics. Here's how:

   a. In the Management Portal, select System Administration > Security > Applications > Web Applications. 

   b. Click Create New Web Application. 

   c. For name, type `/csp/<namespace>` where `<namespace>` is the specific namespace you're using. 

   d. For Namespace, select the same namespace. 

   e. Check the DeepSee and iKnow check boxes. 

   f. Accept all other defaults. 

   g. Click Save.

   If you have already defined a web application for use in this namespace, check the definiton of that web
   application and ensure that both DeepSee and iKnow check boxes are selected.

After step 6, when you access the Analytics submenu of the Management Portal, this namespace will be listed.
For example, you can now use the Analyzer with the cubes that are included within this sample. 

IMPORTANT: If the namespace is not listed when you access the Analytics submenu of the Management Portal, double-check that you performed all parts of step 6.
