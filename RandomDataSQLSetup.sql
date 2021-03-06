-- Random Data in SQL Server
-- purpose; fills the ocassional need to generate a bunch of random text in SQL Server.
-- three files run in this order; 
-- 1) RandomDataSQLSetup.sql - sets up required tables, types, and procedures. 
-- 2) RandomDataSQLInvocationExamples.sql - run examples of various invocations. 
-- 3) RandomDataSQLWords.sql - an alternate way to generate random text in this case by using a table of words
--    in this case the text is lorem ipsum.

-- the file will setup the tables and procedures for generating random text data in sql 
-- NOTE: replace token <database/> with name of database already existing

use <database/>
go

drop procedure populateRandomDataTable;
drop procedure populateRandomDataDelimited;
drop procedure createRandomDataTable;
drop procedure createRandomDataDelimited;
drop procedure BuildRandomDataTable;
drop type RandomDataColumn;
drop procedure getRandomString;
drop procedure getErrorInfo;

go

create type RandomDataColumn as table
(
	ColumnSequence int,
	ColumnName nvarchar(100),
	ColumnType varchar(10),
	SpacePercentage int,
	StringFormat nvarchar(2),
	SizeMin int,
	SizeMax int	
)
go

create procedure getErrorInfo  
(
	@note varchar(max) = ''
)	
as  
select  
	convert( varchar, getdate(), 20) as timeRecorded,
	@note as note,
    error_number() as errorNumber, 
	error_severity() as errorSeverity,  
    error_state() as errorState,  
    error_procedure() as errorProcedure,  
    error_line() as errorLine,  
    error_message() as errorMessage;  
go 

create procedure getRandomString
(
	@sizeMin int = 10,
	@sizeMax int = 100,
	@delimiter varchar(20) = '"',
	@spacePercentage int = 20,
	@format char(2) = 'L', -- 'L' = LIMITED | 'U' = UNLIMITED | 'AN' = ALPHA-NUMERIC | 'A' = ALPHA ONLY | 'N' = NUMERIC
	@retRow nvarchar(max) output
)
as
begin
	begin try
		-- calculate length of column
		declare @columnLen int = floor( rand() * ( @sizeMax - @sizeMin + 1) + @sizeMin);

		declare @stringCharCounter int = 0;
		declare @charWork int;
		declare @stringRet nvarchar(max);
		declare @lastSpace int = 0;

		set @stringRet = '';	
		
		-- build column character by character
		while @stringCharCounter < @columnLen
		begin
			-- 48 - 93 caps, numbers and some symbols
			if(@format = 'L') -- limited 
			begin 
				set @charWork = floor( rand() * (93 - 48 + 1) + 48);
			end
		
			if(@format = 'U')  -- unlimited the code is in here but it isn't functional
			begin 
				set @charWork = floor( rand() * (126 - 32 + 1) + 32);
			end

			if(@format = 'AN')  -- alphanumeric
			begin 
				-- 65-90 #26, 48-57 #10
				-- get random number from 1 -36
				declare @ao36 int;
			
				set @ao36 =  (rand() * 36) + 1;

				if @ao36 <= 10 
				begin
					set @charWork = @ao36 + 47;
				end

				if @ao36 > 10 
				begin
					set @charWork = @ao36 + 54;
				end
			end

			if(@format = 'A')  -- alpha
			begin 
				set @charWork = floor( rand() * (90 - 65 + 1) + 65);
			end

			if(@format = 'N')  -- numeric
			begin 
				set @charWork = floor( rand() * (57 - 48 + 1) + 48);
			end

			-- % chance of adding space character between characters
			if @lastSpace = 1 
			begin
				-- if last character was space then add character 
				set @stringRet = @stringRet + convert( nvarchar, char(@charWork));	
				set @lastSpace = 0; 		
			end
			else
			begin 
				-- add spaces randomly
				declare @replaceChar int = rand() * 100;

				if(@replaceChar <= @spacePercentage)
				begin 
					-- add a space
					set @stringRet = @stringRet + ' ';
					set @lastSpace = 1; 		
				end 
				else 
				begin 
					-- add character 
					set @stringRet = @stringRet + convert( nvarchar, char(@charWork));
				end
			end
		
			set @stringCharCounter = @stringCharCounter + 1;
		end

		set @retRow = @delimiter + rtrim( ltrim( replace( @stringRet, @delimiter, ' '))) + @delimiter;
	end try
	begin catch
		print @@error;

		declare @inputParms varchar(max) = '@sizeMin = ' + convert( varchar, @sizeMin) + 
			'@sizeMax = ' + convert( varchar, @sizeMax) + 
			'@delimiter = ' + convert( varchar, @delimiter) + 
			'@spacePercentage = ' + convert( varchar, @spacePercentage) + 
			'@format = ' + convert( varchar, @format); 

		exec getErrorInfo @inputParms; 
	end catch;	
end
go

-- test invoke procedure
declare @column nvarchar(max) = '';

exec getRandomString 10, 100, '"', 20, 'N', @retRow = @column output;

select 'test invoke procedure getRandomString()',  @column;

go

create procedure createRandomDataTable
(
	@outputTableName nvarchar(100) = 'RandomDataTable',
	@dropTable int = 1,
	@colums RandomDataColumn readonly
)
as
begin
	-- create table, with values in individual columns 
	begin try

		-- drop table if exists -----------------------------
		if @dropTable = 1
		begin
			-- table form
			declare @dropSql nvarchar(300) = 'drop table ' + @outputTableName + ';';

			if exists(select 1 from sysobjects so where so.name = @outputTableName)
			begin
				execute(  @dropSql);
			end
		end

		-- build create table sql ---------------------------
		declare @COLUMNS_TOKEN nvarchar(30) = '<_!COLUMNS_TOKEN!_>';
		declare @createSql nvarchar(max) = 'create table ' + @outputTableName + ' ( ' + @COLUMNS_TOKEN + ' );';
	
		declare @columnName nvarchar(100);
		declare @columnType varchar(10);
		declare @spacePercentage int;
		declare @stringFormat nvarchar(2);
		declare @sizeMin int = 10;
		declare @sizeMax int = 20;

		-- cursor for columns
		declare cursorColumns cursor
		for
		select ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax
		from @colums
		order by ColumnSequence;

		open cursorColumns;

		fetch next from cursorColumns into @columnName, @columnType, @spacePercentage, @stringFormat, @sizeMin, @sizeMax;

		-- build columns sql 
		declare @columnSql nvarchar(max) = '';
	
		-- always add key field
		set @columnSql = @columnSql + ' Id int primary key not null,';

		while @@fetch_status = 0
		begin
			-- different data types
			if @columnType = 'INTEGER'
			begin
				set @columnSql = @columnSql + ' ' + @columnName + ' int,';
			end

			if @columnType = 'FLOAT'
			begin
				set @columnSql = @columnSql + ' ' + @columnName + ' float,';
			end

			if @columnType = 'STRING'
			begin
				set @columnSql = @columnSql + ' ' + @columnName + ' nvarchar( ' + convert( nvarchar, @sizeMax) + '),';
			end

			fetch next from cursorColumns into @columnName, @columnType, @spacePercentage, @stringFormat, @sizeMin, @sizeMax;
		end

		close cursorColumns;
		deallocate cursorColumns;

		-- truncate final comma from columns
		set @columnSql = substring( @columnSql, 0, len( @columnSql));

		-- replace token in create table with columns 
		set @createSql = replace( @createSql, @COLUMNS_TOKEN, @columnSql);

		-- exec create table statement 
		execute( @createSql); 
	end try
	begin catch
		print @@error;

		declare @inputParms varchar(max) = 
			'@outputTableName = ' + convert( varchar, @outputTableName) + 
			'@dropTable = ' + convert( varchar, @dropTable); 

		exec getErrorInfo @inputParms; 
	end catch;	
end 
go

create procedure createRandomDataDelimited
(
	@outputTableName nvarchar(100) = 'RandomDataTable',
	@dropTable int = 1,
	@colums RandomDataColumn readonly
)
as
begin
	-- create table, with two fields and delimited data in field DelimitedRow
	begin try

		-- drop table if exists 
		if @dropTable = 1
		begin
			-- table form
			declare @dropSql nvarchar(300) = 'drop table ' + @outputTableName + ';';

			if exists(select 1 from sysobjects so where so.name = @outputTableName)
			begin
				execute(  @dropSql);
			end
		end

		-- D = Delimited, a table with all values in delimited field 
		declare @createSql nvarchar(max) = 'create table [' + @outputTableName + '] ( Id int identity(1,1) primary key not null, DelimitedRow nvarchar(max) not null);'

		execute(@createSql);

	end try
	begin catch
		print @@error;

		declare @inputParms varchar(max) = 
			'@outputTableName = ' + convert( varchar, @outputTableName) + 
			'@dropTable = ' + convert( varchar, @dropTable); 

		exec getErrorInfo @inputParms; 
	end catch;	
end 
go

create procedure populateRandomDataTable
(	
	@outputTableName nvarchar(100) = 'RandomDataTable',
	@colums RandomDataColumn readonly,
	@rowLimit int = 5000,
	@batchSize int = 1000  -- this is the frequency of commits in records.  hiogher numbers will likely perform better for large data sets.
)
as
begin
	-- add random data to table --
	set nocount on;

	begin try	
		-- major loop variables  
		declare @rowCounter int;  
		declare @numericWork int;
		declare @floatWork float;

		declare @rowSql nvarchar(max) =  'begin tran; ';
	
		-- setup
		set @rowCounter = 0;  

		-- setup cursor for reuse
		declare cursorColumns scroll cursor
		for
		select ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax
		from @colums
		order by ColumnSequence;

		open cursorColumns;

		-- row loop 
		while @rowCounter < @rowLimit  
		begin
			declare @columnSequence int;
			declare @columnName nvarchar(100);
			declare @columnType varchar(10);
			declare @spacePercentage int;
			declare @stringFormat nvarchar(2);
			declare @sizeMin int = 10;
			declare @sizeMax int = 20;

			-- add id row to table
			set @rowSql =  @rowSql + 'insert into ' + @outputTableName + ' ( Id) values ( ' + convert( varchar, @rowCounter + 1) + '); ';

			-- update non-id fields
			set @rowSql = @rowSql + 'update ' + @outputTableName + ' set '; 

			-- fields loop
			fetch first from cursorColumns into @columnSequence, @columnName, @columnType, @spacePercentage, @stringFormat, @sizeMin, @sizeMax;

			while @@fetch_status = 0
			begin		
				-- type of column
				if @columnType = 'FLOAT'
				begin
					-- integer column loop ------------------
					set @floatWork =  rand() * ( @sizeMax - @sizeMin + 1) + @sizeMin;
					set @rowSql =  @rowSql + @columnName + ' = ' + convert( nvarchar, @floatWork) + ', '; 

				end

				if @columnType = 'INTEGER'
				begin
					-- float column loop ------------------
					set @numericWork = floor( rand() * ( @sizeMax - @sizeMin + 1) + @sizeMin);
					set @rowSql =  @rowSql + @columnName + ' = ' + convert( nvarchar, @numericWork) + ', '; 
				
				end

				if @columnType = 'STRING'
				begin
					-- string column loop ----------------
					declare @column nvarchar(max) = '';

					exec getRandomString 
						@sizeMin = @sizeMin, 
						@sizeMax = @sizeMax, 
						@delimiter = '', 
						@spacePercentage = @spacePercentage, 
						@format = @stringFormat, 
						@retRow = @column output;

					set @rowSql = @rowSql + @columnName + ' = ''' + @column + ''', ';
				end

				fetch next from cursorColumns into @columnSequence, @columnName, @columnType, @spacePercentage, @stringFormat, @sizeMin, @sizeMax;
			end

			-- truncate final comma
			set @rowSql = left( @rowSql, len(@rowSql) - 1);

			-- one transaction per row
			set @rowSql = @rowSql + ' from ' + @outputTableName + ' where ID = ' + convert( varchar, @rowCounter + 1) + '; ';

			-- commit tran every @batchSize rows; for better performance turn with large sets turn this up 
			if(@rowCounter % @batchSize = 0) 
			begin
				set @rowSql = @rowSql + ' commit tran; '; 	
				execute( @rowSql);
				set @rowSql = 'begin tran; ';
			end

			-- heartbeat - making sure it works --------------------------------------------------
			if(@rowCounter % @batchSize = 0) 
			begin
				declare @heartBeat nvarchar(max) = convert( varchar, getdate(), 20) + ' - ' + convert( varchar, @rowCounter);
				raiserror( @heartBeat, 0, 1) with nowait;
			end	

			set @rowCounter = @rowCounter + 1;  
		end;

		-- dump buffer if any
		if len( @rowSql) > 12
		begin  
			set @rowSql = @rowSql + ' commit tran; '; 	
			execute( @rowSql);
		end

		-- close up cursor
		close cursorColumns;
		deallocate cursorColumns;
	
		print convert( varchar, getdate()) + ' - ' + convert( varchar, @rowCounter);
	end try
	begin catch
		print @@error;

		declare @inputParms varchar(max) = 
			'@outputTableName = ' + convert( varchar, @outputTableName) + 
			'@rowLimit = ' + convert( varchar, @rowLimit) +
			'@batchSize = ' + convert( varchar, @batchSize);  

		exec getErrorInfo @inputParms; 
	end catch;	
end
go

create procedure populateRandomDataDelimited
(	
	@outputTableName nvarchar(100) = 'RandomDataTable',
	@colums RandomDataColumn readonly,
	@rowLimit int = 5000,
	@stringDelimiter nvarchar(10) = '"',
	@fieldDelimiter nvarchar(10) = ',',
	@batchSize int = 1000  -- this is the frequency of commits in records.  hiogher numbers will likely perform better for large data sets.
)
as
begin
	set nocount on;
	
	begin try
		-- build random data -------------------------------------------------------------------

		-- major loop 
		declare @rowCounter int;  
		declare @rowValue nvarchar(max);
		declare @numericWork int;
		declare @floatWork float;

		declare @rowSql nvarchar(max) =  'begin tran; ';
	
		-- setup
		set @rowCounter = 0;  
		set @rowValue = '';
																																																																				
		while @rowCounter < @rowLimit  
		begin
			set @rowValue = '';

			declare @columnSequence int;
			declare @columnName nvarchar(100);
			declare @columnType varchar(10);
			declare @spacePercentage int;
			declare @stringFormat nvarchar(2);
			declare @sizeMin int = 10;
			declare @sizeMax int = 20;

			declare cursorColumns cursor
			for
			select ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax
			from @colums
			order by ColumnSequence;

			open cursorColumns;

			fetch next from cursorColumns into @columnSequence, @columnName, @columnType, @spacePercentage, @stringFormat, @sizeMin, @sizeMax;

			while @@fetch_status = 0
			begin
				-- type of column
				if @columnType = 'FLOAT'
				begin
					-- integer column loop ------------------
					set @floatWork =  rand() * ( @sizeMax - @sizeMin + 1) + @sizeMin;

					set @rowValue = @rowValue + convert( nvarchar, @floatWork) + @fieldDelimiter;
				end

				if @columnType = 'INTEGER'
				begin
					-- float column loop ------------------
					set @numericWork = floor( rand() * ( @sizeMax - @sizeMin + 1) + @sizeMin);

					set @rowValue = @rowValue + convert( nvarchar, @numericWork) + @fieldDelimiter;
				end

				if @columnType = 'STRING'
				begin
					-- string column loop ----------------
					declare @column nvarchar(max) = '';

					exec getRandomString 
						@sizeMin = @sizeMin, 
						@sizeMax = @sizeMax, 
						@delimiter = @stringDelimiter, 
						@spacePercentage = @spacePercentage, 
						@format = @stringFormat, 
						@retRow = @column output;

					set @rowValue = @rowValue + @column + @fieldDelimiter;
				end

				fetch next from cursorColumns into @columnSequence, @columnName, @columnType, @spacePercentage, @stringFormat, @sizeMin, @sizeMax;
			end

			close cursorColumns;
			deallocate cursorColumns;
	
			-- truncate final delimiter
			set @rowValue = substring( @rowValue, 0, len( @rowValue) - len( @fieldDelimiter) + 1);
		
			-- add to table
			declare @insertSql nvarchar(max) = ' insert into ' + @outputTableName + ' ( DelimitedRow) values ( ''' +  @rowValue + ''' );';

			set @rowSql = @rowSql + @insertSql;

			-- execute(@insertSql);
		
			-- commit tran every @batchSize rows; for better performance turn with large sets turn this up 
			if(@rowCounter % @batchSize = 0) 
			begin
				set @rowSql = @rowSql + ' commit tran; '; 	
				execute( @rowSql);
				set @rowSql = 'begin tran; ';
			end
			
			-- heart beat just making sure it works --------------------------------------------------
			if @rowCounter % @batchSize = 0 
			begin
				declare @heartBeat nvarchar(max) = convert( varchar, getdate(), 20) + ' - ' + @rowValue;
				raiserror( @heartBeat, 0, 1) with nowait;
			end	

			set @rowCounter = @rowCounter + 1;  
		end;

		-- dump buffer if any
		if len( @rowSql) > 12
		begin  
			set @rowSql = @rowSql + ' commit tran; '; 	
			execute( @rowSql);
		end
	
		print convert( varchar, getdate(), 20) + ' - ' + convert( varchar, @rowCounter);
	end try
	begin catch
		print @@error;

		declare @inputParms varchar(max) = 
			'@outputTableName = ' + convert( varchar, @outputTableName) + 
			'@rowLimit = ' + convert( varchar, @rowLimit) +
			'@stringDelimiter = ' + convert( varchar, @stringDelimiter) +
			'@fieldDelimiter = ' + convert( varchar, @fieldDelimiter) +
			'@batchSize = ' + convert( varchar, @batchSize);  

		exec getErrorInfo @inputParms; 
	end catch;	
end
go


create procedure BuildRandomDataTable
(	
	@outputTableName nvarchar(100) = 'RandomDataTable',
	@outputForm nvarchar(1) = 'D',
	@colums RandomDataColumn readonly,
	@rowLimit int = 5000,
	@stringDelimiter nvarchar(10) = '"',
	@fieldDelimiter nvarchar(10) = ',',
	@batchSize int = 500
)
as
begin
	-- parameter descriptions
	-- 
	-- @outputTableName - name of table to create
	--
	-- @outputForm - choices 'D' or 'T'
	--	D = delimited, will result in an output table with one nvarchar(max) field with 
	--  T = table, will result in a table with individual columns from the @columns parameter.   
	--
	-- @columns - table of RandomDataColumn type 
	--	NOTE: every table gets an identity field named Id so please dont add one.
	--	fields 
	--		Column Sequence - every row needs one and they must be unique
	--		Column Name - just like it sounds
	--		ColumnType - data type for column choices; 'INTEGER','FLOAT','STRING'
	--		SpacePercentage - 0% to 100%
	--		StringFormat - Secondary type for STRING ColumnType - choices; 
	--			for INTEGER or FLOAT blank ''
	--			for STRING A, AN 
	--				A = Alpha (letters only)
	--				AN = Alphanumeric
	--				N = Numeric
	--				L = Limited (characters 48 - 93 caps, numbers and some symbols )
	--				-- unimplemented -> U = UNLIMITED (characters 32 - 126 ) 
	--		SizeMin - minumum value for integers, minimum length for strings, minimum value for floats
	--		SizeMax - maximum value for integers, maximum length for strings, maximum value for floats
	--
	-- @rowLimit - number of rows to return 
	--
	-- @stringDelimiter - for @ouputForm = 'D' the delimiter used in wrapping strings
	--   
	-- @fieldDelimiter - for @ouputForm = 'D' the delimiter used in wrapping fields
	--
	set nocount on;

	begin try
		
		if @outputForm = 'D'
		begin
			-- create random delimited data ---------------------------------------------------------------
			exec createRandomDataDelimited 
				@outputTableName = @outputTableName, 
				@dropTable = 1, 
				@colums = @colums;

			exec populateRandomDataDelimited 
				@outputTableName = @outputTableName, 
				@colums = @colums,
				@rowLimit = @rowLimit, 
				@stringDelimiter = @stringDelimiter,
				@fieldDelimiter = @fieldDelimiter,
				@batchSize = @batchSize;
		end

		if @outputForm = 'T'
		begin
			-- create random data in table with individual fields ---------------------------------------------------------------
			exec createRandomDataTable 
				@outputTableName = @outputTableName, 
				@dropTable = 1, 
				@colums = @colums;

			exec populateRandomDataTable 
				@outputTableName = @outputTableName, 
				@colums = @colums,
				@rowLimit = @rowLimit,
				@batchSize = @batchSize;
		end

		end try
	begin catch
		print @@error;

		declare @inputParms varchar(max) = 
			'@outputTableName = ' + convert( varchar, @outputTableName) + 
			'@outputForm = ' + convert( varchar, @outputForm) + 
			'@rowLimit = ' + convert( varchar, @rowLimit) +
			'@stringDelimiter = ' + convert( varchar, @stringDelimiter) +
			'@fieldDelimiter = ' + convert( varchar, @fieldDelimiter) +
			'@batchSize = ' + convert( varchar, @batchSize);  

		exec getErrorInfo @inputParms; 
	end catch;	
end

go
