Include %IKPublic

/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// <p>This class groups code for setting up two demos:</p>
/// <ul>
/// 	<li>The <b>BI Aviation demo</b> demonstrates how the iKnow featues embedded in
/// 		DeepSee can be used to combine analysis of structured and unstructured data. It can be
/// 		configured by calling the <method>SetupCube</method> class method in this class. </li>
/// 	<li>The <b>Text Analytics Aviation demo</b> uses the same dataset, but just loads it as a normal
/// 		standalone iKnow domain, which can be explored to the general iKnow APIs. This domain is
/// 		fully defined through the domain definition in <class>Aviation.ReportDomain</class> and can
/// 		be set up by calling its %Build() method. This class' <method>SetupStandalone</method>
/// 		will invoke that %Build() method and call additional configuration code to ensure your
/// 		security settings allow accessing the UI classes.</p>
/// </ul>
/// 
///  <p>The classes in this package represent events involving aircraft as registered by the 
///  <a href="http://www.ntsb.gov/" target="_blank">National Transportation Safety Board</a>.</p>
///  <p><b>Note on the data</b>: The dataset provided in this sample demo is only a lightweight
///  subset of the full NTSB dataset, which is available from 
///  <a href="http://www.ntsb.gov/" target="_blank">http://www.ntsb.gov</a>. This data is supplied
///  here for demonstration purposes only and neither intended nor warranted to be accurate.<br/>
///  	Courtesy: National Transportation Safety Board</p>
Class Aviation.Utils Extends %RegisteredObject
{

Parameter CUBENAME = "AviationEvents";

Parameter MEASURENAME = "Report";

///  Utility method to load all relevant data and build the
///  <class>Aviation.Cubes.Events</class> cube for the DeepSee Aviation demo.	
ClassMethod SetupCube() As %Status
{
	set namespace = $ZNspace
	set app = $System.CSP.GetDefaultApp(namespace) _ "/"

	try {
		do EnableDeepSee^%SYS.cspServer(app)
	} catch (ex) {
		write !,"WARNING: failed to enable DeepSee for "_namespace_" namespace."
	}
	
	set tSC = $$$OK
	try {
		w !,"Loading Aviation Term Lists...",!
		set tSC = ..CreateTermLists()
		quit:$$$ISERR(tSC)
		
		// compile the cube as pre-loaded samples classes might not have run through
		// all required projection code for iKnow domain generation
		w !,"Compiling Aviation cubes...",!
		set tSC = $system.OBJ.Compile("Aviation.Cubes.Events", "ckr-d")
		quit:$$$ISERR(tSC)
		
		set tSC = ##class(%DeepSee.Utils).%BuildCube("AviationEvents")
		quit:$$$ISERR(tSC)
		set tSC = ##class(%DeepSee.Utils).%BuildCube("AviationAircraft")
		quit:$$$ISERR(tSC)
		set tSC = ##class(%DeepSee.Utils).%BuildCube("AviationCrew")
		quit:$$$ISERR(tSC)
		
		w !,"Loading Aviation Pivots & Dashboard...",!
		set tSC = ##class(%DeepSee.UserLibrary.Utils).%ImportContainer("Aviation.DashboardsEtc",1,1)
		quit:$$$ISERR(tSC)
		
		w !,"All done, you can now use the Aviation cubes in Analyzer",!
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	
	if $$$ISERR(tSC) {
		w !,"An error occurred while loading the demo:"
		d $system.OBJ.DisplayError(tSC)
	}
	
	quit tSC
}

/// <p>Sets up a regular iKnow domain and loads the Aviation demo dataset into it by calling the 
/// <class>Aviation.ReportDomain</class> %Build() method after enabling it and configuring CSP access
/// to %iKnow UI classes for the SAMPLES web application.</p>
ClassMethod SetupStandalone(pLoadTermLists As %Boolean = 1, pVerbose As %Boolean = 1) As %Status
{
	set namespace = $ZNspace
	set app = $System.CSP.GetDefaultApp(namespace) _ "/"
	try {
		do EnableIKnow^%SYS.cspServer(app)
	} catch (ex) {
		write !,"WARNING: failed to enable iKnow sample UI classes for "_namespace_" namespace."
	}
	
	set tSC = $$$OK
	try {
		set tSC = ##class(Aviation.ReportDomain).%Build(pVerbose)
		quit:$$$ISERR(tSC)
		
		set tSC = ##class(%Library.RoutineMgr).GetWebServerPort(.tPort,.tServer,.tURLPrefix,.tURL)		
		write:pVerbose !,"All done.",!!,"You can browse the contents of this domain using the Knowledge Portal at",!,tURL,"csp/sys/_iKnow.UI.KnowledgePortal.zen?$NAMESPACE="_$ZNSpace_"&domain="_##class(Aviation.ReportDomain).%GetDomainId(),!
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	if $$$ISERR(tSC) {
		write !,"An error occurred while setting up the Standalone Aviation Demo:",!
		do $system.OBJ.DisplayError(tSC)
	}
	quit tSC
}

/// Returns the dictionaries to be used for matching with the Aviation dataset in a 
/// pseudo-form, so they can be used both for building Term Lists (see
/// <method>CreateTermLists</method>) and iKnow Dictionaries
/// (<method>CreateIKnowDictionaries</method>).
ClassMethod GetAviationDictionaries(Output pDictionaries) As %Status [ Internal ]
{
	kill pDictionaries 
    s pDictionaries(1) = "Maneuvres"
    s pDictionaries(1,":maneuver:altitude") = "altitude"
    s pDictionaries(1,":maneuver:altitude",1) = "ascend"
    s pDictionaries(1,":maneuver:altitude",2) = "ascended"
    s pDictionaries(1,":maneuver:altitude",3) = "ascending"
    s pDictionaries(1,":maneuver:altitude",4) = "ascent"
    s pDictionaries(1,":maneuver:altitude",5) = "descend"
    s pDictionaries(1,":maneuver:altitude",6) = "descended"
    s pDictionaries(1,":maneuver:altitude",7) = "descending"
    s pDictionaries(1,":maneuver:altitude",8) = "descent"
    s pDictionaries(1,":maneuver:landing") = "landing"
    s pDictionaries(1,":maneuver:landing",1) = "landed"
    s pDictionaries(1,":maneuver:landing",2) = "landing"
    s pDictionaries(1,":maneuver:landing",3) = "lands"
    s pDictionaries(1,":maneuver:takeoff") = "takeoff"
    s pDictionaries(1,":maneuver:takeoff",1) = "take-off"
    s pDictionaries(1,":maneuver:takeoff",2) = "takeoff"
    s pDictionaries(1,":maneuver:takeoff",3) = "takeoffs"
    s pDictionaries(1,":maneuver:takeoff",4) = "taking off"
    s pDictionaries(1,":maneuver:takeoff",5) = "took off"
    s pDictionaries(2) = "Weather conditions"
    s pDictionaries(2,":weather:clouds") = "clouds"
    s pDictionaries(2,":weather:clouds",1) = "broken clouds"
    s pDictionaries(2,":weather:clouds",2) = "cumuliform clouds"
    s pDictionaries(2,":weather:clouds",3) = "scattered clouds"
    s pDictionaries(2,":weather:clouds",4) = "skies overcast"
    s pDictionaries(2,":weather:clouds",5) = "sky broken"
    s pDictionaries(2,":weather:wind") = "mild wind"
    s pDictionaries(2,":weather:wind",1) = "calm winds"
    s pDictionaries(2,":weather:wind",2) = "light winds"
    s pDictionaries(2,":weather:wind",3) = "wind"
    s pDictionaries(2,":weather:visibility") = "clear"
    s pDictionaries(2,":weather:visibility",1) = "clear of clouds"
    s pDictionaries(2,":weather:visibility",2) = "clear skies"
    s pDictionaries(2,":weather:visibility",3) = "clear sky"
    s pDictionaries(2,":weather:visibility",4) = "sky condition clear"
    s pDictionaries(2,":weather:visibility",5) = "unlimited visibility"
    s pDictionaries(2,":weather:visibility",6) = "visibility unrestricted"
    s pDictionaries(2,":weather:rain") = "rain"
    s pDictionaries(2,":weather:rain",1) = "drizzle"
    s pDictionaries(2,":weather:rain",2) = "precipitation"
    s pDictionaries(2,":weather:rain",3) = "rain"
    s pDictionaries(2,":weather:rain",4) = "wet"
    s pDictionaries(2,":weather:heavy wind") = "heavy wind"
    s pDictionaries(2,":weather:heavy wind",1) = "extreme turbulence"
    s pDictionaries(2,":weather:heavy wind",2) = "severe turbulence"
    s pDictionaries(2,":weather:heavy wind",3) = "significant turbulence"
    s pDictionaries(2,":weather:heavy wind",4) = "substantial turbulence"
    s pDictionaries(2,":weather:mist") = "mist"
    s pDictionaries(2,":weather:mist",1) = "fog"
    s pDictionaries(2,":weather:mist",2) = "mist"
    s pDictionaries(2,":weather:winter") = "winter"
    s pDictionaries(2,":weather:winter",1) = "ice-covered"
    s pDictionaries(2,":weather:winter",2) = "icy"
    s pDictionaries(2,":weather:winter",3) = "snow"
    s pDictionaries(2,":weather:winter",4) = "snow-covered"
    s pDictionaries(2,":weather:thunderstorm") = "thunderstorm"
    s pDictionaries(2,":weather:thunderstorm",1) = "thunderstorm"
    s pDictionaries(2,":weather:thunderstorm",2) = "thunderstorms"
    s pDictionaries(3) = "Injuries"
    s pDictionaries(3,":injuries:fatal") = "fatal"
    s pDictionaries(3,":injuries:fatal",1) = "died"
    s pDictionaries(3,":injuries:fatal",2) = "fatal injuries"
    s pDictionaries(3,":injuries:fatal",3) = "fatally injured"
    s pDictionaries(3,":injuries:fatal",4) = "succumbed"
    s pDictionaries(3,":injuries:fatal",5) = "was killed"
    s pDictionaries(3,":injuries:fatal",6) = "were killed"
    s pDictionaries(3,":injuries:minor") = "minor"
    s pDictionaries(3,":injuries:minor",1) = "minor injuries"
    s pDictionaries(3,":injuries:minor",2) = "wounded"
    s pDictionaries(3,":injuries:none") = "none"
    s pDictionaries(3,":injuries:none",1) = "no injuries"
    s pDictionaries(3,":injuries:none",2) = "not injured"
    s pDictionaries(3,":injuries:none",3) = "survived"
    s pDictionaries(3,":injuries:none",4) = "was not injured"
    s pDictionaries(3,":injuries:none",5) = "were not injured"
    s pDictionaries(3,":injuries:serious") = "serious"
    s pDictionaries(3,":injuries:serious",1) = "serious injuries"
    s pDictionaries(3,":injuries:serious",2) = "seriously injured"
    s pDictionaries(4) = "Pilot skills"
    s pDictionaries(4,":skills:pro") = "professional"
    s pDictionaries(4,":skills:pro",1) = "airline transport pilot"
    s pDictionaries(4,":skills:pro",2) = "commercial pilot"
    s pDictionaries(4,":skills:pro",3) = "commercial-rated pilot"
    s pDictionaries(4,":skills:pro",4) = "pilot/owner"
    s pDictionaries(4,":skills:pro",5) = "private pilot"
    s pDictionaries(4,":skills:pro",6) = "private-rated pilot"
    s pDictionaries(4,":skills:instructor") = "instructor"
    s pDictionaries(4,":skills:instructor",1) = "cfi"
    s pDictionaries(4,":skills:instructor",2) = "instructor"
    s pDictionaries(4,":skills:student") = "student"
    s pDictionaries(4,":skills:student",1) = "student pilot"
	quit $$$OK
}

/// Creates the Term Lists used for matching in the DeepSee Aviation demo.
ClassMethod CreateTermLists() As %Status
{
	set tSC = $$$OK
	try {
		
		// Create Term List for US states
		if '##class(%DeepSee.TermList).%TermListExists("USStateCodes") {
			set tSC = ##class(%DeepSee.TermList).%CreateTermList("USStateCodes", "US States",,, "Names of US States (created by the Aviation Event demo setup script)")
			quit:$$$ISERR(tSC)
		}
		set tCode = ""
		for {
			set tCode = $order(^Aviation.States(tCode), 1, tState)
			quit:tCode=""
			
			do ##class(%DeepSee.TermList).%SetValue("USStateCodes", tCode, tState)
		}
		
		// Create Term List for US states
		if '##class(%DeepSee.TermList).%TermListExists("CountryCodes") {
			set tSC = ##class(%DeepSee.TermList).%CreateTermList("CountryCodes", "Country Codes",,, "Names of countries indexed by two-letter country code (created by the Aviation Event demo setup script)")
			quit:$$$ISERR(tSC)
		}
		set tCode = ""
		for {
			set tCode = $order(^Aviation.Countries(tCode), 1, tCountry)
			quit:tCode=""
			
			do ##class(%DeepSee.TermList).%SetValue("CountryCodes", tCode, tCountry)
		}
		
		
		
		// Create Term Lists for matching against iKnow measures
		do ..GetAviationDictionaries(.tDictionaries)
		
		set i = ""
		for {
			set i = $order(tDictionaries(i),1,tDictionary)
			quit:i=""
			
	        do ##class(%DeepSee.TermList).%DeleteTermList(tDictionary)
	        do ##class(%DeepSee.TermList).%CreateTermList(tDictionary, "Aviation terms - "_tDictionary, "URI",, "Sample Term List for Aviation demo", ..#CUBENAME)
			
			set tURI = ""
			for {
				set tURI = $order(tDictionaries(i,tURI),1,tItem)
				quit:tURI=""
				
				set j = ""
				for {
					set j = $order(tDictionaries(i,tURI,j),1,tTerm)
					quit:j=""
					
					do ##class(%DeepSee.TermList).%SetValue(tDictionary, tTerm, tItem)
        			do ##class(%DeepSee.TermList).%SetValue(tDictionary, tTerm, tURI,"URI")
				}
			}
		}
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// <p>Loads <var>pMaxRecords</var> aviation event records from the official NTSB database, which
/// can be downloaded as a Microsoft Access file from <a href="http://www.ntsb.gov/avdata/Access/">www.ntsb.gov</a>.
/// The Access file needs to be exposed through ODBC using a DSN named <var>pDSN</var>. Any existing
/// information for a given event will be overwritten, so loading from the "update" databases on
/// ntsb.gov will just append to your existing database.</p>
/// <p>Set <var>pMaxRecords</var> to 0 to load all events from the database and use <var>pClearFirst</var>
/// to specify whether existing events should be erased prior to the load. Using <var>pPrefList</var>,
/// and <var>pWhereClause</var>, you can list specific events which need to be selected, as records
/// are selected randomly from the full database. With <var>pSkipWhenEmpty</var>, a list of properties
/// of the event, aircraft and crew records can be supplied which needs to be non-null for the record
/// to be selected.</p>
ClassMethod LoadFromNTSB(pDSN As %String = "AviationAccess", pMaxRecords As %Integer = 1200, pClearFirst As %Boolean = 1, pVerbose As %Boolean = 1, pSkipWhenEmpty As %List = {$lb($lb("NarrativeFull","LocationCoordsLongitude","InjuriesHighest","MidAir","SkyConditionNonCeiling"),$lb("Damage","AircraftCategory","FlightType"))}, pWhereClause As %String = "", pPrefList As %List = {$lb("20020611X00850","20030728X01207","20010123X00341")}) As %Status
{
	set tSC = $$$OK
	try {
		if (pClearFirst) {
			do ##class(Aviation.Crew).%KillExtent()
			do ##class(Aviation.Aircraft).%KillExtent()
			do ##class(Aviation.Event).%KillExtent()
		}
		
		set tEventProps = $lg(pSkipWhenEmpty,1)
		set tAircraftProps = $lg(pSkipWhenEmpty,2)
		set tCrewProps = $lg(pSkipWhenEmpty,3)
		
	    set tConnection = ##class(%SQLGatewayConnection).%New()
	    set tSC = tConnection.Connect(pDSN,"","") 
	    quit:$$$ISERR(tSC)

		// prepare main event statements
	    set tEventResultSet = ##class(%ResultSet).%New("%DynamicQueryGW:SQLGW")
	    set tSQLPref = "SELECT *, -1 As FakeOrder FROM events WHERE ev_id = '"_$lts(pPrefList,"' OR ev_id = '")_"'"
	    set tSQL = "SELECT *, (ev_time*ev_time) MOD 79 As FakeOrder FROM events WHERE " _ $s(pWhereClause="":"ev_year >= 2000", 1:pWhereClause)
	    set tSQL = "SELECT * FROM ("_tSQLPref_") UNION ("_tSQL_") ORDER BY FakeOrder"
	    set tCountSQL = "SELECT COUNT(*) FROM ("_tSQL_")"
	    set tSC = tEventResultSet.Prepare(tCountSQL,, tConnection)
	    quit:$$$ISERR(tSC)
	    set tSC = tEventResultSet.Execute()
	    quit:$$$ISERR(tSC)
	    do tEventResultSet.Next()
	    set tMaxCount = tEventResultSet.GetData(1)
	    w:pVerbose !,"Loading ",tMaxCount," events from DSN '",pDSN,"'"
	    do tEventResultSet.Close()
	    set tSC = tEventResultSet.Prepare(tSQL,, tConnection)
	    quit:$$$ISERR(tSC)
	    set tSC = tEventResultSet.Execute()
	    quit:$$$ISERR(tSC)
	    
	    // prepare other statements
	    set tNarrativeResultSet = ##class(%ResultSet).%New("%DynamicQueryGW:SQLGW")
	    set tAircraftResultSet = ##class(%ResultSet).%New("%DynamicQueryGW:SQLGW")
	    set tCrewResultSet = ##class(%ResultSet).%New("%DynamicQueryGW:SQLGW")
	    
		set tCount = 0, tSkipCount = 0, tUpdateCount = 0
	    while tEventResultSet.Next() { 
	    	
	    	set tEventId = tEventResultSet.Get("ev_id")
	    	set tIsNew = '##class(Aviation.Event).PKINDEXExists(tEventId)
	    	
	    	if (tIsNew) {
		    	set tEvent = ##class(Aviation.Event).%New()
    	        set tEvent.EventId = tEventId
	    	} else {
		    	set tEvent = ##class(Aviation.Event).PKINDEXOpen(tEventId)
		    	do tEvent.Aircraft.Clear()
		    	set x = $i(tUpdateCount)
	    	}
	    	
            set tEvent.AirportDirection = $zstrip(tEventResultSet.Get("apt_dir"),"<>W")
            set tEvent.AirportDistance = $zstrip(tEventResultSet.Get("apt_dist"),"<>W")
            set tEvent.AirportElevation = $zstrip(tEventResultSet.Get("apt_elev"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("ev_nr_apt_loc"),"<>W")
            set tEvent.AirportLocation = $case(tValue, "OFAP":"Off airport / airstrip", "ONAP":"On airport", "ONAS":"On airstrip", "UNK":"Unknown", :tValue)
            set tEvent.AirportName = $zstrip(tEventResultSet.Get("apt_name"),"<>W")
            set tEvent.Altimeter = $zstrip(tEventResultSet.Get("altimeter"),"<>W")
            
            set tDate = $zstrip(tEventResultSet.Get("ev_date"),"<>W")
            set tTime = $zstrip(tEventResultSet.Get("ev_time"),"<>W")
            if (+tTime) && (tDate'="") && (tTime'=2400) {
	            set tHours = tTime\100, tHours = $s(tHours>9:tHours, 1:"0"_tHours)
	            set tMinutes = (tTime#100)#60, tMinutes = $s(tMinutes>9:tMinutes, 1:"0"_tMinutes)
	            set tDate = $p(tDate," ",1)_" "_tHours_":"_tMinutes_":00"
            }
            set tEvent.EventDate = tDate
            set tEvent.EventTime = tTime
            
            set tEvent.FAADistrictOffice = $zstrip(tEventResultSet.Get("faa_dist_office"),"<>W")
            set tEvent.InjuriesGroundFatal = $zstrip(tEventResultSet.Get("inj_f_grnd"),"<>W")
            set tEvent.InjuriesGroundMinor = $zstrip(tEventResultSet.Get("inj_m_grnd"),"<>W")
            set tEvent.InjuriesGroundSerious = $zstrip(tEventResultSet.Get("inj_s_grnd"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("ev_highest_injury"),"<>W")
            set tEvent.InjuriesHighest = $case(tValue, "NONE":"None", "MINR":"Minor", "SERS":"Serious", "FATL":"Fatal", "UNK":"Unknown", :tValue)
            set tEvent.InjuriesTotal = $zstrip(tEventResultSet.Get("inj_tot_t"),"<>W")
            set tEvent.InjuriesTotalFatal = $zstrip(tEventResultSet.Get("inj_tot_f"),"<>W")
            set tEvent.InjuriesTotalMinor = $zstrip(tEventResultSet.Get("inj_tot_m"),"<>W")
            set tEvent.InjuriesTotalNone = $zstrip(tEventResultSet.Get("inj_tot_n"),"<>W")
            set tEvent.InjuriesTotalSerious = $zstrip(tEventResultSet.Get("inj_tot_s"),"<>W")
            set tEvent.InvestigatingAgency = $zstrip(tEventResultSet.Get("invest_agy"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("light_cond"),"<>W")
            set tEvent.LightConditions = $case(tValue, "DAWN":"Dawn", "DAYL":"Day", "DUSK":"Dusk", "NBRT":"Night/Bright", "NDRK":"Night/Dark", "NITE":"Night", "NR":"Not Reported", :tValue)
            set tEvent.LocationCity = $zstrip(tEventResultSet.Get("ev_city"),"<>W")
            
            set tLatitude = $zstrip(tEventResultSet.Get("latitude"),"<>W")
            if (tLatitude'="") {
	            set tSign = $case($e(tLatitude,*), "S":-1, :1)
	            set tDegrees = $e(tLatitude,1,*-5)
	            set tMinutes = $e(tLatitude,*-4,*-3)
	            set tSeconds = $e(tLatitude,*-2,*-1)
	            set tLatitude = (tDegrees + (tMinutes/60) + (tSeconds/3600)) * tSign
            }
            set tEvent.LocationCoordsLatitude = tLatitude
            
            set tLongitude = $zstrip(tEventResultSet.Get("longitude"),"<>W")
            if (tLongitude'="") {
	            set tSign = $case($e(tLongitude,*), "W":-1, :1)
	            set tDegrees = $e(tLongitude,1,*-5)
	            set tMinutes = $e(tLongitude,*-4,*-3)
	            set tSeconds = $e(tLongitude,*-2,*-1)
	            set tLongitude = (tDegrees + (tMinutes/60) + (tSeconds/3600)) * tSign
            }
            set tEvent.LocationCoordsLongitude = tLongitude
            
            set tState = $zstrip(tEventResultSet.Get("ev_state"),"<>W")
            set tCountry = $zstrip(tEventResultSet.Get("ev_country"),"<>W")
            set:(tState'="")&&(tCountry="USA") tState = $g(^Aviation.States(tState), tState)
            set:tCountry'="" tCountry = $g(^Aviation.Countries(tCountry), tCountry)
            set tEvent.LocationState = tState
            set tEvent.LocationCountry = tCountry
            set tEvent.LocationSiteZipCode = $zstrip(tEventResultSet.Get("ev_site_zipcode"),"<>W")
            set tEvent.MidAir = $zstrip(tEventResultSet.Get("mid_air"),"<>W")
            set tEvent.NTSBId = $zstrip(tEventResultSet.Get("ntsb_no"),"<>W")
            set tEvent.OnGroundCollision = $zstrip(tEventResultSet.Get("on_ground_collision"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("sky_cond_ceil"),"<>W")
            set tEvent.SkyConditionCeiling = $case(tValue, "BKN":"Broken", "NONE":"None", "OBSC":"Obscured", "OVC":"Overcast", "UNK":"Unknown", "VV":"Indefinite (VV)", :tValue)
            set tEvent.SkyConditionCeilingHeight = $zstrip(tEventResultSet.Get("sky_ceil_ht"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("sky_cond_nonceil"),"<>W")
            set tEvent.SkyConditionNonCeiling = $case(tValue, "BKNT":"Thin broken", "CLER":"Clear", "FEW":"Few", "OVCT":"Thin overcast", "POBS":"Partial obscuration", "SCAT":"Scattered", "UNK":"Unknown", :tValue)
            set tEvent.SkyConditionNonCeilingHeight = $zstrip(tEventResultSet.Get("sky_nonceil_ht"),"<>W")
            set tEvent.TimeZone = $zstrip(tEventResultSet.Get("ev_tmzn"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("ev_type"),"<>W")
            set tEvent.Type = $case(tValue, "ACC":"Accident", "INC":"Incident", "OCC":"Occurrence", "UNK":"Unknown", :tValue)
            set tEvent.Visibility = $zstrip(tEventResultSet.Get("vis_sm"),"<>W")
            set tEvent.WeatherAirTemperature = $zstrip(tEventResultSet.Get("wx_temp"),"<>W")
            set tEvent.WeatherPrecipitation = $zstrip(tEventResultSet.Get("wx_int_precip"),"<>W")
            set tEvent.WindDirection = $zstrip(tEventResultSet.Get("wind_dir_deg"),"<>W")
            set tEvent.WindDirectionIndicator = $zstrip(tEventResultSet.Get("wind_dir_ind"),"<>W")
            set tEvent.WindGust = $zstrip(tEventResultSet.Get("gust_kts"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("gust_ind"),"<>W")
            set tEvent.WindGustIndicator = $case(tValue, "N":"Non gusting", "U":"Unknown", "G":"Gusting", "Y":"Gusting", :tValue)
            set tEvent.WindVelocity = $zstrip(tEventResultSet.Get("wind_vel_kts"),"<>W")
            set tValue = $zstrip(tEventResultSet.Get("wind_vel_ind"),"<>W")
            set tEvent.WindVelocityIndicator = $case(tValue, "CALM":"Calm", "LVAR":"Light and variable", "SPEC":"Special", "UNK":"Unknown", "V":"Variable", :tValue)
            
            
            // load first narrative for this event
            set tSC = tNarrativeResultSet.Prepare("SELECT * FROM narratives WHERE ev_id = '"_tEventId_"' AND Aircraft_Key = 1",, tConnection)
            quit:$$$ISERR(tSC)
            set tSC = tNarrativeResultSet.Execute()
            quit:$$$ISERR(tSC)
            if tNarrativeResultSet.Next() {
	            set tString = $zstrip(tNarrativeResultSet.Get("narr_cause"), "<>W")
	            set tString = $translate(tString, $c(8216,8219,8217,8220,8223,8221,8211,243,8212,8482,8226), "'''""""""-o- -")
	            set tString = $replace($replace(tString,$c(176)," degrees"),$c(8230),"...")
	            set tEvent.NarrativeCause = $zconvert(tString,"O","UTF8")
	            set tString = $zstrip(tNarrativeResultSet.Get("narr_accp"), "<>W")
	            set tString = $translate(tString, $c(8216,8219,8217,8220,8223,8221,8211,243,8212,8482,8226), "'''""""""-o- -")
	            set tString = $replace($replace(tString,$c(176)," degrees"),$c(8230),"...")
	            set tEvent.NarrativeFull = $zconvert(tString,"O","UTF8")
	            set tString = $zstrip(tNarrativeResultSet.Get("narr_accf"), "<>W")
	            set tString = $translate(tString, $c(8216,8219,8217,8220,8223,8221,8211,243,8212,8482,8226), "'''""""""-o- -")
	            set tString = $replace($replace(tString,$c(176)," degrees"),$c(8230),"...")
	            set tEvent.NarrativeSummary = $zconvert(tString,"O","UTF8")
            }
            do tNarrativeResultSet.Close()
            
            
            // verify pSkipWhenEmpty elements
            set ptr=0, tSkip=0
            while $listnext(tEventProps, ptr, tProp) {
	            if ($property(tEvent, tProp)="") {
		            set tSkip=$i(tSkipCount)
		            quit
	            }
            }
            continue:tSkip
            
            
            // loop through aircraft for this event
            set tSC = tAircraftResultSet.Prepare("SELECT * FROM aircraft WHERE ev_id = '"_tEventId_"'",, tConnection)
            quit:$$$ISERR(tSC)
            set tSC = tAircraftResultSet.Execute()
            quit:$$$ISERR(tSC)
           	while tAircraftResultSet.Next() {
	           	set tAircraftKey = tAircraftResultSet.Get("Aircraft_Key")
	           	
	           	if (tIsNew) || '##class(Aviation.Aircraft).PKINDEXExists(tEventId, tAircraftKey) {
		           	set tAircraft = ##class(Aviation.Aircraft).%New()
	           		set tAircraft.EventId = tEventId
		        	set tAircraft.AircraftKey = tAircraftKey
	           	} else {
		           	set tAircraft = ##class(Aviation.Aircraft).PKINDEXOpen(tEventId, tAircraftKey)
		           	do tAircraft.Crew.Clear()
	           	}
	           	
	           	set tValue = $zstrip(tAircraftResultSet.Get("acft_expl"),"<>W")
	           	set tAircraft.AccidentExplosion = $case(tValue, "BOTH":"Ground and in-flight", "GRD":"Ground", "IFLT":"In-flight", "NONE":"None", "UNK":"Unknown", "UORG":"Unknown origin", :tValue)
	           	set tValue = $zstrip(tAircraftResultSet.Get("acft_fire"),"<>W")
		        set tAircraft.AccidentFire = $case(tValue, "BOTH":"Ground and in-flight", "GRD":"Ground", "IFLT":"In-flight", "NONE":"None", "UNK":"Unknown", "UORG":"Unknown origin", :tValue)
		        set tAircraft.AirFrameHours = $zstrip(tAircraftResultSet.Get("afm_hrs"),"<>W")
		        set tAircraft.AirFrameHoursSince = $zstrip(tAircraftResultSet.Get("afm_hrs_since"),"<>W")
		        set tAircraft.AirFrameHoursSinceLastInspection = $zstrip(tAircraftResultSet.Get("afm_hrs_last_insp"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("acft_category"),"<>W")
		        set tAircraft.AircraftCategory = $case(tValue, "AIR":"Airplane", "BALL":"Balloon", "BLIM":"Blimp", "GLI":"Glider", "GYRO":"Gyrocraft", "HELI":"Helicopter", "PLFT":"Powered-Lift", "ULTR":"Ultralight", "UNK":"Unknown", "PPAR":"Powered Parachute", "WSFT":"Weight Shift", :tValue)
		        set tAircraft.AircraftCertMaxGrossWeight = $zstrip(tAircraftResultSet.Get("cert_max_gr_wt"),"<>W")
		        set tAircraft.AircraftHomeBuilt = $zstrip(tAircraftResultSet.Get("homebuilt"),"<>W")
		        set tAircraft.AircraftManufacturer = $zstrip(tAircraftResultSet.Get("acft_make"),"<>W")
		        set tAircraft.AircraftModel = $zstrip(tAircraftResultSet.Get("acft_model"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("acft_reg_cls"),"<>W")
		        set tAircraft.AircraftRegistrationClass = $case(tValue, "FNFN":"Foreign Registered/Foreign Soil", "FNUS":"Foreign Registered/US Soil", "MIL":"Military", "NREG":"Not Registered", "UNK":"Unknown", "USFN":"US Registered/Foreign Soil", "USFO":"US Registered/Foreign Operator", "USUS":"US Registered/US Soil", :tValue)
		        set tAircraft.AircraftSerialNo = $zstrip(tAircraftResultSet.Get("acft_serial_no"),"<>W")
		        set tAircraft.AircraftSeries = $zstrip(tAircraftResultSet.Get("acft_series"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("damage"),"<>W")
		        set tAircraft.Damage = $case(tValue, "NONE":"None", "MINR":"Minor", "SUBS":"Substantial", "DEST":"Destroyed", "UNK":"Unknown", :tValue)
		        set tAircraft.DepartureAirportId = $zstrip(tAircraftResultSet.Get("dprt_apt_id"),"<>W")
		        set tAircraft.DepartureCity = $zstrip(tAircraftResultSet.Get("dprt_city"),"<>W")
		        set tAircraft.DepartureCountry = $zstrip(tAircraftResultSet.Get("dprt_country"),"<>W")
		        set tAircraft.DepartureSameAsEvent = $zstrip(tAircraftResultSet.Get("dprt_pt_same_ev"),"<>W")
		        set tAircraft.DepartureState = $zstrip(tAircraftResultSet.Get("dprt_state"),"<>W")
		        set tAircraft.DepartureTime = $zstrip(tAircraftResultSet.Get("dprt_time"),"<>W")
		        set tAircraft.DepartureTimeZone = $zstrip(tAircraftResultSet.Get("dprt_timezn"),"<>W")
		        set tAircraft.DestinationAirportId = $zstrip(tAircraftResultSet.Get("dest_apt_id"),"<>W")
		        set tAircraft.DestinationCity = $zstrip(tAircraftResultSet.Get("dest_city"),"<>W")
		        set tAircraft.DestinationCountry = $zstrip(tAircraftResultSet.Get("dest_country"),"<>W")
		        set tAircraft.DestinationSameAsLocal = $zstrip(tAircraftResultSet.Get("dest_same_local"),"<>W")
		        set tAircraft.DestinationState = $zstrip(tAircraftResultSet.Get("dest_state"),"<>W")
		        set tAircraft.EngineCount = $zstrip(tAircraftResultSet.Get("num_eng"),"<>W")
		        set tAircraft.EvacuationOccurred = $zstrip(tAircraftResultSet.Get("evacuation"),"<>W")
		        set tAircraft.FlightMedical = $zstrip(tAircraftResultSet.Get("air_medical"),"<>W")
		        set tAircraft.FlightMedicalType = $zstrip(tAircraftResultSet.Get("med_type_flight"),"<>W")
		        set tAircraft.FlightPhase = $zstrip(tAircraftResultSet.Get("phase_flt_spec"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("flt_plan_filed"),"<>W")
		        set tAircraft.FlightPlan = $case(tValue, "CVFR":"Company VFR", "DFR":"Defense VFR", "IFR":"IFR", "MVFR":"Military VFR", "NONE":"None", "SVFR":"Special VFR", "UNK":"Unknown", "VFF":"Visual flight", "VFIF":"VFR/IFR", "VFR":"VFR", "ORGT":"Organ transport", :tValue)
		        set tAircraft.FlightPlanActivated = $zstrip(tAircraftResultSet.Get("flight_plan_activated"),"<>W")
		        set tAircraft.FlightSiteSeeing = $zstrip(tAircraftResultSet.Get("site_seeing"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("type_fly"),"<>W")
		        set tAircraft.FlightType = $case(tValue, "AAPL":"Aerial Application", "ADRP":"Air Drop", "AIRM":"Air Medical", "AOBV":"Aerial Observation", "ASHO":"Air Race/Show", "ATXA":"Air Taxi Non-Sched.(135A)", "ATXC":"Air Taxi Commuter", "ATXO":"Air Taxi Oper./Large Aircraft", "ATXS":"Air Taxi Sched./Not Commuter", "BANT":"Banner Tow", "BUS":"Business", "CRGO":"All Cargo Carriers", "EXEC":"Executive/Corporate", "FERY":"Ferry", "FLTS":"Flight Test", "EXLD":"External Load", "FIRF":"Fire Fighting", "GLDT":"Glider Tow", "HIRE":"For Hire", "ILGL":"Illegal Cargo/Operation", "INDS":"Industrial Special", "INST":"Instructional", "OTH":"Other", "OWRK":"Other Work Use", "PERS":"Personal", "POSI":"Positioning", "PUBU":"Public Use", "PUBL":"Public Use - Local", "PUBF":"Public Use - Federal", "SCAC":"Scheduled Air Carrier", "SCRH":"Sched. Air Carrier Helicopter", "SITE":"Site Seeing", "SKYD":"Skydiving", "SUPP":"Supplemental/Commercial Oper.", "TVLC":"Travel Club", "UNK":"Unknown", :tValue)
		        set tAircraft.GearType = $zstrip(tAircraftResultSet.Get("fixed_retractable"),"<>W")
		        set tAircraft.LastInspectionDate = $zstrip(tAircraftResultSet.Get("date_last_insp"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("type_last_insp"),"<>W")
		        set tAircraft.LastInspectionType = $case(tValue, "100H":"100 Hours", "ANNL":"Annual", "COAW":"Continuous Airworthiness", "COND":"Conditional", "UNK":"Unknown", :tValue)
		        set tAircraft.Missing = $zstrip(tAircraftResultSet.Get("acft_missing"),"<>W")
		        set tValue = $zstrip(tAircraftResultSet.Get("oper_dom_int"),"<>W")
		        set tAircraft.OperationDomestic = $case(tValue, "DOM":"Domestic", "INT":"International", "N/A":"Not Applicable", "UNK":"Unknown", :tValue)
		        set tValue = $zstrip(tAircraftResultSet.Get("oper_sched"),"<>W")
		        set tAircraft.OperationScheduled = $case(tValue, "N/A":"Not Applicable", "UNK":"Unknown", "NSCH":"Non-scheduled", "SCHD":"Scheduled", :tValue)
		        set tValue = $zstrip(tAircraftResultSet.Get("oper_pax_cargo"),"<>W")
		        set tAircraft.OperationType = $case(tValue, "CARG":"Cargo", "MAIL":"Mail", "N/A":"Not applicable", "PACA":"Passenger & cargo", "PAX":"Passenger only", :tValue)
		        set tAircraft.OperatorCertificate = $zstrip(tAircraftResultSet.Get("oper_cert"),"<>W")
		        set tAircraft.OperatorCertificateNum = $zstrip(tAircraftResultSet.Get("oper_cert_num"),"<>W")
		        set tAircraft.OperatorCode = $zstrip(tAircraftResultSet.Get("oper_code"),"<>W")
		        set tAircraft.OperatorCountry = $zstrip(tAircraftResultSet.Get("oper_country"),"<>W")
		        set tAircraft.OperatorIndividual = $zstrip(tAircraftResultSet.Get("oper_individual_name"),"<>W")
		        set tAircraft.OperatorName = $zstrip(tAircraftResultSet.Get("oper_name"),"<>W")
		        set tAircraft.OperatorState = $zstrip(tAircraftResultSet.Get("oper_state"),"<>W")
		        set tAircraft.Owner = $zstrip(tAircraftResultSet.Get("owner_acft"),"<>W")
		        set tAircraft.OwnerCertified = $zstrip(tAircraftResultSet.Get("certs_held"),"<>W")
		        set tAircraft.OwnerCountry = $zstrip(tAircraftResultSet.Get("owner_country"),"<>W")
		        set tAircraft.OwnerState = $zstrip(tAircraftResultSet.Get("owner_state"),"<>W")
		        set tAircraft.RegistrationNumber = $zstrip(tAircraftResultSet.Get("regis_no"),"<>W")
		        set tAircraft.ReportedToICAO = $zstrip(tAircraftResultSet.Get("report_to_icao"),"<>W")
		        set tAircraft.SeatsCabinCrew = $zstrip(tAircraftResultSet.Get("cc_seats"),"<>W")
		        set tAircraft.SeatsFlightCrew = $zstrip(tAircraftResultSet.Get("fc_seats"),"<>W")
		        set tAircraft.SeatsPassengers = $zstrip(tAircraftResultSet.Get("pax_seats"),"<>W")
		        set tAircraft.SeatsTotal = $zstrip(tAircraftResultSet.Get("total_seats"),"<>W")
		        set tAircraft.SecondPilot = $zstrip(tAircraftResultSet.Get("second_pilot"),"<>W")
		        
	            // verify pSkipWhenEmpty elements
   		        set ptr=0, tSkip=0
   	    	    while $listnext(tAircraftProps, ptr, tProp) {
	        	    if ($property(tAircraft, tProp)="") {
		        	    set tSkip=1
		        	    quit
	            	}
            	}
            	continue:tSkip
	           	do tEvent.Aircraft.Insert(tAircraft)
		        
		        set tSC = tCrewResultSet.Prepare("SELECT * FROM Flight_Crew WHERE ev_id = '"_tEventId_"' AND Aircraft_Key = "_tAircraftKey,, tConnection)
	    		quit:$$$ISERR(tSC)
		        set tSC = tCrewResultSet.Execute()
		        quit:$$$ISERR(tSC)
		        while tCrewResultSet.Next() {
			        set tCrewNumber = tCrewResultSet.Get("crew_no")
			        if (tIsNew) || '##class(Aviation.Crew).PKINDEXExists(tEventId, tAircraftKey, tCrewNumber) {
				        set tCrew = ##class(Aviation.Crew).%New()
				        set tCrew.EventId = tEventId
				        set tCrew.AircraftKey = tAircraftKey
			        	set tCrew.CrewNumber = tCrewNumber
			        } else {
				        set tCrew = ##class(Aviation.Crew).PKINDEXOpen(tEventId, tAircraftKey, tCrewNumber)
			        }
			        
			        set tCrew.Age = $zstrip(tCrewResultSet.Get("crew_age"),"<>W")
			        set tValue = $zstrip(tCrewResultSet.Get("crew_category"),"<>W")
			        set tCrew.Category = $case(tValue, "CPLT":"Co-Pilot", "DSTU":"Student Pilot", "FENG":"Flight Engineer", "FLTI":"Flight Instructor", "KPLT":"Check Pilot", "OTHR":"Other", "PLT":"Pilot", :tValue)
			        set tValue = $zstrip(tCrewResultSet.Get("crew_inj_level"),"<>W")
			        set tCrew.Injury = $case(tValue, "NONE":"None", "MINR":"Minor", "SERS":"Serious", "FATL":"Fatal", "UNK":"Unknown", :tValue)
			        set tValue = $zstrip(tCrewResultSet.Get("med_certf"),"<>W")
			        set tCrew.MedicalCertification = $case(tValue, "CL1":"Class 1", "CL2":"Class 2", "CL3":"Class 3", "NONE":"None", "SPRT":"Sport Pilot", "UNK":"Unknown", :tValue)
			        set tCrew.MedicalCertificationDate = $zstrip(tCrewResultSet.Get("date_lst_med"),"<>W")
			        set tValue = $zstrip(tCrewResultSet.Get("med_crtf_vldty"),"<>W")
			        set tCrew.MedicalCertificationValid = $case(tValue, "EXP":"Expired", "NONE":"None", "NV":"Invalid Medical for flight", "UNK":"Unknown", "VNOW":"Valid Medical - no waivers/lim.", "VWW":"Valid Medical - w/ waivers/lim.", "WOWL":"Without Waivers/Limitations", "WWL":"With Waivers/Limitations", :tValue)
			        set tValue = $zstrip(tCrewResultSet.Get("seat_occ_pic"),"<>W")
			        set tCrew.Seat = $case(tValue, "CTR":"Center", "FRT":"Front", "LEFT":"Left", "REAR":"Rear", "RGT":"Right", "SNGL":"Single", "UNK":"Unknown", :tValue)
			        set tCrew.SeatbeltUsed = $zstrip(tCrewResultSet.Get("seatbelts_used"),"<>W")
			        set tCrew.Sex = $zstrip(tCrewResultSet.Get("crew_sex"),"<>W")
			        set tCrew.ShoulderHarnessUsed = $zstrip(tCrewResultSet.Get("shldr_harn_used"),"<>W")
			        set tCrew.ToxicologyTestPerformed = $zstrip(tCrewResultSet.Get("crew_tox_perf"),"<>W")
			        
			        
		            // verify pSkipWhenEmpty elements
		            set ptr=0, tSkip=0
		            while $listnext(tCrewProps, ptr, tProp) {
			            if ($property(tCrew, tProp)="") {
				            set tSkip=1
				            quit
			            }
		            }
		            continue:tSkip
			        do tAircraft.Crew.Insert(tCrew)
		        }
		        do tCrewResultSet.Close()
		        
		        // skip if no Crew entries left
		        continue:'tAircraft.Crew.Count()
           	}
           	do tAircraftResultSet.Close()
           	
           	// skip if no Aircraft entries left
           	if ('tEvent.Aircraft.Count()) {
	           	set tSkipCount = tSkipCount+1
	           	continue
           	}
           	
            set tSC = tEvent.%Save()
            quit:$$$ISERR(tSC)
            
            set x = $i(tCount)
            
            if '(tCount#100) {
	            w:pVerbose !,"Processed ",tCount," out of ",tMaxCount," events... ",$s(tUpdateCount:"(including "_tUpdateCount_" updates) ", 1:"")
    	        w:pVerbose&&tSkipCount " - skipped ",tSkipCount," because of missing data"
            }
            
            quit:pMaxRecords&&(pMaxRecords<=tCount)
	    } 
	    quit:$$$ISERR(tSC)
	    do tEventResultSet.Close()
	    
	    w:pVerbose !!,"Disconnecting from DSN '",pDSN,"'"
	    set tSC = tConnection.Disconnect() 
	    quit:$$$ISERR(tSC)
	    
	    w:pVerbose !!,"Done",!,"Loaded ",tCount," events ",$s(tUpdateCount:"(including "_tUpdateCount_" updates) ", 1:"")
        w:pVerbose&&tSkipCount " - skipped ",tSkipCount," because of missing data"
        w:pVerbose !
        
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
