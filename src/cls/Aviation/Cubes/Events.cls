/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// 
Class Aviation.Cubes.Events Extends %DeepSee.CubeDefinition [ CompileAfter = Aviation.KPI.Actions, DependsOn = Aviation.Event, ProcedureBlock ]
{

Parameter DOMAIN;

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="AviationEvents" displayName="Aviation Events" disabled="false" abstract="false" sourceClass="Aviation.Event" actionClass="Aviation.KPI.Actions" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" defaultListing="SimpleListing">
<dimension name="EventDateD" displayName="Event Date" disabled="false" hasAll="false" allCaption="All EventDate" allDisplayName="EventDate" sourceProperty="EventDate" type="time" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level name="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true">
</level>
<level name="Month" disabled="false" timeFunction="MonthNumber" list="false" useDisplayValue="true" useAsFilter="true">
</level>
<level name="Day" disabled="false" timeFunction="DayNumber" list="false" useDisplayValue="true" useAsFilter="true">
</level>
</hierarchy>
</dimension>
<dimension name="LocationD" displayName="Location" disabled="false" hasAll="false" allCaption="All LocationCountry" allDisplayName="LocationCountry" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="LocationCountry" sourceExpression="%cube.%Lookup(&quot;CountryCodes&quot;, %source.LocationCountry)" name="Country" disabled="false" timeFunction="DayNumber" list="false" useDisplayValue="true" useAsFilter="true" nullReplacement="Unknown">
</level>
<level sourceProperty="LocationState" sourceExpression="$s(%source.LocationCountry=&quot;USA&quot;:%cube.%Lookup(&quot;USStateCodes&quot;, %source.LocationState), 1:%source.LocationState)" name="State" disabled="false" timeFunction="DayNumber" list="false" useDisplayValue="true" useAsFilter="true" nullReplacement="Unknown">
</level>
</hierarchy>
</dimension>
<dimension name="SkyConditionD" displayName="Sky Condition" disabled="false" hasAll="false" allCaption="All SkyConditionNonCeiling" allDisplayName="SkyConditionNonCeiling" type="data" iKnowMeasure="Report" iKnowType="dictionary" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="SkyConditionNonCeiling" name="SkyCondition" displayName="Sky Condition" description="Sky Condition (non-ceiling)" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
</level>
</hierarchy>
</dimension>
<dimension name="MidAirD" displayName="Mid-Air" disabled="false" hasAll="false" allCaption="All MidAir" allDisplayName="MidAir" type="data" iKnowMeasure="Report" iKnowType="dictionary" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="MidAir" name="MidAir" displayName="Mid-Air" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
</level>
</hierarchy>
</dimension>
<dimension name="InjuriesD" displayName="Injuries" disabled="false" hasAll="false" allCaption="All InjuriesHighest" allDisplayName="InjuriesHighest" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="InjuriesHighest" name="InjuriesHighest" displayName="Highest Injury" disabled="false" >
<property name="InjuryLevelNumeric" hidden="true" sourceExpression="$case(%source.InjuriesHighest, &quot;Fatal&quot;:3, &quot;Serious&quot;:2, &quot;Minor&quot;:1, &quot;None&quot;:0, :99)" sort="asc" />
</level>
</hierarchy>
</dimension>
<dimension name="EntitiesD" displayName="Entities" disabled="false" hasAll="true" allCaption="All Entities" allDisplayName="All Entities" type="iKnow" iKnowMeasure="Report" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level name="Entities" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
</level>
</hierarchy>
</dimension>
<dimension name="DictionariesD" displayName="Dictionaries" disabled="false" hasAll="true" allCaption="All Dictionaries" allDisplayName="All Dictionaries" type="iKnow" iKnowMeasure="Report" iKnowType="dictionary" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level name="Dictionaries" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
</level>
<level name="Items" disabled="false" list="false" useDisplayValue="true" useAsFilter="true">
</level>
</hierarchy>
</dimension>

<measure sourceProperty="NarrativeFull" name="Report" displayName="Report" disabled="false" aggregate="COUNT" type="iKnow" hidden="false" searchable="false" iKnowSource="string" iKnowParameters="MAT:SkipRelations::0" iKnowDictionaries="Injuries,Maneuvres,Pilot skills,Weather conditions"></measure>
<measure sourceProperty="InjuriesTotal" name="InjuriesTotal" disabled="false" type="number" hidden="false" searchable="false"></measure>

<relationship name="Aircraft" displayName="Aircraft" disabled="false" relatedCube="AviationAircraft" inverse="Event" cardinality="many"></relationship>

<calculatedMember name="Distinct Entity Count" disabled="false" dimension="MEASURES" valueExpression="%KPI(&quot;%DeepSee.iKnow&quot;,&quot;Result&quot;,1,&quot;aggregate&quot;,&quot;total&quot;,&quot;%CONTEXT&quot;)" hidden="false"></calculatedMember>
<calculatedMember name="Dictionary Match Count" disabled="false" dimension="MEASURES" valueExpression="%KPI(&quot;%DeepSee.iKnowDictionary&quot;,&quot;MatchCount&quot;,1,&quot;aggregate&quot;,&quot;sum&quot;,&quot;%CONTEXT&quot;) " hidden="false"></calculatedMember>
<calculatedMember name="Average Dictionary Score" disabled="false" dimension="MEASURES" valueExpression="%KPI(&quot;%DeepSee.iKnowDictionary&quot;,&quot;MatchScore&quot;,1,&quot;aggregate&quot;,&quot;average&quot;,&quot;%CONTEXT&quot;) " hidden="false"></calculatedMember>

<listing name="SimpleListing" disabled="false" listingType="table" fieldList="EventId, $$$IKLINK as Report, EventDate, Type, LocationCountry, LocationState, InjuriesHighest"></listing>
<listing name="ShortListing" disabled="false" listingType="table" fieldList="EventId, EventDate, LocationCountry, LocationState"></listing>
<listing name="Map" disabled="false" listingType="map" fieldList="EventId, $$$IKSUMMARY as Summary, LocationCoordsLatitude As Latitude, LocationCoordsLongitude As Longitude"></listing>
</cube>
}

}

