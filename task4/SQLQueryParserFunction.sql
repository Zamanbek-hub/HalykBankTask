CREATE FUNCTION HandleProfiles(@Input Varchar(8000), @Delimiter  Varchar(3), @RowDelimiter Varchar(3))

RETURNS @profiles Table( firstname varchar(255), surname varchar(255), email varchar(255))
	
AS
BEGIN
	IF (@Delimiter IS NULL OR @Delimiter = '') 
            SET @Delimiter = ','
	
	IF (@RowDelimiter IS NULL OR @RowDelimiter = '')
            SET @Delimiter = ';'

	DECLARE @data VARCHAR(8000)
	DECLARE @RowDelimIndex  INT = 0 -- to get row
    DECLARE @ProfileList VARCHAR(8000) -- row
    DECLARE @DelimIndex  INT -- to get column
	

	SET @data = @Input

	DECLARE @firstname  VARCHAR(255) = ''
	DECLARE @surname VARCHAR(255) = ''
	DECLARE @email VARCHAR(255) = ''

	-- get row
	SET @RowDelimIndex = CHARINDEX(@RowDelimiter, @data, 0)
	WHILE (@RowDelimIndex != 0)
	BEGIN
		
		--handle row
		SET @ProfileList = SUBSTRING(@data,0, @RowDelimIndex)
		SET @DelimIndex = CHARINDEX(@Delimiter, @ProfileList, 0)
		DECLARE @Count INT = 0

		WHILE (@DelimIndex != 0)
		BEGIN
			SET @Count = @Count + 1 
		
			IF (@Count  = 1)
				SET @firstname = SUBSTRING(@ProfileList, 0, @DelimIndex)


			IF (@Count  = 2)
			BEGIN
				SET @surname = SUBSTRING(@ProfileList, 0, @DelimIndex)
				SET @email = SUBSTRING(@ProfileList, @DelimIndex+1, @RowDelimIndex - @DelimIndex )	
			END

			-- get column
			SET @ProfileList = SUBSTRING(@ProfileList, @DelimIndex+1, LEN(@ProfileList)-@DelimIndex)
			SET @DelimIndex = CHARINDEX(@Delimiter, @ProfileList, 0)
			
		
		
		END -- End WHILE

		-- If columns recorded insert to table
		IF (@firstname != '' AND @surname != '' AND @email != '')
		BEGIN
			Insert into @profiles(firstname, surname, email) values(@firstname, @surname, @email)
			SET @firstname = ''
			SET @firstname = ''
			SET @email = ''
			SET @Count = 0
		END

		-- overwrite data without first row
		SET @data = SUBSTRING(@data, @RowDelimIndex+1, LEN(@data)-@RowDelimIndex)
		SET @RowDelimIndex = CHARINDEX(@RowDelimiter, @data, 0)
	END -- END WHILE

	return 
END



SELECT * FROM dbo.HandleProfiles('Zamanbek,Turukbayev,zturukbayev888@gmail.com;Nurdan,Kakibay,Kakibay@gmail.com;Akzhol,Baqatay,baqatay@gmail.com;', ',', ';');