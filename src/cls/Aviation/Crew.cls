/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
///  <p>This class represents the details on crew involved in events registered by the 
///  <a href="http://www.ntsb.gov/" target="_blank">National Transportation Safety Board</a>.</p>
///  <p><b>Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  <a href="http://www.ntsb.gov/" target="_blank">http://www.ntsb.gov</a>. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.<br/>
///  	Courtesy: National Transportation Safety Board</p>
Class Aviation.Crew Extends %Persistent
{

Property EventId As %String;

Property AircraftKey As %Library.Integer;

Property CrewNumber As %Library.Integer;

Relationship Aircraft As Aviation.Aircraft [ Cardinality = parent, Inverse = Crew ];

Index PKINDEX On (EventId, AircraftKey, CrewNumber) [ PrimaryKey, Unique ];

Property Age As %Integer;

Property Category As %String(MAXLEN = 20);

Property Injury As %String(MAXLEN = 10);

Property Sex As %String(MAXLEN = 1);

Property ToxicologyTestPerformed As %String(MAXLEN = 1);

Property MedicalCertificationDate As %Library.TimeStamp;

Property MedicalCertification As %String(MAXLEN = 20);

Property MedicalCertificationValid As %String(MAXLEN = 50);

Property Seat As %String(MAXLEN = 10);

Property SeatbeltUsed As %String(MAXLEN = 1);

Property ShoulderHarnessUsed As %String(MAXLEN = 1);

Storage Default
{
<Data name="CrewDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EventId</Value>
</Value>
<Value name="3">
<Value>AircraftKey</Value>
</Value>
<Value name="4">
<Value>CrewNumber</Value>
</Value>
<Value name="5">
<Value>Age</Value>
</Value>
<Value name="6">
<Value>Category</Value>
</Value>
<Value name="7">
<Value>Injury</Value>
</Value>
<Value name="8">
<Value>Sex</Value>
</Value>
<Value name="9">
<Value>ToxicologyTestPerformed</Value>
</Value>
<Value name="10">
<Value>MedicalCertificationDate</Value>
</Value>
<Value name="11">
<Value>MedicalCertification</Value>
</Value>
<Value name="12">
<Value>MedicalCertificationValid</Value>
</Value>
<Value name="13">
<Value>Seat</Value>
</Value>
<Value name="14">
<Value>SeatbeltUsed</Value>
</Value>
<Value name="15">
<Value>ShoulderHarnessUsed</Value>
</Value>
</Data>
<DataLocation>{%%PARENT}("Crew")</DataLocation>
<DefaultData>CrewDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Aviation.AircraftC("Crew")</IdLocation>
<IndexLocation>^Aviation.CrewI</IndexLocation>
<StreamLocation>^Aviation.CrewS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

