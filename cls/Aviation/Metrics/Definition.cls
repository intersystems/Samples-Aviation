/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
Class Aviation.Metrics.Definition Extends %iKnow.Metrics.MetricDefinition [ CompileAfter = Aviation.Metrics.Builder ]
{

XData Metrics [ XMLNamespace = "http://www.intersystems.com/iknow/metrics" ]
{
<metrics>
<metric name="TFIDF" type="source" targets="entity"
	builderClass="Aviation.Metrics.Builder"
	description="This well-known metric multiplies the local frequency of a term with its (smoothed) Inverse Document Frequency (defined as $zlog(([totalSrcCount] - [spread] + 0.5) / ([spread] + 0.5)). In this implementation, we're using a weighted local frequency where relationships are counted as 0.5 (but the IDF uses unweighted entity spread)." />
<metric name="ReportQuality" type="domain" targets="source" maintainIndex="true"
	description="A custom metric expressing the writing quality of a report (to be manually assigned, NOT calculated)" />
<metric name="CategoryRelevance" type="group" targets="source" groupField="AircraftCategory"
 	builderClass="Aviation.Metrics.Builder" maintainIndex="true"
 	description="A simplistic metric expressing how often the aircraft category was referred in the report" />
</metrics>
}

}

