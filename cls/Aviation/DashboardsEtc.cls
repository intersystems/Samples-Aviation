/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
Class Aviation.DashboardsEtc Extends %DeepSee.UserLibrary.Container [ Abstract ]
{

///  This XData section contains the contents of this container.
///  Typically this is an xml document representing a Dashboard or Pivot.
XData Contents [ XMLNamespace = "http://www.intersystems.com/deepsee/library" ]
{
<items>

<!-- Aviation demo\Per state overview.pivot -->
<!-- Pie chart plotting a breakdown of US aviation events by state, with geo listing option -->
<pivot xmlns="http://www.intersystems.com/deepsee/library" name="Per state overview" folderName="Aviation demo" title="" description="This pivot shows the events per state (US only), broken down by light conditions." keywords="iKnow,Aviation" owner="" shared="true" public="false" locked="false" resource="" timeCreated="2012-03-05T16:26:58.792Z" createdBy="UnknownUser" mdx="" cellWidth="120" columnHeaderStyle="" rowHeaderStyle="" cellStyle="" rowLabelSpan="true" columnLabelSpan="true" cellHeight="22" showEmptyRows="false" showEmptyColumns="false" cubeName="AviationEvents" caption="" listing="" listingRows="" showStatus="true" pageSize="100" colorScale="" rowTotals="false" columnTotals="false" rowTotalAgg="sum" columnTotalAgg="sum" rowTotalSource="page" showZebra="false" showRowCaption="true" printTitle="" printSubtitle="" printPageSize="" printOrientation="" printMarginTop="" printMarginLeft="" printMarginRight="" printMarginBottom="" printLabelWidth="" printCellWidth="">
  <rowAxisOptions spec="" key="" value="" text="" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </rowAxisOptions>
  <columnAxisOptions spec="" key="" value="" text="" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </columnAxisOptions>
  <rowLevel spec="[LocationD].[H1].[State].Members" key="" value="" text="State" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </rowLevel>
  <filter spec="[LocationD].[H1].[Country].&amp;[United States]" key="United States" value="" text="United States" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </filter>
</pivot>

<!-- Aviation demo\Injuries comparison.pivot -->
<!-- Pivot plotting the "highest injury level" attribute from the Event table against textual evidence found by iKnow in the actual report text -->
<pivot xmlns="http://www.intersystems.com/deepsee/library" name="Injuries comparison" folderName="Aviation demo" title="" description="This pivot compares the &quot;Highest injuries&quot; property with what can be derived from the Report text, using a simple Term List dictionary." keywords="iKnow,Aviation" owner="" shared="true" public="false" locked="false" resource="" timeCreated="2012-03-05T16:11:05.729Z" createdBy="UnknownUser" mdx="" cellWidth="120" columnHeaderStyle="" rowHeaderStyle="" cellStyle="" rowLabelSpan="true" columnLabelSpan="true" cellHeight="22" showEmptyRows="false" showEmptyColumns="false" cubeName="AviationEvents" caption="" listing="" listingRows="" showStatus="true" pageSize="100" colorScale="" rowTotals="false" columnTotals="false" rowTotalAgg="sum" columnTotalAgg="sum" rowTotalSource="page" showZebra="false" showRowCaption="true" printTitle="" printSubtitle="" printPageSize="" printOrientation="" printMarginTop="" printMarginLeft="" printMarginRight="" printMarginBottom="" printLabelWidth="" printCellWidth="">
  <rowAxisOptions spec="" key="" value="" text="" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </rowAxisOptions>
  <columnAxisOptions spec="" key="" value="" text="" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </columnAxisOptions>
  <rowLevel spec="[DictionariesD].[H1].[Dictionaries].[Injuries]" key="" value="" text="Dictionary" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="iKnow" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
    <childLevels spec="[DictionariesD].[H1].[Items].[:injuries:none]" key="" value="" text="none" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="none" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
    </childLevels>
    <childLevels spec="[DictionariesD].[H1].[Items].[:injuries:minor]" key="" value="" text="minor" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="minor" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
    </childLevels>
    <childLevels spec="[DictionariesD].[H1].[Items].[:injuries:serious]" key="" value="" text="serious" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="serious" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
    </childLevels>
    <childLevels spec="[DictionariesD].[H1].[Items].[:injuries:fatal]" key="" value="" text="fatal" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="fatal" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
    </childLevels>
  </rowLevel>
  <rowLevel spec="[DictionariesD].[H1].[Dictionaries].[Injuries]" key="" value="" text="All reports" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </rowLevel>
  <columnLevel spec="[InjuriesD].[H1].[InjuriesHighest].[None]" key="" value="" text="None" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </columnLevel>
  <columnLevel spec="[InjuriesD].[H1].[InjuriesHighest].[Minor]" key="" value="" text="Minor" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </columnLevel>
  <columnLevel spec="[InjuriesD].[H1].[InjuriesHighest].[Serious]" key="" value="" text="Serious" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </columnLevel>
  <columnLevel spec="[InjuriesD].[H1].[InjuriesHighest].[Fatal]" key="" value="" text="Fatal" headEnabled="false" headCount="" filterEnabled="false" filterExpression="" orderEnabled="false" orderExpression="" orderDirection="BDESC" aggEnabled="false" aggFunction="" aggFunctionParm="" levelCaption="" levelFormat="" levelSummary="" levelType="" drillLevel="0" advanced="false" levelStyle="" levelHeaderStyle="">
  </columnLevel>
</pivot>

<!-- Aviation event reports.dashboard -->
<!-- Contains the following widgets: 
		- Aviation demo\Injuries comparison.pivot
		- Aviation demo\Per state overview.pivot 
		- AviationTopConcepts.kpi (plotting top concepts for Report iKnow measure) -->
<dashboard xmlns="http://www.intersystems.com/deepsee/library" name="Aviation event reports" folderName="" title="Aviation event reports" description="Note on the data: The dataset provided in this sample demo is only a lightweight subset of the full NTSB dataset, which is available from http://www.ntsb.gov. This data is supplied here for demonstration purposes only and neither intended nor warranted to be accurate. Courtesy: National Transportation Safety Board" keywords="iKnow,Aviation" owner="" shared="true" public="true" locked="false" resource="" timeCreated="2012-03-05T15:18:29.165Z" createdBy="UnknownUser" category="" bookCover="{background: {style:&apos;background:white;&apos;},header: {text:&apos;$type&apos;},title: {text:&apos;$title&apos;},image: {style:&apos;width:137.5px;height:122.5px;&apos;,src:&apos;covers/book_128.gif&apos;,imageStyle:&apos;width:137.5px;height:122.5px;&apos;},subtitle: {},footer: {text:&apos;unstructured data&apos;,style:&apos;background-color:rgb(224, 0, 0);&apos;}}" scheme="" worklistCount="1" snapTo="false" snapGrid="true" gridRows="10" gridCols="10" canResize="true" canModify="true" showTitleBar="true">
  <widget name="InjuriesComparison" type="pivot" subtype="pivot" subtypeClass="" title="&quot;Highest injuries&quot; vs matching results" dataSource="Aviation demo/Injuries comparison.pivot" dataLink="" drillDownDataSource="" top="3" left="545" width="602" height="285" sidebarContent="" showSidebar="false" sidebarWidth="" maximized="false" homeRowL="0" homeColL="4" colSpanL="6" rowSpanL="5" showToolbar="true" theme="">
    <control name="" action="showListing" target="" targetProperty="SimpleListing" location="widget" type="auto" controlClass="" label="" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
    <control name="" action="GoToReport" target="" targetProperty="" location="widget" type="auto" controlClass="" label="NTSB report" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen="listingSelected1"></control>
    <property name="analyzer">1</property>
    <property name="chartToggle">none</property>
    <property name="dimensionSource"></property>
    <property name="excel">0</property>
    <property name="initialExecute">1</property>
    <property name="pivotSelect"></property>
    <property name="print">0</property>
    <property name="showDimensions">0</property>
  </widget>
  <widget name="PerStateOverview" type="pivot" subtype="pieChart" subtypeClass="pieChart" title="US Accidents by state" dataSource="Aviation demo/Per state overview.pivot" dataLink="" drillDownDataSource="" top="3" left="5" width="540" height="551" sidebarContent="" showSidebar="false" sidebarWidth="" maximized="false" homeRowL="0" homeColL="0" colSpanL="4" rowSpanL="10" showToolbar="true" theme="">
    <control name="" action="showListing" target="" targetProperty="SimpleListing" location="widget" type="auto" controlClass="" label="" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
    <control name="" action="showGeoListing" target="" targetProperty="Map" location="widget" type="auto" controlClass="" label="" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
    <control name="" action="applyFilter" target="*" targetProperty="[EventDateD].[H1].[Year]" location="dashboard" type="searchBox" controlClass="" label="Year" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
    <control name="" action="applyFilter" target="*" targetProperty="[Aircraft].[AircraftTypeD].[H1].[Category]" location="dashboard" type="dropdown" controlClass="" label="Aircraft type" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
    <control name="" action="showBreakdown" target="" targetProperty="" location="widget" type="auto" controlClass="" label="" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen="itemSelected"></control>
    <control name="" action="GoToReport" target="" targetProperty="" location="widget" type="auto" controlClass="" label="NTSB report" title="" value="" text="" readOnly="false" valueList="" displayList="" activeWhen="listingSelected1"></control>
    <property name="analyzer">1</property>
    <property name="chartToggle">chart</property>
    <property name="dimensionSource"></property>
    <property name="excel">0</property>
    <property name="initialExecute">1</property>
    <property name="legendPos">bottom</property>
    <property name="pivotSelect"></property>
    <property name="print">0</property>
    <property name="showDimensions">0</property>
    <override name="legend">{orientation:'horizontal',_type:'chartLegend'}</override>
  </widget>
  <widget name="TopConceptsKPI" type="pivot" subtype="pivot" subtypeClass="" title="Top concepts in Event Reports" dataSource="AviationTopConcepts.kpi" dataLink="" drillDownDataSource="" top="291" left="546" width="598" height="261" sidebarContent="" showSidebar="false" sidebarWidth="" maximized="false" homeRowL="5" homeColL="4" colSpanL="6" rowSpanL="5" showToolbar="true" theme="">
    <control name="" action="prevPage" target="" targetProperty="" location="widget" type="auto" controlClass="" label="&lt;&lt;" title="Previous page" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
    <control name="" action="nextPage" target="" targetProperty="" location="widget" type="auto" controlClass="" label="&gt;&gt;" title="Next page" value="" text="" readOnly="false" valueList="" displayList="" activeWhen=""></control>
  </widget>
</dashboard>
</items>
}

}

