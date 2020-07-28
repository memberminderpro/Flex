<cfcomponent displayname="ChargeItemDetailDAO" hint="table ID column = ChargeItemDetailID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - ChargeItemDetail Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="public" output="false" returntype="ChargeItemDetailDAO">
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
	View - ChargeItemDetail
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="remote" output="false" returntype="Query" DisplayName="View ChargeItemDetail">
		<cfargument Name="ChargeItemDetailID"   Type="Numeric"  	Required="No" 	Hint="ChargeItemDetailID">
		<cfargument Name="Override"         		 Type="String"  	Required="No" 	Hint="Override" 				Default="N">
		<cfargument Name="Filter" 	         	 Type="String"  	Required="No" 	Hint="Filter" 					Default="">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 					Default="">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				tblChargeItemDetail.ChargeItemDetailID,
				tblChargeItemDetail.ChargeItemDetail,
				tblChargeItemDetail.ChargeItemID,
				tblChargeItemDetail.Amount,
				tblChargeItemDetail.DateFrom,
				tblChargeItemDetail.DateTo,
							
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					tblChargeItemDetail.Created_Tmstmp,
							
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
					tblChargeItemDetail.Modified_Tmstmp
				
			FROM	tblChargeItemDetail
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeItemDetail.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeItemDetail.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1
			AND		tblChargeItemDetail.ChargeItemDetailID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemDetailID#" CFSQLTYPE="CF_SQL_INTEGER">
					
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeItemDetail.ChargeItemDetail 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>
			
			ORDER BY 	tblChargeItemDetail.ChargeItemDetailID 

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	List - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="List" access="remote" output="false" returntype="Query" DisplayName="List ChargeItemDetail">
		<cfargument Name="ChargeItemDetailID"   Type="Numeric"  	Required="No" 	Hint="ChargeItemDetailID">

		<cfset var qList = "" />
		<cfquery name="qList" datasource="RotaryTest">
			SELECT
				tblChargeItemDetail.ChargeItemDetailID,
				tblChargeItemDetail.ChargeItemDetail,
				tblChargeItemDetail.ChargeItemID,
				tblChargeItemDetail.Amount,
				tblChargeItemDetail.DateFrom,
				tblChargeItemDetail.DateTo,
				tblChargeItemDetail.Created_By,
				tblChargeItemDetail.Created_Tmstmp,
				tblChargeItemDetail.Modified_By,
				tblChargeItemDetail.Modified_Tmstmp
				
			FROM	tblChargeItemDetail
			WHERE 		1 = 1
			AND		tblChargeItemDetail.ChargeItemDetailID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemDetailID#" CFSQLTYPE="CF_SQL_INTEGER">
					
			<CFIF IsDefined("ARGUMENTS.ChargeItemDetailID") AND ARGUMENTS.ChargeItemDetailID GT 0>
				AND 	tblChargeItemDetail.ChargeItemDetailID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemDetailID#" CFSQLTYPE="cf_sql_integer">
			</cfif>
			
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeItemDetail.ChargeItemDetail 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			ORDER BY 	tblChargeItemDetail.ChargeItemDetailID 

		</cfquery>
		<cfreturn qList>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="remote" output="false" returntype="struct" DisplayName="Read ChargeItemDetail">
		<cfargument name="ChargeItemDetail" type="ChargeItemDetail" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					tblChargeItemDetail.ChargeItemDetailID,
					tblChargeItemDetail.ChargeItemDetail,
					tblChargeItemDetail.ChargeItemID,
					tblChargeItemDetail.Amount,
					tblChargeItemDetail.DateFrom,
					tblChargeItemDetail.DateTo,
							
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						tblChargeItemDetail.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						tblChargeItemDetail.Modified_Tmstmp

				FROM	tblChargeItemDetail
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeItemDetail.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeItemDetail.Modified_By = tblUser_2.UserID

				WHERE	ChargeItemDetailID = <cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ChargeItemDetail.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="remote" output="false" returntype="boolean" DisplayName="Delete ChargeItemDetail">
		<cfargument name="ChargeItemDetail" type="ChargeItemDetail" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	tblChargeItemDetail
			WHERE	ChargeItemDetailID = <cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="remote" output="false" returntype="numeric" DisplayName="Create ChargeItemDetail">
		<cfargument name="ChargeItemDetail" 	 type="ChargeItemDetail" 	required="true" />
		<cfargument name="OnErrorContinue"  	type="String" 				required="false" 	Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>

			<cflock timeout="5" throwontimeout="Yes" name="inserttblChargeItemDetail" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(ChargeItemDetailID) as MaxID from tblChargeItemDetail
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 100>
				<cfelse>
					<CFSET MaxID = Max(qMax.MaxID + 1, 100)>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO tblChargeItemDetail
						(
						ChargeItemDetailID,	
						ChargeItemDetail,	
						ChargeItemID,	
						Amount,	
						DateFrom,	
						DateTo,	
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 												CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemDetail()#" 	CFSQLType="cf_sql_varchar" />,
						<cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemID()#" 		CFSQLType="cf_sql_integer" 	 null="#not len(arguments.ChargeItemDetail.getChargeItemID())#" />,
						<cfqueryparam value="#arguments.ChargeItemDetail.getAmount()#" 				CFSQLType="cf_sql_money" 	 null="#not len(arguments.ChargeItemDetail.getAmount())#" />,
						<cfqueryparam value="#arguments.ChargeItemDetail.getDateFrom()#" 			CFSQLType="cf_sql_timestamp" null="#not len(arguments.ChargeItemDetail.getDateFrom())#" />,
						<cfqueryparam value="#arguments.ChargeItemDetail.getDateTo()#" 				CFSQLType="cf_sql_timestamp" null="#not len(arguments.ChargeItemDetail.getDateTo())#" />,
						<cfqueryparam value="#SESSION.UserID#" 										CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 												CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="ChargeItemDetail" type="I" Value="#MaxID#" Desc=" [#arguments.ChargeItemDetail.getChargeItemDetail()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="ChargeItemDetail" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.ChargeItemDetail.getChargeItemDetail()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a ChargeItemDetail" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="ChargeItemDetail-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="remote" output="false" returntype="numeric" DisplayName="Update ChargeItemDetail">
		<cfargument name="ChargeItemDetail" type="ChargeItemDetail" required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	tblChargeItemDetail
				SET
					ChargeItemDetail 	= <cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemDetail()#" 	CFSQLType="cf_sql_varchar"  />,
					ChargeItemID 		= <cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemID()#" 		CFSQLType="cf_sql_integer"  null="#not len(arguments.ChargeItemDetail.getChargeItemID())#" />,
					Amount 				= <cfqueryparam value="#arguments.ChargeItemDetail.getAmount()#" 			CFSQLType="cf_sql_money"  null="#not len(arguments.ChargeItemDetail.getAmount())#" />,
					DateFrom 			= <cfqueryparam value="#arguments.ChargeItemDetail.getDateFrom()#" 			CFSQLType="cf_sql_timestamp"  null="#not len(arguments.ChargeItemDetail.getDateFrom())#" />,
					DateTo 				= <cfqueryparam value="#arguments.ChargeItemDetail.getDateTo()#" 			CFSQLType="cf_sql_timestamp"  null="#not len(arguments.ChargeItemDetail.getDateTo())#" />,
					
					Modified_By 		= <cfqueryparam value="#SESSION.UserID#" 									CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp 	= <cfqueryparam value="#Now()#" 											CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					ChargeItemDetailID 	= <cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="ChargeItemDetail" type="U" Value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" Desc=" [#arguments.ChargeItemDetail.getChargeItemDetail()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="ChargeItemDetail" type="U" Value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" Desc="Error updating [#arguments.ChargeItemDetail.getChargeItemDetail()#] (#cfcatch.message#)" />

				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating ChargeItemDetail" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeItemDetail-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.ChargeItemDetail.getChargeItemDetailID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="remote" output="false" returntype="boolean" DisplayName="Delete ChargeItemDetail">
		<cfargument name="ChargeItemDetail" type="ChargeItemDetail" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	tblChargeItemDetail 
				WHERE	
					ChargeItemDetailID = <cfqueryparam value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="ChargeItemDetail" type="D" Value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" Desc=" [#ARGUMENTS.ChargeItemDetail.getChargeItemDetail()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="ChargeItemDetail" type="D" Value="#arguments.ChargeItemDetail.getChargeItemDetailID()#" Desc="Error deleting [#ARGUMENTS.ChargeItemDetail.getChargeItemDetail()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a ChargeItemDetail" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeItemDetail-delete" />

				<cfreturn false />
			</cfcatch>
		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Save - ChargeItemDetail
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="remote" output="false" returntype="numeric" DisplayName="Save ChargeItemDetail">
		<cfargument name="ChargeItemDetail" type="ChargeItemDetail" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.ChargeItemDetail)>
			<cfset pkID = update(arguments.ChargeItemDetail) />
		<cfelse>
			<cfset pkID = create(arguments.ChargeItemDetail) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - ChargeItemDetail
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
