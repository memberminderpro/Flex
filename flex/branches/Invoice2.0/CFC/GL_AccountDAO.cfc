<cfcomponent displayname="GL_AccountDAO" hint="table ID column = GL_AccountID">

<!--- Local Variables --->
<cfset VARIABLES.dsn 		= "">

<!--------------------------------------------------------------------------------------------
	Init - GL_Account2 Constructor
	
	Entry Conditions:
		DSN			- datasource name
---------------------------------------------------------------------------------------------->
	<cffunction name="init" access="Remote" output="false" returntype="GL_AccountDAO">
		<cfargument name="dsn" type="string" required="true">
		<cfset variables.dsn = arguments.dsn>
		<cfreturn this>
	</cffunction>

<!--------------------------------------------------------------------------------------------
	getVariablesScope - Return variable Scope
	
	Entry Conditions:
		None
---------------------------------------------------------------------------------------------->
	<cffunction name="getVariablesScope" access="Public" output="false" returntype="struct">
      <cfreturn variables />
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	getClubMembers - Lookup Club Members
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="getClubMembers" access="Remote" output="false" returntype="Query" DisplayName=" Lookup Club Members">
		<cfargument Name="ClubID"          	Type="Numeric"  	Required="Yes" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="TermDate"         Type="Date"  		Required="No" 	Hint="TermDate" >
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="UserName">

		<cfset var getClubMembers = "" />
		
		<cfquery name="getClubMembers" datasource="RotaryTest">
SELECT     dbo.tblUser.UserID, dbo.tblUser.LastName + ', ' + dbo.tblUser.FirstName + ' ' + dbo.tblUser.MidName + ' ' + dbo.tblUser.NameSfx AS UserName, 
                      dbo.tblClub.ClubName, dbo.tblUser.ClubID, dbo.tblMemberType.MemberType, 0 As Amount
FROM         dbo.tblClub INNER JOIN
                      dbo.tblUser ON dbo.tblClub.ClubID = dbo.tblUser.ClubID INNER JOIN
                      dbo.tblMemberType ON dbo.tblUser.MemberTypeID = dbo.tblMemberType.MemberTypeID

			WHERE 	1 = 1
			AND		tblUser.ClubID 	= <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND		tblUser.dFlag		=  'N'
			<cfelse>
				AND		(
						tblUser.TermDate	IS NULL OR
						tblUser.TermDate	>= #TermDate#
						)
			</cfif>
					
			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="UserName">ORDER BY 	UserName	</cfcase>
			</cfswitch>

		</cfquery>
		<cfreturn getClubMembers>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	getMember - Lookup Member
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="getMemberAddress" access="Remote" output="false" returntype="Query" DisplayName=" Lookup Member Address">
		<cfargument Name="UserID"          	Type="Numeric"  	Required="Yes" 	Hint="UserID" >

		<cfset var getMember = "" />
		
		<cfquery name="getMemberAddress" datasource="RotaryTest">
SELECT     dbo.tblUser.UserID, 
                      CASE tblUser.DisplayID WHEN 0 THEN tblUser.LastName + ', ' + tblUser.FirstName + ' ' + tblUser.MidName + ' ' + tblUser.NameSFX WHEN 1 THEN tblUser.BusName END
                       AS UserName, CASE Len(tblUser.NickName) WHEN 0 THEN tblUser.FirstName ELSE tblUser.NickName END AS FName, dbo.tblUser.Private, 
                      dbo.tblMemberAddress.Address1, dbo.tblMemberAddress.Address2, dbo.tblMemberAddress.City, dbo.tblMemberAddress.StateCode, 
                      dbo.tblMemberAddress.ProvOrOther, dbo.tblMemberAddress.PostalZip, dbo.tblMemberAddress.HomePhone, dbo.tblMemberAddress.OfficePhone, dbo.tblUser.Email, 
                      dbo.tblCountry.CountryName, dbo.tblUser.Prefix, dbo.tblMemberType.MemberType, dbo.tblUser.OptIn
FROM         dbo.tblMemberType INNER JOIN
                      dbo.tblUser ON dbo.tblMemberType.MemberTypeID = dbo.tblUser.MemberTypeID LEFT OUTER JOIN
                      dbo.tblCountry RIGHT OUTER JOIN
                      dbo.tblMemberAddress ON dbo.tblCountry.CountryCode = dbo.tblMemberAddress.CountryCode ON dbo.tblUser.AddressID = dbo.tblMemberAddress.AddressID

			WHERE 	1 = 1
			AND		tblUser.UserID 	= <CFQUERYPARAM Value="#ARGUMENTS.UserID#" CFSQLTYPE="CF_SQL_INTEGER">

		</cfquery>
		<cfreturn getMemberAddress>
	</cffunction>


<!--- ----------------------------------------------------------------------------------------------------------------
	Pick - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Pick" access="Remote" output="false" returntype="Query" DisplayName="Pick GL_Account">
		<cfargument Name="ClubID"          	Type="Numeric"  	Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="Parent">

		<cfset var qPick = "" />
		<cfquery name="qPick" datasource="RotaryTest">
SELECT     GL_AccountID, GL_Account, AccountCode, ParentID, IsPosting, EntityID
FROM       GL_Account

			WHERE 	1 = 1
			AND		GL_Account.ClubID 	= <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	GL_Account.IsActive 	<> 'N'
			</cfif>

			Order By ParentID, GL_AccountID	
		</cfquery>
		<cfreturn qPick>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	PickXML - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="PickXML" access="Remote" output="true" returntype="XML" DisplayName="PickXML GL_Account">
		<cfargument Name="ClubID"          	Type="Numeric" 		Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument name="GL_AccountID" 	type="Numeric" 		required="No" 	Hint="GL_AccountID" 		Default="0"/>
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="">

		<cfset var qPick = "" />
		<cfset var sXML = "" />
		<cfset var s = "" />

		<cfquery name="qPick" datasource="RotaryTest">
SELECT     GL_AccountID, GL_Account, AccountCode, ParentID, IsPosting, EntityID
FROM       GL_Account

			WHERE 	1 = 1
			AND		GL_Account.ClubID 	= <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	GL_Account.IsActive 	<> 'N'
			</cfif>

			Order By ParentID, GL_AccountID	
		</cfquery>

		<cfset s = createObject('java','java.lang.StringBuffer').init("<?xml version=""1.0"" encoding=""UTF-8""?>")>
		<cfset s = s & "<Account Label=""#qPick.GL_Account#"">">
			<cfif qPick.recordcount GT 0>
			    <cfset s = s & Child(Q="#qPick#", ID="#qPick.GL_AccountID#", Level="0") />
			</cfif>
		<cfset s = s & "</Account>">
		<cfset sXML = tostring(s)>
		<cfreturn sXML>
	</cffunction>

	<cffunction name="Child" access="Remote" output="false" returntype="String" DisplayName="Child">
		<cfargument Name="Q" 	        Type="Query"  		Required="Yes" 	Hint="Query">
		<cfargument Name="ID" 	        Type="Numeric" 		Required="Yes" 	Hint="ChildID">
		<cfargument Name="Level"        Type="Numeric" 		Required="Yes" 	Hint="Level">
	
		<cfset var s = "" />
		<cfset var n = "" />
		<cfset var NxtLevel = 0 />

		<cfif ARGUMENTS.Level LT 6>
			<cfquery name="N" dbtype="query">
				SELECT	* FROM ARGUMENTS.Q
				WHERE 	ParentID = #ARGUMENTS.ID#
			</cfquery>
			
			<cfif N.Recordcount GT 0>
				<cfset NxtLevel = ARGUMENTS.Level + 1>
				<cfoutput query="N">
					<cfif N.IsPosting EQ "Y">
 						<cfset s = s & "<Folder Label=""#N.GL_Account#"" ID=""#N.GL_AccountID#"">">
					<cfelse>
						<cfset s = s & "<Folder Label=""#N.GL_Account#"">">
					</cfif>
				    <cfset s = s & Child(Q="#ARGUMENTS.Q#", ID="#N.GL_AccountID#", Level="#NxtLevel#") />
					<cfset s = s & "</Folder>">
				</cfoutput>
			</cfif>
		</cfif>

		<cfreturn s>
	</cffunction>

	
<!--- ----------------------------------------------------------------------------------------------------------------
	Lookup - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Lookup" access="Remote" output="false" returntype="Query" DisplayName="Lookup GL_Account">
		<cfargument Name="ClubID"          	Type="Numeric"  	Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"		Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="GL_Account">

		<cfset var qLookup = "" />
		<cfquery name="qLookup" datasource="RotaryTest">
			SELECT
				GL_Account.GL_AccountID,
				GL_Account.GL_Account,
				GL_Account.AccountCode,
				GL_Account.ClubID,
				GL_Account.EntityID,
				GL_Account.ParentID,
				GL_Account.GL_AccountType,
				GL_Account.IsPosting,
				GL_Account.IsActive,
				GL_Account.IsExport,
				GL_Account.ExtAccountCode,
				GL_Account.Created_By,
				GL_Account.Created_Tmstmp,
				GL_Account.Modified_By,
				GL_Account.Modified_Tmstmp
				
			FROM	GL_Account

			WHERE 		1 = 1
			AND		GL_Account.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	GL_Account.IsActive 	<> 'N'
			</cfif>

			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	GL_Account.GL_AccountID 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			Order By ParentID, GL_AccountID	

		</cfquery>
		<cfreturn qLookup>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	View - GL_Account
	Entry Conditions
	
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="View" access="Remote" output="false" returntype="Query" DisplayName="View GL_Account">
		<cfargument Name="ClubID"          	Type="Numeric"  	Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"		Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="Parent">

		<cfset var qView = "" />
		<cfquery name="qView" datasource="RotaryTest">
			SELECT
				GL_Account.GL_AccountID,
				GL_Account.GL_Account,
				GL_Account.AccountCode,
				GL_Account.ClubID,
				GL_Account.EntityID,
				GL_Account.ParentID,
				GL_Account.GL_AccountType,
				GL_Account.IsPosting,
				GL_Account.IsActive,
				GL_Account.IsExport,
				GL_Account.ExtAccountCode,
							
				tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
					GL_Account.Created_Tmstmp,
							
				tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
					GL_Account.Modified_Tmstmp
				
			FROM	GL_Account
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON GL_Account.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON GL_Account.Modified_By = tblUser_2.UserID

			WHERE 		1 = 1
			AND		GL_Account.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	GL_Account.IsActive 	<> 'N'
			</cfif>
					
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	GL_Account.GL_Account 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>
			
			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="GL_Account">ORDER BY 	GL_Account.GL_Account </cfcase>
				<cfdefaultcase> 		   ORDER BY 	GL_Account.Parent </cfdefaultcase>
			</cfswitch>

		</cfquery>
		<cfreturn qView>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	List - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="List" access="Remote" output="false" returntype="Query" DisplayName="List GL_Account">
		<cfargument name="GL_AccountID" 	type="Numeric" 		required="No" 	Hint="GL_AccountID" 		Default="0"/>
		<cfargument Name="ClubID"          	Type="Numeric" 		Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"		Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="">

		<cfset var qList = "" />
		<cfquery name="qList" datasource="RotaryTest">
SELECT     TOP (100) PERCENT GL_Account_1.GL_Account AS Parent, dbo.GL_Account.GL_Account, dbo.GL_Account.AccountCode, dbo.GL_Account.ClubID, 
                      dbo.GL_Account.EntityID, dbo.GL_Account.ParentID, dbo.GL_Account.GL_AccountType, dbo.GL_Account.IsPosting, 
                      dbo.GL_Account.IsActive, dbo.GL_Account.IsExport, dbo.GL_Account.ExtAccountCode, dbo.GL_Account.Created_By, dbo.GL_Account.Created_Tmstmp, 
                      dbo.GL_Account.Modified_By, dbo.GL_Account.Modified_Tmstmp
FROM         dbo.GL_Account INNER JOIN
                      dbo.GL_Account AS GL_Account_1 ON dbo.GL_Account.ParentID = GL_Account_1.GL_AccountID

			WHERE 		1 = 1
			AND		GL_Account.ClubID = <CFQUERYPARAM Value="#ARGUMENTS.ClubID#" CFSQLTYPE="CF_SQL_INTEGER">

			<cfif ARGUMENTS.Override EQ "N">
				AND	 	GL_Account.IsActive 	<> 'N'
			</cfif>

			<CFIF ARGUMENTS.GL_AccountID GT 0>
				AND 	GL_Account.GL_AccountID = <CFQUERYPARAM Value="#ARGUMENTS.GL_AccountID#" CFSQLTYPE="cf_sql_integer">
			</cfif>
			
			<CFIF Len(ARGUMENTS.Filter) GT 0>
				AND 	GL_Account.GL_Account 			LIKE '#ARGUMENTS.Filter#%'
			</cfif>

			<cfswitch expression="#ARGUMENTS.SortBy#">
				<cfcase value="GL_Account">	ORDER BY 	GL_Account.GL_Account </cfcase>
				<cfdefaultcase> 			ORDER BY 	Parent </cfdefaultcase>
			</cfswitch>

		</cfquery>
		<cfreturn qList>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	ListXML - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="ListXML" access="Remote" output="false" returntype="XML" DisplayName="ListXML GL_Account">
		<cfargument name="GL_AccountID" 	type="Numeric" 		required="No" 	Hint="GL_AccountID" 		Default="0"/>
		<cfargument Name="ClubID"          	Type="Numeric" 		Required="No" 	Hint="ClubID" 				Default="#SESSION.ClubID#">
		<cfargument Name="Override"         Type="String"  		Required="No" 	Hint="Override" 			Default="N">
		<cfargument Name="Filter" 	        Type="String"		Required="No" 	Hint="Filter" 				Default="">
		<cfargument Name="SortBy" 	        Type="String"  		Required="No" 	Hint="SortBy" 				Default="">

		<cfset var qList = "" />
		<cfset var qXML = "" />

		<cfset qList 	= List(ClubID=#ARGUMENTS.ClubID#) />
		<cfset qXML 	= APPLICATION.toXML.queryToXML(qList, "Accounts", "Account") />

		<cfreturn qXML>
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Read - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Read" access="Remote" output="false" returntype="struct" DisplayName="Read GL_Account">
		<cfargument name="GL_Account" type="GL_Account" required="true" />

		<cfset var qRead = "" />
		<cfset var strReturn = structNew() />
			<cfquery name="qRead" datasource="RotaryTest">
				SELECT
					GL_Account.GL_AccountID,
					GL_Account.GL_Account,
					GL_Account.AccountCode,
					GL_Account.ClubID,
					GL_Account.EntityID,
					GL_Account.ParentID,
					GL_Account.GL_AccountType,
					GL_Account.IsPosting,
					GL_Account.IsActive,
					GL_Account.IsExport,
					GL_Account.ExtAccountCode,
							
					tblUser_1.FirstName + ' ' + tblUser_1.LastName AS Created_By,
						GL_Account.Created_Tmstmp,
							
					tblUser_2.FirstName + ' ' + tblUser_2.LastName AS Modified_By,
						GL_Account.Modified_Tmstmp

			FROM	GL_Account
			LEFT OUTER JOIN	tblUser AS tblUser_1 ON GL_Account.Created_By = tblUser_1.UserID 
			LEFT OUTER JOIN tblUser AS tblUser_2 ON GL_Account.Modified_By = tblUser_2.UserID

			WHERE	GL_AccountID = <cfqueryparam value="#arguments.GL_Account.getGL_AccountID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
		<cfif qRead.recordCount>
			<cfset strReturn = queryRowToStruct(qRead)>
			<cfset arguments.GL_Account.init(argumentCollection=strReturn)>
		</cfif>
		<cfreturn strReturn>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Exists - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Exists" access="Remote" output="false" returntype="boolean" DisplayName="Delete GL_Account">
		<cfargument name="GL_Account" type="GL_Account" required="true" />

		<cfset var qExists = "">
		<cfquery name="qExists" datasource="RotaryTest" maxrows="1">
			SELECT count(1) as idexists
			FROM	GL_Account
			WHERE	GL_AccountID = <cfqueryparam value="#arguments.GL_Account.getGL_AccountID()#" CFSQLType="cf_sql_integer" />
		</cfquery>

		<cfif qExists.idexists>
			<cfreturn true />
		<cfelse>
			<cfreturn false />
		</cfif>
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Create - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Create" access="Remote" output="false" returntype="numeric" DisplayName="Create GL_Account">
		<cfargument name="GL_Account"  type="GL_Account" required="true" />
		<cfargument name="OnErrorContinue"  type="String" required="false" Default="N" />

		<cfset var qCreate = "" />
		<cfset var qMax 	  = "" />
		<cfset var MaxID 	= "0" />
		<cfset var errMsg 	= "" />

		<cftry>
			<cflock timeout="5" throwontimeout="Yes" name="insertGL_Account" type="EXCLUSIVE">
				<cfquery name="qMax" datasource="RotaryTest">
					Select MAX(GL_AccountID) as MaxID from GL_Account
				</cfquery>
				<cfif NOT IsNumeric(qMax.MaxID)>
					<CFSET MaxID = 1000>
				<cfelse>
					<CFSET MaxID = Max(qMax.MaxID + 1, 1000)>
				</cfif>
	
				<cfquery name="qCreate" datasource="RotaryTest">
					INSERT INTO GL_Account
						(
						GL_AccountID,	
						GL_Account,	
						AccountCode,	
						ClubID,	
						EntityID,	
						ParentID,	
						GL_AccountType,	
						IsPosting,	
						IsActive,	
						IsExport,	
						ExtAccountCode,	
						Created_By,
						Created_Tmstmp
						)
					VALUES
						(
						<cfqueryparam value="#MaxID#" 										CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.GL_Account.getGL_Account()#" 		CFSQLType="cf_sql_varchar" />,
						<cfqueryparam value="#arguments.GL_Account.getAccountCode()#" 		CFSQLType="cf_sql_integer" 	null="#not len(arguments.GL_Account.getAccountCode())#" />,
						<cfqueryparam value="#arguments.GL_Account.getClubID()#"		 	CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.GL_Account.getEntityID()#" 			CFSQLType="cf_sql_integer" />,
						<cfqueryparam value="#arguments.GL_Account.getParentID()#" 			CFSQLType="cf_sql_integer" 	null="#not len(arguments.GL_Account.getParentID())#" />,
						<cfqueryparam value="#arguments.GL_Account.getGL_AccountType()#" 		CFSQLType="cf_sql_integer" 	null="#not len(arguments.GL_Account.getGL_AccountType())#" />,
						<cfqueryparam value="#arguments.GL_Account.getIsPosting()#" 		CFSQLType="cf_sql_char"		null="#not len(arguments.GL_Account.getIsPosting())#" />,
						<cfqueryparam value="#arguments.GL_Account.getIsActive()#" 			CFSQLType="cf_sql_char" 	null="#not len(arguments.GL_Account.getIsActive())#" />,
						<cfqueryparam value="#arguments.GL_Account.getIsExport()#" 			CFSQLType="cf_sql_char" 	null="#not len(arguments.GL_Account.getIsExport())#" />,
						<cfqueryparam value="#arguments.GL_Account.getExtAccountCode()#" 	CFSQLType="cf_sql_varchar" 	null="#not len(arguments.GL_Account.getExtAccountCode())#" />,
						<cfqueryparam value="#SESSION.UserID#" 								CFSQLType="CF_SQL_INTEGER" />,
						<cfqueryparam value="#Now()#" 										CFSQLType="CF_SQL_TIMESTAMP" />
						)
				</cfquery>
			</cflock>
	
			<CF_XLog Table="GL_Account" type="I" Value="#MaxID#" Desc=" [#arguments.GL_Account.getGL_Account()#] created">
			<cfcatch type="database">
				<cfif ARGUMENTS.OnErrorContinue EQ "N">
					<CF_XLog Table="GL_Account" type="I" Value="#MaxID#" Desc="Error inserting [#arguments.GL_Account.getGL_Account()#] (#cfcatch.message#)" />
					<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
					<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
					<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
					<CF_XError2 What="Error adding a GL_Account" 
						Todo="Go back to the previous page and correct the problem" 
						Details="#errMsg#" Reference="GL_Account-create" />
				</cfif>	
				<cfreturn 0 />
			</cfcatch>
	
			</cftry>
		<cfreturn MaxID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Update - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Update" access="Remote" output="false" returntype="numeric" DisplayName="Update GL_Account">
		<cfargument name="GL_Account" type="GL_Account" required="true" />

		<cfset var qUpdate = "" />
		<cfset var errMsg 	= "" />
	
		<cftry>
			<cfquery name="qUpdate" datasource="RotaryTest">
				UPDATE	GL_Account
				SET
					GL_Account 		= <cfqueryparam value="#arguments.GL_Account.getGL_Account()#" 		CFSQLType="cf_sql_varchar"  />,
					AccountCode 	= <cfqueryparam value="#arguments.GL_Account.getAccountCode()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.GL_Account.getAccountCode())#" />,
					ClubID 			= <cfqueryparam value="#arguments.GL_Account.getClubID()#" 			CFSQLType="cf_sql_integer"  />,
					EntityID 		= <cfqueryparam value="#arguments.GL_Account.getEntityID()#" 		CFSQLType="cf_sql_integer"  />,
					ParentID 		= <cfqueryparam value="#arguments.GL_Account.getParentID()#" 		CFSQLType="cf_sql_integer"  null="#not len(arguments.GL_Account.getParentID())#" />,
					GL_AccountType 	= <cfqueryparam value="#arguments.GL_Account.getGL_AccountType()#" 	CFSQLType="cf_sql_integer"  null="#not len(arguments.GL_Account.getGL_AccountType())#" />,
					IsPosting		= <cfqueryparam value="#arguments.GL_Account.getIsPosting()#" 		CFSQLType="cf_sql_char"  	null="#not len(arguments.GL_Account.getIsPosting())#" />,
					IsActive 		= <cfqueryparam value="#arguments.GL_Account.getIsActive()#" 		CFSQLType="cf_sql_char"  	null="#not len(arguments.GL_Account.getIsActive())#" />,
					IsExport 		= <cfqueryparam value="#arguments.GL_Account.getIsExport()#" 		CFSQLType="cf_sql_char"  	null="#not len(arguments.GL_Account.getIsExport())#" />,
					ExtAccountCode 	= <cfqueryparam value="#arguments.GL_Account.getExtAccountCode()#" CFSQLType="cf_sql_varchar"  null="#not len(arguments.GL_Account.getExtAccountCode())#" />,
					
					Modified_By 	= <cfqueryparam value="#SESSION.UserID#" CFSQLType="CF_SQL_INTEGER" />,
					Modified_Tmstmp = <cfqueryparam value="#Now()#" CFSQLType="CF_SQL_TIMESTAMP" />
				WHERE	
					GL_AccountID 	= <cfqueryparam value="#arguments.GL_Account.getGL_AccountID()#" CFSQLType="cf_sql_integer" />
			</cfquery>
			
			<CF_XLog Table="GL_Account" type="U" Value="#arguments.GL_Account.getGL_AccountID()#" Desc=" [#arguments.GL_Account.getGL_Account()#] updated">
			<cfcatch type="database">
				<CF_XLog Table="GL_Account" type="U" Value="#arguments.GL_Account.getGL_AccountID()#" Desc="Error updating [#arguments.GL_Account.getGL_Account()#] (#cfcatch.message#)" />

				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error updating GL_Account" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="GL_Account-update" />
				<cfreturn 0 />
			</cfcatch>
		</cftry>
		<cfreturn arguments.GL_Account.getGL_AccountID() />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Delete - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Delete" access="Remote" output="false" returntype="boolean" DisplayName="Delete GL_Account">
		<cfargument name="GL_Account" type="GL_Account" required="true" />

		<cfset var qDelete = "">
		<cfset var errMsg 	= "" />

		<cftry>
			<cfquery name="qDelete" datasource="RotaryTest">
				DELETE FROM	GL_Account 
				WHERE	
					GL_AccountID = <cfqueryparam value="#arguments.GL_Account.getGL_AccountID()#" CFSQLType="cf_sql_integer" />
			</cfquery>

			<CF_XLog Table="GL_Account" type="D" Value="#arguments.GL_Account.getGL_AccountID()#" Desc=" [#ARGUMENTS.GL_Account.getGL_Account()#] deleted">
			<cfcatch type="database">
				<CF_XLog Table="GL_Account" type="D" Value="#arguments.GL_Account.getGL_AccountID()#" Desc="Error deleting [#ARGUMENTS.GL_Account.getGL_Account()#] (#cfcatch.message#)" />
				
				<cfset errMsg = "Message=#cfcatch.message#<BR>Details=#cfcatch.detail#" />
				<cfif IsDefined("cfcatch.SQLState")>	<cfset errMsg = errMsg & "<BR>SQLState=#cfcatch.SQLState#"  ></cfif>
				<cfif IsDefined("cfcatch.ErrNumber")> <cfset errMsg = errMsg & "<BR>ErrNumber=#cfcatch.ErrNumber#"></cfif>
				<CF_XError2 What="Error deleting a GL_Account" 
					Todo="Go back to the previous page and correct the problem" 
					Details="#errMsg#" Reference="GL_Account-delete" />

				<cfreturn false />
			</cfcatch>

		</cftry>
		<cfreturn true />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	LoadBase - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="LoadBase" access="Remote" output="true" returntype="boolean" DisplayName="LoadBase GL_Account">
		<cfargument name="ClubID" type="Numeric" required="false"  Default="0"/>

		<cfset var Q = "" />
		
		<cfset Q = Lookup( ClubID="#ARGUMENTS.ClubID#"  ) />		<!--- Get Base default --->

		<cfinvoke component="GL_Account" method="init" returnvariable="GL_AccountObj">
			<cfinvokeargument name="GL_Account"			Value="CLUB #SESSION.ClubID#" />
			<cfinvokeargument name="AccountCode"		Value="#Q.AccountCode#" />
			<cfinvokeargument name="ClubID"				Value="#SESSION.ClubID#" />
			<cfinvokeargument name="EntityID"			Value="#Q.EntityID#" />
			<cfinvokeargument name="ParentID"			Value="0" />
			<cfinvokeargument name="GL_AccountType"		Value="#Q.GL_AccountType#" />
			<cfinvokeargument name="IsPosting"			Value="#Q.IsPosting#" />
			<cfinvokeargument name="IsActive"			Value="#Q.IsActive#" />
			<cfinvokeargument name="IsExport"			Value="#Q.IsExport#" />
			<cfinvokeargument name="ExtAccountCode"		Value="#Q.ExtAccountCode#" />
		</cfinvoke>
		<cfset newID = Create ( GL_AccountObj )>
		<cfset Clone(Q="#Q#", ParentID=#newID#, ChildID="#Q.GL_AccountID#", Level="0") />
		<cfreturn TRUE />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	Clone - recursive GL_Account structure
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Clone" access="Public" output="false" returntype="String" DisplayName="Child">
		<cfargument Name="Q" 	        Type="Query"  		Required="Yes" 	Hint="Query">
		<cfargument Name="ParentID" 	Type="Numeric" 		Required="Yes" 	Hint="ParentID - hook to this ID">
		<cfargument Name="ChildID" 	    Type="Numeric" 		Required="Yes" 	Hint="ChildID - Node to search for">
		<cfargument Name="Level"        Type="Numeric" 		Required="Yes" 	Hint="Level">
	
		<cfset var s = "" />
		<cfset var n = "" />
		<cfset var NxtLevel = 0 />

		<cfif ARGUMENTS.Level LT 6>
			<cfquery name="N" dbtype="query">
				SELECT	* FROM ARGUMENTS.Q
				WHERE 	ParentID = #ARGUMENTS.ChildID#
			</cfquery>
			
			<cfif N.Recordcount GT 0>
				<cfset NxtLevel = ARGUMENTS.Level + 1>
				<cfoutput query="N">
					<cfinvoke component="GL_Account" method="init" returnvariable="GL_AccountObj">
						<cfinvokeargument name="GL_Account"			Value="#N.GL_Account#" />
						<cfinvokeargument name="AccountCode"		Value="#N.AccountCode#" />
						<cfinvokeargument name="ClubID"				Value="#SESSION.ClubID#" />
						<cfinvokeargument name="EntityID"			Value="#N.EntityID#" />
						<cfinvokeargument name="ParentID"			Value="#ARGUMENTS.ParentID#" />
						<cfinvokeargument name="GL_AccountType"		Value="#N.GL_AccountType#" />
						<cfinvokeargument name="IsPosting"			Value="#N.IsPosting#" />
						<cfinvokeargument name="IsActive"			Value="#N.IsActive#" />
						<cfinvokeargument name="IsExport"			Value="#N.IsExport#" />
						<cfinvokeargument name="ExtAccountCode"		Value="#N.ExtAccountCode#" />
					</cfinvoke>
					<cfset newID = Create ( GL_AccountObj )>
					<cfset Clone(Q="#ARGUMENTS.Q#", ParentID=#newID#, ChildID="#N.GL_AccountID#", Level="#NxtLevel#") />
				</cfoutput>
			</cfif>
		</cfif>

		<cfreturn >
	</cffunction>
	
<!--- ----------------------------------------------------------------------------------------------------------------
	Save - GL_Account
	Modifications
---------------------------------------------------------------------------------------------------------------------->
	<cffunction name="Save" access="Remote" output="false" returntype="numeric" DisplayName="Save GL_Account">
		<cfargument name="GL_Account" type="GL_Account" required="true" />
		
		<cfset var pkID = 0 />		<!--- 0=false --->
		<cfif exists(arguments.GL_Account)>
			<cfset pkID = update(arguments.GL_Account) />
		<cfelse>
			<cfset pkID = create(arguments.GL_Account) />
		</cfif>
		
		<cfreturn pkID />
	</cffunction>

<!--- ----------------------------------------------------------------------------------------------------------------
	queryRowToStruct - GL_Account
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
