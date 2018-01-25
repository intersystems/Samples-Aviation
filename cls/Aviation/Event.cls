/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
///  <p>This class represents events involving aircraft as registered by the 
///  <a href="http://www.ntsb.gov/" target="_blank">National Transportation Safety Board</a>.</p>
///  <p><b>Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  <a href="http://www.ntsb.gov/" target="_blank">http://www.ntsb.gov</a>. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.<br/>
///  	Courtesy: National Transportation Safety Board</p>
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

Storage Default
{
<Data name="EventDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>EventId</Value>
</Value>
<Value name="3">
<Value>NTSBId</Value>
</Value>
<Value name="4">
<Value>Type</Value>
</Value>
<Value name="5">
<Value>EventDate</Value>
</Value>
<Value name="6">
<Value>EventTime</Value>
</Value>
<Value name="7">
<Value>TimeZone</Value>
</Value>
<Value name="8">
<Value>LocationCountry</Value>
</Value>
<Value name="9">
<Value>LocationState</Value>
</Value>
<Value name="10">
<Value>LocationCity</Value>
</Value>
<Value name="11">
<Value>LocationCountryCode</Value>
</Value>
<Value name="12">
<Value>LocationSiteZipCode</Value>
</Value>
<Value name="13">
<Value>LocationCoordsLatitude</Value>
</Value>
<Value name="14">
<Value>LocationCoordsLongitude</Value>
</Value>
<Value name="15">
<Value>MidAir</Value>
</Value>
<Value name="16">
<Value>OnGroundCollision</Value>
</Value>
<Value name="17">
<Value>AirportName</Value>
</Value>
<Value name="18">
<Value>AirportLocation</Value>
</Value>
<Value name="19">
<Value>AirportDistance</Value>
</Value>
<Value name="20">
<Value>AirportDirection</Value>
</Value>
<Value name="21">
<Value>AirportElevation</Value>
</Value>
<Value name="22">
<Value>LightConditions</Value>
</Value>
<Value name="23">
<Value>SkyConditionNonCeiling</Value>
</Value>
<Value name="24">
<Value>SkyConditionNonCeilingHeight</Value>
</Value>
<Value name="25">
<Value>SkyConditionCeilingHeight</Value>
</Value>
<Value name="26">
<Value>SkyConditionCeiling</Value>
</Value>
<Value name="27">
<Value>Visibility</Value>
</Value>
<Value name="28">
<Value>WeatherAirTemperature</Value>
</Value>
<Value name="29">
<Value>WindDirection</Value>
</Value>
<Value name="30">
<Value>WindDirectionIndicator</Value>
</Value>
<Value name="31">
<Value>WindVelocity</Value>
</Value>
<Value name="32">
<Value>WindVelocityIndicator</Value>
</Value>
<Value name="33">
<Value>WindGustIndicator</Value>
</Value>
<Value name="34">
<Value>WindGust</Value>
</Value>
<Value name="35">
<Value>Altimeter</Value>
</Value>
<Value name="36">
<Value>WeatherPrecipitation</Value>
</Value>
<Value name="37">
<Value>InjuriesHighest</Value>
</Value>
<Value name="38">
<Value>InjuriesGroundFatal</Value>
</Value>
<Value name="39">
<Value>InjuriesGroundMinor</Value>
</Value>
<Value name="40">
<Value>InjuriesGroundSerious</Value>
</Value>
<Value name="41">
<Value>InjuriesTotalFatal</Value>
</Value>
<Value name="42">
<Value>InjuriesTotalMinor</Value>
</Value>
<Value name="43">
<Value>InjuriesTotalNone</Value>
</Value>
<Value name="44">
<Value>InjuriesTotalSerious</Value>
</Value>
<Value name="45">
<Value>InjuriesTotal</Value>
</Value>
<Value name="46">
<Value>InvestigatingAgency</Value>
</Value>
<Value name="47">
<Value>FAADistrictOffice</Value>
</Value>
<Value name="48">
<Value>NarrativeFull</Value>
</Value>
<Value name="49">
<Value>NarrativeSummary</Value>
</Value>
<Value name="50">
<Value>NarrativeCause</Value>
</Value>
</Data>
<DataLocation>^Aviation.EventD</DataLocation>
<DefaultData>EventDefaultData</DefaultData>
<ExtentSize>100000</ExtentSize>
<IdLocation>^Aviation.EventD</IdLocation>
<IndexLocation>^Aviation.EventI</IndexLocation>
<StreamLocation>^Aviation.EventS</StreamLocation>
<Type>%Library.CacheStorage</Type>
}

}

