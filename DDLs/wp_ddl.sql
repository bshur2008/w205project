
add jar /project/libs/hivexmlserde-1.0.5.3.jar;

CREATE DATABASE IF NOT EXISTS raw ;
CREATE DATABASE IF NOT EXISTS prd ;

--DROP TABLE IF EXISTS raw.es_wikipedia ;

CREATE EXTERNAL TABLE IF NOT EXISTS raw.es_wikipedia
(
	title string
	, id bigint
	, restrictions string
	, revision map<string, string>
)
ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
WITH SERDEPROPERTIES (
"column.xpath.title"="/page/title/text()",
"column.xpath.id"="/page/id/text()",
"column.xpath.restrictions"="/page/restrictions/text()",
"column.xpath.revision"="/page/revision/*"
)
STORED AS
INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
LOCATION  '/user/w205/wp/es'
TBLPROPERTIES (
"xmlinput.start"="<page>",
"xmlinput.end"="</page>"
)
;

--DROP TABLE IF EXISTS prd.wikipedia;

CREATE TABLE IF NOT EXISTS prd.wikipedia
(
	language string
	, title string
	, words array<string>
)
STORED AS ORC
;
