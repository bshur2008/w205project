
add jar /project/libs/hivexmlserde-1.0.5.3.jar;

CREATE DATABASE IF NOT EXISTS raw ;

DROP TABLE IF EXISTS raw.wikipedia ;

CREATE EXTERNAL TABLE IF NOT EXISTS raw.wikipedia
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
LOCATION  '/user/w205/wp'
TBLPROPERTIES (
"xmlinput.start"="<page>",
"xmlinput.end"="</page>"
)
;

