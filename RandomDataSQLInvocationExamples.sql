-- examples of invoking RandomDataSQL procedure -----------------------------------------
-- replace token <database/> with name of target database 
--
use <database/>
go

-- delimited table ---------------------------------------------------------------------
-- generate 50,000 rows delimited takes about 1 minute 15 seconds on my workstation  
--
-- recall the parameters purpose
-- describe the random output to generate in table form and pass as table variable
-- description 
-- Column Sequence - every row needs one and they must be unique
-- Column Name - just like it sounds
-- ColumnType - data type for column choices; 'INTEGER','FLOAT','STRING'
-- SpacePercentage - 0% to 100%
-- StringFormat - Secondary type for STRING ColumnType - choices; 
--		for INTEGER or FLOAT blank ''
--		for STRING A, AN 
--			A = Alpha (letters only)
--			AN = Alphanumeric
--			N = Numeric
--			L = Limited (characters 48 - 93 caps, numbers and some symbols )
-- SizeMin - minumum value for integers, minimum length for strings, minimum value for floats
-- SizeMax - maximum value for integers, maximum length for strings, maximum value for floats
print 'start first example; ' + convert(varchar, getdate(), 108);

declare @columns RandomDataColumn;

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (2, 'CheeseNumber', 'INTEGER', 0, '', 1000, 6000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (3, 'BlueFloat', 'FLOAT', 0, '', 1, 1000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (4, 'GoldName', 'STRING', 20, 'A', 10, 20 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (5, 'IronDescription', 'STRING', 20, 'AN', 100, 300 );

-- create table of random data
exec BuildRandomDataTable
	@outputTableName = 'RandomDataDelimited', 
	@outputForm = 'D',
	@colums = @columns, 
	@rowLimit = 50000,
	@stringDelimiter = '"',  
	@fieldDelimiter = '|',
	@batchSize = 500
go

-- if all went well show our work
select top 100 * from RandomDataDelimited;
print 'end first example; ' + convert(varchar, getdate(), 108);
go

-- standard table ------------------------------------------------------------
-- generate 50,000 rows of four columns takes about 4 minutes 15 seconds on my workstation  
--
print 'start second example; ' + convert(varchar, getdate(), 108);

declare @columns RandomDataColumn;

-- build columns
insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (2, 'CheeseNumber', 'INTEGER', 0, '', 1000, 6000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (3, 'BlueFloat', 'FLOAT', 0, '', 1, 1000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (4, 'GoldName', 'STRING', 20, 'A', 10, 20 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (5, 'IronDescription', 'STRING', 20, 'AN', 100, 300 );

-- build table RandomDataTable2 with random data
exec BuildRandomDataTable 
	@outputTableName = 'RandomDataTable2', 
	@outputForm = 'T',
	@colums = @columns, 
	@rowLimit = 50000,
	@stringDelimiter = '',  
	@fieldDelimiter = '',
	@batchSize = 500
go

-- if all went well show our work
select top 100 * from RandomDataTable2;
go

print 'end second example; ' + convert(varchar, getdate(), 108);

-- big table ------------------------------------------------------------
-- generate 50,000 rows of seven columns takes about 26 minutes 15 seconds on my workstation  
--
print 'start third example; ' + convert(varchar, getdate(), 108);

set nocount on;

declare @columns RandomDataColumn;

-- build @columns with desired output
insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (2, 'GlowingHockeyStick', 'INTEGER', 0, '', 100, 100000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (3, 'jQuerry', 'FLOAT', 0, '', 2000, 40000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (4, 'TargetNumber9', 'STRING', 20, 'A', 100, 200 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (5, 'HammerHammer', 'STRING', 20, 'AN', 100, 200 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (5, 'WrenchWrench', 'STRING', 20, 'L', 1000, 3000 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (6, 'GreenWall', 'INTEGER', 0, '', 26, 38 );

insert into @columns ( ColumnSequence, ColumnName, ColumnType, SpacePercentage, StringFormat, SizeMin, SizeMax) 
values (7, 'DoubleSecond', 'STRING', 10, 'L', 1, 17 );

exec BuildRandomDataTable 
	@outputTableName = 'RandomDataTable3', 
	@outputForm = 'T',
	@colums = @columns, 
	@rowLimit = 10000,
	@stringDelimiter = '',  
	@fieldDelimiter = '',
	@batchSize = 500
go

-- if all went well show our work
select top 100 * from RandomDataTable3;
go

print 'end third example; ' + convert(varchar, getdate(), 108);
