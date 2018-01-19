/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
Class Aviation.Metrics.Builder Extends %iKnow.Metrics.MetricBuilder
{

Property TotalSourceCount As %Integer;

Property SourceFreqs [ MultiDimensional ];

Property SimilarEntIds [ MultiDimensional ];

Method CalculateEntUniMetrics(pEntUniId As %Integer, pEntUniValue As %String, Output pValues) As %Status
{
	set tSC = $$$OK
	try {
		kill pValues
		
		if (..Type=$$$IKMTRTYPESOURCE) {
			/// Calculation for TF*IDF:
			/// using a weighted local frequency with relationships counted as 0.5 occurrences
			set tSourceFreqs = $g(..SourceFreqs(pEntUniId))
			set tTF = $lg(tSourceFreqs,1) + ($lg(tSourceFreqs,2) * 0.5)
			
			// Use unweighted spread for IDF calculation
			set tSpread = ##class(%iKnow.Queries.EntityAPI).GetSpread(..DomainId, pEntUniId, $$$ENTTYPEANY)
			set tIDF = $zlog((..TotalSourceCount - tSpread + 0.5) / (tSpread + 0.5))
			set pValues("TFIDF") = tTF*tIDF
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Method OnAfterBuildMetricsForSource(pSrcId As %Integer) As %Status
{
	set tSC = $$$OK
	try {
		kill ..SourceFreqs
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Method OnBeforeBuildMetricsForSource(pSrcId As %Integer) As %Status
{
	set tSC = $$$OK
	try {
		
		// pre-load frequencies for this source
		set tSC = ##class(%iKnow.Queries.EntityAPI).GetBySource(.tResult, ..DomainId, pSrcId, 0, 0, $$$ENTTYPECONCEPT)
		quit:$$$ISERR(tSC)
		
		kill ..SourceFreqs
		set i=""
		for {
			set i = $order(tResult(i),1,tEntity)
			quit:i=""
			
			set ..SourceFreqs($li(tEntity,1)) = $li(tEntity,3,4)
		}
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// <p>Utility method called before a MetricBuilder starts building any metrics, in which
/// custom code can be executed to set up any auxiliary objects or data structures.</p>
/// <p>Note: depending on the value of <parameter>SUPPORTSMULTIPROCESS</parameter>, multiple
/// MetricBuilder instances can be running alongside one another</p>
Method OnBeforeBuildMetrics() As %Status
{
	set ..TotalSourceCount = ##class(%iKnow.Queries.SourceAPI).GetCountByDomain(..DomainId)
	quit $$$OK
}

/// <p>This is the main method a custom MetricBuilder should implement to support metrics
/// targeting sources. Depending on the value of <property>Type</property>, the properties
/// <property>CurrentSrcId</property> (for $$$IKMTRTYPESOURCE), <property>CurrentFieldName</property>
/// and <property>CurrentFieldValue</property> (for $$$IKMTRTYPEGROUP) or neither of these
/// (for $$$IKMTRTYPEDOMAIN) will define the scope for which metrics should be calculated.</p>
/// <p>For a given source <var>pSourceId</var> in the context of a given source <var>pSrcId</var>,
/// this method should calculate all metrics it knows about and return them through
/// <var>pValues</var> in an array indexed by metric name:
/// 			pValues(<i>metricName</i>) = value </p>
Method CalculateSourceMetrics(pSourceId As %Integer, Output pValues) As %Status
{
	set tSC = $$$OK
	try {
		kill pValues
		 
		if (..Type = $$$IKMTRTYPEGROUP) {
			set tDomainId = ..DomainId
			set tFilter = ##class(%iKnow.Filters.SourceIdFilter).%New(tDomainId, $lb(pSourceId))
			set tEntUniId = "", tScore = ""
			for {
				set tEntUniId = $order(..SimilarEntIds(tEntUniId))
				quit:tEntUniId=""
				
				set tScore = tScore + ##class(%iKnow.Queries.EntityAPI).GetFrequency(tDomainId, tEntUniId,,, tFilter)
			}
			set:tScore pValues("CategoryRelevance") = tScore
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// <p>Utility method called after a MetricBuilder instance finishes building any metrics for the
/// group identified by <property>CurrentFieldName</property> and <property>CurrentFieldValue</property>,
/// for metrics of type $$$IKMTRTYPEGROUP.</p>
Method OnAfterBuildMetricsForGroup() As %Status
{
	set tSC = $$$OK
	try {
		kill ..SimilarEntIds
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// <p>Utility method called before a MetricBuilder instance starts building any metrics for the
/// group identified by <property>CurrentFieldName</property> and <property>CurrentFieldValue</property>,
/// for metrics of type $$$IKMTRTYPEGROUP.</p>
Method OnBeforeBuildMetricsForGroup() As %Status
{
	set tSC = $$$OK
	try {
		set tFilter = ##class(%iKnow.Filters.SimpleMetadataFilter).%New(..DomainId, ..CurrentFieldName, $$$MDOPEQUAL, ..CurrentFieldValue)
		set tSC = ##class(%iKnow.Queries.EntityAPI).GetSimilar(.tResult, ..DomainId, ..CurrentFieldValue, 0, 0, tFilter, $$$FILTERONLY)
		quit:$$$ISERR(tSC)
		
		set i = ""
		for {
			set i = $order(tResult(i),1,tData)
			quit:i=""
			
			set ..SimilarEntIds($li(tData,1)) = ""
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}

