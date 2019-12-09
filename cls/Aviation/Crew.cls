/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
///  This class represents the details on aircraft involved in events registered by the 
///  National Transportation Safety Board.
///  Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  http://www.ntsb.gov. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.
///  	Courtesy: National Transportation Safety Board
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

}

