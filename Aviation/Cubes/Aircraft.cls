/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// 
Class Aviation.Cubes.Aircraft Extends %DeepSee.CubeDefinition [ DependsOn = (Aviation.Aircraft, Aviation.Cubes.Events), ProcedureBlock ]
{

Parameter DOMAIN;

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="AviationAircraft" displayName="Aviaton Aircraft" disabled="false" abstract="false" sourceClass="Aviation.Aircraft" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0">
<dimension name="AircraftTypeD" displayName="Aircraft Type" disabled="false" hasAll="true" allCaption="All Types" allDisplayName="All Types" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="AircraftCategory" name="Category" disabled="false" list="false" useDisplayValue="true">
</level>
<level sourceProperty="AircraftManufacturer" name="Manufacturer" disabled="false" list="false" useDisplayValue="true">
</level>
<level sourceProperty="AircraftModel" name="Model" disabled="false" list="false" useDisplayValue="true">
</level>
</hierarchy>
</dimension>
<dimension name="FlightTypeD" displayName="Flight Type" disabled="false" hasAll="false" allCaption="All FlightType" allDisplayName="FlightType" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="FlightType" name="FlightType" disabled="false" list="false" useDisplayValue="true">
</level>
</hierarchy>
</dimension>
<dimension name="DamageD" displayName="Damage" disabled="false" hasAll="false" allCaption="All Damage" allDisplayName="Damage" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="Damage" name="Damage" disabled="false" list="false" useDisplayValue="true">
<property name="DamageNumeric" hidden="true" sourceExpression="$case(%source.Damage, &quot;Destroyed&quot;:3, &quot;Substantial&quot;:2, &quot;Minor&quot;:1, &quot;None&quot;:0, :99)" sort="asc" />
</level>
</hierarchy>
</dimension>
<relationship sourceProperty="Event" name="Event" disabled="false" relatedCube="AviationEvents" inverse="Aircraft" cardinality="one"></relationship>
<relationship name="Crew" disabled="false" relatedCube="AviationCrew" inverse="Aircraft" cardinality="many"></relationship>
</cube>
}

}

