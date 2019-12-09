/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
///  This class represents the details on aircraft involved in events registered by the 
///  National Transportation Safety Board.
///  Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  http://www.ntsb.gov. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.
///  	Courtesy: National Transportation Safety Board
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

}

