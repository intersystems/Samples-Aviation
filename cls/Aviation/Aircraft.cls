/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
///  <p>This class represents the details on aircraft involved in events registered by the 
///  <a href="http://www.ntsb.gov/" target="_blank">National Transportation Safety Board</a>.</p>
///  <p><b>Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  <a href="http://www.ntsb.gov/" target="_blank">http://www.ntsb.gov</a>. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.<br/>
///  	Courtesy: National Transportation Safety Board</p>
Class Aviation.Aircraft Extends %Persistent
{

Property EventId As %String;

Property AircraftKey As %Library.Integer;

Relationship Event As Aviation.Event [ Cardinality = parent, Inverse = Aircraft ];

Relationship Crew As Aviation.Crew [ Cardinality = children, Inverse = Aircraft ];

Property RegistrationNumber As %Library.String(MAXLEN = 11);

Property Missing As %Library.String(MAXLEN = 1);

Property FlightPlan As %Library.String(MAXLEN = 20);

Property FlightPlanActivated As %Library.String(MAXLEN = 1);

Property Damage As %Library.String(MAXLEN = 20);

Property AccidentFire As %Library.String(MAXLEN = 20);

Property AccidentExplosion As %Library.String(MAXLEN = 20);

Property AircraftManufacturer As %Library.String(MAXLEN = 30);

Property AircraftModel As %Library.String(MAXLEN = 20);

Property AircraftSeries As %Library.String(MAXLEN = 10);

Property AircraftSerialNo As %Library.String(MAXLEN = 20);

Property AircraftCertMaxGrossWeight As %Library.Integer;

Property AircraftCategory As %Library.String(MAXLEN = 20);

Property AircraftRegistrationClass As %Library.String(MAXLEN = 50);

Property AircraftHomeBuilt As %Library.String(MAXLEN = 3);

Property SeatsFlightCrew As %Library.Integer;

Property SeatsCabinCrew As %Library.Integer;

Property SeatsPassengers As %Library.Integer;

Property SeatsTotal As %Library.Integer;

Property EngineCount As %Library.Integer;

Property GearType As %Library.String(MAXLEN = 4);

Property LastInspectionType As %Library.String(MAXLEN = 50);

Property LastInspectionDate As %Library.TimeStamp;

Property AirFrameHoursSinceLastInspection As %Library.String(MAXLEN = 50);

Property AirFrameHours As %Library.String(MAXLEN = 50);

Property Owner As %Library.String(MAXLEN = 50);

Property OwnerState As %Library.String(MAXLEN = 2);

Property OwnerCountry As %Library.String(MAXLEN = 4);

Property OperatorIndividual As %Library.String(MAXLEN = 1);

Property OperatorName As %Library.String(MAXLEN = 50);

Property OperatorState As %Library.String(MAXLEN = 2);

Property OperatorCountry As %Library.String(MAXLEN = 4);

Property OperatorCode As %Library.String(MAXLEN = 4);

Property OwnerCertified As %Library.String(MAXLEN = 1);

Property OperatorCertificate As %Library.String(MAXLEN = 4);

Property OperatorCertificateNum As %Library.String(MAXLEN = 11);

Property OperationScheduled As %Library.String(MAXLEN = 20);

Property OperationDomestic As %Library.String(MAXLEN = 20);

Property OperationType As %Library.String(MAXLEN = 20);

Property FlightType As %Library.String(MAXLEN = 20);

Property SecondPilot As %Library.String(MAXLEN = 1);

Property DepartureSameAsEvent As %Library.String(MAXLEN = 1);

Property DepartureAirportId As %Library.String(MAXLEN = 4);

Property DepartureCity As %Library.String(MAXLEN = 50);

Property DepartureState As %Library.String(MAXLEN = 2);

Property DepartureCountry As %Library.String(MAXLEN = 3);

Property DepartureTime As %Library.Integer;

Property DepartureTimeZone As %Library.String(MAXLEN = 3);

Property DestinationSameAsLocal As %Library.String(MAXLEN = 4);

Property DestinationAirportId As %Library.String(MAXLEN = 4);

Property DestinationCity As %Library.String(MAXLEN = 50);

Property DestinationState As %Library.String(MAXLEN = 2);

Property DestinationCountry As %Library.String(MAXLEN = 3);

Property FlightPhase As %Library.Integer;

Property ReportedToICAO As %Library.String(MAXLEN = 1);

Property EvacuationOccurred As %Library.String(MAXLEN = 1);

Property AirFrameHoursSince As %Library.String(MAXLEN = 4);

Property FlightSiteSeeing As %Library.String(MAXLEN = 1);

Property FlightMedical As %Library.String(MAXLEN = 1);

Property FlightMedicalType As %Library.String(MAXLEN = 15);

Index PKINDEX On (EventId, AircraftKey) [ PrimaryKey, Unique ];

Storage Default
{
<Data name="AircraftDefaultData">
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
<Value>RegistrationNumber</Value>
</Value>
<Value name="5">
<Value>Missing</Value>
</Value>
<Value name="6">
<Value>FlightPlan</Value>
</Value>
<Value name="7">
<Value>FlightPlanActivated</Value>
</Value>
<Value name="8">
<Value>Damage</Value>
</Value>
<Value name="9">
<Value>AccidentFire</Value>
</Value>
<Value name="10">
<Value>AccidentExplosion</Value>
</Value>
<Value name="11">
<Value>AircraftManufacturer</Value>
</Value>
<Value name="12">
<Value>AircraftModel</Value>
</Value>
<Value name="13">
<Value>AircraftSeries</Value>
</Value>
<Value name="14">
<Value>AircraftSerialNo</Value>
</Value>
<Value name="15">
<Value>AircraftCertMaxGrossWeight</Value>
</Value>
<Value name="16">
<Value>AircraftCategory</Value>
</Value>
<Value name="17">
<Value>AircraftRegistrationClass</Value>
</Value>
<Value name="18">
<Value>AircraftHomeBuilt</Value>
</Value>
<Value name="19">
<Value>SeatsFlightCrew</Value>
</Value>
<Value name="20">
<Value>SeatsCabinCrew</Value>
</Value>
<Value name="21">
<Value>SeatsPassengers</Value>
</Value>
<Value name="22">
<Value>SeatsTotal</Value>
</Value>
<Value name="23">
<Value>EngineCount</Value>
</Value>
<Value name="24">
<Value>GearType</Value>
</Value>
<Value name="25">
<Value>LastInspectionType</Value>
</Value>
<Value name="26">
<Value>LastInspectionDate</Value>
</Value>
<Value name="27">
<Value>AirFrameHoursSinceLastInspection</Value>
</Value>
<Value name="28">
<Value>AirFrameHours</Value>
</Value>
<Value name="29">
<Value>Owner</Value>
</Value>
<Value name="30">
<Value>OwnerState</Value>
</Value>
<Value name="31">
<Value>OwnerCountry</Value>
</Value>
<Value name="32">
<Value>OperatorIndividual</Value>
</Value>
<Value name="33">
<Value>OperatorName</Value>
</Value>
<Value name="34">
<Value>OperatorState</Value>
</Value>
<Value name="35">
<Value>OperatorCountry</Value>
</Value>
<Value name="36">
<Value>OperatorCode</Value>
</Value>
<Value name="37">
<Value>OwnerCertified</Value>
</Value>
<Value name="38">
<Value>OperatorCertificate</Value>
</Value>
<Value name="39">
<Value>OperatorCertificateNum</Value>
</Value>
<Value name="40">
<Value>OperationScheduled</Value>
</Value>
<Value name="41">
<Value>OperationDomestic</Value>
</Value>
<Value name="42">
<Value>OperationType</Value>
</Value>
<Value name="43">
<Value>FlightType</Value>
</Value>
<Value name="44">
<Value>SecondPilot</Value>
</Value>
<Value name="45">
<Value>DepartureSameAsEvent</Value>
</Value>
<Value name="46">
<Value>DepartureAirportId</Value>
</Value>
<Value name="47">
<Value>DepartureCity</Value>
</Value>
<Value name="48">
<Value>DepartureState</Value>
</Value>
<Value name="49">
<Value>DepartureCountry</Value>
</Value>
<Value name="50">
<Value>DepartureTime</Value>
</Value>
<Value name="51">
<Value>DepartureTimeZone</Value>
</Value>
<Value name="52">
<Value>DestinationSameAsLocal</Value>
</Value>
<Value name="53">
<Value>DestinationAirportId</Value>
</Value>
<Value name="54">
<Value>DestinationCity</Value>
</Value>
<Value name="55">
<Value>DestinationState</Value>
</Value>
<Value name="56">
<Value>DestinationCountry</Value>
</Value>
<Value name="57">
<Value>FlightPhase</Value>
</Value>
<Value name="58">
<Value>ReportedToICAO</Value>
</Value>
<Value name="59">
<Value>EvacuationOccurred</Value>
</Value>
<Value name="60">
<Value>AirFrameHoursSince</Value>
</Value>
<Value name="61">
<Value>FlightSiteSeeing</Value>
</Value>
<Value name="62">
<Value>FlightMedical</Value>
</Value>
<Value name="63">
<Value>FlightMedicalType</Value>
</Value>
</Data>
<DataLocation>{%%PARENT}("Aircraft")</DataLocation>
<DefaultData>AircraftDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Aviation.EventC("Aircraft")</IdLocation>
<IndexLocation>^Aviation.AircraftI</IndexLocation>
<StreamLocation>^Aviation.AircraftS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

