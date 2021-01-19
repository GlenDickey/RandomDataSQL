-- Random Data by Words in SQL Server
-- RandomDataSQLWords.sql 
-- purpose; an alternate way to generate random text in this case by using a table of words in this case the text is lorem ipsum.

-- the file will setup the tables and procedures for generating random text data in sql 
-- NOTE: replace token <database/> with name of database already existing

use <database/>
go

if exists(
	select 1 
	from sysobjects 
	where id = object_id('Words' ) 
        and OBJECTPROPERTY(id, N'IsProcedure') = 0
)
begin 
	drop table Words;
end
go

create table Words 
(
	Id int identity(1,1) primary key not null,
	[Sequence] int null,
	Word nvarchar(200) not null,
	Size int not null
);
go

-- the text for the outoput will be random but based on the words from 'Lorem ipsum...'
-- you could use any text you cared to disaassemble into this table.
begin
	set nocount on;

	insert into Words ( [Sequence], Word, Size) values (1, 'sed', 3);
	insert into Words ( [Sequence], Word, Size) values (2, 'ut', 2);
	insert into Words ( [Sequence], Word, Size) values (3, 'perspiciatis', 12);
	insert into Words ( [Sequence], Word, Size) values (4, 'unde', 4);
	insert into Words ( [Sequence], Word, Size) values (5, 'omnis', 5);
	insert into Words ( [Sequence], Word, Size) values (6, 'iste', 4);
	insert into Words ( [Sequence], Word, Size) values (7, 'natus', 5);
	insert into Words ( [Sequence], Word, Size) values (8, 'error', 5);
	insert into Words ( [Sequence], Word, Size) values (9, 'sit', 3);
	insert into Words ( [Sequence], Word, Size) values (10, 'voluptatem', 10);
	insert into Words ( [Sequence], Word, Size) values (11, 'accusantium', 11);
	insert into Words ( [Sequence], Word, Size) values (12, 'doloremque', 10);
	insert into Words ( [Sequence], Word, Size) values (13, 'laudantium', 10);
	insert into Words ( [Sequence], Word, Size) values (14, 'totam', 5);
	insert into Words ( [Sequence], Word, Size) values (15, 'rem', 3);
	insert into Words ( [Sequence], Word, Size) values (16, 'aperiam', 7);
	insert into Words ( [Sequence], Word, Size) values (17, 'eaque', 5);
	insert into Words ( [Sequence], Word, Size) values (18, 'ipsa', 4);
	insert into Words ( [Sequence], Word, Size) values (19, 'quae', 4);
	insert into Words ( [Sequence], Word, Size) values (20, 'ab', 2);
	insert into Words ( [Sequence], Word, Size) values (21, 'illo', 4);
	insert into Words ( [Sequence], Word, Size) values (22, 'inventore', 9);
	insert into Words ( [Sequence], Word, Size) values (23, 'veritatis', 9);
	insert into Words ( [Sequence], Word, Size) values (24, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (25, 'quasi', 5);
	insert into Words ( [Sequence], Word, Size) values (26, 'architecto', 10);
	insert into Words ( [Sequence], Word, Size) values (27, 'beatae', 6);
	insert into Words ( [Sequence], Word, Size) values (28, 'vitae', 5);
	insert into Words ( [Sequence], Word, Size) values (29, 'dicta', 5);
	insert into Words ( [Sequence], Word, Size) values (30, 'sunt', 4);
	insert into Words ( [Sequence], Word, Size) values (31, 'explicabo', 9);
	insert into Words ( [Sequence], Word, Size) values (32, 'nemo', 4);
	insert into Words ( [Sequence], Word, Size) values (33, 'enim', 4);
	insert into Words ( [Sequence], Word, Size) values (34, 'ipsam', 5);
	insert into Words ( [Sequence], Word, Size) values (35, 'voluptatem', 10);
	insert into Words ( [Sequence], Word, Size) values (36, 'quia', 4);
	insert into Words ( [Sequence], Word, Size) values (37, 'voluptas', 8);
	insert into Words ( [Sequence], Word, Size) values (38, 'sit', 3);
	insert into Words ( [Sequence], Word, Size) values (39, 'aspernatur', 10);
	insert into Words ( [Sequence], Word, Size) values (40, 'aut', 3);
	insert into Words ( [Sequence], Word, Size) values (41, 'odit', 4);
	insert into Words ( [Sequence], Word, Size) values (42, 'aut', 3);
	insert into Words ( [Sequence], Word, Size) values (43, 'fugit', 5);
	insert into Words ( [Sequence], Word, Size) values (44, 'sed', 3);
	insert into Words ( [Sequence], Word, Size) values (45, 'quia', 4);
	insert into Words ( [Sequence], Word, Size) values (46, 'consequuntur', 12);
	insert into Words ( [Sequence], Word, Size) values (47, 'magni', 5);
	insert into Words ( [Sequence], Word, Size) values (48, 'dolores', 7);
	insert into Words ( [Sequence], Word, Size) values (49, 'eos', 3);
	insert into Words ( [Sequence], Word, Size) values (50, 'qui', 3);
	insert into Words ( [Sequence], Word, Size) values (51, 'ratione', 7);
	insert into Words ( [Sequence], Word, Size) values (52, 'voluptatem', 10);
	insert into Words ( [Sequence], Word, Size) values (53, 'sequi', 5);
	insert into Words ( [Sequence], Word, Size) values (54, 'nesciunt', 8);
	insert into Words ( [Sequence], Word, Size) values (55, 'neque', 5);
	insert into Words ( [Sequence], Word, Size) values (56, 'porro', 5);
	insert into Words ( [Sequence], Word, Size) values (57, 'quisquam', 8);
	insert into Words ( [Sequence], Word, Size) values (58, 'est', 3);
	insert into Words ( [Sequence], Word, Size) values (59, 'qui', 3);
	insert into Words ( [Sequence], Word, Size) values (60, 'dolorem', 7);
	insert into Words ( [Sequence], Word, Size) values (61, 'ipsum', 5);
	insert into Words ( [Sequence], Word, Size) values (62, 'quia', 4);
	insert into Words ( [Sequence], Word, Size) values (63, 'dolor', 5);
	insert into Words ( [Sequence], Word, Size) values (64, 'sit', 3);
	insert into Words ( [Sequence], Word, Size) values (65, 'amet', 4);
	insert into Words ( [Sequence], Word, Size) values (66, 'consectetur', 11);
	insert into Words ( [Sequence], Word, Size) values (67, 'adipiscing', 10);
	insert into Words ( [Sequence], Word, Size) values (68, 'velit', 5);
	insert into Words ( [Sequence], Word, Size) values (69, 'sed', 3);
	insert into Words ( [Sequence], Word, Size) values (70, 'quia', 4);
	insert into Words ( [Sequence], Word, Size) values (71, 'non', 3);
	insert into Words ( [Sequence], Word, Size) values (72, 'numquam', 7);
	insert into Words ( [Sequence], Word, Size) values (73, 'do', 2);
	insert into Words ( [Sequence], Word, Size) values (74, 'eius', 4);
	insert into Words ( [Sequence], Word, Size) values (75, 'modi', 4);
	insert into Words ( [Sequence], Word, Size) values (76, 'tempora', 7);
	insert into Words ( [Sequence], Word, Size) values (77, 'inci', 4);
	insert into Words ( [Sequence], Word, Size) values (78, 'di', 2);
	insert into Words ( [Sequence], Word, Size) values (79, 'dunt', 4);
	insert into Words ( [Sequence], Word, Size) values (80, 'ut', 2);
	insert into Words ( [Sequence], Word, Size) values (81, 'labore', 6);
	insert into Words ( [Sequence], Word, Size) values (82, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (83, 'dolore', 6);
	insert into Words ( [Sequence], Word, Size) values (84, 'magnam', 6);
	insert into Words ( [Sequence], Word, Size) values (85, 'aliquam', 7);
	insert into Words ( [Sequence], Word, Size) values (86, 'quaerat', 7);
	insert into Words ( [Sequence], Word, Size) values (87, 'voluptatem', 10);
	insert into Words ( [Sequence], Word, Size) values (88, 'ut', 2);
	insert into Words ( [Sequence], Word, Size) values (89, 'enim', 4);
	insert into Words ( [Sequence], Word, Size) values (90, 'ad', 2);
	insert into Words ( [Sequence], Word, Size) values (91, 'minima', 6);
	insert into Words ( [Sequence], Word, Size) values (92, 'veniam', 6);
	insert into Words ( [Sequence], Word, Size) values (93, 'quis', 4);
	insert into Words ( [Sequence], Word, Size) values (94, 'nostrumd', 8);
	insert into Words ( [Sequence], Word, Size) values (95, 'exercitationem', 14);
	insert into Words ( [Sequence], Word, Size) values (96, 'ullam', 5);
	insert into Words ( [Sequence], Word, Size) values (97, 'corporis', 8);
	insert into Words ( [Sequence], Word, Size) values (98, 'suscipit', 8);
	insert into Words ( [Sequence], Word, Size) values (99, 'laboriosam', 10);
	insert into Words ( [Sequence], Word, Size) values (100, 'nisi', 4);
	insert into Words ( [Sequence], Word, Size) values (101, 'ut', 2);
	insert into Words ( [Sequence], Word, Size) values (102, 'aliquid', 7);
	insert into Words ( [Sequence], Word, Size) values (103, 'ex', 2);
	insert into Words ( [Sequence], Word, Size) values (104, 'ea', 2);
	insert into Words ( [Sequence], Word, Size) values (105, 'commodi', 7);
	insert into Words ( [Sequence], Word, Size) values (106, 'consequatur', 11);
	insert into Words ( [Sequence], Word, Size) values (107, 'quis', 4);
	insert into Words ( [Sequence], Word, Size) values (108, 'autem', 5);
	insert into Words ( [Sequence], Word, Size) values (109, 'vel', 3);
	insert into Words ( [Sequence], Word, Size) values (110, 'eum', 3);
	insert into Words ( [Sequence], Word, Size) values (111, 'iure', 4);
	insert into Words ( [Sequence], Word, Size) values (112, 'reprehenderit', 13);
	insert into Words ( [Sequence], Word, Size) values (113, 'qui', 3);
	insert into Words ( [Sequence], Word, Size) values (114, 'in', 2);
	insert into Words ( [Sequence], Word, Size) values (115, 'ea', 2);
	insert into Words ( [Sequence], Word, Size) values (116, 'voluptate', 9);
	insert into Words ( [Sequence], Word, Size) values (117, 'velit', 5);
	insert into Words ( [Sequence], Word, Size) values (118, 'esse', 4);
	insert into Words ( [Sequence], Word, Size) values (119, 'quam', 4);
	insert into Words ( [Sequence], Word, Size) values (120, 'nihil', 5);
	insert into Words ( [Sequence], Word, Size) values (121, 'molestiae', 9);
	insert into Words ( [Sequence], Word, Size) values (122, 'consequatur', 11);
	insert into Words ( [Sequence], Word, Size) values (123, 'vel', 3);
	insert into Words ( [Sequence], Word, Size) values (124, 'illum', 5);
	insert into Words ( [Sequence], Word, Size) values (125, 'qui', 3);
	insert into Words ( [Sequence], Word, Size) values (126, 'dolorem', 7);
	insert into Words ( [Sequence], Word, Size) values (127, 'eum', 3);
	insert into Words ( [Sequence], Word, Size) values (128, 'fugiat', 6);
	insert into Words ( [Sequence], Word, Size) values (129, 'quo', 3);
	insert into Words ( [Sequence], Word, Size) values (130, 'voluptas', 8);
	insert into Words ( [Sequence], Word, Size) values (131, 'nulla', 5);
	insert into Words ( [Sequence], Word, Size) values (132, 'pariatur', 8);
	insert into Words ( [Sequence], Word, Size) values (133, 'at', 2);
	insert into Words ( [Sequence], Word, Size) values (134, 'vero', 4);
	insert into Words ( [Sequence], Word, Size) values (135, 'eos', 3);
	insert into Words ( [Sequence], Word, Size) values (136, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (137, 'accusamus', 9);
	insert into Words ( [Sequence], Word, Size) values (138, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (139, 'iusto', 5);
	insert into Words ( [Sequence], Word, Size) values (140, 'odio', 4);
	insert into Words ( [Sequence], Word, Size) values (141, 'dignissimos', 11);
	insert into Words ( [Sequence], Word, Size) values (142, 'ducimus', 7);
	insert into Words ( [Sequence], Word, Size) values (143, 'qui', 3);
	insert into Words ( [Sequence], Word, Size) values (144, 'blanditiis', 10);
	insert into Words ( [Sequence], Word, Size) values (145, 'praesentium', 11);
	insert into Words ( [Sequence], Word, Size) values (146, 'voluptatum', 10);
	insert into Words ( [Sequence], Word, Size) values (147, 'deleniti', 8);
	insert into Words ( [Sequence], Word, Size) values (148, 'atque', 5);
	insert into Words ( [Sequence], Word, Size) values (149, 'corrupti', 8);
	insert into Words ( [Sequence], Word, Size) values (150, 'quos', 4);
	insert into Words ( [Sequence], Word, Size) values (151, 'dolores', 7);
	insert into Words ( [Sequence], Word, Size) values (152, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (153, 'quas', 4);
	insert into Words ( [Sequence], Word, Size) values (154, 'molestias', 9);
	insert into Words ( [Sequence], Word, Size) values (155, 'excepturi', 9);
	insert into Words ( [Sequence], Word, Size) values (156, 'sint', 4);
	insert into Words ( [Sequence], Word, Size) values (157, 'obcaecati', 9);
	insert into Words ( [Sequence], Word, Size) values (158, 'cupiditate', 10);
	insert into Words ( [Sequence], Word, Size) values (159, 'non', 3);
	insert into Words ( [Sequence], Word, Size) values (160, 'provident', 9);
	insert into Words ( [Sequence], Word, Size) values (161, 'similique', 9);
	insert into Words ( [Sequence], Word, Size) values (162, 'sunt', 4);
	insert into Words ( [Sequence], Word, Size) values (163, 'in', 2);
	insert into Words ( [Sequence], Word, Size) values (164, 'culpa', 5);
	insert into Words ( [Sequence], Word, Size) values (165, 'qui', 3);
	insert into Words ( [Sequence], Word, Size) values (166, 'officia', 7);
	insert into Words ( [Sequence], Word, Size) values (167, 'deserunt', 8);
	insert into Words ( [Sequence], Word, Size) values (168, 'mollitia', 8);
	insert into Words ( [Sequence], Word, Size) values (169, 'animi', 5);
	insert into Words ( [Sequence], Word, Size) values (170, 'id', 2);
	insert into Words ( [Sequence], Word, Size) values (171, 'est', 3);
	insert into Words ( [Sequence], Word, Size) values (172, 'laborum', 7);
	insert into Words ( [Sequence], Word, Size) values (173, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (174, 'dolorum', 7);
	insert into Words ( [Sequence], Word, Size) values (175, 'fuga', 4);
	insert into Words ( [Sequence], Word, Size) values (176, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (177, 'harum', 5);
	insert into Words ( [Sequence], Word, Size) values (178, 'quidem', 6);
	insert into Words ( [Sequence], Word, Size) values (179, 'rerum', 5);
	insert into Words ( [Sequence], Word, Size) values (180, 'facilis', 7);
	insert into Words ( [Sequence], Word, Size) values (181, 'est', 3);
	insert into Words ( [Sequence], Word, Size) values (182, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (183, 'expedita', 8);
	insert into Words ( [Sequence], Word, Size) values (184, 'distinctio', 10);
	insert into Words ( [Sequence], Word, Size) values (185, 'nam', 3);
	insert into Words ( [Sequence], Word, Size) values (186, 'libero', 6);
	insert into Words ( [Sequence], Word, Size) values (187, 'tempore', 7);
	insert into Words ( [Sequence], Word, Size) values (188, 'cum', 3);
	insert into Words ( [Sequence], Word, Size) values (189, 'soluta', 6);
	insert into Words ( [Sequence], Word, Size) values (190, 'nobis', 5);
	insert into Words ( [Sequence], Word, Size) values (191, 'est', 3);
	insert into Words ( [Sequence], Word, Size) values (192, 'eligendi', 8);
	insert into Words ( [Sequence], Word, Size) values (193, 'optio', 5);
	insert into Words ( [Sequence], Word, Size) values (194, 'cumque', 6);
	insert into Words ( [Sequence], Word, Size) values (195, 'nihil', 5);
	insert into Words ( [Sequence], Word, Size) values (196, 'impedit', 7);
	insert into Words ( [Sequence], Word, Size) values (197, 'quo', 3);
	insert into Words ( [Sequence], Word, Size) values (198, 'minus', 5);
	insert into Words ( [Sequence], Word, Size) values (199, 'id', 2);
	insert into Words ( [Sequence], Word, Size) values (200, 'quod', 4);
	insert into Words ( [Sequence], Word, Size) values (201, 'maxime', 6);
	insert into Words ( [Sequence], Word, Size) values (202, 'placeat', 7);
	insert into Words ( [Sequence], Word, Size) values (203, 'facere', 6);
	insert into Words ( [Sequence], Word, Size) values (204, 'possimus', 8);
	insert into Words ( [Sequence], Word, Size) values (205, 'omnis', 5);
	insert into Words ( [Sequence], Word, Size) values (206, 'voluptas', 8);
	insert into Words ( [Sequence], Word, Size) values (207, 'assumenda', 9);
	insert into Words ( [Sequence], Word, Size) values (208, 'est', 3);
	insert into Words ( [Sequence], Word, Size) values (209, 'omnis', 5);
	insert into Words ( [Sequence], Word, Size) values (210, 'dolor', 5);
	insert into Words ( [Sequence], Word, Size) values (211, 'repellendus', 11);
	insert into Words ( [Sequence], Word, Size) values (212, 'temporibus', 10);
	insert into Words ( [Sequence], Word, Size) values (213, 'autem', 5);
	insert into Words ( [Sequence], Word, Size) values (214, 'quibusdam', 9);
	insert into Words ( [Sequence], Word, Size) values (215, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (216, 'aut', 3);
	insert into Words ( [Sequence], Word, Size) values (217, 'officiis', 8);
	insert into Words ( [Sequence], Word, Size) values (218, 'debitis', 7);
	insert into Words ( [Sequence], Word, Size) values (219, 'aut', 3);
	insert into Words ( [Sequence], Word, Size) values (220, 'rerum', 5);
	insert into Words ( [Sequence], Word, Size) values (221, 'necessitatibus', 14);
	insert into Words ( [Sequence], Word, Size) values (222, 'saepe', 5);
	insert into Words ( [Sequence], Word, Size) values (223, 'eveniet', 7);
	insert into Words ( [Sequence], Word, Size) values (224, 'ut', 2);
	insert into Words ( [Sequence], Word, Size) values (225, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (226, 'voluptates', 10);
	insert into Words ( [Sequence], Word, Size) values (227, 'repudiandae', 11);
	insert into Words ( [Sequence], Word, Size) values (228, 'sint', 4);
	insert into Words ( [Sequence], Word, Size) values (229, 'et', 2);
	insert into Words ( [Sequence], Word, Size) values (230, 'molestiae', 9);
	insert into Words ( [Sequence], Word, Size) values (231, 'non', 3);
	insert into Words ( [Sequence], Word, Size) values (232, 'recusandae', 10);
	insert into Words ( [Sequence], Word, Size) values (233, 'itaque', 6);
	insert into Words ( [Sequence], Word, Size) values (234, 'earum', 5);
	insert into Words ( [Sequence], Word, Size) values (235, 'rerum', 5);
	insert into Words ( [Sequence], Word, Size) values (236, 'hic', 3);
	insert into Words ( [Sequence], Word, Size) values (237, 'tenetur', 7);
	insert into Words ( [Sequence], Word, Size) values (238, 'a', 1);
	insert into Words ( [Sequence], Word, Size) values (239, 'sapiente', 8);
	insert into Words ( [Sequence], Word, Size) values (240, 'delectus', 8);
	insert into Words ( [Sequence], Word, Size) values (241, 'ut', 2);
	insert into Words ( [Sequence], Word, Size) values (242, 'aut', 3);
	insert into Words ( [Sequence], Word, Size) values (243, 'reiciendis', 10);
	insert into Words ( [Sequence], Word, Size) values (244, 'voluptatibus', 12);
	insert into Words ( [Sequence], Word, Size) values (245, 'maiores', 7);
	insert into Words ( [Sequence], Word, Size) values (246, 'alias', 5);
	insert into Words ( [Sequence], Word, Size) values (247, 'consequatur', 11);
	insert into Words ( [Sequence], Word, Size) values (248, 'aut', 3);
	insert into Words ( [Sequence], Word, Size) values (249, 'perferendis', 11);
	insert into Words ( [Sequence], Word, Size) values (250, 'doloribus', 9);
	insert into Words ( [Sequence], Word, Size) values (251, 'asperiores', 10);
	insert into Words ( [Sequence], Word, Size) values (252, 'repellat', 8);
end;
go

-- info only - length of characters 
select * from Words order by [sequence]

select 'max length of characters', sum(size) from Words

go

-- dump old version if exists
if exists(
	select 1 
	from sysobjects 
	where id = object_id('GetRandomWords' ) 
        and OBJECTPROPERTY(id, N'IsProcedure') = 1
)
begin
	drop procedure GetRandomWords;
end
go

-- create procedure for generating random words
create procedure GetRandomWords  
(
	@finalSize int,	-- input length of random text, max in sequence order is 1443 (words) + 251 (spaces) = 1694 characters
	@inOrder bit = 0,  -- should words be in order or random
	@retText nvarchar(max) out -- ouput as variable
)
as
begin
	-- example - invoking sp to return 200 characters of words in random order based on the text of lorem ipsum but not the sequence 
	-- possible output = 'quidem vel id tempore dunt ullam eos dolorum eveniet possimus suscipit aliquam blanditiis itaque vitae nisi expedita sed modi qui sunt explicabo repellat unde et provident explicabo laudantium rerum '
	--
	-- DANGER! POSSIBLE HUMOROUS OUTPUT! 
	-- the output can be translated via into english
	-- via google translate the example random string reads; 'in this respect, that the blandishments of the time they give no occasion, therefore, some of them of the sorrows of life, unless it receives the result will be able to explain to repel, whence, and who are provide in the explication thereof will unfold in praise with canticles, but in the manner of things,'
	-- if you get any 'secret messages' from this program please disregard them, telepathic communications and sending secret messages is on a different day.  
	-- i bear no responsibility or liability if you waste time translating random text

	set nocount on;

	declare @word nvarchar(200);
	declare @size int;

	declare @workSize int = @finalSize;

	declare @wordSequence int = 1;

	set @retText ='';

	if @inOrder = 1 
	begin		
		-- loop return in order
		declare @maxSequence int = 0;

		select @maxSequence = max(w.sequence)
		from Words w;

		while @workSize > 0
		begin
			-- get next word and size
			select @word = w.Word,
				@size = w.Size
			from Words w
			where w.Sequence = @wordSequence;

			-- append to return value
			set @retText = @retText + @word + ' ';
						
			if @maxSequence = @wordSequence
			begin
				-- reset counter
				set @wordSequence = 0;
			end
			else
			begin
				-- increment for next word
				set @wordSequence = @wordSequence + 1;
			end			

			-- decrement total length
			set @workSize = @workSize - ( @size + 1);
		end
	end
	else
	begin
		-- get random word
		declare @randomWord int = 0;
		declare @maxRandom int = 0;
			
		-- get count of words in tables
		select @maxRandom = count(1)
		from Words w;

		while @workSize > 0
		begin			
			-- get random word from table
			set @randomWord = rand() * @maxRandom + 1;

			-- get next word and size
			select @word = w.Word,
				@size = w.Size
			from Words w
			where w.Sequence = @randomWord;			

			-- append to return value
			set @retText = @retText + @word + ' ';

			-- decrement total length
			set @workSize = @workSize - ( @size + 1);		
		end
	end

	-- truncate to max size 
	set @retText = left( @retText, @finalSize - 1);
end
go

-- example - invoking sp to return the first 200 characters based on words in lorem ipsum in sequence
-- output = 'sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium totam rem ...' to character 200 ... the text in order limited by the length
--
declare @retText nvarchar(max) = '';

exec GetRandomWords @finalSize = 200, @inOrder = 1, @retText = @retText output

select 'words in sequence', @retText
go

-- example - invoking sp to return 200 characters of words in random order based on the text of lorem ipsum but not the sequence 
-- possible output = 'quidem vel id tempore dunt ullam eos dolorum eveniet possimus suscipit aliquam blanditiis itaque vitae nisi expedita sed modi qui sunt explicabo repellat unde et provident explicabo laudantium rerum '
--
-- DANGER! POSSIBLE HUMOROUS OUTPUT! 
-- the output can be translated via into english
-- via google translate the example random string reads; 'in this respect, that the blandishments of the time they give no occasion, therefore, some of them of the sorrows of life, unless it receives the result will be able to explain to repel, whence, and who are provide in the explication thereof will unfold in praise with canticles, but in the manner of things,'
-- if you get any 'secret messages' from this program please disregard them, telepathic communications and sending secret messages is on a different day.  
-- i bear no responsibility or liability if you waste time translating random text
--    
declare @retText nvarchar(max) = '';

exec GetRandomWords @finalSize = 200, @inOrder = 0, @retText = @retText output

select 'words at random', @retText
go
