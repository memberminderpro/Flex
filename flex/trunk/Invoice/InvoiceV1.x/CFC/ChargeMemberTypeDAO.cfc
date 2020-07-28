<cfcomponent displayname="ChargeMemberTypeDAO" hint="table ID column = ChargeMemberTypeID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - ChargeMemberType Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="public" output="false" returntype="ChargeMemberTypeDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

<!--------------------------------------------------------------------------------------------
	getVariablesScope - Return variable Scope
	
	Entry Conditions:
		None
---------------------------------------------------------------------------------------------->
	<cffunction name="getVariablesScope" access="public" output="false" returntype="struct">
      <cfreturn variables />
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Pick - ChargeMemberType - Looks up the MemberType charges by using the ChargeItemID.  
		   Sort by MemberTypeID
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Pick" access="public" output="false" returntype="Query" DisplayName="Pick ChargeMemberType">
		<cfargument Name="ChargeItemID"          Type="Numeric"  	Required="Yes" 	Hint="ChargeItemID">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 				Default="MemberTypeID">

		<cfset var qPick = "" />
		<cfquery name="qPick" datasource="RotaryTest">
			SELECT 	ChargeMemberTypeID, MemberTypeID, Amount
			FROM	tblChargeMemberType

			WHERE 		1 = 1
			AND 		tblChargeMemberType.ChargeItemID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemID#" CFSQLTYPE="CF_SQL_INTEGER">

			ORDER BY 	#ARGUMENTS.SortBy#
		</cfquery>
		<cfreturn qPick>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Lookup - ChargeMemberType - Returns the full record with timestamps.  Otherwise, same as pick
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="public" output="false" returntype="Query" DisplayName="Lookup ChargeMemberType">
		<cfargument Name="ChargeItemID"          Type="Numeric"  	Required="Yes" 	Hint="ChargeItemID">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 				Default="PositionSort">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
SELECT     dbo.tblChargeMemberType.ChargeMemberTypeID, dbo.tblChargeMemberType.ChargeItemID, dbo.tblChargeMemberType.MemberTypeID, 
                      dbo.tblMemberType.MemberType, dbo.tblChargeMemberType.Amount
FROM         dbo.tblChargeMemberType INNER JOIN
                      dbo.tblMemberType ON dbo.tblChargeMemberType.MemberTypeID = dbo.tblMemberType.MemberTypeID

			WHERE 		1 = 1
			AND 		tblChargeMemberType.ChargeItemID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="PositionSort">ORDER BY 	tblMemberType.PositionSort </cfcase>
				<cfcase value="MemberTypeID">ORDER BY 	tblChargeMemberType.MemberTypeID </cfcase>
			</cfswitch>
		</cfquery>
		<cfif qLookup.RecordCount EQ 0>
			<cfquery name="qLookup" datasource="RotaryTest">
				SELECT     0 AS ChargememberTypeID, 0 AS ChargeItemID, MemberTypeID, MemberType, 0 AS Amount
FROM         dbo.tblMemberType

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="PositionSort">ORDER BY 	tblMemberType.PositionSort </cfcase>
			</cfswitch>
		</cfquery>
		</cfif>
		<cfreturn qLookup>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Lookup - getChargeMemberType - Returns the full record with timestamps.  Otherwise, same as pick
	Modifications
	<cffunction name="Lookup" access="public" output="false" returntype="Query" DisplayName="Lookup ChargeMemberType">
		<cfargument Name="ChargeItemID"          Type="Numeric"  	Required="Yes" 	Hint="ChargeItemID">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 				Default="PositionSort">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
SELECT     dbo.tblChargeMemberType.ChargeMemberTypeID, dbo.tblChargeMemberType.ChargeItemID, dbo.tblChargeMemberType.MemberTypeID, 
                      dbo.tblMemberType.MemberType, dbo.tblChargeMemberType.Amount, dbo.tblChargeMemberType.Created_By, dbo.tblChargeMemberType.Created_Tmstmp, 
                      dbo.tblChargeMemberType.Modified_By, dbo.tblChargeMemberType.Modified_Tmstmp, dbo.tblMemberType.PositionSort
FROM         dbo.tblChargeMemberType INNER JOIN
                      dbo.tblMemberType ON dbo.tblChargeMemberType.MemberTypeID = dbo.tblMemberType.MemberTypeID

			WHERE 		1 = 1
			AND 		tblChargeMemberType.ChargeItemID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="PositionSort">ORDER BY 	tblMemberType.PositionSort </cfcase>
				<cfcase value="MemberTypeID">ORDER BY 	tblChargeMemberType.MemberTypeID </cfcase>
			</cfswitch>
		</cfquery>
		<cfreturn qLookup>
	</cffunction>
---------------------------------------------------------------------------------------------------------------------->
	
	
<!--- ----------------------------------------------------------------------------------------------------------------
	View - ChargeMemberType
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="public" output="false" returntype="Query" DisplayName="View ChargeMemberType">
		<cfargument Name="ChargeItemID"          Type="Numeric"  	Required="No" 	Hint="ChargeItemID">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="SortBy" 				Default="MemberTypeID">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				tblChargeMemberType.ChargeMemberTypeID,
				tblChargeMemberType.ChargeItemID,
				tblChargeMemberType.MemberTypeID,
				tblChargeMemberType.Amount,
							
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					tblChargeMemberType.Created_Tmstmp,
							
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
					tblChargeMemberType.Modified_Tmstmp
				
			FROM	tblChargeMemberType
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeMemberType.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeMemberType.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1
			AND 		tblChargeMemberType.ChargeItemID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="MemberTypeID">ORDER BY 	tblChargeMemberType.MemberTypeID </cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	List - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="List" access="public" output="false" returntype="Query" DisplayName="List ChargeMemberType">
		<cfargument Name="ChargeItemID"          Type="Numeric"  	Required="No" 	Hint="ChargeItemID">
		<cfargument Name="SortBy" 	         	 Type="String"  	Required="No" 	Hint="PositionSort" 					Default="">

		<cfset var qList = "" />
		<cfquery name="qList" datasource="RotaryTest">
SELECT     dbo.tblChargeMemberType.ChargeMemberTypeID, dbo.tblChargeMemberType.ChargeItemID, dbo.tblChargeMemberType.MemberTypeID, 
                      dbo.tblChargeMemberType.Amount, dbo.tblChargeMemberType.Created_By, dbo.tblChargeMemberType.Created_Tmstmp, dbo.tblChargeMemberType.Modified_By, 
                      dbo.tblChargeMemberType.Modified_Tmstmp, dbo.tblMemberType.MemberType, dbo.tblMemberType.PositionSort
FROM         dbo.tblChargeMemberType INNER JOIN
                      dbo.tblMemberType ON dbo.tblChargeMemberType.MemberTypeID = dbo.tblMemberType.MemberTypeID
					  					  
			WHERE 		1 = 1
			AND 		tblChargeMemberType.ChargeItemID = <CFQUERYPARAM Value="#ARGUMENTS.ChargeItemID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="PositionSort">ORDER BY 	dbo.tblMemberType.PositionSort </cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn qList>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="public" output="false" returntype="struct" DisplayName="Read ChargeMemberType">
		<cfargument name="ChargeMemberType" type="ChargeMemberType" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					tblChargeMemberType.ChargeMemberTypeID,
					tblChargeMemberType.ChargeItemID,
					tblChargeMemberType.MemberTypeID,
					tblChargeMemberType.Amount,
							
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						tblChargeMemberType.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						tblChargeMemberType.Modified_Tmstmp

				FROM	tblChargeMemberType
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON tblChargeMemberType.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON tblChargeMemberType.Modified_By = tblUser_2.UserID

				WHERE	ChargeMemberTypeID = <cfqueryparam value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.ChargeMemberType.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="public" output="false" returntype="boolean" DisplayName="Delete ChargeMemberType">
		<cfargument name="ChargeMemberType" type="ChargeMemberType" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	tblChargeMemberType
			WHERE	ChargeMemberTypeID = <cfqueryparam value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="public" output="false" returntype="numeric" DisplayName="Create ChargeMemberType">
		<cfargument name="ChargeMemberType"  type="ChargeMemberType" required="true" />
		<cfargument name="OnErrorContinue"  type="String" required="false" Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>

			<cflock timeout="5" throwontimeout="Yes" name="inserttblChargeMemberType" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(ChargeMemberTypeID) as MaxID from tblChargeMemberType
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1>
				<cfelse>
					<CFSET MaxID = qMax.MaxID + 1>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO tblChargeMemberType
						(
						ChargeMemberTypeID,	
						ChargeItemID,	
						MemberTypeID,	
						Amount,	
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.ChargeMemberType.getChargeItemID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ChargeMemberType.getChargeItemID())#" />,
						<cfqueryparam value="#arguments.ChargeMemberType.getMemberTypeID()#" CFSQLType="cf_sql_integer" null="#not len(arguments.ChargeMemberType.getMemberTypeID())#" />,
						<cfqueryparam value="#arguments.ChargeMemberType.getAmount()#" CFSQLType="cf_sql_money" null="#not len(arguments.ChargeMemberType.getAmount())#" />,
						<cfqueryparam value="#SESSION.UserID#" CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="ChargeMemberType" type="I" Value="#MaxID#" Desc=" [#arguments.ChargeMemberType.getChargeItemID()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="ChargeMemberType" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.ChargeMemberType.getChargeItemID()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a ChargeMemberType" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="ChargeMemberType-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	UpdateQ - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="UpdateQ" access="public" output="false" returntype="numeric" DisplayName="Update ChargeMemberType">
		<cfargument name="ChargeMemberTypeQ"  	type="query" required="true" 	Hint="Query for Multiple Updates"/>

		<cfoutput query="ChargeMemberTypeQ">
			<cfinvoke component="ChargeMemberType" method="init" returnvariable="ChargeMemberTypeObj">
				<cfinvokeargument name="ChargeMemberTypeID"	Value="#ChargeMemberTypeID#" />
				<cfinvokeargument name="ChargeItemID"		Value="#ChargeItemID#" />
				<cfinvokeargument name="MemberTypeID"		Value="#MemberTypeID#" />
				<cfinvokeargument name="Amount"				Value="#Amount#" />
			</cfinvoke>
			<cfset RC = Update( ChargeMemberTypeObj, "Y" ) />
		</cfoutput>

		<cfreturn TRUE />
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Update - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="public" output="false" returntype="numeric" DisplayName="Update ChargeMemberType">
		<cfargument name="ChargeMemberType" type="ChargeMemberType" required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	tblChargeMemberType
				SET
					ChargeItemID 		= <cfqueryparam value="#arguments.ChargeMemberType.getChargeItemID()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.ChargeMemberType.getChargeItemID())#" />,
					MemberTypeID		= <cfqueryparam value="#arguments.ChargeMemberType.getMemberTypeID()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.ChargeMemberType.getMemberTypeID())#" />,
					Amount 				= <cfqueryparam value="#arguments.ChargeMemberType.getAmount()#" 		CFSQLType="cf_sql_money"  	null="#not len(arguments.ChargeMemberType.getAmount())#" />,
					Modified_By 		= <cfqueryparam value="#SESSION.UserID#" 								CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp 	= <cfqueryparam value="#Now()#" 										CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					ChargeMemberTypeID = <cfqueryparam value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="ChargeMemberType" type="U" Value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" Desc=" [#arguments.ChargeMemberType.getChargeItemID()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="ChargeMemberType" type="U" Value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" Desc="Error updating [#arguments.ChargeMemberType.getChargeItemID()#] (#cfcatch.message#)" />

				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating ChargeMemberType" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeMemberType-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.ChargeMemberType.getChargeMemberTypeID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="public" output="false" returntype="boolean" DisplayName="Delete ChargeMemberType">
		<cfargument name="ChargeMemberType" type="ChargeMemberType" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	tblChargeMemberType 
				WHERE	ChargeMemberTypeID = <cfqueryparam value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="ChargeMemberType" type="D" Value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" Desc=" [#ARGUMENTS.ChargeMemberType.getChargeItemID()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="ChargeMemberType" type="D" Value="#arguments.ChargeMemberType.getChargeMemberTypeID()#" Desc="Error deleting [#ARGUMENTS.ChargeMemberType.getChargeItemID()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a ChargeMemberType" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="ChargeMemberType-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	SaveQ - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="SaveQ" access="public" output="false" returntype="numeric" DisplayName="Save ChargeMemberType">
		<cfargument name="ChargeMemberTypeQ"  	type="query" required="true" 	Hint="Query for Multiple Updates"/>
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfoutput query="ChargeMemberTypeQ">
			<cfinvoke component="ChargeMemberType" method="init" returnvariable="ChargeMemberType">
				<cfinvokeargument name="ChargeMemberTypeID"	Value="#ChargeMemberTypeID#" />
				<cfinvokeargument name="ChargeItemID"		Value="#ChargeItemID#" />
				<cfinvokeargument name="MemberTypeID"		Value="#MemberTypeID#" />
				<cfinvokeargument name="Amount"				Value="#Amount#" />
			</cfinvoke>

			<cfif exists(ChargeMemberType)>
				<cfset pkID = update(ChargeMemberType) />
			<cfelse>
				<cfset pkID = create(ChargeMemberType) />
			</cfif>

		</cfoutput>

		<cfreturn TRUE />
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Save - ChargeMemberType
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="public" output="false" returntype="numeric" DisplayName="Save ChargeMemberType">
		<cfargument name="ChargeMemberType" type="ChargeMemberType" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.ChargeMemberType)>
			<cfset pkID = update(arguments.ChargeMemberType) />
		<cfelse>
			<cfset pkID = create(arguments.ChargeMemberType) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - ChargeMemberType
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
