/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// <p>This class wraps all settings for the Aviation Events demo domain in a single XData block.
/// Check the documentation on "Domain Definitions" or the class reference of
/// <class>%iKnow.DomainDefinition</class> for more details.</p>
/// <p>Note: for licensing reasons, this domain is disabled by default. To enable it, open this class 
/// in Studio, change the "disabled" property in the root &lt;domain&gt; element of the
/// <xdata>Domain</xdata> XData block to "false" and compile the class. Alternatively, run the 
/// SetupStandalone() method in <class>Aviation.Utils</class>.<br/>This step
/// is only required for licensing reasons, as the outcome of the compile-time actions taken by an
/// iKnow domain definition could not be packaged in the distributed SAMPLES database before knowing
/// the license context at the actual Cache instance where it will be installed.</p>
/// <p><b>Note on the data</b>: The dataset provided in this sample demo is only a lightweight
/// subset of the full NTSB dataset, which is available from 
/// <a href="http://www.ntsb.gov/" target="_blank">http://www.ntsb.gov</a>. This data is supplied
/// here for demonstration purposes only and neither intended nor warranted to be accurate.<br/>
/// Courtesy: National Transportation Safety Board</p>
Class Aviation.ReportDomain Extends %iKnow.DomainDefinition
{

XData Domain [ XMLNamespace = "http://www.intersystems.com/iknow" ]
{
<domain name="Aviation Events demo" disabled="true">

<!-- use parameter elements to configure domain-level parameters -->
<parameter name="Status" value="1" />

<!-- this expression is used in the where clause of the query selecting data for this domain
	 through the "%expression.MaxYear" reference -->
<expression name="MaxYear" value="2013" />

<!-- this section configures the metadata fields for this domain -->
<metadata>
<field name="EventDate" dataType="DATE" operators="=,BETWEEN" />
<field name="Year" dataType="NUMBER" operators="=,&lt;=,>=,>,&lt;,BETWEEN" />
<field name="Country" dataType="STRING" operators="=" />
<field name="State" dataType="STRING" operators="=" />
<field name="LightConditions" dataType="STRING" operators="=" />
<field name="HighestInjury" dataType="STRING" caseSensitive="true" />
</metadata>

<!-- this section configures where to load the data from, upon calling the %Build() method.
	 Note that you can have any number of elements within this section, each corresponding to
	 one batch or list of sources previously indexed through an iKnow Lister class -->
<data dropBeforeBuild="true">
<table tableName="Aviation.Event" idField="EventId" groupField="YEAR(EventDate)" dataFields="NarrativeFull"
	whereClause="&quot;YEAR(EventDate) &lt;= &quot; _ %expression.MaxYear"
	metadataColumns="CAST(EventDate AS DATE) As EventDate, YEAR(EventDate) As Year, LocationCountry As Country, LocationState As State, LightConditions, InjuriesHighest HighestInjury" >
</table>
</data>

<!-- this section configures any dictionaries to be loaded into the domain upon building it -->
<matching dropBeforeBuild="true">

<!-- this first entry refers to a dictionary sourced from elsewhere, through a SQL query selecting
	 all dictionary terms to be loaded into the dictionary -->
<external sql="SELECT DISTINCT AircraftManufacturer, AircraftModel, ':aircraft:'||AircraftCategory||':'||AircraftManufacturer FROM Aviation.Aircraft" >
<column fixedValue="Aircraft" role="dictionary name" />
<column fixedValue="List of aircraft manufacturers and models" role="dictionary description" />
<column position="1" role="item name" />
<column position="1" role="term" />
<column position="2" role="term" />
<column position="3" role="item URI" />
</external>

<!-- subsequent dictionaries are defined statically -->
<dictionary name="Maneuvres">
 <item name="altitude" uri=":maneuver:altitude">
  <term string="ascend" />
  <term string="ascended" />
  <term string="ascending" />
  <term string="ascent" />
  <term string="descend" />
  <term string="descended" />
  <term string="descending" />
  <term string="descent" />
 </item>
 <item name="landing" uri=":maneuver:landing">
  <term string="landed" />
  <term string="landing" />
  <term string="lands" />
 </item>
 <item name="takeoff" uri=":maneuver:takeoff">
  <term string="take-off" />
  <term string="takeoff" />
  <term string="takeoffs" />
  <term string="taking off" />
  <term string="took off" />
 </item>
</dictionary>
<dictionary name="Weather conditions">
 <item name="clouds" uri=":weather:clouds">
  <term string="broken clouds" />
  <term string="cumuliform clouds" />
  <term string="scattered clouds" />
  <term string="skies overcast" />
  <term string="sky broken" />
 </item>
 <item name="heavy wind" uri=":weather:heavy wind">
  <term string="extreme turbulence" />
  <term string="severe turbulence" />
  <term string="significant turbulence" />
  <term string="substantial turbulence" />
 </item>
 <item name="mist" uri=":weather:mist">
  <term string="fog" />
  <term string="mist" />
 </item>
 <item name="rain" uri=":weather:rain">
  <term string="drizzle" />
  <term string="precipitation" />
  <term string="rain" />
  <term string="wet" />
 </item>
 <item name="thunderstorm" uri=":weather:thunderstorm">
  <term string="thunderstorm" />
  <term string="thunderstorms" />
 </item>
 <item name="clear" uri=":weather:visibility">
  <term string="clear of clouds" />
  <term string="clear skies" />
  <term string="clear sky" />
  <term string="sky condition clear" />
  <term string="unlimited visibility" />
  <term string="visibility unrestricted" />
 </item>
 <item name="mild wind" uri=":weather:wind">
  <term string="calm winds" />
  <term string="light winds" />
  <term string="wind" />
 </item>
 <item name="winter" uri=":weather:winter">
  <term string="ice-covered" />
  <term string="icy" />
  <term string="snow" />
  <term string="snow-covered" />
 </item>
</dictionary>
<dictionary name="Injuries">
 <item name="fatal" uri=":injuries:fatal">
  <term string="died" />
  <term string="fatal injuries" />
  <term string="fatally injured" />
  <term string="succumbed" />
  <term string="was killed" />
  <term string="were killed" />
 </item>
 <item name="minor" uri=":injuries:minor">
  <term string="minor injuries" />
  <term string="wounded" />
 </item>
 <item name="none" uri=":injuries:none">
  <term string="no injuries" />
  <term string="not injured" />
  <term string="survived" />
  <term string="was not injured" />
  <term string="were not injured" />
 </item>
 <item name="serious" uri=":injuries:serious">
  <term string="serious injuries" />
  <term string="seriously injured" />
 </item>
</dictionary>
<dictionary name="Pilot skills">
 <item name="instructor" uri=":skills:instructor">
  <term string="cfi" />
  <term string="instructor" />
 </item>
 <item name="professional" uri=":skills:pro">
  <term string="airline transport pilot" />
  <term string="commercial pilot" />
  <term string="commercial-rated pilot" />
  <term string="pilot/owner" />
  <term string="private pilot" />
  <term string="private-rated pilot" />
 </item>
 <item name="student" uri=":skills:student">
  <term string="student pilot" />
 </item>
</dictionary>
</matching>
</domain>
}

}

