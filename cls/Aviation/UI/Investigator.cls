Include %IKInclude

/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
/// This page represents a mockup interface for typing in new aviation event reports for the
/// Aviation.Event narrative columns. After typing in a report of a few
/// sentences and pressing the "process" button, the system will look for reports similar to the
/// one being typed in using the basic similarity algorithm (first tab) and a slightly more
/// elaborate matching-based approach (second tab). This matching-based approach constructs a
/// simple dictionary based on the contents of what's being typed in (<method>BuildSrcDictionary</method>) and then finds the report
/// with the highest number of matches against this dictionary. While the basic similarity option
/// (using %iKnow.Queries.SourceAPI.GetSimilar()) is easier to use and has a few options by itself,
/// the matching-based alternative demonstrates how other iKnow API calls can be used together
/// from a simple interface. More specifically, the matching-based approach has the advantage
/// non-exact matches also contribute to the similarity, at the cost of performance and slight
/// over-scoring of simple re-occurring words. 
/// 
/// When clicking one of the suggested "similar" reports, a popup shows the basic details of
/// the similar event (time, location, aircraft, link to NTSB report) as well as the the contents
/// of the existing report, with all entities (and CRCs) of the input text highlighted in this
/// similar one. A second tab then reveals the presumed cause of that similar event as recorded
/// by the NTSB, which may "help" the user get an idea of a likely cause for the event being
/// described in his manual input. 
/// 
/// Being a code sample, the code is supposed to be quite readable with some comments about
/// what is being achieved by specific line(s) of code, as well as suggesting extensions
/// developers might wish to make to make the demo perform better.
/// 
/// To set up the demo, run the following command from the terminal:
/// do ##class(Aviation.UI.Investigator).Setup()
Class Aviation.UI.Investigator Extends %ZEN.Component.page
{

/// Displayed name of this page.
Parameter PAGENAME = "Aviation Event Investigation";

/// Default iKnow domain name for event reports
Parameter IKNOWREPORTDOMAINNAME = "Aviation Investigator demo - reports";

/// Default iKnow domain name for event causes
Parameter IKNOWCAUSEDOMAINNAME = "Aviation Investigator demo - causes";

/// Name of the dictionary generated as part of the matching-based similarity search
Parameter IKNOWDICTNAME [ Internal ] = "Aviation.UI.Investigator Dictionary";

/// Length of the report/cause summary to be displayed in the popup.
Property summaryLength As %ZEN.Datatype.string(ZENURL = "LENGTH");

/// The source ID of the report selected from the "similar reports" list (any tab).
Property selectedSource As %ZEN.Datatype.integer;

/// The domain ID for the event reports. Populated during <method>%OnAfterCreatePage</method>.
Property reportDomain As %ZEN.Datatype.integer;

/// The domain ID for the event causes. Populated during <method>%OnAfterCreatePage</method>.
Property causeDomain As %ZEN.Datatype.integer;

/// The Source ID of the source containing the manual input from the text box. This is a Virtual
/// Source and hence the number will be negative.
Property inputSource As %ZEN.Datatype.integer;

/// A filter string to restrict the scope of the similarity search.
/// Either use an InitialExpression or add code to populate this property, similar to the
/// filterPane and associated methods in %iKnow.UI.AbstractPortal
Property filter As %ZEN.Datatype.string(ZENURL = "FILTER");

/// The ID of the dictionary created as part of <method>BuildSrcDictionary</method>
Property dictId As %ZEN.Datatype.integer;

/// This XML block defines the contents of this page.
XData Contents [ XMLNamespace = "http://www.intersystems.com/zen" ]
{
<page xmlns="http://www.intersystems.com/zen" title="Aviation Event Investigator - iKnow Demo">
<modalGroup id="modSource" layout="vertical" containerStyle="padding:10px;">
<vgroup cellVAlign="top">
<html id="htmlTitle" OnDrawContent="DrawEventHeader" />
<spacer height="10" />
<tabGroup showTabBar="true" enclosingStyle="padding:5px;">
<tab caption="Event report" cellStyle="padding:5px;" width="100%">
<html id="htmlSource" OnDrawContent="DrawSource" containerStyle="overflow-y:scroll;" 
enclosingClass="textBox" seed="REPORT" />
<spacer height="10" />
<hgroup labelPosition="left" cellVAlign="top">
<text id="txtLength" value="all" hint="number of sentences to display" label="Summary length: " />
<spacer width="20" />
<button caption="summarize" onclick="zenPage.summarize();" />
</hgroup>
</tab>
<!-- uncomment the <tab> below to display more (basic) info about the currently selected
	 report. Optionally change the queryClass and queryName attributes of the <tablePane>
	 to display different information or add more <tablePane> elements to display different
	 types of information simultaneously. -->
<!--tab caption="Report analysis" cellStyle="padding:10px;" width="100%">
<titleBox title="Top concepts" />
<tablePane id="tabTopEnts" queryClass="%iKnow.Queries.EntityQAPI" queryName="GetTop" 
showRowSelector="false" width="100%">
<parameter value="#(%page.reportDomain)#" />
<parameter value="1" />
<parameter value="12" />
<parameter value="" />
<parameter value="15" />
<parameter value="0" />
<parameter value="0" />
<parameter value="#(%page.inputSource)#" />
<column colName="entUniId" hidden="true" />
<column colName="spread" hidden="true" />
</tablePane>
</tab-->
<tab caption="Cause" cellStyle="padding:5px;" width="100%">
<html id="htmlCause" containerStyle="overflow-y:scroll" OnDrawContent="DrawSource" 
enclosingClass="textBox" seed="CAUSE" />
</tab>
</tabGroup>
</vgroup>
</modalGroup>

<form method="post" id="form" height="100%" width="100%">
<vgroup containerStyle="padding:10px;" height="100%" width="100%">
<hgroup id="logoContainer" >
<image src="/csp/sys/iknow/img/iknow.jpg" height="70" id="imgLogoPane" />
<spacer width="30" />
<label label="Aviation Event Investigator" labelClass="pageTitle" />
</hgroup>
<spacer height="10" />
<hgroup id="grpMain" valign="top" >
<vgroup id="grpText" valign="top">
<textarea id="txtInput" rows="7" title="Type your event report here and press the 'process' button to look for similar events." />
</vgroup>
<spacer width="20" />
<vgroup id="grpButtons" valign="top" labelPosition="left">
<select required="true" label="Language" id="optLanguage" valueList="AUTO,en,fr,de,nl,es,pt"
displayList="Auto-detect,English,French,German,Dutch,Spanish,Portugese" showEmpty="false" />
<spacer height="10" />
<button caption="process" onclick="zenPage.realTimeInputClient();" />
<spacer height="10" />
</vgroup>
</hgroup>
<spacer height="10" />
<tabGroup id="tgrResults" showTabBar="true" height="100px">
<tab id="tabSimilar" caption="Basic similarity" cellStyle="padding:10px;" title="Normal entity-based similarity" >
<tablePane id="tblSimilar" queryClass="%iKnow.Queries.SourceQAPI" queryName="GetSimilar"
 autoExecute="false" OnExecuteResultSet="ExecuteSimilarQuery" showRowSelector="false">
<parameter value="#(%page.reportDomain)#" />
<parameter value="#(%page.inputSource)#" />
<parameter value="1" />
<parameter value="10" />
<parameter value="#(%page.filter)#" />
<parameter value="SIMPLE" />
<column colName="srcId" hidden="true" />
<column colName="extId" header="External ID"  link="javascript:zenPage.displaySourceClient(#(%query.srcId)#);" width="40" />
<column header="Event date" OnDrawCell="DrawMetadata" seed="EventDate" width="15" />
<column header="Category" OnDrawCell="DrawMetadata" seed="AircraftCategory" width="15" />
<column colName="percentageMatched" header="Percentage matched" OnDrawCell="DrawPercentage" width="15" />
<column colName="percentageNew" header="Percentage new" OnDrawCell="DrawPercentage" width="15" />
<column colName="nbOfEntsInRefSrc" hidden="true" />
<column colName="nbOfEntsInCommon" hidden="true" />
<column colName="nbOfEntsInSimSrc" hidden="true" />
<column colName="score" header="Score" hidden="true" />
</tablePane>
</tab>
<tab id="tabSrcDictionary" caption="Dictionary-based similarity" cellStyle="padding:10px;" title="Similar events based on matching results of the new report treated as a dictionary.">
<tablePane id="tblDictionary" queryClass="%iKnow.Matching.MatchingQAPI" showRowSelector="false"
queryName="GetTopSourcesByDictionary" autoExecute="false" OnExecuteResultSet="ExecuteSimilarQuery">
<parameter value="#(%page.reportDomain)#" />
<parameter value="#(%page.dictId)#" />
<parameter value="1" />
<parameter value="10" />
<parameter value="#(%page.filter)#" />
<column colName="srcId" hidden="true" />
<column colName="externalId" header="External ID"  link="javascript:zenPage.displaySourceClient(#(%query.srcId)#);" width="40" />
<column header="Event date" OnDrawCell="DrawMetadata" seed="EventDate" width="15" />
<column header="Category" OnDrawCell="DrawMetadata" seed="AircraftCategory" width="15" />
<column colName="matchCount" header="Match count" width="15" />
<column colName="totalScore" header="Total score" width="15" />
</tablePane>
</tab>
<!-- Currently not implemented as Virtual Sources don't have dominance information -->
<!--tab id="tabDominance" caption="Dominance-based similarity" cellStyle="padding:10px;" >
<tablePane id="tblDominance" queryClass="%iKnow.Queries.SourceQAPI" queryName="GetSimilar"
 autoExecute="false" OnExecuteResultSet="ExecuteSimilarQuery" showRowSelector="false">
<parameter value="#(%page.reportDomain)#" />
<parameter value="#(%page.inputSource)#" />
<parameter value="1" />
<parameter value="10" />
<parameter value="#(%page.filter)#" />
<parameter value="DOMINANTENTITIES" />
<column colName="srcId" hidden="true" />
<column colName="extId" header="External ID" OnDrawCell="DrawExternalId" width="60" />
<column colName="percentageMatched" header="Percentage matched" width="20" />
<column colName="percentageNew" header="Percentage new" width="20" />
<column colName="nbOfEntsInRefSrc" hidden="true" />
<column colName="nbOfEntsInCommon" hidden="true" />
<column colName="nbOfEntsInSimSrc" hidden="true" />
<column colName="score" header="Score" hidden="true" />
</tablePane>
</tab-->
</tabGroup>
</vgroup>
</form>
</page>
}

/// ZenMethod to process manual user input pText by the iKnow engine and store the
/// ID of the generated Virtual Source in <property>inputSource</property>.
Method ProcessInput(pText As %String(MAXLEN=32767), pLanguage As %String) As %String [ ZenMethod ]
{
	set tSC = $$$OK, tOldStatus = 0
	try {
		set tDomainId = ..reportDomain
		set tDomainName = $system.iKnow.GetDomainName(tDomainId)
		
		// Drop the previous virtual source created
		do:..inputSource ##class(%iKnow.Source.Loader).DeleteVirtualSource(tDomainId, $zabs(..inputSource))
		
		// create a simple configuration object for pLanguage, if none exists yet
		set tConfigName = "AviationInvestigatorConfig"_pLanguage
		if '##class(%iKnow.Configuration).NameIndexExists(tConfigName) {
			set tLanguages = $s(pLanguage="AUTO":$$$IKLANGUAGES, 1:$lb(pLanguage))
			set tConfig = ##class(%iKnow.Configuration).%New(tConfigName, (pLanguage="AUTO"), tLanguages)
			set tSC = tConfig.%Save()
			quit:$$$ISERR(tSC)
		}
		
		// Process pText, loading it as a virtual source
		set tFullRef = "AviationInvestigatorInput "_$zdt($h)
		set tSC = $system.iKnow.IndexString(tDomainName, tFullRef, pText, tConfigName, 1, .vSrcId)
		quit:$$$ISERR(tSC)
		
		// Store the generated (virtual) source ID
		set ..inputSource = vSrcId
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit $s($$$ISOK(tSC):"OK", 1:$system.Status.GetErrorText(tSC))
}

/// Client-side method coordinating the processing of user input by invoking <method>ProcessInput</method>
/// and then refreshing the appropriate sections of the interface. 
ClientMethod realTimeInputClient() [ Language = javascript ]
{
	var msg = zenPage.ProcessInput(zen('txtInput').getValue(), zen('optLanguage').getValue());
	if (msg != 'OK') {
		alert(msg);
	}
	zen('tblSimilar').refreshContents();
	zenPage.refreshDictionaryAsync();
	//zen('tblDominance').refreshContents();
}

/// Builds/replaces a dictionary based on the contents of the (virtual) source represented by
/// <property>inputSource</property> and stores it into both the reports and the causes domains.
/// The ID of this dictionary (in the reports domain) is stored into <property>dictId</property>.
Method BuildSrcDictionary() As %Status [ ZenMethod ]
{
	set tSC = $$$OK
	try {
		set tSrcId = +..inputSource
		set tDomainId = ..reportDomain
		set tDomainIdCause = ..causeDomain
		
		// First kill existing dictionary
		set tDictId = ##class(%iKnow.Matching.DictionaryAPI).GetDictionaryId(tDomainId, ..#IKNOWDICTNAME)
		set:tDictId>0 tSC = ##class(%iKnow.Matching.DictionaryAPI).DropDictionary(tDomainId, tDictId)
		quit:$$$ISERR(tSC)
		set tDictIdCause = ##class(%iKnow.Matching.DictionaryAPI).GetDictionaryId(tDomainIdCause, ..#IKNOWDICTNAME)
		set:tDictIdCause>0 tSC = ##class(%iKnow.Matching.DictionaryAPI).DropDictionary(tDomainIdCause, tDictIdCause)
		quit:$$$ISERR(tSC)
		
		// Now create a new one, containing all entities and CRCs of the current source
		// NOTE: this is a very crude approach. refining this to all entities that are dominant
		// in the input text and/or not too common in the overall domain (such as "pilot" etc),
		// could improve the results.
		set ..dictId = ##class(%iKnow.Matching.DictionaryAPI).CreateDictionary(tDomainId, ..#IKNOWDICTNAME)
		set tDictIdCause = ##class(%iKnow.Matching.DictionaryAPI).CreateDictionary(tDomainIdCause, ..#IKNOWDICTNAME)
		
		set tSC = ##class(%iKnow.Queries.EntityAPI).GetBySource(.tEntities, tDomainId, tSrcId, 0, 0)
		quit:$$$ISERR(tSC)
		set i=""
		for {
			set i = $order(tEntities(i),1,tData)
			quit:i=""
			
			set tSC = ##class(%iKnow.Matching.DictionaryAPI).CreateDictionaryItemAndTerm(tDomainId, ..dictId, $li(tData,2), ":entity:"_$li(tData,1)_":"_$li(tData,2))
			quit:$$$ISERR(tSC)
			set tSC = ##class(%iKnow.Matching.DictionaryAPI).CreateDictionaryItemAndTerm(tDomainIdCause, tDictIdCause, $li(tData,2), ":entity:"_$li(tData,1)_":"_$li(tData,2))
			quit:$$$ISERR(tSC)
		}
		quit:$$$ISERR(tSC)
		
		set tSC = ##class(%iKnow.Queries.CrcAPI).GetBySource(.tCrcs, tDomainId, tSrcId, 0, 0)
		quit:$$$ISERR(tSC)
		set i=""
		for {
			set i = $order(tCrcs(i),1,tData)
			quit:i=""
			
			set tSC = ##class(%iKnow.Matching.DictionaryAPI).CreateDictionaryItemAndTerm(tDomainId, ..dictId, $lts($li(tData,2,4)," "), ":crc:"_$lts($li(tData,1,4),":"))
			quit:$$$ISERR(tSC)
			set tSC = ##class(%iKnow.Matching.DictionaryAPI).CreateDictionaryItemAndTerm(tDomainIdCause, tDictIdCause, $lts($li(tData,2,4)," "), ":crc:"_$lts($li(tData,1,4),":"))
			quit:$$$ISERR(tSC)
		}
		quit:$$$ISERR(tSC)
		
		// Now match all sources in the reports domain against this new dictionary
		set tSC = ##class(%iKnow.Matching.MatchingAPI).MatchSources(tDomainId, ..filter, $lb(..dictId))
		quit:$$$ISERR(tSC)
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Client-side method called asynchroneously from <method>realTimeInputClient</method> to
/// perform the matching-based similarity search in the background and avoid "freezing" the UI
/// while it runs.
ClientMethod refreshDictionaryAsync() [ Language = javascript ]
{
	var sc = zenPage.BuildSrcDictionary();
	zen('tblDictionary').refreshContents();
	
	// Also refresh source view panes, should they already be open before the matching process
	// finished at the end of BuildSrcDictionary();
	zen('htmlSource').refreshContents();
	zen('htmlCause').refreshContents();
}

/// This client event, if present, is fired when the page 
/// is first loaded or whenever it is resized.
/// If this is called at load time, then load will be true.
ClientMethod onlayoutHandler(load) [ Language = javascript ]
{
	zenPage.resizeGroups(load);
}

/// Utility method to properly position and align the main page components.
ClientMethod resizeGroups(load) [ Language = javascript ]
{
	var logo = zen('logoContainer').getEnclosingDiv().clientHeight;
	var txtInput = zen('grpText').getEnclosingDiv().clientHeight;
	var available = 100; //zenGetWindowHeight()-logo-txtInput-100; ???
	zen('tgrResults').getEnclosingDiv().style.height = available;
	zen('tabSimilar').getEnclosingDiv().style.height = available-20;
	zen('tabSrcDictionary').getEnclosingDiv().style.height = available-20;
	
	var fullWidth = zenGetWindowWidth()-40;
	zen('grpMain').getEnclosingDiv().style.width = fullWidth;
	zen('tgrResults').getEnclosingDiv().style.width = fullWidth;
	zen('tblSimilar').getEnclosingDiv().style.width = fullWidth-40;
	zen('grpText').getEnclosingDiv().style.width = parseInt(fullWidth*0.7);
	zen('txtInput').setProperty('cols', parseInt(fullWidth*0.07));
	zen('grpButtons').getEnclosingDiv().style.width = parseInt(fullWidth*0.3);
}

/// Ensures required parameters are present when calling a GetSimilar() query from the main
/// tables, to avoid noisy errors when the page opens before typing/selecting anything.
Method ExecuteSimilarQuery(pRS As %Library.ResultSet, ByRef tSC As %Status, pInfo As %ZEN.Auxiliary.QueryInfo) As %Boolean
{
	merge p = pInfo.parms
	quit:'+p(1) 1  // quit if no domain is specified
	quit:'+p(2) 1  // quit if no source is specified
	
	set p = $o(p(""),-1)
	set tSC = pRS.Execute(p...)
	
	quit 1
}

/// Client-side utility method to refresh appropriate sections when <property>filter</property>
/// changes.
ClientMethod onUpdateFilterClient() [ Language = javascript ]
{
	zen('tblSimilar').refreshContents();
	zen('tblDictionary').refreshContents();
}

/// Draws a &lt;tablePane&gt; column's contents as a percentage
Method DrawPercentage(pTable As %ZEN.Component.tablePane, pName As %String, pSeed As %String) As %Status
{
	write $g(%query(pName))*100, "%"
	quit $$$OK
}

/// Utility method to draw source metadata in a &lt;tablePane&gt; column for a given source.
/// pSeed is expected to be the name of the metadata field to display.
Method DrawMetadata(pTable As %ZEN.Component.tablePane, pName As %String, pSeed As %String) As %Status
{
	set tExtId = $g(%query("extId"),$g(%query("externalId")))
	set tValue = ##class(%iKnow.Queries.MetadataAPI).GetValue(..reportDomain, pSeed, tExtId, .tSC)
	set:pSeed="EventDate" tValue = $zd(tValue)
	write tValue
	quit tSC
}

/// Client-side method refreshing appropriate sections of the popup window using the
/// srcId passed in.
ClientMethod displaySourceClient(srcId) [ Language = javascript ]
{
	zen('modSource').show();
	var sc = zenPage.setProperty('selectedSource',srcId);
	zen('htmlTitle').refreshContents();
	zen('htmlSource').refreshContents();
	zen('htmlCause').refreshContents();
	zen('tabTopEnts').refreshContents();
}

/// Client-side method triggered when the user presses the "summarize" button.
ClientMethod summarize() [ Language = javascript ]
{
	var sc = zenPage.setProperty('summaryLength', zen('txtLength').getValue());
	zen('htmlSource').refreshContents();
}

/// Draws a number of event properties as a header for the popup.
Method DrawEventHeader(pSeed As %String) As %Status
{
	set tSC = $$$OK
	try {
		quit:'..selectedSource
		
		set tExtId = ##class(%iKnow.Queries.SourceAPI).GetExternalId(..reportDomain, ..selectedSource)
		set tSC = ##class(%iKnow.Source.Lister).SplitExtId(..reportDomain, tExtId, .tLister, .tGroup, .tEventId)
		quit:$$$ISERR(tSC)
		
		#dim tEvent As Aviation.Event
		set tEvent = ##class(Aviation.Event).PKINDEXOpen(tEventId)
		
		write "<table id=""title""><tr>"
		write "<td id=""titleLeft"">"_tExtId_"</td>"
		write "<td id=""titleRight""><a href=""http://dms.ntsb.gov/aviation/GenPDF.aspx?id="_tEvent.NTSBId_"&rpt=fa"" target=""_new"">NTSB report</a></td>"
		write "</tr></table>"
		
		write "<table id=""metadata"">"
		write "<tr><td class=""left"">Date:</td><td>"_$e(tEvent.EventDate,1,10)_"</td></tr>"
		write "<tr><td class=""left"">NTSB ID:</td><td><a href=""http://dms.ntsb.gov/aviation/GenPDF.aspx?id="_tEvent.NTSBId_"&rpt=fa"" target=""_new"">"_tEvent.NTSBId_"</a></td></tr>"
		write "<tr><td class=""left"">Location:</td><td><a href=""http://maps.google.com/maps?q="_tEvent.LocationCoordsLatitude_",+"_tEvent.LocationCoordsLongitude_"+(Event location:+"_$zconvert(tEvent.LocationCity,"O","URL")_")&iwloc=A"" target=""_new"">"_$s(tEvent.LocationState'="":tEvent.LocationState_", ", 1:"")_tEvent.LocationCountry_"</a></td></tr>"
		write "<tr><td class=""left"">Light conditions:</td><td>"_$case(tEvent.LightConditions, "DAYL":"Daylight", "DUSK":"Dusk", "DAWN":"Dawn", "NBRT":"Night (bright)", "NDRK":"Night (dark)", "NITE":"Night", :"Unkown")_"</td></tr>"
		write "<tr><td class=""left"">Aircraft:</td><td>"_tEvent.Aircraft.GetAt(1).AircraftManufacturer_" ("_$case(tEvent.Aircraft.GetAt(1).AircraftCategory, "HELI":"helicopter", "AIR":"airplane", "BALL":"balloon", "GLI":"glider", "GYRO":"gyrocraft", "PPAR":"powered parachute", "ULTR":"ultralight", "WSFT":"weight shift", :"unknown")_")</td></tr>"
		write "</table>"
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Draws the contents of a source (report or cause, based on pSeed) as identified by
/// the value of <property>selectedSource</property>. The source is summarized if
/// <property>summaryLength</property> is non-zero (interpreted as the number of sentences) and
/// any matches against the dictionary created by <method>BuildSrcDictionary</method> is
/// highlighted.
Method DrawSource(pSeed As %String) As %Status
{
	set tSC = $$$OK
	try {
		quit:'..selectedSource
		
		if (pSeed="REPORT") {
			set tDomainId = ..reportDomain
			set tSrcId = ..selectedSource
			set tLength = ..summaryLength
		} else {
			set tDomainId = ..causeDomain
			set tExtId = ##class(%iKnow.Queries.SourceAPI).GetExternalId(..reportDomain, ..selectedSource)
			set tSrcId = ##class(%iKnow.Queries.SourceAPI).GetSourceId(tDomainId, tExtId)
			set tLength = 0
		}
		
		set tMatchFilter = ##class(%iKnow.Matching.MatchFilter).%New()
		set tDictId = ##class(%iKnow.Matching.DictionaryAPI).GetDictionaryId(tDomainId, ..#IKNOWDICTNAME)
		set tHighlight("MATCH", tDictId) = "<span class=""matchF"" title=""$$$TERM"">"
		set tHighlight("MATCH", tDictId, "PARTIAL") = "<span class=""matchP"" title=""$$$TERM"">"
		
		// Cause domain is not matched yet!
		set:pSeed="CAUSE" tSC = ##class(%iKnow.Matching.MatchingAPI).MatchSource(tDomainId, tSrcId, $lb(tDictId))
		quit:$$$ISERR(tSC)
		
		w ""
		
		set srcObj = ##class(%iKnow.Objects.Source).PKINDEXOpen(tDomainId, tSrcId)
		set sentBase = srcObj.FirstSentenceId-1
			
		if (tLength>0) {
			set tSC = ##class(%iKnow.Queries.SourceAPI).GetSummary(.res, tDomainId, tSrcId, tLength)
			quit:$$$ISERR(tSC)
		} else {
			kill res
			for i=1:1:srcObj.SentenceCount { set res(i) = $lb(sentBase+i) }
		}
		
		set i = "", prevPos=0
		for {
			set i = $o(res(i),1,d)
			quit:i=""
			
			set tSentId = $li(d,1), sentPos = tSentId-sentBase
			w:(sentPos>(prevPos+1)) " ... "
			
			write ##class(%iKnow.Queries.SentenceAPI).GetHighlighted(tDomainId, tSentId, .tHighlight,,,.tSC)," "
			quit:$$$ISERR(tSC)
			
			set prevPos = sentPos
		}
		w:(prevPos=(sentBase+srcObj.SentenceCount)) " ..."
		
		w ""
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Initializes some of the panes and session variables used by this page, fetching domain, 
/// source and term variables from the request (if present).
/// This method also verifies if the appropriate domains are present.
Method %OnAfterCreatePage() As %Status
{
	set ..reportDomain = $system.iKnow.GetDomainId(..#IKNOWREPORTDOMAINNAME)
	set ..causeDomain = $system.iKnow.GetDomainId(..#IKNOWCAUSEDOMAINNAME)
	
	if (..reportDomain="") || (..causeDomain="") {
		quit $$$ERROR($$$GeneralError, "Please set up the Aviation Investigator demo before opening this page, using the following command: do ##class(Aviation.UI.Investigator).Setup()")
	}
	
	quit ##super()
}

XData Style
{
<style type="text/css">
body {
	font-family: Verdana, Arial;
	font-size: 12px;
	line-height: 17px;
}

a {
	color: #a00000;
}

.match,.matchF {
	background-color: #9999ff;
	border: solid #9999ff 2px;
}
.matchP {
	border: solid #9999ff 2px;
	background-color: none;
}

table#title {
	border-bottom: solid black 1px;
	width: 100%;
}
td#titleLeft {
	font-weight: bold;
	font-size: 20px;
}
td#titleRight {
	vertical-alignment: bottom;
	text-align: right
}

table#metadata {
	margin-left: 20px;
	margin-top: 10px;
}
table#metadata td.left {
	padding-right: 10px;
	text-align: right;
}

.pageTitle {
	vertical-alignment: bottom;
	font-weight: bold;
	font-size: 25px;
}

.textBox {
	overflow-y: scroll;
	width: 500px;
	height: 300px;
	background-color: white;
	padding: 5px;
}

</style>
}

/// Sets up the Aviation Investigator demo. If the Standalone Aviation demo was already
/// set up through Aviation.Utils, that domain will be used.
ClassMethod Setup() As %Status
{
	try {
		do EnableIKnow^%SYS.cspServer("/csp/samples/")
	} catch (ex) {
		write !,"WARNING: failed to enable iKnow sample UI classes for this namespace.",!
	}
	
	set tSC = $$$OK
	try {
		
		write !,"Setting up reports domain..."
		if '##class(%iKnow.Domain).NameIndexExists(..#IKNOWREPORTDOMAINNAME) {
			set tDomain = ##class(%iKnow.Domain).%New(..#IKNOWREPORTDOMAINNAME)
			set tSC = tDomain.%Save()
			quit:$$$ISERR(tSC)
			set tSC = $system.iKnow.IndexTable(..#IKNOWREPORTDOMAINNAME, "Aviation.Event", "EventId", "YEAR(EventDate)", "NarrativeFull")
			quit:$$$ISERR(tSC)
		}
		write " (domain ID: ",$system.iKnow.GetDomainId(..#IKNOWREPORTDOMAINNAME),")"
		
		
		write !,"Setting up causes domain..."
		if '##class(%iKnow.Domain).NameIndexExists(..#IKNOWCAUSEDOMAINNAME) {
			set tDomain = ##class(%iKnow.Domain).%New(..#IKNOWCAUSEDOMAINNAME)
			set tSC = tDomain.%Save()
			quit:$$$ISERR(tSC)
			
			set tSC = $system.iKnow.IndexTable(..#IKNOWCAUSEDOMAINNAME, "Aviation.Event", "EventId", "YEAR(EventDate)", "NarrativeCause As Cause")
			quit:$$$ISERR(tSC)
			set ^Aviation.DomainName.Causes = ..#IKNOWCAUSEDOMAINNAME
		}
		write " (domain ID: ",$system.iKnow.GetDomainId(..#IKNOWCAUSEDOMAINNAME),")"
		
		
		do ##Class(%Library.RoutineMgr).GetWebServerPort(.tPort,.tServer,.tURLPrefix,.tURL)
		write !,"All done.",!!,"You can access the Aviation Investigator sample application at",!,tURL_"csp/samples/Aviation.UI.Investigator.zen",!
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	if $$$ISERR(tSC) {
		write !,"An error occurred while setting up the Aviation Investigator Demo:",!
		do $system.OBJ.DisplayError(tSC)
	}
	quit tSC
}

ClientMethod onunloadHandler() [ Language = javascript ]
{
	zenPage.OnUnload();
	return true;
}

Method OnUnload() As %Status [ Internal, ZenMethod ]
{
	try {
		// clean up any leftover sources
		do:..reportDomain&&..inputSource ##class(%iKnow.Source.Loader).DeleteVirtualSource(..reportDomain, $zabs(..inputSource))
	} catch {}
	quit $$$OK
}

}

