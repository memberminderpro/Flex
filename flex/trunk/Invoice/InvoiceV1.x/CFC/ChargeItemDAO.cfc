<cfcomponent displayname="ChargeItemDAO" hint="table ID column = ChargeItemID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - ChargeItem Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="Remote" output="false" returntype="ChargeItemDAO">
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
	Count - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Count" access="Remote" output="false" returntype="Numeric" DisplayName="Count ChargeItem">
		<cfargument Name="ChargeItem"        Type="string"  	Required="Yes" 	Hint="ChargeItem">
		<cfargument Name="ClubID"          	 Type="Numeric"  	Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">

		<cfset var qCount = "" />
		<cfquery name="qCount" datasource="RotaryTest">
			SELECT Count(*) As Cnt
			FROM	tblChargeItem

			WHERE 		1 = 1
			AND			tblChargeItem.ClubID 		= <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<CFIF Len(ARGUMENTS.ChargeItem) GT 0>
				AND 	tblChargeItem.ChargeItem 	= <CFQUERYPARAM Value="#ARGUMENTS.ChargeItem#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
		</cfquery>

		<cfif qCount.RecordCount GT 0>
			<cfset Count = qCount.Cnt>
		<cfelse>	
			<cfset Count = 0>
		</cfif>
		<cfreturn Count>

	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Pick - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Pick" access="Remote" output="false" returntype="Query" DisplayName="Pick ChargeItem">
		<cfargument Name="ClubID"          	 	Type="Numeric"  Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         	Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	         	Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	         	Type="String"  	Required="No" 	Hint="SortBy" 				Default="ChargeItemID">

		<cfset var qPick = "" />
		<cfquery name="qPick" datasource="RotaryTest">
			SELECT
				ChargeItemID,
				ChargeItem
			FROM	tblChargeItem

			WHERE 		1 = 1
			AND		tblChargeItem.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	IsActive 	<> 'N'
			</cfif>

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeItem.ChargeItem 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			ORDER BY 	#ARGUMENTS.SortBy#
		</cfquery>
		<cfreturn qPick>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Lookup - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="Remote" output="false" returntype="Query" DisplayName="Lookup ChargeItem">
		<cfargument Name="ClubID"          	Type="Numeric"  Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  	Required="No" 	Hint="SortBy" 				Default="ChargeItemID">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
			SELECT
				tblChargeItem.ChargeItemID,
				tblChargeItem.ChargeItem,
				tblChargeItem.ChargeTypeID,
				tblChargeItem.ClubID,
				tblChargeItem.IsActive,
				tblChargeItem.Amount,
				tblChargeItem.TaxPercent,
				tblChargeItem.TaxMin,
				tblChargeItem.TaxMax,
				tblChargeItem.Created_By,
				tblChargeItem.Created_Tmstmp,
				tblChargeItem.Modified_By,
				tblChargeItem.Modified_Tmstmp
				
			FROM	tblChargeItem

			WHERE 		1 = 1
			AND		tblChargeItem.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	IsActive 	<> 'N'
			</cfif>

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeItem.ChargeItemID 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="ChargeItem">		ORDER BY 	tblChargeItem.ChargeItem 	</cfcase>
				<cfcase value="ChargeItemID">	ORDER BY 	tblChargeItem.ChargeItemID 	</cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qLookup>
	</cffunction>
	
	

<!--- ----------------------------------------------------------------------------------------------------------------
	View - ChargeItem
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="Remote" output="false" returntype="Query" DisplayName="View ChargeItem">
		<cfargument Name="ClubID"          	Type="Numeric"  Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  	Required="No" 	Hint="SortBy" 				Default="ChargeItemID">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
SELECT     dbo.tblChargeItem.ChargeItemID, dbo.tblChargeItem.ChargeItem, dbo.tblChargeItem.ChargeTypeID, dbo.tblChargeItem.ClubID, dbo.tblChargeItem.IsActive, 
                      dbo.tblChargeItem.Amount, dbo.tblChargeItem.TaxPercent, dbo.tblChargeItem.TaxMin, dbo.tblChargeItem.TaxMax, 
                      tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By, dbo.tblChargeItem.Created_Tmstmp, tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
                       dbo.tblChargeItem.Modified_Tmstmp, dbo.tblChargeType.ChargeType
FROM         dbo.tblChargeItem INNER JOIN
                      dbo.tblChargeType ON dbo.tblChargeItem.ChargeTypeID = dbo.tblChargeType.ChargeTypeID LEFT OUTER JOIN
                      dbo.tblUser AS tblUser_1 ON dbo.tblChargeItem.Created_By = tblUser_1.UserID LEFT OUTER JOIN
                      dbo.tblUser AS tblUser_2 ON dbo.tblChargeItem.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1
			AND		tblChargeItem.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	tblChargeItem.IsActive 	<> 'N'
			</cfif>

					
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeItem.ChargeItem 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>
			
			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="ChargeItem">		ORDER BY 	tblChargeItem.ChargeItem 	</cfcase>
				<cfcase value="ChargeItemID">	ORDER BY 	tblChargeItem.ChargeItemID 	</cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	List - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="List" access="Remote" output="false" returntype="Query" DisplayName="List ChargeItem">
		<cfargument name="ChargeItemID" type="numeric" required="false" />
		<cfargument Name="ClubID"          	Type="Numeric"  Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  	Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"  	Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  	Required="No" 	Hint="SortBy" 				Default="ChargeItemID">

		<cfset var qList = "" />
		<cfquery name="qList" datasource="RotaryTest">
			SELECT
				tblChargeItem.ChargeItemID,
				tblChargeItem.ChargeItem,
				tblChargeItem.ChargeTypeID,
				tblChargeItem.ClubID,
				tblChargeItem.IsActive,
				tblChargeItem.Amount,
				tblChargeItem.TaxPercent,
				tblChargeItem.TaxMin,
				tblChargeItem.TaxMax,
				tblChargeItem.Created_By,
				tblChargeItem.Created_Tmstmp,
				tblChargeItem.Modified_By,
				tblChargeItem.Modified_Tmstmp
				
			FROM	tblChargeItem

			WHERE 		1 = 1
			AND		tblChargeItem.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	IsActive 	<> 'N'
			</cfif>

					
			<CFIF IsDefined("ARGUMENTS.ChargeItemID") AND ARGUMENTS.ChargeItemID GT 0>
				AND 	tblChargeItem.ChargeItemID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemID#" CFSQLTYPE="cf_sql_integer">
			</cfif>
			
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	tblChargeItem.ChargeItem 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="ChargeItem">		ORDER BY 	tblChargeItem.ChargeItem 	</cfcase>
				<cfcase value="ChargeItemID">	ORDER BY 	tblChargeItem.ChargeItemID 	</cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qList>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="Remote" output="false" returntype="struct" DisplayName="Read ChargeItem">
		<cfargument name="ChargeItem" type="ChargeItem" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					tblChargeItem.ChargeItemID,
					tblChargeItem.ChargeItem,
					tblChargeItem.ChargeTypeID,
					tblChargeItem.ClubID,
					tblChargeItem.IsActive,
					tblChargeItem.Amount,
					tblChargeItem.TaxPercent,
					tblChargeItem.TaxMin,
					tblChargeItem.TaxMax,
							
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						tblChargeItem.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						tblChargeItem.Modified_Tmstmp

				FROM	tblChargeItem
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeItem.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeItem.Modified_By = tblUser_2.UserID

				WHERE	
					ChargeItemID 	= <cfqueryparam value="#arguments.ChargeItem.getChargeItemID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ChargeItem.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="Remote" output="false" returntype="boolean" DisplayName="Delete ChargeItem">
		<cfargument name="ChargeItem" type="ChargeItem" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	tblChargeItem
			WHERE	
				ChargeItemID 	= <cfqueryparam value="#arguments.ChargeItem.getChargeItemID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="Remote" output="false" returntype="numeric" DisplayName="Create ChargeItem">
		<cfargument name="ChargeItem"  type="ChargeItem" required="true" />
		<cfargument name="OnErrorContinue"  type="String" required="false" Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>

			<cflock timeout="5" throwontimeout="Yes" name="inserttblChargeItem" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(ChargeItemID) as MaxID from tblChargeItem
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1>
				<cfelse>
					<CFSET MaxID = qMax.MaxID + 1>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO tblChargeItem
						(
						ChargeItemID,	
						ChargeItem,	
						ChargeTypeID,	
						ClubID,	
						IsActive,	
						Amount,	
						TaxPercent,	
						TaxMin,	
						TaxMax,	
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 										CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.ChargeItem.getChargeItem()#" 		CFSQLType="cf_sql_varchar" />,
						<cfqueryparam value="#arguments.ChargeItem.getChargeTypeID()#" 		CFSQLType="cf_sql_integer" null="#not len(arguments.ChargeItem.getChargeTypeID())#" />,
						<cfqueryparam value="#arguments.ChargeItem.getClubID()#" 			CFSQLType="cf_sql_integer" null="#not len(arguments.ChargeItem.getClubID())#" />,
						<cfqueryparam value="#arguments.ChargeItem.getIsActive()#" 			CFSQLType="cf_sql_char" null="#not len(arguments.ChargeItem.getIsActive())#" />,
						<cfqueryparam value="#arguments.ChargeItem.getAmount()#" 			CFSQLType="cf_sql_money" null="#not len(arguments.ChargeItem.getAmount())#" />,
						<cfqueryparam value="#arguments.ChargeItem.getTaxPercent()#" 		CFSQLType="cf_sql_decimal" null="#not len(arguments.ChargeItem.getTaxPercent())#" />,
						<cfqueryparam value="#arguments.ChargeItem.getTaxMin()#" 			CFSQLType="cf_sql_money" null="#not len(arguments.ChargeItem.getTaxMin())#" />,
						<cfqueryparam value="#arguments.ChargeItem.getTaxMax()#" 			CFSQLType="cf_sql_money" null="#not len(arguments.ChargeItem.getTaxMax())#" />,
						<cfqueryparam value="#SESSION.UserID#" 								CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 										CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="ChargeItem" type="I" Value="#MaxID#" Desc=" [#arguments.ChargeItem.getChargeItem()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="ChargeItem" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.ChargeItem.getChargeItem()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a ChargeItem" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="ChargeItem-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="Remote" output="false" returntype="numeric" DisplayName="Update ChargeItem">
		<cfargument name="ChargeItem" type="ChargeItem" required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	tblChargeItem
				SET
					ChargeItem 		= <cfqueryparam value="#arguments.ChargeItem.getChargeItem()#" 		CFSQLType="cf_sql_varchar"  />,
					ChargeTypeID 	= <cfqueryparam value="#arguments.ChargeItem.getChargeTypeID()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.ChargeItem.getChargeTypeID())#" />,
					ClubID 			= <cfqueryparam value="#arguments.ChargeItem.getClubID()#" 			CFSQLType="cf_sql_integer"  null="#not len(arguments.ChargeItem.getClubID())#" />,
					IsActive 		= <cfqueryparam value="#arguments.ChargeItem.getIsActive()#" 		CFSQLType="cf_sql_char"  	null="#not len(arguments.ChargeItem.getIsActive())#" />,
					Amount 			= <cfqueryparam value="#arguments.ChargeItem.getAmount()#" 			CFSQLType="cf_sql_money"  	null="#not len(arguments.ChargeItem.getAmount())#" />,
					TaxPercent 		= <cfqueryparam value="#arguments.ChargeItem.getTaxPercent()#" 		CFSQLType="cf_sql_decimal"  null="#not len(arguments.ChargeItem.getTaxPercent())#" />,
					TaxMin 			= <cfqueryparam value="#arguments.ChargeItem.getTaxMin()#" 			CFSQLType="cf_sql_money"  	null="#not len(arguments.ChargeItem.getTaxMin())#" />,
					TaxMax 			= <cfqueryparam value="#arguments.ChargeItem.getTaxMax()#" 			CFSQLType="cf_sql_money"  	null="#not len(arguments.ChargeItem.getTaxMax())#" />,
					
					Modified_By 	= <cfqueryparam value="#SESSION.UserID#" 							CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp = <cfqueryparam value="#Now()#" 									CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					ChargeItemID 	= <cfqueryparam value="#arguments.ChargeItem.getChargeItemID()#" 	CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="ChargeItem" type="U" Value="#arguments.ChargeItem.getChargeItemID()#" Desc=" [#arguments.ChargeItem.getChargeItem()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="ChargeItem" type="U" Value="#arguments.ChargeItem.getChargeItemID()#" Desc="Error updating [#arguments.ChargeItem.getChargeItem()#] (#cfcatch.message#)" />

				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating ChargeItem" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeItem-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.ChargeItem.getChargeItemID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - ChargeItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="Remote" output="false" returntype="boolean" DisplayName="Delete ChargeItem">
		<cfargument name="ChargeItem" type="ChargeItem" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	tblChargeItem 
				WHERE	ChargeItemID = <cfqueryparam value="#arguments.ChargeItem.getChargeItemID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="ChargeItem" type="D" Value="#arguments.ChargeItem.getChargeItemID()#" Desc=" [#ARGUMENTS.ChargeItem.getChargeItem()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="ChargeItem" type="D" Value="#arguments.ChargeItem.getChargeItemID()#" Desc="Error deleting [#ARGUMENTS.ChargeItem.getChargeItem()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a ChargeItem" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeItem-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - ChargeItem
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
