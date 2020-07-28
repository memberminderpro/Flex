<cfcomponent displayname="InvoiceItemDAO" hint="table ID column = InvoiceItemID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - InvoiceItem Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="public" output="false" returntype="InvoiceItemDAO">
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
	Lookup - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="remote" output="false" returntype="Query" DisplayName="Lookup InvoiceItem">
		<cfargument Name="InvoiceItemID"         Type="Numeric"  	Required="No" 	Hint="InvoiceItemID"	Default="0">
		<cfargument Name="InvoiceID"         	 Type="Numeric"  	Required="No" 	Hint="InvoiceID"		Default="0">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
			SELECT
				GL_InvoiceItem.InvoiceItemID,
				GL_InvoiceItem.InvoiceID,
				GL_InvoiceItem.Description,
				GL_InvoiceItem.GL_AccountID,
				GL_InvoiceItem.Qty,
				GL_InvoiceItem.Rate,
				GL_InvoiceItem.Amount,
				GL_InvoiceItem.Created_By,
				GL_InvoiceItem.Created_Tmstmp,
				GL_InvoiceItem.Modified_By,
				GL_InvoiceItem.Modified_Tmstmp
			FROM	GL_InvoiceItem

			WHERE 		1 = 1
	
			<CFIF ARGUMENTS.InvoiceItemID GT 0>
				AND 	GL_InvoiceItem.InvoiceItemID 	= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceItemID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
			<CFIF ARGUMENTS.InvoiceID GT 0>
				AND 	GL_InvoiceItem.InvoiceID 		= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>

			ORDER BY 	GL_InvoiceItem.InvoiceItemID
			
		</cfquery>
		<cfreturn qLookup>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	View - InvoiceItem
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="remote" output="false" returntype="Query" DisplayName="View InvoiceItem">
		<cfargument Name="InvoiceItemID"         Type="Numeric"  	Required="No" 	Hint="InvoiceItemID"	Default="0">
		<cfargument Name="InvoiceID"         	 Type="Numeric"  	Required="No" 	Hint="InvoiceID"		Default="0">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				GL_InvoiceItem.InvoiceItemID,
				GL_InvoiceItem.InvoiceID,
				GL_InvoiceItem.Description,
				GL_InvoiceItem.GL_AccountID,
				GL_InvoiceItem.Qty,
				GL_InvoiceItem.Rate,
				GL_InvoiceItem.Amount,
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					GL_InvoiceItem.Created_Tmstmp,
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
					GL_InvoiceItem.Modified_Tmstmp
				
			FROM	GL_InvoiceItem
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON GL_InvoiceItem.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON GL_InvoiceItem.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1
			<CFIF ARGUMENTS.InvoiceItemID GT 0>
				AND 	GL_InvoiceItem.InvoiceItemID 	= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceItemID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
			<CFIF ARGUMENTS.InvoiceID GT 0>
				AND 	GL_InvoiceItem.InvoiceID 		= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>

			ORDER BY 	GL_InvoiceItem.InvoiceItemID

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="remote" output="false" returntype="struct" DisplayName="Read InvoiceItem">
		<cfargument name="InvoiceItem" type="InvoiceItem" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					GL_InvoiceItem.InvoiceItemID,
					GL_InvoiceItem.InvoiceID,
					GL_InvoiceItem.Description,
					GL_InvoiceItem.GL_AccountID,
					GL_InvoiceItem.Qty,
					GL_InvoiceItem.Rate,
					GL_InvoiceItem.Amount,
							
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						GL_InvoiceItem.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						GL_InvoiceItem.Modified_Tmstmp

				FROM	GL_InvoiceItem
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON GL_InvoiceItem.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON GL_InvoiceItem.Modified_By = tblUser_2.UserID

				WHERE	InvoiceItemID = <cfqueryparam value="#arguments.InvoiceItem.getInvoiceItemID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.InvoiceItem.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="remote" output="false" returntype="boolean" DisplayName="Delete InvoiceItem">
		<cfargument name="InvoiceItem" type="InvoiceItem" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	GL_InvoiceItem
			WHERE	InvoiceItemID = <cfqueryparam value="#arguments.InvoiceItem.getInvoiceItemID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="remote" output="false" returntype="numeric" DisplayName="Create InvoiceItem">
		<cfargument name="InvoiceItem"  type="InvoiceItem" required="true" />
		<cfargument name="OnErrorContinue"  type="String" required="false" Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>

			<cflock timeout="5" throwontimeout="Yes" name="insertGL_InvoiceItem" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(InvoiceItemID) as MaxID from GL_InvoiceItem
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1>
				<cfelse>
					<CFSET MaxID = qMax.MaxID + 1>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO GL_InvoiceItem
						(
						InvoiceItemID,	
						InvoiceID,	
						Description,	
						GL_AccountID,	
						Qty,	
						Rate,	
						Amount,	
						
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 										CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.InvoiceItem.getInvoiceID()#" 		CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.InvoiceItem.getDescription()#" 		CFSQLType="cf_sql_varchar" null="#not len(arguments.InvoiceItem.getDescription())#" />,
						<cfqueryparam value="#arguments.InvoiceItem.getGL_AccountID()#" 	CFSQLType="cf_sql_integer" null="#not len(arguments.InvoiceItem.getGL_AccountID())#" />,
						<cfqueryparam value="#arguments.InvoiceItem.getQty()#" 				CFSQLType="cf_sql_integer" null="#not len(arguments.InvoiceItem.getQty())#" />,
						<cfqueryparam value="#arguments.InvoiceItem.getRate()#" 			CFSQLType="cf_sql_money" null="#not len(arguments.InvoiceItem.getRate())#" />,
						<cfqueryparam value="#arguments.InvoiceItem.getAmount()#" 			CFSQLType="cf_sql_money" null="#not len(arguments.InvoiceItem.getAmount())#" />,
						<cfqueryparam value="#SESSION.UserID#" 								CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 										CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="InvoiceItem" type="I" Value="#MaxID#" Desc=" [#arguments.InvoiceItem.getInvoiceID()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="InvoiceItem" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.InvoiceItem.getInvoiceID()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a InvoiceItem" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="InvoiceItem-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="remote" output="false" returntype="numeric" DisplayName="Update InvoiceItem">
		<cfargument name="InvoiceItem" type="InvoiceItem" required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	GL_InvoiceItem
				SET
					InvoiceID 		= <cfqueryparam value="#arguments.InvoiceItem.getInvoiceID()#" 		CFSQLType="cf_sql_integer"  />,
					Description 	= <cfqueryparam value="#arguments.InvoiceItem.getDescription()#" 	CFSQLType="cf_sql_varchar"  null="#not len(arguments.InvoiceItem.getDescription())#" />,
					GL_AccountID 	= <cfqueryparam value="#arguments.InvoiceItem.getGL_AccountID()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.InvoiceItem.getGL_AccountID())#" />,
					Qty 			= <cfqueryparam value="#arguments.InvoiceItem.getQty()#" 			CFSQLType="cf_sql_integer"  null="#not len(arguments.InvoiceItem.getQty())#" />,
					Rate 			= <cfqueryparam value="#arguments.InvoiceItem.getRate()#" 			CFSQLType="cf_sql_money"  	null="#not len(arguments.InvoiceItem.getRate())#" />,
					Amount 			= <cfqueryparam value="#arguments.InvoiceItem.getAmount()#" 		CFSQLType="cf_sql_money"  	null="#not len(arguments.InvoiceItem.getAmount())#" />,
					Modified_By 	= <cfqueryparam value="#SESSION.UserID#" 							CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp = <cfqueryparam value="#Now()#" 									CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
				InvoiceItemID = <cfqueryparam value="#arguments.InvoiceItem.getInvoiceItemID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="InvoiceItem" type="U" Value="#arguments.InvoiceItem.getInvoiceItemID()#" Desc=" [#arguments.InvoiceItem.getInvoiceID()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="InvoiceItem" type="U" Value="#arguments.InvoiceItem.getInvoiceItemID()#" Desc="Error updating [#arguments.InvoiceItem.getInvoiceID()#] (#cfcatch.message#)" />
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating InvoiceItem" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="InvoiceItem-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.InvoiceItem.getInvoiceItemID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="remote" output="false" returntype="boolean" DisplayName="Delete InvoiceItem">
		<cfargument name="InvoiceItem" type="InvoiceItem" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	GL_InvoiceItem 
				WHERE	
					InvoiceItemID 	= <cfqueryparam value="#arguments.InvoiceItem.getInvoiceItemID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="InvoiceItem" type="D" Value="#arguments.InvoiceItem.getInvoiceItemID()#" Desc=" [#ARGUMENTS.InvoiceItem.getInvoiceID()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="InvoiceItem" type="D" Value="#arguments.InvoiceItem.getInvoiceItemID()#" Desc="Error deleting [#ARGUMENTS.InvoiceItem.getInvoiceID()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a InvoiceItem" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="InvoiceItem-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Save - InvoiceItem
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="remote" output="false" returntype="numeric" DisplayName="Save InvoiceItem">
		<cfargument name="InvoiceItem" type="InvoiceItem" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.InvoiceItem)>
			<cfset pkID = update(arguments.InvoiceItem) />
		<cfelse>
			<cfset pkID = create(arguments.InvoiceItem) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - InvoiceItem
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
