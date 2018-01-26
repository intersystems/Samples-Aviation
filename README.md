# Samples-Aviation
This is the README file for SAMPLES-AVIATION. 
The end of the file has setup instructions.
************************************************************************************
Use or operation of this code is subject to acceptance of the license available in the code 
repository for this code.
************************************************************************************
SAMPLES-AVIATION provides sample data for use in exploring InterSystems IRIS Text Analytics capabilities. This data provides a combination of structured and unstructured 
meant solely for use in exploring InterSystems IRIS capabilities.

After setup, the data is available for use in various ways:
* For use in InterSystems IRIS Natural Language Processing. See 
  http://docs.intersystems.com/irislatest?KEY=GIKNOW 
  The repo also contains specific samples related to NLP.
* For use with InterSystems IRIS SQL Search. See 
  http://docs.intersystems.com/irislatest?KEY=GSQLSRCH
* For use with Text Analytics options in InterSystems IRIS Business Intelligence.
  See http://docs.intersystems.com/irislatest?KEY=D2MODADV_ch_iknow
  The repo also contains specific samples related to these options.

************************************************************************************
Repo items related to the data
************************************************************************************
* The Aviation.Aircraft, Aviation.Crew, and Aviation.Event classes are persistent
  classes/tables that collectively represent a selected subset of aviation 
  incidents reported to the U.S. National Transportation Safety Board. 
  
* Upon setup (see end), data is loaded from the gbl/Aviation.xml file into these
  classes.

* The Aviation.DataUtils and Aviation.Utils are helper classes used by the repo
  setup routine (see end).

************************************************************************************
Repo items for use with InterSystems IRIS Natural Language Processing (NLP) 
************************************************************************************
* The Aviation.ReportDomain class defines a sample NLP domain based on the data
  from this repo. You can run NLP queries against this domain. See 
  http://docs.intersystems.com/irislatest?KEY=GIKNOW

* The Aviation.Classification.Utils class illustrates how to build and test Text 
  Categorization models programmatically. See 
  http://docs.intersystems.com/irislatest?KEY=GIKNOW_textcat

* The Aviation.Metrics.Builder and Aviation.Metrics.Definition classes demonstrate
  how to customize NLP by adding custom metrics. See 
  http://docs.intersystems.com/irislatest?KEY=GIKNOW_metrics

* The Aviation.UI package contains two sample classes that you can use to perform
  NLP queries and visualize the results.

************************************************************************************
Repo items for use with Text Analytics options in InterSystems IRIS Business Intelligence (BI).
************************************************************************************
* The Cubes package contains BI cube definitions that use Text Analytics features
  and that use the data in this repo. See 
  http://docs.intersystems.com/irislatest?KEY=D2MODADV_ch_iknow for details.
* KPI.TopConcepts contains a BI KPI that uses a Text Analytics query.
* KPI.Actions defines a KPI action (which is used on a dashboard also in this repo).
* Aviation.DashboardsEtc defines Business Intelligence pivot tables and dashboards
  that display the data in this repo and that provide you the ability of performing
  simple analyses of that dat.

************************************************************************************
Setup instructions
************************************************************************************
1. Download the repo to your local disk.
2. Open the InterSystems IRIS Terminal.
3. Enter the following command, where my-namespace is the namespace where you want to load the sample:
   ZN "my-namespace"
4. Enter the following commands (replacing with the full path of the       buildsample/buildsampleaviation.rtn file):
   do $system.OBJ.Load("full-path-to-buildsampleaviation.rtn","ck")
   do ^buildsampleaviation
   These steps load & start a routine that will load the rest of the sample and 
   its data and compile all the code in the sample.
5. Then answer the prompts.
6. Create a web application for use in this namespace and enable that web app for use with analytics. Here's how: 
   <p>a. In the Management Portal, select System Administration > Security > Applications > Web Applications.<p>
   <p>b. Click Create New Web Application.<p>
   <p>c. For name, type csp/namespace where namespace is the specific namespace you're using.<p> 
   <p>d. For Namespace, select the same namespace.<p> 
   <p>e. Check the DeepSee and iKnow check boxes.<p> 
   <p>f. Accept all other defaults.<p> 
   <p>g. Click Save.<p>
