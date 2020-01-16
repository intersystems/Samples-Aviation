/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// 
Class Aviation.Cubes.Crew Extends %DeepSee.CubeDefinition [ DependsOn = (Aviation.Crew, Aviation.Cubes.Aircraft), ProcedureBlock ]
{

Parameter DOMAIN;

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="AviationCrew" displayName="Aviation Crew" disabled="false" abstract="false" sourceClass="Aviation.Crew" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0">
<dimension name="AgeD" displayName="Age" disabled="false" hasAll="true" allCaption="All Ages" allDisplayName="All ages" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="Age" name="AgeGroup" displayName="Age group" disabled="false" list="false" rangeExpression="(,25):&lt; 25;[25,45):25-45;[45,55):45-55;[55,):55+;" useDisplayValue="true">
</level>
<level sourceProperty="Age" name="Age" disabled="false" list="false" useDisplayValue="true">
</level>
</hierarchy>
</dimension>
<dimension name="GenderD" displayName="Gender" disabled="false" hasAll="true" allCaption="All gender" allDisplayName="All gender" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="Sex" name="Gender" disabled="false" list="false" useDisplayValue="true">
</level>
</hierarchy>
</dimension>
<dimension name="CategoryD" displayName="Category" disabled="false" hasAll="true" allCaption="All categories" allDisplayName="All categories" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="Category" name="Category" disabled="false" list="false" useDisplayValue="true">
</level>
</hierarchy>
</dimension>
<dimension name="InjuryD" displayName="Injury" disabled="false" hasAll="true" allCaption="All injuries" allDisplayName="All injuries" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="Injury" name="Injury" disabled="false" list="false" useDisplayValue="true" nullReplacement="Unknown">
<property name="InjuryNumeric" hidden="true" sourceExpression="$case(%source.Injury, &quot;Fatal&quot;:3, &quot;Serious&quot;:2, &quot;Minor&quot;:1, &quot;None&quot;:0, :99)" sort="asc" />
</level>
</hierarchy>
</dimension>
<dimension name="MedicalCertificationD" displayName="Medical Certification" disabled="false" hasAll="true" allCaption="All certifications" allDisplayName="All certifications" type="data" iKnowType="entity" hidden="false" showHierarchies="default">
<hierarchy name="H1" disabled="false">
<level sourceProperty="MedicalCertification" name="MedicalCertification" displayName="Medical Certification" disabled="false" list="false" useDisplayValue="true">
</level>
</hierarchy>
</dimension>
<listing name="Details" disabled="false" listingType="table" fieldList="CrewNumber,Age,Sex,Category,MedicalCertification,MedicalCertificationDate,MedicalCertificationValid,SeatbeltUsed,ShoulderHarnessUsed,ToxicologyTestPerformed"></listing>
<relationship name="Aircraft" relatedCube="AviationAircraft" sourceProperty="Aircraft" cardinality="one" inverse="Crew" />
</cube>
}

}

