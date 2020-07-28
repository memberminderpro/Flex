<cfcomponent displayname="ChargeTypeDAO" hint="table ID column = ChargeTypeID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - ChargeType Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="Remote" output="false" returntype="ChargeTypeDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

<!--------------------------------------------------------------------------------------------
	getVariablesScope - Return variable Scope
	
	Entry Conditions:
		None
---------------------------------------------------------------------------------------------->
	<cffunction name="getVariablesScope" access="Remote" output="false" returntype="struct">
      <cfreturn variables />
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Pick - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Pick" access="Remote" output="false" returntype="Query" DisplayName="Pick ChargeType">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 				Default="PositionSort">

		<cfset var qPick = "" />
		<cfquery name="qPick" datasource="RotaryTest">
			SELECT
				ChargeTypeID, ChargeType
			FROM	tblChargeType

			WHERE 		1 = 1

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	IsActive 	<> 'N'
			</cfif>

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeType.ChargeType 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			ORDER BY 	#ARGUMENTS.SortBy#
		</cfquery>
		<cfreturn qPick>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Lookup - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="Remote" output="false" returntype="Query" DisplayName="Lookup ChargeType">
		<cfargument Name="Override"          Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	         Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	         Type="String"  	Required="No" 	Hint="SortBy" 				Default="PositionSort">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
			SELECT
				tblChargeType.ChargeTypeID,
				tblChargeType.ChargeType,
				tblChargeType.IsActive,
				tblChargeType.PositionSort,
				tblChargeType.Created_By,
				tblChargeType.Created_Tmstmp,
				tblChargeType.Modified_By,
				tblChargeType.Modified_Tmstmp
				
			FROM	tblChargeType

			WHERE 		1 = 1

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	IsActive 	<> 'N'
			</cfif>

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeType.ChargeTypeID 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="ChargeType">		ORDER BY 	tblChargeType.ChargeType </cfcase>
				<cfcase value="PositionSort">	ORDER BY 	tblChargeType.PositionSort </cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qLookup>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	View - ChargeType
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="Remote" output="false" returntype="Query" DisplayName="View ChargeType">
		<cfargument Name="Override"         	 Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 				Default="PositionSort">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				tblChargeType.ChargeTypeID,
				tblChargeType.ChargeType,
				tblChargeType.IsActive,
				tblChargeType.PositionSort,
							
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					tblChargeType.Created_Tmstmp,
							
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
				tblChargeType.Modified_Tmstmp
				
			FROM	tblChargeType
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeType.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeType.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	tblChargeType.IsActive 	<> 'N'
			</cfif>

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeType.ChargeType 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>
			
			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="ChargeType">		ORDER BY 	tblChargeType.ChargeType </cfcase>
				<cfcase value="PositionSort">	ORDER BY 	tblChargeType.PositionSort </cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	List - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="List" access="Remote" output="false" returntype="Query" DisplayName="List ChargeType">
		<cfargument name="ChargeTypeID" 		type="numeric" 		Required="false" />
		<cfargument Name="Override"         	Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	         	Type="String"  		Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	         	Type="String"  		Required="No" 	Hint="SortBy" 				Default="PositionSort">

		<cfset var qList = "" />
		<cfquery name="qList" datasource="RotaryTest">
			SELECT
				tblChargeType.ChargeTypeID,
				tblChargeType.ChargeType,
				tblChargeType.IsActive,
				tblChargeType.PositionSort,
				tblChargeType.Created_By,
				tblChargeType.Created_Tmstmp,
				tblChargeType.Modified_By,
				tblChargeType.Modified_Tmstmp
				
			FROM	tblChargeType

			WHERE 		1 = 1

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	IsActive 	<> 'N'
			</cfif>

			<CFIF IsDefined("ARGUMENTS.ChargeTypeID") AND ARGUMENTS.ChargeTypeID GT 0>
				AND 	tblChargeType.ChargeTypeID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeTypeID#" CFSQLTYPE="cf_sql_integer">
			</cfif>
			
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeType.ChargeType 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="ChargeType">		ORDER BY 	tblChargeType.ChargeType </cfcase>
				<cfcase value="PositionSort">	ORDER BY 	tblChargeType.PositionSort </cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qList>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="Remote" output="false" returntype="struct" DisplayName="Read ChargeType">
		<cfargument name="ChargeType" type="ChargeType" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					tblChargeType.ChargeTypeID,
					tblChargeType.ChargeType,
					tblChargeType.IsActive,
					tblChargeType.PositionSort,
					
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						tblChargeType.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						tblChargeType.Modified_Tmstmp

				FROM	tblChargeType
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeType.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeType.Modified_By = tblUser_2.UserID

				WHERE	
					ChargeTypeID 	= <cfqueryparam value="#arguments.ChargeType.getChargeTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ChargeType.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="Remote" output="false" returntype="boolean" DisplayName="Delete ChargeType">
		<cfargument name="ChargeType" type="ChargeType" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	tblChargeType
			WHERE	ChargeTypeID = <cfqueryparam value="#arguments.ChargeType.getChargeTypeID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="Remote" output="false" returntype="numeric" DisplayName="Create ChargeType">
		<cfargument name="ChargeType"  		 Type="ChargeType" 	Required="true" />
		<cfargument name="OnErrorContinue"   type="String" 		Required="false" 								Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>

			<cflock timeout="5" throwontimeout="Yes" name="inserttblChargeType" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(ChargeTypeID) as MaxID from tblChargeType
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1>
				<cfelse>
					<CFSET MaxID = qMax.MaxID + 1>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO tblChargeType
						(
						ChargeTypeID,	
						ChargeType,	
						IsActive,
						PositionSort,	
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 									CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.ChargeType.getChargeType()#" 	CFSQLType="cf_sql_varchar" />,
						<cfqueryparam value="#arguments.ChargeType.getIsActive()#" 		CFSQLType="cf_sql_char" 	null="#not len(arguments.ChargeType.getIsActive())#" />,
						<cfqueryparam value="#arguments.ChargeType.getPositionSort()#" 	CFSQLType="cf_sql_integer" 	null="#not len(arguments.ChargeType.getPositionSort())#" />,
						<cfqueryparam value="#SESSION.UserID#" 							CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 									CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="ChargeType" type="I" Value="#MaxID#" Desc=" [#arguments.ChargeType.getChargeType()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="ChargeType" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.ChargeType.getChargeType()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a ChargeType" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="ChargeType-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="Remote" output="false" returntype="numeric" DisplayName="Update ChargeType">
		<cfargument name="ChargeType" 		 Type="ChargeType"  Required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	tblChargeType
				SET
					ChargeType 		= <cfqueryparam value="#arguments.ChargeType.getChargeType()#" 			CFSQLType="cf_sql_varchar"  />,
					IsActive 		= <cfqueryparam value="#arguments.ChargeType.getIsActive()#" 			CFSQLType="cf_sql_char"  	null="#not len(arguments.ChargeType.getIsActive())#" />,
					PositionSort 		= <cfqueryparam value="#arguments.ChargeType.getPositionSort()#" 	CFSQLType="CF_SQL_INTEGER"  null="#not len(arguments.ChargeType.getPositionSort())#" />,
					Modified_By 	= <cfqueryparam value="#SESSION.UserID#" 								CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp = <cfqueryparam value="#Now()#" 										CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					ChargeTypeID 	= <cfqueryparam value="#arguments.ChargeType.getChargeTypeID()#" 		CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="ChargeType" type="U" Value="#arguments.ChargeType.getChargeTypeID()#" Desc=" [#arguments.ChargeType.getChargeType()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="ChargeType" type="U" Value="#arguments.ChargeType.getChargeTypeID()#" Desc="Error updating [#arguments.ChargeType.getChargeType()#] (#cfcatch.message#)" />

				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating ChargeType" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeType-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.ChargeType.getChargeTypeID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="Remote" output="false" returntype="boolean" DisplayName="Delete ChargeType">
		<cfargument name="ChargeType" type="ChargeType" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	tblChargeType 
				WHERE	ChargeTypeID = <cfqueryparam value="#arguments.ChargeType.getChargeTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="ChargeType" type="D" Value="#arguments.ChargeType.getChargeTypeID()#" Desc=" [#ARGUMENTS.ChargeType.getChargeType()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="ChargeType" type="D" Value="#arguments.ChargeType.getChargeTypeID()#" Desc="Error deleting [#ARGUMENTS.ChargeType.getChargeType()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a ChargeType" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeType-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Save - ChargeType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="Remote" output="false" returntype="numeric" DisplayName="Save ChargeType">
		<cfargument name="ChargeType" type="ChargeType" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.ChargeType)>
			<cfset pkID = update(arguments.ChargeType) />
		<cfelse>
			<cfset pkID = create(arguments.ChargeType) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - ChargeType
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
