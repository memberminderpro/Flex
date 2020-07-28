<cfcomponent displayname="InvoiceGrpDAO" hint="table ID column = InvoiceGrpID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - InvoiceGrp Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="remote" output="false" returntype="InvoiceGrpDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

<!--------------------------------------------------------------------------------------------
	getVariablesScope - Return variable Scope
	
	Entry Conditions:
		None
---------------------------------------------------------------------------------------------->
	<cffunction name="getVariablesScope" access="remote" output="false" returntype="struct">
      <cfreturn variables />
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Pick - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Pick" access="remote" output="false" returntype="Query" DisplayName="Pick InvoiceGrp">
		<cfargument Name="AccountID"          	 Type="Numeric"  	Required="No" 	Hint="AccountID" 				Default="#SESSION.AccountID#">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 				Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 					Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 					Default="InvoiceGrp">

		<cfset var qPick = "" />
		<cfquery name="qPick" datasource="RotaryTest">
			SELECT
				InvoiceGrpID,
				InvoiceGrp
			FROM	tblInvoiceGrp

			WHERE 		1 = 1

			AND		tblInvoiceGrp.AccountID = <CFQUERYPARAM Value="#ARGUMENTS.AccountID#" CFSQLTYPE="CF_SQL_INTEGER">
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblInvoiceGrp.InvoiceGrp 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			ORDER BY 	#ARGUMENTS.SortBy#
		</cfquery>
		<cfreturn qPick>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Lookup - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="remote" output="false" returntype="Query" DisplayName="Lookup InvoiceGrp">
		<cfargument Name="AccountID"          	 Type="Numeric"  	Required="No" 	Hint="AccountID" 				Default="#SESSION.AccountID#">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 				Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 					Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 					Default="">

		<cfset var qLookup = "" />

		<cfquery name="qLookup" datasource="RotaryTest">
			SELECT
				tblInvoiceGrp.InvoiceGrpID,
				tblInvoiceGrp.InvoiceGrp,
				tblInvoiceGrp.AccountID,
				tblInvoiceGrp.ClubID,
				tblInvoiceGrp.Period,
				tblInvoiceGrp.InvoiceDate,
				tblInvoiceGrp.DueDate,
				tblInvoiceGrp.IsPosted,
				tblInvoiceGrp.Amount,
				tblInvoiceGrp.Description,
				tblInvoiceGrp.Message,
				tblInvoiceGrp.IncZeroAmts,
				tblInvoiceGrp.IsProforma,
				tblInvoiceGrp.Created_By,
				tblInvoiceGrp.Created_Tmstmp,
				tblInvoiceGrp.Modified_By,
				tblInvoiceGrp.Modified_Tmstmp
			FROM	tblInvoiceGrp
			WHERE 		1 = 1
			AND		tblInvoiceGrp.AccountID = <CFQUERYPARAM Value="#ARGUMENTS.AccountID#" CFSQLTYPE="CF_SQL_INTEGER">

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblInvoiceGrp.InvoiceGrpID 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="InvoiceGrp">ORDER BY 	tblInvoiceGrp.InvoiceGrp </cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qLookup>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	View - InvoiceGrp
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="remote" output="false" returntype="Query" DisplayName="View InvoiceGrp">
		<cfargument Name="AccountID"          	 Type="Numeric"  	Required="No" 	Hint="AccountID" 				Default="#SESSION.AccountID#">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 				Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 					Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 					Default="">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				tblInvoiceGrp.InvoiceGrpID,
				tblInvoiceGrp.InvoiceGrp,
				tblInvoiceGrp.AccountID,
				tblInvoiceGrp.ClubID,
				tblInvoiceGrp.Period,
				tblInvoiceGrp.InvoiceDate,
				tblInvoiceGrp.DueDate,
				tblInvoiceGrp.IsPosted,
				tblInvoiceGrp.Amount,
				tblInvoiceGrp.Description,
				tblInvoiceGrp.Message,
				tblInvoiceGrp.IncZeroAmts,
				tblInvoiceGrp.IsProforma,
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					tblInvoiceGrp.Created_Tmstmp,
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
					tblInvoiceGrp.Modified_Tmstmp
				
			FROM	tblInvoiceGrp
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblInvoiceGrp.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON tblInvoiceGrp.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1

			AND		tblInvoiceGrp.AccountID = <CFQUERYPARAM Value="#ARGUMENTS.AccountID#" CFSQLTYPE="CF_SQL_INTEGER">
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblInvoiceGrp.InvoiceGrp 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>
			
			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="InvoiceGrp">ORDER BY 	tblInvoiceGrp.InvoiceGrp </cfcase>

			</cfswitch>

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	List - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="List" access="remote" output="false" returntype="Query" DisplayName="List InvoiceGrp">
		<cfargument name="InvoiceGrpID" type="numeric" required="false" />
		<cfargument Name="AccountID"          	 Type="Numeric"  	Required="No" 	Hint="AccountID" 				Default="#SESSION.AccountID#">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 				Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 					Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 					Default="">

		<cfset var qList = "" />
		<cfquery name="qList" datasource="RotaryTest">
			SELECT
				tblInvoiceGrp.InvoiceGrpID,
					tblInvoiceGrp.InvoiceGrp,
					tblInvoiceGrp.AccountID,
					tblInvoiceGrp.ClubID,
					tblInvoiceGrp.Period,
					tblInvoiceGrp.InvoiceDate,
					tblInvoiceGrp.DueDate,
					tblInvoiceGrp.IsPosted,
					tblInvoiceGrp.Amount,
					tblInvoiceGrp.Description,
					tblInvoiceGrp.Message,
					tblInvoiceGrp.IncZeroAmts,
					tblInvoiceGrp.IsProforma,
					tblInvoiceGrp.Created_By,
					tblInvoiceGrp.Created_Tmstmp,
					tblInvoiceGrp.Modified_By,
					tblInvoiceGrp.Modified_Tmstmp
				
			FROM	tblInvoiceGrp
			WHERE 		1 = 1

			AND		tblInvoiceGrp.AccountID = <CFQUERYPARAM Value="#ARGUMENTS.AccountID#" CFSQLTYPE="CF_SQL_INTEGER">
					
			<CFIF IsDefined("ARGUMENTS.InvoiceGrpID") AND ARGUMENTS.InvoiceGrpID GT 0>
				AND 	tblInvoiceGrp.InvoiceGrpID = <CFQUERYPARAM Value="#ARGUMENTS.InvoiceGrpID#" CFSQLTYPE="cf_sql_integer">
			</cfif>
			
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblInvoiceGrp.InvoiceGrp 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="InvoiceGrp">ORDER BY 	tblInvoiceGrp.InvoiceGrp </cfcase>

			</cfswitch>

		</cfquery>
		<cfreturn qList>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Initial - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Initial" access="remote" output="false" returntype="Query" DisplayName="Initial InvoiceGrp">
		<cfargument Name="AccountID"          	 Type="Numeric"  	Required="No" 	Hint="AccountID" 				Default="#SESSION.AccountID#">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 				Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 					Default="">

		<cfset var qInitial = "" />
		<cfquery name="qInitial" datasource="RotaryTest">
			SELECT 	DISTINCT Left(InvoiceGrp, 1) as Initial
			FROM	tblInvoiceGrp
			WHERE 		1 = 1

			AND		tblInvoiceGrp.AccountID = <CFQUERYPARAM Value="#ARGUMENTS.AccountID#" CFSQLTYPE="CF_SQL_INTEGER">
					
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblInvoiceGrp.InvoiceGrp 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>
			ORDER BY 	Left(InvoiceGrp, 1)

		</cfquery>
		<cfreturn qInitial>
	</cffunction>
	
	

<!--- ----------------------------------------------------------------------------------------------------------------
	Read - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="remote" output="false" returntype="struct" DisplayName="Read InvoiceGrp">
		<cfargument name="InvoiceGrp" type="InvoiceGrp" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					tblInvoiceGrp.InvoiceGrpID,
					tblInvoiceGrp.InvoiceGrp,
					tblInvoiceGrp.AccountID,
					tblInvoiceGrp.ClubID,
					tblInvoiceGrp.Period,
					tblInvoiceGrp.InvoiceDate,
					tblInvoiceGrp.DueDate,
					tblInvoiceGrp.IsPosted,
					tblInvoiceGrp.Amount,
					tblInvoiceGrp.Description,
					tblInvoiceGrp.Message,
					tblInvoiceGrp.IncZeroAmts,
					tblInvoiceGrp.IsProforma,
					
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						tblInvoiceGrp.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						tblInvoiceGrp.Modified_Tmstmp

				FROM	tblInvoiceGrp
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblInvoiceGrp.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON tblInvoiceGrp.Modified_By = tblUser_2.UserID

				WHERE	InvoiceGrpID = <cfqueryparam value="#arguments.InvoiceGrp.getInvoiceGrpID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.InvoiceGrp.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="remote" output="false" returntype="boolean" DisplayName="Delete InvoiceGrp">
		<cfargument name="InvoiceGrp" type="InvoiceGrp" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	tblInvoiceGrp
			WHERE	InvoiceGrpID = <cfqueryparam value="#arguments.InvoiceGrp.getInvoiceGrpID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="remote" output="false" returntype="numeric" DisplayName="Create InvoiceGrp">
		<cfargument name="InvoiceGrp" 		type="InvoiceGrp" 	required="true" />
		<cfargument name="OnErrorContinue"  type="String" 		required="false" 	Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>
			<cflock timeout="5" throwontimeout="Yes" name="inserttblInvoiceGrp" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(InvoiceGrpID) as MaxID from tblInvoiceGrp
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1>
				<cfelse>
					<CFSET MaxID = qMax.MaxID + 1>
				</cfif>
				
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO tblInvoiceGrp
						(
						InvoiceGrpID,	
						InvoiceGrp,	
						AccountID,	
						ClubID,	
						Period,	
						InvoiceDate,	
						DueDate,	
						IsPosted,	
						Amount,	
						Description,	
						Message,	
						IncZeroAmts,	
						IsProforma,	
						
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 									CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getInvoiceGrp()#" 	CFSQLType="cf_sql_varchar" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getAccountID()#" 	CFSQLType="cf_sql_integer" 	null="#not len(arguments.InvoiceGrp.getAccountID())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getClubID()#" 		CFSQLType="cf_sql_integer" 	null="#not len(arguments.InvoiceGrp.getClubID())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getPeriod()#" 		CFSQLType="cf_sql_varchar" 	null="#not len(arguments.InvoiceGrp.getPeriod())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getInvoiceDate()#" 	CFSQLType="cf_sql_date" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getDueDate()#" 		CFSQLType="cf_sql_date" 	null="#not len(arguments.InvoiceGrp.getDueDate())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getIsPosted()#" 		CFSQLType="cf_sql_char" 	null="#not len(arguments.InvoiceGrp.getIsPosted())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getAmount()#" 		CFSQLType="cf_sql_money" 	null="#not len(arguments.InvoiceGrp.getAmount())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getDescription()#" 	CFSQLType="cf_sql_varchar" 	null="#not len(arguments.InvoiceGrp.getDescription())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getMessage()#" 		CFSQLType="cf_sql_varchar" 	null="#not len(arguments.InvoiceGrp.getMessage())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getIncZeroAmts()#" 	CFSQLType="cf_sql_char" 	null="#not len(arguments.InvoiceGrp.getIncZeroAmts())#" />,
						<cfqueryparam value="#arguments.InvoiceGrp.getIsProforma()#" 	CFSQLType="cf_sql_char" 	null="#not len(arguments.InvoiceGrp.getIsProforma())#" />,
						<cfqueryparam value="#SESSION.UserID#" 							CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 									CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="InvoiceGrp" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.InvoiceGrp.getInvoiceGrp()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a InvoiceGrp" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="InvoiceGrp-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="remote" output="false" returntype="numeric" DisplayName="Update InvoiceGrp">
		<cfargument name="InvoiceGrp" 		type="InvoiceGrp" 	required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	tblInvoiceGrp
				SET
					InvoiceGrp 	= <cfqueryparam value="#arguments.InvoiceGrp.getInvoiceGrp()#" 		CFSQLType="cf_sql_varchar"  />,
					AccountID 	= <cfqueryparam value="#arguments.InvoiceGrp.getAccountID()#" 		CFSQLType="cf_sql_integer"  null="#not len(arguments.InvoiceGrp.getAccountID())#" />,
					ClubID 		= <cfqueryparam value="#arguments.InvoiceGrp.getClubID()#" 			CFSQLType="cf_sql_integer"  null="#not len(arguments.InvoiceGrp.getClubID())#" />,
					Period 		= <cfqueryparam value="#arguments.InvoiceGrp.getPeriod()#" 			CFSQLType="cf_sql_varchar"  null="#not len(arguments.InvoiceGrp.getPeriod())#" />,
					InvoiceDate = <cfqueryparam value="#arguments.InvoiceGrp.getInvoiceDate()#" 	CFSQLType="cf_sql_date"  />,
					DueDate 	= <cfqueryparam value="#arguments.InvoiceGrp.getDueDate()#" 		CFSQLType="cf_sql_date"  	null="#not len(arguments.InvoiceGrp.getDueDate())#" />,
					IsPosted	= <cfqueryparam value="#arguments.InvoiceGrp.getIsPosted()#" 		CFSQLType="cf_sql_char"  	null="#not len(arguments.InvoiceGrp.getIsPosted())#" />,
					Amount 		= <cfqueryparam value="#arguments.InvoiceGrp.getAmount()#" 			CFSQLType="cf_sql_money"  	null="#not len(arguments.InvoiceGrp.getAmount())#" />,
					Description = <cfqueryparam value="#arguments.InvoiceGrp.getDescription()#" 	CFSQLType="cf_sql_varchar"  null="#not len(arguments.InvoiceGrp.getDescription())#" />,
					Message 	= <cfqueryparam value="#arguments.InvoiceGrp.getMessage()#" 		CFSQLType="cf_sql_varchar"  null="#not len(arguments.InvoiceGrp.getMessage())#" />,
					IncZeroAmts = <cfqueryparam value="#arguments.InvoiceGrp.getIncZeroAmts()#" 	CFSQLType="cf_sql_char"  	null="#not len(arguments.InvoiceGrp.getIncZeroAmts())#" />,
					IsProforma 	= <cfqueryparam value="#arguments.InvoiceGrp.getIsProforma()#" 		CFSQLType="cf_sql_char"  	null="#not len(arguments.InvoiceGrp.getIsProforma())#" />,
					
					Modified_By = <cfqueryparam value="#SESSION.UserID#" CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp = <cfqueryparam value="#Now()#" CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					InvoiceGrpID = <cfqueryparam value="#arguments.InvoiceGrp.getInvoiceGrpID()#" 	CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="InvoiceGrp" type="U" Value="#arguments.InvoiceGrp.getInvoiceGrpID()#" Desc=" [#arguments.InvoiceGrp.getInvoiceGrp()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="InvoiceGrp" type="U" Value="#arguments.InvoiceGrp.getInvoiceGrpID()#" Desc="Error updating [#arguments.InvoiceGrp.getInvoiceGrp()#] (#cfcatch.message#)" />

				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating InvoiceGrp" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="InvoiceGrp-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.InvoiceGrp.getInvoiceGrpID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="remote" output="false" returntype="boolean" DisplayName="Delete InvoiceGrp">
		<cfargument name="InvoiceGrp" type="InvoiceGrp" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE 	FROM	tblInvoiceGrp 
				WHERE	InvoiceGrpID 	= <cfqueryparam value="#arguments.InvoiceGrp.getInvoiceGrpID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="InvoiceGrp" type="D" Value="#arguments.InvoiceGrp.getInvoiceGrpID()#" Desc=" [#ARGUMENTS.InvoiceGrp.getInvoiceGrp()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="InvoiceGrp" type="D" Value="#arguments.InvoiceGrp.getInvoiceGrpID()#" Desc="Error deleting [#ARGUMENTS.InvoiceGrp.getInvoiceGrp()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a InvoiceGrp" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="InvoiceGrp-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>


<!--- ----------------------------------------------------------------------------------------------------------------
	Clone - InvoiceGrp
	Modifications
	<cffunction name="Clone" access="remote" output="true" returntype="numeric" DisplayName="Clone InvoiceGrp">
		<cfargument name="InvoiceGrp" type="InvoiceGrp" required="true" />

	<cfset var CloneID = 0 />

		<cfinvoke component="InvoiceGrp" method="init" returnvariable="InvoiceGrpObj">
			<cfinvokeargument name="InvoiceGrp"			Value="#arguments.InvoiceGrp.getInvoiceGrp()#" />
			<cfinvokeargument name="ClubID"				Value="#arguments.InvoiceGrp.getClubID()#" />
			<cfinvokeargument name="Period"				Value="#arguments.InvoiceGrp.getPeriod()#" />
			<cfinvokeargument name="InvoiceDate"		Value="#arguments.InvoiceGrp.getInvoiceDate()#" />
			<cfinvokeargument name="DueDate"			Value="#arguments.InvoiceGrp.getDueDate()#" />
			<cfinvokeargument name="IsPosted"				Value="#arguments.InvoiceGrp.getIsPosted()#" />
			<cfinvokeargument name="Amount"				Value="#arguments.InvoiceGrp.getAmount()#" />
			<cfinvokeargument name="Description"		Value="#arguments.InvoiceGrp.getDescription()#" />
			<cfinvokeargument name="Message"			Value="#arguments.InvoiceGrp.getMessage()#" />
			<cfinvokeargument name="IncZeroAmts"		Value="#arguments.InvoiceGrp.getIncZeroAmts()#" />
			<cfinvokeargument name="IsProforma"			Value="#arguments.InvoiceGrp.getIsProforma()#" />
		</cfinvoke>
		<cfset CloneID = Create( InvoiceGrpObj, "Y" ) />
			
		<cfreturn CloneID />
	</cffunction>
---------------------------------------------------------------------------------------------------------------------->

<!--- ----------------------------------------------------------------------------------------------------------------
	LoadBase - InvoiceGrp
	Modifications
	<cffunction name="LoadBase" access="remote" output="true" returntype="numeric" DisplayName="LoadBase InvoiceGrp">
		<cfargument name="AccountID" type="Numeric" required="false"  Default="999"/>

		<cfset var Q = "" />
		
		<cfset Q = Lookup( UseCustom="N", AccountID="#ARGUMENTS.AccountID#"  ) />
		<cfloop query="Q">
			<cfinvoke component="InvoiceGrp" method="init" returnvariable="InvoiceGrpObj">
				<cfinvokeargument name="InvoiceGrp"		Value="#Q.InvoiceGrp#" />
				<cfinvokeargument name="ClubID"			Value="#Q.ClubID#" />
				<cfinvokeargument name="Period"			Value="#Q.Period#" />
				<cfinvokeargument name="InvoiceDate"	Value="#Q.InvoiceDate#" />
				<cfinvokeargument name="DueDate"		Value="#Q.DueDate#" />
				<cfinvokeargument name="IsPosted"			Value="#Q.IsPosted#" />
				<cfinvokeargument name="Amount"			Value="#Q.Amount#" />
				<cfinvokeargument name="Description"	Value="#Q.Description#" />
				<cfinvokeargument name="Message"		Value="#Q.Message#" />
				<cfinvokeargument name="IncZeroAmts"	Value="#Q.IncZeroAmts#" />
				<cfinvokeargument name="IsProforma"		Value="#Q.IsProforma#" />
			</cfinvoke>
			<cfset Create( InvoiceGrpObj, "Y" ) />
		</cfloop>
			
		<cfreturn TRUE />
	</cffunction>
---------------------------------------------------------------------------------------------------------------------->

<!--- ----------------------------------------------------------------------------------------------------------------
	Save - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="remote" output="false" returntype="numeric" DisplayName="Save InvoiceGrp">
		<cfargument name="InvoiceGrp" type="InvoiceGrp" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.InvoiceGrp)>
			<cfset pkID = update(arguments.InvoiceGrp) />
		<cfelse>
			<cfset pkID = create(arguments.InvoiceGrp) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - InvoiceGrp
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="queryRowToStruct" access="private" output="false" returntype="struct">
		<cfargument name="qry" type="query" required="true">
		
		<cfscript>
			/**
			 * Makes a row of a query into a structure.
			 * 
			 * @param query 	 The query to work with. 
			 * @param row 	 Row number to check. Defaults to row 1. 
			 * @return Returns a structure. 
			 * @author Nathan Dintenfass (nathan@changemedia.com) 
			 * @version 1, December 11, 2001 
			 */
			//by default, do this to the first row of the query
			var row = 1;
			//a var for looping
			var ii = 1;
			//the cols to loop over
			var cols = listToArray(qry.columnList);
			//the struct to return
			var stReturn = structnew();
			//if there is a second argument, use that for the row number
			if(arrayLen(arguments) GT 1)
				row = arguments[2];
			//loop over the cols and build the struct from the query row
			for(ii = 1; ii lte arraylen(cols); ii = ii + 1){
				stReturn[cols[ii]] = qry[cols[ii]][row];
			}		
			//return the struct
			return stReturn;
		</cfscript>
	</cffunction>

</cfcomponent>
