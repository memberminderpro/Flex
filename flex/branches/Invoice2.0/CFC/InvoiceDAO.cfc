<cfcomponent displayname="InvoiceDAO" hint="table ID column = InvoiceID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - Invoice Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="remote" output="false" returntype="InvoiceDAO">
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
	Lookup - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="remote" output="false" returntype="Query" DisplayName="Lookup Invoice">
		<cfargument Name="InvoiceID"         	Type="Numeric"  	Required="No" 	Hint="InvoiceID"		Default="0">
		<cfargument Name="InvoiceGrpID"         Type="Numeric"  	Required="No" 	Hint="InvoiceGrpID"		Default="0">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
			SELECT
				GL_Invoice.InvoiceID,
				GL_Invoice.InvoiceGrpID,
				GL_Invoice.UserID,
				GL_Invoice.Amount,
				GL_Invoice.Message,
				GL_Invoice.Created_By,
				GL_Invoice.Created_Tmstmp,
				GL_Invoice.Modified_By,
				GL_Invoice.Modified_Tmstmp
				
			FROM	GL_Invoice

			WHERE 		1 = 1
			<CFIF ARGUMENTS.InvoiceGrpID GT 0>
				AND 	GL_InvoiceItem.InvoiceGrpID 	= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceGrpID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
			<CFIF ARGUMENTS.InvoiceID GT 0>
				AND 	GL_InvoiceItem.InvoiceID 		= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
			ORDER BY 	GL_InvoiceItem.InvoiceID

		</cfquery>
		<cfreturn qLookup>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	View - Invoice
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="remote" output="false" returntype="Query" DisplayName="View Invoice">
		<cfargument Name="InvoiceID"         	Type="Numeric"  	Required="No" 	Hint="InvoiceID"		Default="0">
		<cfargument Name="InvoiceGrpID"         Type="Numeric"  	Required="No" 	Hint="InvoiceGrpID"		Default="0">

		<cfset var qView = "" />

		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				GL_Invoice.InvoiceID,
				GL_Invoice.InvoiceGrpID,
				GL_Invoice.UserID,
				GL_Invoice.Amount,
				GL_Invoice.Message,
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					GL_Invoice.Created_Tmstmp,
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
					GL_Invoice.Modified_Tmstmp
				
			FROM	GL_Invoice
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON GL_Invoice.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON GL_Invoice.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1
			<CFIF ARGUMENTS.InvoiceGrpID GT 0>
				AND 	GL_InvoiceItem.InvoiceGrpID 	= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceGrpID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
			<CFIF ARGUMENTS.InvoiceID GT 0>
				AND 	GL_InvoiceItem.InvoiceID 		= <CFQUERYPARAM Value="#ARGUMENTS.InvoiceID#" CFSQLTYPE="CF_SQL_INTEGER">
			</cfif>
			ORDER BY 	GL_InvoiceItem.InvoiceID

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="remote" output="false" returntype="struct" DisplayName="Read Invoice">
		<cfargument name="Invoice" type="Invoice" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					GL_Invoice.InvoiceID,
					GL_Invoice.InvoiceGrpID,
					GL_Invoice.UserID,
					GL_Invoice.Amount,
					GL_Invoice.Message,
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						GL_Invoice.Created_Tmstmp,
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						GL_Invoice.Modified_Tmstmp

				FROM	GL_Invoice
				LEFT OUTER JOIN	tblUser AS tblUser_1 ON GL_Invoice.Created_By = tblUser_1.UserID 
				LEFT OUTER JOIN tblUser AS tblUser_2 ON GL_Invoice.Modified_By = tblUser_2.UserID

				WHERE	InvoiceID = <cfqueryparam value="#arguments.Invoice.getInvoiceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.Invoice.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="remote" output="false" returntype="boolean" DisplayName="Delete Invoice">
		<cfargument name="Invoice" type="Invoice" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	GL_Invoice
			WHERE	InvoiceID = <cfqueryparam value="#arguments.Invoice.getInvoiceID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="remote" output="false" returntype="numeric" DisplayName="Create Invoice">
		<cfargument name="Invoice"  type="Invoice" required="true" />
		<cfargument name="OnErrorContinue"  type="String" required="false" Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>

			<cflock timeout="5" throwontimeout="Yes" name="insertGL_Invoice" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(InvoiceID) as MaxID from GL_Invoice
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1>
				<cfelse>
					<CFSET MaxID = qMax.MaxID + 1>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO GL_Invoice
						(
						InvoiceID,	
						InvoiceGrpID,	
						UserID,	
						Amount,	
						Message,	
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 									CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.Invoice.getInvoiceGrpID()#" 	CFSQLType="cf_sql_integer" null="#not len(arguments.Invoice.getInvoiceGrpID())#" />,
						<cfqueryparam value="#arguments.Invoice.getUserID()#" 			CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.Invoice.getAmount()#" 			CFSQLType="cf_sql_money" null="#not len(arguments.Invoice.getAmount())#" />,
						<cfqueryparam value="#arguments.Invoice.getMessage()#" 			CFSQLType="cf_sql_varchar" null="#not len(arguments.Invoice.getMessage())#" />,
						<cfqueryparam value="#SESSION.UserID#" 							CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 									CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="Invoice" type="I" Value="#MaxID#" Desc=" [#arguments.Invoice.getInvoiceGrpID()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="Invoice" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.Invoice.getInvoiceGrpID()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a Invoice" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="Invoice-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="remote" output="false" returntype="numeric" DisplayName="Update Invoice">
		<cfargument name="Invoice" type="Invoice" required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	GL_Invoice
				SET
					InvoiceGrpID 	= <cfqueryparam value="#arguments.Invoice.getInvoiceGrpID()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.Invoice.getInvoiceGrpID())#" />,
					UserID 			= <cfqueryparam value="#arguments.Invoice.getUserID()#" 		CFSQLType="cf_sql_integer"  />,
					Amount 			= <cfqueryparam value="#arguments.Invoice.getAmount()#" 		CFSQLType="cf_sql_money"  null="#not len(arguments.Invoice.getAmount())#" />,
					Message 		= <cfqueryparam value="#arguments.Invoice.getMessage()#" 		CFSQLType="cf_sql_varchar"  null="#not len(arguments.Invoice.getMessage())#" />,
					
					Modified_By 	= <cfqueryparam value="#SESSION.UserID#" 						CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp = <cfqueryparam value="#Now()#" 								CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					InvoiceID 		= <cfqueryparam value="#arguments.Invoice.getInvoiceID()#" 	CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="Invoice" type="U" Value="#arguments.Invoice.getInvoiceID()#" Desc=" [#arguments.Invoice.getInvoiceGrpID()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="Invoice" type="U" Value="#arguments.Invoice.getInvoiceID()#" Desc="Error updating [#arguments.Invoice.getInvoiceGrpID()#] (#cfcatch.message#)" />
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating Invoice" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="Invoice-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.Invoice.getInvoiceID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="remote" output="false" returntype="boolean" DisplayName="Delete Invoice">
		<cfargument name="Invoice" type="Invoice" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	GL_Invoice 
				WHERE	InvoiceID = <cfqueryparam value="#arguments.Invoice.getInvoiceID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="Invoice" type="D" Value="#arguments.Invoice.getInvoiceID()#" Desc=" [#ARGUMENTS.Invoice.getInvoiceGrpID()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="Invoice" type="D" Value="#arguments.Invoice.getInvoiceID()#" Desc="Error deleting [#ARGUMENTS.Invoice.getInvoiceGrpID()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a Invoice" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="Invoice-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Save - Invoice
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="remote" output="false" returntype="numeric" DisplayName="Save Invoice">
		<cfargument name="Invoice" type="Invoice" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.Invoice)>
			<cfset pkID = update(arguments.Invoice) />
		<cfelse>
			<cfset pkID = create(arguments.Invoice) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - Invoice
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
