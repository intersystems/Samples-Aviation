/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
///  This class represents the details on aircraft involved in events registered by the 
///  National Transportation Safety Board.
///  Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  http://www.ntsb.gov. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.
///  	Courtesy: National Transportation Safety Board
Class Aviation.Event Extends %Persistent
{

Property EventId As %Library.String;

Property NTSBId As %Library.String(MAXLEN = 10);

Property Type As %Library.String(MAXLEN = 10);

Property EventDate As %TimeStamp;

Property EventTime As %Integer;

Property TimeZone As %Library.String(MAXLEN = 3);

Property LocationCountry As %Library.String(MAXLEN = 100);

Property LocationState As %Library.String(MAXLEN = 100);

Property LocationCity As %Library.String(MAXLEN = 50);

Property LocationSiteZipCode As %Library.String(MAXLEN = 10);

Property LocationCoordsLatitude As %Double;

Property LocationCoordsLongitude As %Double;

Property MidAir As %Library.String(MAXLEN = 1);

Property OnGroundCollision As %Library.String(MAXLEN = 1);

Property AirportName As %Library.String(MAXLEN = 30);

Property AirportLocation As %Library.String(MAXLEN = 25);

Property AirportDistance As %Library.String(MAXLEN = 50);

Property AirportDirection As %Integer;

Property AirportElevation As %Integer;

Property LightConditions As %Library.String(MAXLEN = 20);

Property SkyConditionNonCeiling As %Library.String(MAXLEN = 20);

Property SkyConditionNonCeilingHeight As %Library.Integer;

Property SkyConditionCeilingHeight As %Library.Integer;

Property SkyConditionCeiling As %Library.String(MAXLEN = 20);

Property Visibility As %Library.String(MAXLEN = 50);

Property WeatherAirTemperature As %Integer;

Property WindDirection As %Integer;

Property WindDirectionIndicator As %Library.String(MAXLEN = 20);

Property WindVelocity As %Integer;

Property WindVelocityIndicator As %Library.String(MAXLEN = 20);

Property WindGustIndicator As %Library.String(MAXLEN = 20);

Property WindGust As %Integer;

Property Altimeter As %Library.String(MAXLEN = 50);

Property WeatherPrecipitation As %Library.String(MAXLEN = 3);

Property InjuriesHighest As %Library.String(MAXLEN = 10);

Property InjuriesGroundFatal As %Integer;

Property InjuriesGroundMinor As %Integer;

Property InjuriesGroundSerious As %Integer;

Property InjuriesTotalFatal As %Integer;

Property InjuriesTotalMinor As %Integer;

Property InjuriesTotalNone As %Integer;

Property InjuriesTotalSerious As %Integer;

Property InjuriesTotal As %Integer;

Property InvestigatingAgency As %Library.String(MAXLEN = 1);

Property FAADistrictOffice As %Library.String(MAXLEN = 50);

/// For simplicity, using the narratives for the first aircraft involved in this event,
/// as in most cases subsequent narratives just refer to the initial one.
Property NarrativeFull As %String(MAXLEN = 100000);

Property NarrativeSummary As %String(MAXLEN = 30000);

Property NarrativeCause As %String(MAXLEN = 30000);

Relationship Aircraft As Aviation.Aircraft [ Cardinality = children, Inverse = Event ];

Index PKINDEX On EventId [ PrimaryKey, Unique ];

}

