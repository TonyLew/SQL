





--Data Manipulation



If		(@@SERVERNAME <> 'w28-sql2k8-cl05')
BEGIN


		SET			NOCOUNT ON
		Update		dbo.DRServiceType 
		Set			IsActive = 0
		--select x.* 
		FROM	(
					SELECT		DRServiceGroupTypeId				= dsgt.DRServiceGroupTypeId, 
								DRServiceTypeIdInner				= ds.DRServiceTypeId, 
								DRServiceGroupTypename				= dsgt.Name, 
								DRServiceTypeName					= ds.Name,
								IsActive							= ds.IsActive
					FROM		dbo.XDRServiceDMSService x
					RIGHT JOIN	dbo.DRServiceType ds				ON x.DRServiceTypeId = ds.DRServiceTypeId
					JOIN		dbo.DRServiceGroupType dsgt			ON ds.DRServiceGroupTypeId = dsgt.DRServiceGroupTypeId
					WHERE		x.DRServiceTypeId IS NULL
					AND			dsgt.Name							NOT IN ('Underlying Rights Service','Production Service')
				) x
		WHERE		DRServiceTypeId = x.DRServiceTypeIdInner 


		insert		dbo.Users (UserId,UserName,Login,IsActive,LastActivityDate)
		select		NewId(),'$bellol','swna\$bellol',1,getdate()


		Update		Users 
		Set			RoleId = r.RoleId
		--select *
		from		Roles r
		Where		r.RoleName = 'Creative Assistant'
		and			UserName = '$bellol'


END



/*


			Insert dbo.Network ( NetworkName, ShortName , OptionNotificationDL, IsActive)
			Select x.NetworkName, x.ShortName , x.OptionNotificationDL, x.IsActive
			from
				(
					Select NetworkName = 'ABC Studios',ShortName = 'ABCS',OptionNotificationDL='#CNGContractAdmin-DCDMSOptionNotifications@disney.com',IsActive=1
				) x
			left join dbo.Network y
			On x.NetworkName= y.NetworkName
			where y.NetworkId is null


			UPDATE [Executive]
			SET IsActive = 0


			INSERT INTO dbo.Executive
					   (
					   ExecutiveId,
					   ExecutiveName,
					   ExecutiveShortName,
					   IsActive
					   )
			SELECT 
					   x.ExecutiveId,
					   x.ExecutiveName,
					   x.ExecutiveShortName,
					   x.IsActive
			FROM
					(
						SELECT ExecutiveId=NEWID(),ExecutiveName='Channing Dungey',ExecutiveShortName='CD',IsActive=1 UNION
						SELECT ExecutiveId=NEWID(),ExecutiveName='Nne Ebong',ExecutiveShortName='NE',IsActive=1 UNION
						SELECT ExecutiveId=NEWID(),ExecutiveName='Amy Hartwick',ExecutiveShortName='AH',IsActive=1 UNION
						SELECT ExecutiveId=NEWID(),ExecutiveName='Zack Olin',ExecutiveShortName='ZO',IsActive=1
					) x
			LEFT JOIN dbo.Executive y ON x.ExecutiveName = y.ExecutiveName
			WHERE y.ExecutiveId IS NULL


			Update		dbo.Executive
			Set			IsActive = 1
			FROM
					(
						SELECT ExecutiveId=NEWID(),ExecutiveName='Channing Dungey',ExecutiveShortName='CD',IsActive=1 UNION
						SELECT ExecutiveId=NEWID(),ExecutiveName='Nne Ebong',ExecutiveShortName='NE',IsActive=1 UNION
						SELECT ExecutiveId=NEWID(),ExecutiveName='Amy Hartwick',ExecutiveShortName='AH',IsActive=1 UNION
						SELECT ExecutiveId=NEWID(),ExecutiveName='Zack Olin',ExecutiveShortName='ZO',IsActive=1
					) y
			WHERE		Executive.ExecutiveName = y.ExecutiveName



			Declare		@DepartmentId UNIQUEIDENTIFIER
			select		@DepartmentId = DepartmentId from dbo.Department Where DepartmentName = 'Creative'

			INSERT dbo.DepartmentExecutive	( DepartmentId, ExecutiveId )
			SELECT 
					   DepartmentId			= @DepartmentId,
					   ExecutiveId			= y.ExecutiveId
			FROM
					(
						SELECT ExecutiveName='Channing Dungey',ExecutiveShortName='CD',IsActive=1 UNION
						SELECT ExecutiveName='Nne Ebong',ExecutiveShortName='NE',IsActive=1 UNION
						SELECT ExecutiveName='Amy Hartwick',ExecutiveShortName='AH',IsActive=1 UNION
						SELECT ExecutiveName='Zack Olin',ExecutiveShortName='ZO',IsActive=1
					) x
			JOIN		dbo.Executive y ON x.ExecutiveName = y.ExecutiveName
			LEFT JOIN dbo.DepartmentExecutive z ON z.DepartmentId = @DepartmentId AND y.ExecutiveId = z.ExecutiveId
			WHERE z.Id IS NULL


			Declare		@NetworkId UNIQUEIDENTIFIER
			select		@NetworkId = NetworkId from dbo.Network Where NetworkName = 'ABC Studios'

			--Declare		@DepartmentId UNIQUEIDENTIFIER
			--select		@DepartmentId = DepartmentId from dbo.Department Where DepartmentName = 'Creative'

			--Declare		@ProjectId UNIQUEIDENTIFIER = newid()
			--Insert		dbo.Project (ProjectId,ProjectName,NetworkId)
			--Select		@ProjectId,'Project Name for Demo ' + CAST( @ProjectId AS VARCHAR(100)), @NetworkId

			INSERT		dbo.Project ( ProjectId,ProjectName,NetworkId )
			SELECT 
						ProjectId			= x.ProjectId,
						ProjectName			= x.ProjectName,
						NetworkId			= x.NetworkId
			FROM
					(
						SELECT ProjectId=NEWID(), ProjectName='Grey’s Anatomy', NetworkId = @NetworkId	UNION
						SELECT ProjectId=NEWID(), ProjectName='Scandal', NetworkId = @NetworkId
					) x
			LEFT JOIN	dbo.Project y ON x.ProjectName = y.ProjectName
			WHERE		y.ProjectId IS NULL



			--IF			( @ProjectId IS NOT NULL AND @DepartmentId IS NOT NULL )
			--INSERT		dbo.ProjectExecutive ( ProjectExecutiveId,ProjectId,ExecutiveId,DepartmentId )
			--SELECT 
			--			ProjectExecutiveId	= x.ProjectExecutiveId,
			--			ProjectId			= @ProjectId,
			--			ExecutiveId			= y.ExecutiveId,
			--			DepartmentId		= @DepartmentId
			--FROM
			--		(
			--			SELECT ProjectExecutiveId=NEWID(), ExecutiveName='Channing Dungey',		ExecutiveShortName='CD',IsActive=1 UNION
			--			SELECT ProjectExecutiveId=NEWID(), ExecutiveName='Nne Ebong',			ExecutiveShortName='NE',IsActive=1 UNION
			--			SELECT ProjectExecutiveId=NEWID(), ExecutiveName='Amy Hartwick',		ExecutiveShortName='AH',IsActive=1 UNION
			--			SELECT ProjectExecutiveId=NEWID(), ExecutiveName='Zack Olin',			ExecutiveShortName='ZO',IsActive=1
			--		) x
			--JOIN		dbo.Executive y ON x.ExecutiveName = y.ExecutiveName



			Declare		@DepartmentId UNIQUEIDENTIFIER
			select		@DepartmentId = DepartmentId from dbo.Department Where DepartmentName = 'Creative'

			IF			( @DepartmentId IS NOT NULL )
			INSERT		dbo.ProjectExecutive ( ProjectExecutiveId,ProjectId,ExecutiveId,DepartmentId )

			SELECT		ProjectExecutiveId	=	NEWID(),
						ProjectId			= a.ProjectId,
						--ProjectName			= a.ProjectName,
						ExecutiveId			= a.ExecutiveId,
						--ExecutiveName		= a.ExecutiveName
						DepartmentId		= @DepartmentId
			FROM	(
						SELECT		ProjectId			= x.ProjectId,
									ProjectName			= x.ProjectName,
									ExecutiveId			= y.ExecutiveId,
									ExecutiveName		= y.ExecutiveName,
									DepartmentId		= @DepartmentId
						FROM	(
									SELECT ProjectId,ProjectName FROM dbo.Project p WHERE ProjectName IN ('Grey’s Anatomy','Scandal')
								) x
						CROSS JOIN
								(
									SELECT ExecutiveId,ExecutiveName FROM dbo.Executive WHERE ExecutiveName IN ('Channing Dungey','Nne Ebong','Amy Hartwick','Zack Olin')
								) y
					) a
			LEFT JOIN	dbo.ProjectExecutive pe
			ON			a.ExecutiveId = pe.ExecutiveId 
			AND			a.DepartmentId = pe.DepartmentId
			AND			a.ProjectId = pe.ProjectId
			WHERE		pe.ProjectExecutiveId IS NULL

			EXEC		dbo.GetDMSNetworkCreativeExecutive


			update		dbo.Network
			set			IsActive = 0

			update		dbo.Network
			set			IsActive = 1
			Where		NetworkName = 'ABC Studios'


			Declare		@RoleId UNIQUEIDENTIFIER
			select		@RoleId = RoleId from dbo.Roles r where RoleName = 'BA Negotiator'


			Insert		dbo.Users	
					(
						UserId,
						UserName,
						Login,
						RoleId,
						PropertyValuesString,
						IsActive,
						LastActivityDate
					)
			select 
						x.UserId,
						x.UserName,
						x.Login,
						RoleId = @RoleId,
						x.PropertyValuesString,
						x.IsActive,
						x.LastActivityDate
			from	(
			select 
						UserId = newid(),
						UserName = 'Jacqui Grunfeld',
						Login = 'swna\grunj001',
						--RoleId = @RoleId,
						PropertyValuesString = '<Preferences>
  <DisplayName></DisplayName>
  <Theme />
  <RememberLastTab>false</RememberLastTab>
  <RowsPerTable>15</RowsPerTable>
  <OpenPage>Master</OpenPage>
  <CollapseLeftPanel>false</CollapseLeftPanel>
  <MergeOption />
  <NetworkList />
</Preferences>',
						IsActive = 1,
						LastActivityDate = GETDATE()
			UNION
			select 
						UserId = newid(),
						UserName = 'Ray Caldito',
						Login = 'swna\caldr001',
						--RoleId = @RoleId,
						PropertyValuesString = '<Preferences>
  <DisplayName></DisplayName>
  <Theme />
  <RememberLastTab>false</RememberLastTab>
  <RowsPerTable>15</RowsPerTable>
  <OpenPage>Master</OpenPage>
  <CollapseLeftPanel>false</CollapseLeftPanel>
  <MergeOption />
  <NetworkList />
</Preferences>',
						IsActive = 1,
						LastActivityDate = GETDATE()
					) x
			LEFT JOIN	dbo.Users y ON x.UserName = y.UserName
			WHERE		y.UserId IS NULL


			select *
			from users u
			join dbo.Roles r on u.RoleId = r.RoleId
			Where UserName IN ('Jacqui Grunfeld','Ray Caldito')



END

*/



