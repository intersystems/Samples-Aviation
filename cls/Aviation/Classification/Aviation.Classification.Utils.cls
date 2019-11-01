/// This sample illustrates how to build and test Text Categorization models programmatically
/// Use or operation of this code is subject to acceptance of the license available in the code repository for this code.
Class Aviation.Classification.Utils
{

/// Demonstration method using the <method>%iKnow.Classification.Builder</method> API to
/// create a simple classifier on the Aviation Events demo.
ClassMethod CreateClassifier() As %Status
{
	set tSC = $$$OK
	try {
		set tDomId = $system.iKnow.GetDomainId("Aviation Events demo")
		
		if 'tDomId || '##class(%iKnow.Queries.SourceAPI).GetCountByDomain(tDomId) {
			write !,"Aviation events domain is not set up. Run ##class(Aviation.Utils).SetupStandalone() first",!
			quit
		}
		
		// Create training and test set using a rather random split based on the modulo of the record ID
		// Using the modulo operator ensures we'll get the same results each time (unlike using RandomFilter)
		set tTrainingSet = ##class(%iKnow.Filters.SqlFilter).%New(tDomId, "SELECT ':SQL:'||YEAR(EventDate)||':'||EventID AS ExternalID FROM Aviation.Event WHERE (ID # 10) <= 5")
		set tTestSet = ##class(%iKnow.Filters.SqlFilter).%New(tDomId, "SELECT ':SQL:'||YEAR(EventDate)||':'||EventID AS ExternalID FROM Aviation.Event WHERE (ID # 10) > 5")
		
		// Instantiate builder and configure for use with highest injury
		set tBuilder = ##class(%iKnow.Classification.IKnowBuilder).%New("Aviation Events demo",tTrainingSet)
		set tBuilder.TestSet = tTestSet
		set tSC = tBuilder.%LoadMetadataCategories("HighestInjury")
		quit:$$$ISERR(tSC)
		
		// Note that "HighestInjury" is perhaps not that convenient to use as a category, as 
		// for example, a "HighestInjury=Serious" record could well mention some minor injuries as well.
		
		
		// Populate the model with a few terms
		set tSC = tBuilder.%PopulateTerms(50)
		quit:$$$ISERR(tSC)
		set tSC = tBuilder.%AddEntity("crash site")
		quit:$$$ISERR(tSC)
		set tSC = tBuilder.%AddTermsFromSQL("SELECT TOP 50 EntityValue AS Term FROM %iKnow_Objects.EntityUnique WHERE DomainID = "_tDomId_" AND EntityValue LIKE '%injur%' ORDER BY CorpusSpread DESC")
		quit:$$$ISERR(tSC)
		
		// Add more terms as you see fit
		// ...
		

		// Generate classifier class
		set tSC = tBuilder.%CreateClassifierClass("Aviation.Classification.MyClassifier", 1, 1, 1)
		quit:$$$ISERR(tSC)
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Code sample using the <method>%iKnow.Classification.Optimizer</method> class to increase the
/// accuracy of our classification model.
ClassMethod OptimizeClassifier() As %Status
{
	set tSC = $$$OK
	try {
		if '$$$defClassDefined("Aviation.Classification.MyClassifier") {
			w !,"Please run the ..CreateClassifier() method first",!
			quit
		}
		
		set tDomId = $system.iKnow.GetDomainId("Aviation Events demo")
		
		// Restore a builder object from our class definition
		set tSC = ##class(%iKnow.Classification.Builder).%LoadFromDefinition("Aviation.Classification.MyClassifier", .tBuilder)
		quit:$$$ISERR(tSC)
		
		// Instantiate a builder object
		set tOptimizer = ##class(%iKnow.Classification.Optimizer).%New()
		set tOptimizer.Builder = tBuilder
		
		// Load candidate entities
		set tSC = ##class(%iKnow.Queries.EntityAPI).GetTopBM25(.tCandidates, tDomId, 1, 200)
		quit:$$$ISERR(tSC)
		
		// Skip the first 50, as we already added them in ..CreateClassifier()
		for i=1:1:50 { kill tCandidates(i) }
		set tSC = tOptimizer.LoadTermsArray(.tCandidates, 2)
		quit:$$$ISERR(tSC)
		
		// fFire off the optimization process
		set tOptimizer.Verbose = 1
		set tSC = tOptimizer.Optimize(20)
		quit:$$$ISERR(tSC)
		write !
		
		// Save updated class
		set tSC = tOptimizer.SaveClassifier("Aviation.Classificaton.MyClassifier", 1)
		quit:$$$ISERR(tSC)
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

/// Code sample using the batch testing features offered by <class>%iKnow.Classification.Utils</class>
ClassMethod TestClassifier() As %Status
{
	set tSC = $$$OK
	try {
		if '$$$defClassDefined("Aviation.Classification.MyClassifier") {
			w !,"Please run the ..CreateClassifier() method first",!
			quit
		}
		
		set tDomId = $system.iKnow.GetDomainId("Aviation Events demo")
		set tTestSet = ##class(%iKnow.Filters.SqlFilter).%New(tDomId, "SELECT ':SQL:'||YEAR(EventDate)||':'||EventID AS ExternalID FROM Aviation.Event WHERE (ID # 10) > 5")
		set tSC = ##class(%iKnow.Classification.Utils).%RunModelFromDomain(.tResId, "Aviation.Classification.MyClassifier", tDomId, "HighestInjury", tTestSet)
		quit:$$$ISERR(tSC)
		
		&SQL(SELECT COUNT(*), SUM(CASE WHEN ActualValue=PredictedValue THEN 1 ELSE 0 END) 
				INTO :tTotal, :tRight 
				FROM %DeepSee_PMML_Utils.TempResult 
				WHERE TestId = :tResId)
				
		write !,"We got ",tRight," records right out of ",tTotal,!
		
		
		// Retrieve precision and recall metrics for this test result
		set tSC = ##class(%DeepSee.PMML.Utils.TempResult).GetAggregatePrecisionMetrics(tResId,.tPrecision,.tMPrecision,.tRecall,.tMRecall,.tFMeasure,.tMFMeasure)
		quit:$$$ISERR(tSC)
		write !,"            micro-AVG   macro-AVG"
		write !,"Precision:     ",$fnumber(tMPrecision,"",2),"%      ",$fnumber(tPrecision,"",2),"%"
		write !,"Recall:        ",$fnumber(tMRecall,"",2),"%      ",$fnumber(tRecall,"",2),"%"
		write !,"F-measure:     ",$fnumber(tMFMeasure,"",2),"%      ",$fnumber(tFMeasure,"",2),"%",!
		
		// Drop test results
		do ##class(%DeepSee.PMML.Utils).%DropResults(tResId)
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}

