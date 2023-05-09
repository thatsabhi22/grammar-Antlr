grammar TDSql;

options {
  // antlr will generate java lexer and parser
  language = Java;
  // generated parser should create abstract syntax tree
  output   = AST;
}

tokens {
  COLUMN_NAME                = 'columnName';
  SELECT_STATEMENT           = 'selectStatement';
  WHERE_CLAUSE               = 'whereClause';
  FROM_CLAUSE                = 'fromClause';
  SEARCH_CONDITION           = 'searchCondition';
  RELATION_EXPRESSION        = 'relationExpression';
  UNARY_EXPRESSION           = 'unaryExpression';
  LOGICAL_EXPRESSION         = 'logicalExpresion';
  TABLE_SOURCE               = 'tableSource';
  SQLID                      = 'sqlid';
  LOGICAL_OPERATOR           = 'logicalOperator';
  MAT_EXPRESSION             = 'matExpression';
  CAT_EXPRESSION             = 'catExpression';
  SQL_STATEMENTS             = 'sqlStatements';
  SQL_STATEMENT              = 'sqlStatement';
  PREDICATE                  = 'predicate';
  COLUMN_LIST                = 'columnList';
  VALUE_LIST                 = 'valueList';
  VALUES_CLAUSE              = 'valuesClause';
  EXISTS_CLAUSE              = 'existsClause';
  PREDICATE                  = 'predicate';
  PREDICATE2                 = 'predicat2';
  SUBSEARCH_CONDITION        = 'subSearchCondition';
  SUB_EXPRESSION             = 'subExpression';
  LOGICAL_OPS_VALUES         = 'logicalOpsValues';
  PREDICATE_OPTIONS          = 'predicateOptions';
  LBI_VALUES                 = 'lbiValues';
  FUNCTION_CALL              = 'functionCall';
  FUNCTION_NAME              = 'functionName';
  FUNCTION_ARGUMENTS         = 'functionArguments';
  ARGU_LIST                  = 'arguList';
  TABLE                      = 'table';
  DATABASE                   = 'database';
  ALIAS                      = 'alias';
  SUB_TABLE_SOURCE           = 'subTableSource';
  SUB_TABLE_SOURCE_VALUE     = 'subTableSourceValue';
  QUERY_EXPRESSION           = 'queryExpression';
  SUB_QUERY_EXPRESSION       = 'subQueryExpression';
  QUERY_SPECIFICATION        = 'querySpecification';
  HAVING_CLAUSE              = 'havingClause';
  MULTI_TABLES               = 'multiTables';
  JOINED_TABLES              = 'joinedTables';
  LOWER_TABLE_SOURCE         = 'lowerTableSource';
  ORDER_BY_RULE              = 'orderByRule';
  COMPUTE                    = 'compute';
  GROUP_BY_CLAUSE            = 'groupByClause';
  SELECT_CLAUSE              = 'selectClause';
  SELECT_LIST                = 'selectList';
  SELECT_ITEM                = 'selectItem';
  SELECT_TOKEN               = 'selectToken';
  JOINED_TABLE               = 'joinedTable';
  CROSS_JOIN                 = 'crossJoin';
  INNER_JOIN                 = 'innerJoin';
  OUTER_JOIN                 = 'outerJoin';
  ORDER_BY_CLAUSE            = 'orderByClause';
  ORDER_BY_ITEM              = 'orderByItem';
  MULTI_VALUE_LIST           = 'multiValueList';
  SELECT_ITEM_EXPRESSION     = 'selectItemExpression';
  AGGREGATE_FUNCTION_CALL    = 'aggregateFunctionCall';
  COUNT_FUNCTION             = 'countFunction';
  MAX_FUNCTION               = 'maxFunction';
  AVG_FUNCTION               = 'avgFunction';
  MIN_FUNCTION               = 'minFunction';
  SUM_FUNCTION               = 'sumFunction';
  ADD_MONTHS_FUNCTION        = 'addMonthsFunction';
  TO_CHAR_FUNCTION           = 'toCharFunction';
  POSITION_FUNCTION          = 'positionFunction';
  CALENDER_FUNCTION          = 'calenderFunction';
  EXTRACT_FUNCTION           = 'extractFunction';
  TRIM_FUNCTION              = 'trimFunction';
  TRIM_OPTION                = 'trimOption';
  DATE_TIME_LITERAL          = 'dateTimeLiteral';
  TYPE_FUNCTION              = 'typeFunction';
  TITLE_FUNCTION             = 'titleFunction';
  LDIFF_FUNCTION             = 'ldiffFunction';
  RDIFF_FUNCTION             = 'rdiffFunction';
  CASE_STATEMENT             = 'caseStatement';
  CASE_STATEMENT1            = 'caseStatement1';
  CASE_STATEMENT2            = 'caseStatement2';
  CASE_WHEN_THEN             = 'caseWhenThen';
  CASE_WHEN_THEN2            = 'caseWhenThen2';
  CASE_ELSE                  = 'caseElse';
  DATE_DATATYPE              = 'dateDataType';
  INT_DATATYPE               = 'intDataType';
  DECIMAL_DATATYPE           = 'decimalDataType';
  CHAR_DATATYPE              = 'charDataType';
  FORMAT_ALIAS_EXPRESSION    = 'formatAliasExpression';
  ALIAS_EXPRESSION1          = 'aliasExpression1';
  ALIAS_EXPRESSION2          = 'aliasExpression2';
  FORMAT_EXPRESSION          = 'formatExpression';
  NAMED_EXPRESSION           = 'namedExpression';
  TITLE_EXPRESSION           = 'titleExpression';
  BUSINESS_CALENDER_FUNCTION = 'businessCalenderFunction';
  CAST_FUNCTION              = 'castFunction';
  DATA_TYPE_EXPRESSION       = 'dataTypeExpression';
  LIKE_EXPRESSION            = 'likeExpression';
  SELECT_CAT_EXPRESSION      = 'selectCatExpression';
  SELECT_ARITH_EXPRESSION    = 'selectArithExpression';
  UPDATE_STATEMENT           = 'updateStatement';
  INSERT_STATEMENT           = 'insertStatement';
  DELETE_STATEMENT           = 'deleteStatement';
  UPDATE_CLAUSE              = 'updateClause';
  SET_CLAUSE                 = 'setClause';
  INTO_CLAUSE                = 'intoClause';
  SQL_EQUAL_EXPRESSION       = 'sqlEqualExpression';
  U_I_M_E                    = 'uime';
}

@lexer::header {
package com.dm.sql.lexer;
}

@parser::header {
package com.dm.sql.parser;
}

sqlStatements
  :
  delim sqlStatement delim SEMI delim (sqlStatement delim SEMI delim)*
    ->
      ^(
        SQL_STATEMENTS sqlStatement (sqlStatement)*
       )
  ;

sqlStatement
  :
  selectStatement
    ->
      ^(SQL_STATEMENT selectStatement)
  | insertStatement
    ->
      ^(SQL_STATEMENT insertStatement)
  | updateStatement
    ->
      ^(SQL_STATEMENT updateStatement)
  | deleteStatement
    ->
      ^(SQL_STATEMENT deleteStatement)
  ;

updateStatement
  :
  updateClause delim (fromClause)? delim (setClause)? delim (whereClause)? delim
    ->
      ^(
        UPDATE_STATEMENT updateClause (fromClause)? (setClause)? (whereClause)?
       )
  ;

updateClause
  :
  UPDATE delim tableSource delim
    ->
      ^(UPDATE_CLAUSE tableSource)
  ;

setClause
  :
  SET delim sqlEqualExpression delim (COMMA delim sqlEqualExpression delim)*
    ->
      ^(
        SET_CLAUSE sqlEqualExpression (sqlEqualExpression)*
       )
  ;

sqlEqualExpression
  :
  selectToken delim ASSIGNEQUAL delim catExpression delim ALL? delim
    ->
      ^(SQL_EQUAL_EXPRESSION selectToken catExpression)
  ;

/***************** insert statement **********************/
insertStatement
  :
  insertClause delim (intoClause)? delim (valuesClause)? delim
    ->
      ^(
        INSERT_STATEMENT (intoClause)? (valuesClause)?
       )
  ;

insertClause
  :
  INSERT
  ;

intoClause
  :
  INTO delim tableSource delim (columnList delim)?
    ->
      ^(
        INTO_CLAUSE tableSource (columnList)?
       )
  ;

valuesClause
  :
  VALUES delim multiValueList delim
    ->
      ^(VALUES_CLAUSE multiValueList)
  | selectStatement delim
    ->
      ^(VALUES_CLAUSE selectStatement)
  ;

deleteStatement
  :
  deleteClause delim (fromClause)? delim (whereClause)? delim
    ->
      ^(
        DELETE_STATEMENT (fromClause)? (whereClause)?
       )
  ;

deleteClause
  :
  DELETE
  ;

/************************     SQL SELECT STATEMENT   *****************/
selectStatement
  :
  queryExpression delim
    ->
      ^(SELECT_STATEMENT queryExpression)
  ;

queryExpression
  :
  subQueryExpression delim (unionIntersectMinusExcept delim subQueryExpression delim)* (orderByClause delim)?
    ->
      ^(
        QUERY_EXPRESSION subQueryExpression (unionIntersectMinusExcept subQueryExpression)* (orderByClause)?
       )
  ;

unionIntersectMinusExcept
  :
  unionOperator delim (ALL delim)?
    ->
      ^(
        U_I_M_E unionOperator (ALL)?
       )
  | INTERSECT delim
    ->
      ^(U_I_M_E INTERSECT)
  | MINUSC delim
    ->
      ^(U_I_M_E MINUSC)
  | EXCEPT delim
    ->
      ^(U_I_M_E EXCEPT)
  ;

subQueryExpression
  :
  querySpecification delim
    ->
      ^(SUB_QUERY_EXPRESSION querySpecification)
  | LPAREN delim queryExpression delim RPAREN delim
    ->
      ^(SUB_QUERY_EXPRESSION LPAREN queryExpression RPAREN)
  ;

querySpecification
  :
  selectClause delim (fromClause)? delim (whereClause)? delim (groupHaving delim)*
    ->
      ^(
        QUERY_SPECIFICATION selectClause (fromClause)? (whereClause)? (groupHaving)*
       )
  ;

groupHaving
  :
  groupByClause
  | havingClause
  ;

selectClause
  :
  SELECT delim (DISTINCT delim)? (TOP delim NUMBER delim (PERCENT delim)?)? selectList delim
    ->
      ^(
        SELECT_CLAUSE (DISTINCT)? (TOP NUMBER (PERCENT)?)? selectList
       )
  ;

orderByClause
  :
  ORDER delim BY delim orderByItem (COMMA delim orderByItem delim)*
    ->
      ^(
        ORDER_BY_CLAUSE orderByItem (orderByItem)*
       )
  ;

orderByItem
  :
  subExpression delim (orderType)? delim
    ->
      ^(
        ORDER_BY_ITEM subExpression (orderType)?
       )
  ;

orderType
  :
  (
    ASC
    | DESC
  )
  ;

groupByClause
  :
  GROUP delim BY delim (set_quantifier)? delim selectItemExpression delim (COMMA delim selectItemExpression delim)*
    ->
      ^(
        GROUP_BY_CLAUSE (set_quantifier)? selectItemExpression (selectItemExpression)*
       )
  ;

set_quantifier
  :
  DISTINCT
  | ALL
  ;

havingClause
  :
  HAVING delim searchCondition delim
    ->
      ^(HAVING_CLAUSE searchCondition)
  ;

selectList
  :
  selectItem delim (COMMA delim selectItem delim)*
    ->
      ^(
        SELECT_LIST selectItem (selectItem)*
       )
  ;

selectItem
  :
  selectItemExpression delim formatAliasExpression delim
    ->
      ^(SELECT_ITEM selectItemExpression formatAliasExpression)
  ;

selectItemExpression
  :
  selectCatExpression delim
    ->
      ^(SELECT_ITEM_EXPRESSION selectCatExpression)
  | LPAREN delim querySpecification delim RPAREN delim
    ->
      ^(SELECT_ITEM_EXPRESSION LPAREN querySpecification RPAREN)
  ;

selectCatExpression
  :
  selectArithExpression delim ('||' delim selectArithExpression delim)*
    ->
      ^(
        SELECT_CAT_EXPRESSION selectArithExpression (selectArithExpression)*
       )
  ;

selectArithExpression
  :
  selectToken delim (arithmeticOperator delim selectToken delim)*
    ->
      ^(
        SELECT_ARITH_EXPRESSION selectToken (arithmeticOperator selectToken)*
       )
  ;

selectToken
  :
  STAR delim
    ->
      ^(SELECT_TOKEN STAR)
  | (table DOT_STAR delim) => table DOT_STAR delim
    ->
      ^(SELECT_TOKEN table DOT_STAR)
  | database DOT table DOT column delim
    ->
      ^(SELECT_TOKEN database DOT table DOT column)
  | table DOT column delim
    ->
      ^(SELECT_TOKEN table DOT column)
  | column delim
    ->
      ^(SELECT_TOKEN column)
  | functionCall delim
    ->
      ^(SELECT_TOKEN functionCall)
  | NUMBER delim
    ->
      ^(SELECT_TOKEN NUMBER)
  | dateTimeLiteral delim
    ->
      ^(SELECT_TOKEN dateTimeLiteral)
  | caseStatement delim
    ->
      ^(SELECT_TOKEN caseStatement)
  | LPAREN delim selectItemExpression RPAREN delim
    ->
      ^(SELECT_TOKEN LPAREN selectItemExpression RPAREN)
  ;

tableSource
  :
  subTableSource delim (joinedTable delim)*
    ->
      ^(
        TABLE_SOURCE subTableSource (joinedTable)*
       )
  ;

subTableSource
  :
  (
    subTableSourceValue delim (joinedTable delim)*
      ->
        ^(
          SUB_TABLE_SOURCE subTableSourceValue (joinedTable)*
         )
    | LCPAREN delim sqlid delim subTableSourceValue delim (joinedTable delim)* RCPAREN delim
      ->
        ^(
          SUB_TABLE_SOURCE subTableSourceValue (joinedTable)*
         )
    | LPAREN delim tableSource delim RPAREN delim
      ->
        ^(SUB_TABLE_SOURCE LPAREN tableSource RPAREN)
  )
  ;

joinedTable
  :
  crossTableJoin delim JOIN delim subTableSource delim
    ->
      ^(JOINED_TABLE crossTableJoin JOIN subTableSource)
  | (innerOuterTableJoin)? delim JOIN delim subTableSource delim ON delim searchCondition delim
    ->
      ^(
        JOINED_TABLE (innerOuterTableJoin)? JOIN subTableSource ON searchCondition
       )
  ;

crossTableJoin
  :
  CROSS delim
    ->
      ^(CROSS_JOIN CROSS)
  ;

innerOuterTableJoin
  :
  INNER delim
    ->
      ^(INNER_JOIN INNER)
  | flrJoin delim (OUTER)? delim
    ->
      ^(
        OUTER_JOIN flrJoin (OUTER)?
       )
  ;

flrJoin
  :
  (
    LEFT
    | RIGHT
    | FULL
  )
  ;

subTableSourceValue
  :
  (database DOT)? table delim aliasExpression1 delim
    ->
      ^(
        SUB_TABLE_SOURCE_VALUE (database DOT)? table aliasExpression1
       )
  | LPAREN delim querySpecification delim RPAREN delim aliasExpression2 delim
    ->
      ^(SUB_TABLE_SOURCE_VALUE LPAREN querySpecification RPAREN aliasExpression2)
  ;

fromClause
  :
  FROM delim tableSource delim (COMMA delim tableSource)*
    ->
      ^(
        FROM_CLAUSE tableSource (tableSource)*
       )
  ;

whereClause
  :
  WHERE delim searchCondition
    ->
      ^(WHERE_CLAUSE searchCondition)
  ;

searchCondition
  :
  logicalExpression
    ->
      ^(SEARCH_CONDITION logicalExpression)
  ;

logicalExpression
  :
  subSearchCondition delim (logicalOp delim subSearchCondition delim)*
    ->
      ^(
        LOGICAL_EXPRESSION subSearchCondition (logicalOp subSearchCondition)*
       )
  ;

subSearchCondition
  :
  ( (NOT delim)? predicate delim) => (NOT delim)? predicate delim
    ->
      ^(
        SUBSEARCH_CONDITION (NOT)? predicate
       )
  | (NOT delim)? LPAREN delim searchCondition delim RPAREN delim
    ->
      ^(
        SUBSEARCH_CONDITION (NOT)? LPAREN searchCondition RPAREN
       )
  ;

logicalOp
  :
  (
    OR
    | AND
    | XOR
  )
  ;

predicate
  :
  valueList delim predicate2 delim
      ->
        ^(PREDICATE valueList predicate2)
  | existsClause delim
    ->
      ^(PREDICATE existsClause)
  ;

predicate2
  :
  (
    (NOT delim)? comparisonOperator delim logicalOpsValues delim
      ->
        ^(
          PREDICATE2 (NOT)? comparisonOperator logicalOpsValues
         )
    | predicateOptions delim
      ->
        ^(PREDICATE2 predicateOptions)
    | (NOT delim)? comparisonOperator delim catExpression delim
      ->
        ^(
          PREDICATE2 (NOT)? comparisonOperator catExpression
         )
  )
  ;

catExpression
  :
  matExpression delim ('||' delim matExpression delim)*
    ->
      ^(
        CAT_EXPRESSION matExpression (matExpression)*
       )
  ;

matExpression
  :
  subExpression delim (arithmeticOperator delim subExpression delim)*
    ->
      ^(
        MAT_EXPRESSION subExpression (arithmeticOperator subExpression)*
       )
  | LPAREN delim querySpecification delim RPAREN delim
    ->
      ^(MAT_EXPRESSION LPAREN querySpecification RPAREN)
  ;

existsClause
  :
  EXISTS delim valueList delim
    ->
      ^(EXISTS_CLAUSE EXISTS valueList)
  ;

predicateOptions
  :
  (
    IS delim (NOT)? delim NULL
      ->
        ^(
          PREDICATE_OPTIONS IS (NOT)? NULL
         )
    | lbiValues delim
      ->
        ^(PREDICATE_OPTIONS lbiValues)
  )
  ;

logicalOpsValues
  :
  (
    logicalOp2 delim valueList delim
      ->
        ^(LOGICAL_OPS_VALUES logicalOp2 valueList)
    | logicalOp delim LPAREN delim selectStatement delim RPAREN delim
      ->
        ^(LOGICAL_OPS_VALUES logicalOp LPAREN selectStatement RPAREN)
  )
  ;

logicalOp2
  :
  (
    ALL
    | SOME
    | ANY
  )
  ;

lbiValues
  :
  (
    (NOT)? delim likeExpression
      ->
        ^(
          LBI_VALUES (NOT)? likeExpression
         )
    | (NOT)? delim BETWEEN delim subExpression AND delim subExpression delim
      ->
        ^(
          LBI_VALUES (NOT)? BETWEEN subExpression AND subExpression
         )
    | (NOT)? delim IN delim inValueList delim
      ->
        ^(
          LBI_VALUES (NOT)? IN inValueList
         )
  )
  ;

likeExpression
  :
  LIKE delim (likeOperator delim)? inValueList delim (ESCAPE delim stringLiteral delim)?
    ->
      ^(
        LIKE_EXPRESSION LIKE (likeOperator)? inValueList (ESCAPE stringLiteral)?
       )
  ;

multiValueList
  :
  valueList delim (COMMA delim valueList delim)*
    ->
      ^(
        MULTI_VALUE_LIST valueList (COMMA valueList)*
       )
  ;

valueList
  :
  (catExpression delim) => catExpression delim
    ->
      ^(VALUE_LIST catExpression)
  | LPAREN delim catExpression delim (COMMA delim catExpression delim)* RPAREN delim
    ->
      ^(
        VALUE_LIST LPAREN catExpression (catExpression)* RPAREN
       )
  ;

inValueList
  :
  valueList
  | (LPAREN delim NUMBER delim TO delim NUMBER delim RPAREN delim)
    ->
      ^(VALUE_LIST NUMBER TO NUMBER)
  ;

caseStatement
  :
  CASE delim caseStatement1 delim END delim
    ->
      ^(CASE_STATEMENT caseStatement1)
  | CASE delim caseStatement2 delim END delim
    ->
      ^(CASE_STATEMENT caseStatement2)
  ;

caseStatement2
  :
  caseWhenThen2 (caseWhenThen2)* caseElse? delim
    ->
      ^(
        CASE_STATEMENT2 caseWhenThen2 (caseWhenThen2)* caseElse?
       )
  ;

caseWhenThen2
  :
  WHEN delim searchCondition delim THEN delim catExpression delim
    ->
      ^(CASE_WHEN_THEN2 searchCondition catExpression)
  ;

caseStatement1
  :
  column delim caseWhenThen (caseWhenThen)* caseElse?
    ->
      ^(
        CASE_STATEMENT1 column caseWhenThen (caseWhenThen)* caseElse?
       )
  ;

caseElse
  :
  ELSE delim catExpression delim
    ->
      ^(CASE_ELSE catExpression)
  ;

caseWhenThen
  :
  WHEN delim catExpression delim THEN delim catExpression delim
    ->
      ^(CASE_WHEN_THEN catExpression catExpression)
  ;

dateTimeLiteral
  :
  dateLiteral
  | timeLiteral
  | timeStampLiteral
  | current_date
  | current_timestamp
  | current_time
  | date
  | time
  ;

timeStampLiteral
  :
  (timestamp delim)? stringLiteral
    ->
      ^(
        DATE_TIME_LITERAL (timestamp)? stringLiteral
       )
  ;

dateLiteral
  :
  (date delim)? stringLiteral
    ->
      ^(
        DATE_TIME_LITERAL (date)? stringLiteral
       )
  ;

timeLiteral
  :
  (time delim)? stringLiteral
    ->
      ^(
        DATE_TIME_LITERAL (time)? stringLiteral
       )
  ;

timestamp
  :
  'TIMESTAMP'
  | 'timestamp'
  ;

time
  :
  'TIME'
  | 'time'
  ;

year
  :
  'year'
  | 'YEAR'
  ;

month
  :
  'month'
  | 'MONTH'
  ;

date
  :
  'DATE'
  | 'date'
  ;

day
  :
  'DAY'
  | 'day'
  ;

hour
  :
  'hour'
  | 'HOUR'
  ;

minute
  :
  'minute'
  | 'MINUTE'
  ;

second
  :
  'second'
  | 'SECOND'
  ;

current_date
  :
  'CURRENT_DATE'
  | 'current_date'
  ;

current_time
  :
  'current_time'
  | 'CURRENT_TIME'
  ;

timezone_hour
  :
  'timezone_hour'
  | 'TIMEZONE_HOUR'
  ;

timezone_minute
  :
  'timezone_minute'
  | 'TIMEZONE_MINUTE'
  ;

current_timestamp
  :
  'CURRENT_TIMESTAMP'
  | 'current_timestamp'
  ;

add_months
  :
  'ADD_MONTHS'
  | 'add_months'
  ;

position
  :
  'position'
  | 'POSITION'
  ;

extract
  :
  'extract'
  | 'EXTRACT'
  ;

trim
  :
  'trim'
  | 'TRIM'
  ;

to_char
  :
  'to_char'
  | 'TO_CHAR'
  ;

type
  :
  'type'
  | 'TYPE'
  ;

ldiff
  :
  'ldiff'
  | 'LDIFF'
  ;

rdiff
  :
  'rdiff'
  | 'RDIFF'
  ;

commaor
  :
  COMMA
  | OR
  ;

subExpression
  :
  (caseStatement delim formatAliasExpression delim) => caseStatement delim formatAliasExpression delim
    ->
      ^(SUB_EXPRESSION caseStatement formatAliasExpression)
  | ( (unaryOperator delim)? functionCall delim formatAliasExpression delim) => (unaryOperator delim)? functionCall delim formatAliasExpression delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? functionCall formatAliasExpression
       )
  | ( (unaryOperator delim)? database DOT table DOT column delim formatAliasExpression delim) => (unaryOperator delim)? database DOT table DOT column delim formatAliasExpression delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? database DOT table DOT column formatAliasExpression
       )
  | ( (unaryOperator delim)? table DOT column delim formatAliasExpression delim) => (unaryOperator delim)? table DOT column delim formatAliasExpression delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? table DOT column formatAliasExpression
       )
  | ( (unaryOperator delim)? column delim formatAliasExpression delim) => (unaryOperator delim)? column delim formatAliasExpression delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? column formatAliasExpression
       )
  | ( (unaryOperator delim)? constant delim formatAliasExpression delim) => (unaryOperator delim)? constant delim formatAliasExpression delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? constant formatAliasExpression
       )
  | (unaryOperator delim)? NUMBER delim formatAliasExpression delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? NUMBER formatAliasExpression
       )
  | current_date delim delim formatAliasExpression delim
    ->
      ^(SUB_EXPRESSION current_date formatAliasExpression)
  | current_time delim delim formatAliasExpression delim
    ->
      ^(SUB_EXPRESSION current_time formatAliasExpression)
  | current_timestamp delim formatAliasExpression delim
    ->
      ^(SUB_EXPRESSION current_timestamp formatAliasExpression)
  | LCPAREN delim sqlid delim stringLiteral delim RCPAREN delim
    ->
      ^(SUB_EXPRESSION LCPAREN sqlid stringLiteral RCPAREN)
  | dateTimeLiteral delim
    ->
      ^(SUB_EXPRESSION dateTimeLiteral)
  | LPAREN delim catExpression delim RPAREN delim
    ->
      ^(SUB_EXPRESSION LPAREN catExpression RPAREN)
  ;

columnList
  :
  (LPAREN delim column delim (COMMA delim column)* RPAREN delim)
    ->
      ^(
        COLUMN_LIST column (column)*
       )
  ;

aggregateFunctionCall
  :
  countFunction
  | sumFunction
  | avgFunction
  | maxFunction
  | minFunction
  | addMonthsFunction
  | toCharFunction
  | positionFunction
  | calenderFunction
  | businessCalenderFunction
  | extractFunction
  | trimFunction
  | titleFunction
  | typeFunction
  | ldiffFunction
  | rdiffFunction
  | castFunction
  ;

ldiffFunction
  :
  column delim ldiff delim column delim
    ->
      ^(LDIFF_FUNCTION column column)
  ;

rdiffFunction
  :
  column delim rdiff delim column delim
    ->
      ^(RDIFF_FUNCTION column column)
  ;

typeFunction
  :
  type delim LPAREN delim ( (database DOT)? table DOT)? column delim RPAREN delim
    ->
      ^(
        TYPE_FUNCTION ( (database)? table)? column
       )
  ;

castFunction
  :
  cast delim LPAREN delim catExpression delim AS delim dataType delim (ftmExpressions delim)? RPAREN delim
    ->
      ^(
        CAST_FUNCTION cast catExpression dataType (ftmExpressions)?
       )
  ;

titleFunction
  :
  title delim LPAREN delim ( (database DOT)? table DOT)? column delim RPAREN delim
    ->
      ^(
        TITLE_FUNCTION ( (database)? table)? column
       )
  ;

trimFunction
  :
  trim delim LPAREN delim trimOption? delim catExpression delim RPAREN delim
    ->
      ^(TRIM_FUNCTION trimOption? catExpression)
  ;

trimOption
  :
  trimType delim trimExpression? delim FROM delim
    ->
      ^(TRIM_OPTION trimType trimExpression?)
  ;

trimExpression
  :
  stringLiteral
  | column
  ;

trimCharSet
  :
  '_Latin'
  | '_Unicode'
  | '_KanjiSJIS'
  | '_Graphic'
  ;

trimType
  :
  'BOTH'
  | 'TRAILING'
  | 'LEADING'
  ;

extractFunction
  :
  extract delim LPAREN delim extractType delim FROM delim catExpression delim RPAREN delim
    ->
      ^(EXTRACT_FUNCTION extractType catExpression)
  ;

extractType
  :
  day
  | hour
  | minute
  | second
  | timezone_hour
  | timezone_minute
  | year
  | month
  ;

calenderFunction
  :
  ('SYSLIB' DOT)? calenderFunctionName delim LPAREN delim catExpression delim RPAREN delim
    ->
      ^(
        CALENDER_FUNCTION ('SYSLIB' DOT)? calenderFunctionName catExpression
       )
  ;

businessCalenderFunction
  :
  ('TD_SYSFNLIB' DOT)? businessCalenderFunctionName delim LPAREN delim catExpression delim (COMMA delim stringLiteral delim)? RPAREN delim
    ->
      ^(
        BUSINESS_CALENDER_FUNCTION ('TD_SYSFNLIB' DOT)? businessCalenderFunctionName catExpression (COMMA stringLiteral)?
       )
  ;

businessCalenderFunctionName
  :
  'td_week_begin'
  | 'td_week_end'
  | 'td_sunday'
  | 'td_monday'
  | 'td_tuesday'
  | 'td_wednesday'
  | 'td_thursday'
  | 'td_friday'
  | 'td_saturday'
  | 'daynumber_of_week'
  | 'td_month_begin'
  | 'td_month_end'
  | 'daynumber_of_month'
  | 'dayoccurrence_of_month'
  | 'weeknumber_of_month'
  | 'td_year_begin'
  | 'td_year_end'
  | 'daynumber_of_year'
  | 'weeknumber_of_year'
  | 'monthnumber_of_year'
  | 'td_quarter_begin'
  | 'td_quarter_end'
  | 'weeknumber_of_quarter'
  | 'monthnumber_of_quarter'
  | 'quarternumber_of_year'
  | 'daynumber_of_calendar'
  | 'weeknumber_of_calendar'
  | 'monthnumber_of_calendar'
  | 'quarternumber_of_calendar'
  | 'yearnumber_of_calendar'
  | 'TD_WEEK_BEGIN'
  | 'TD_WEEK_END'
  | 'TD_SUNDAY'
  | 'TD_MONDAY'
  | 'TD_TUESDAY'
  | 'TD_WEDNESDAY'
  | 'TD_THURSDAY'
  | 'TD_FRIDAY'
  | 'TD_SATURDAY'
  | 'DAYNUMBER_OF_WEEK'
  | 'TD_MONTH_BEGIN'
  | 'TD_MONTH_END'
  | 'DAYNUMBER_OF_MONTH'
  | 'DAYOCCURRENCE_OF_MONTH'
  | 'WEEKNUMBER_OF_MONTH'
  | 'TD_YEAR_BEGIN'
  | 'TD_YEAR_END'
  | 'DAYNUMBER_OF_YEAR'
  | 'WEEKNUMBER_OF_YEAR'
  | 'MONTHNUMBER_OF_YEAR'
  | 'TD_QUARTER_BEGIN'
  | 'TD_QUARTER_END'
  | 'WEEKNUMBER_OF_QUARTER'
  | 'MONTHNUMBER_OF_QUARTER'
  | 'QUARTERNUMBER_OF_YEAR'
  | 'DAYNUMBER_OF_CALENDAR'
  | 'WEEKNUMBER_OF_CALENDAR'
  | 'MONTHNUMBER_OF_CALENDAR'
  | 'QUARTERNUMBER_OF_CALENDAR'
  | 'YEARNUMBER_OF_CALENDAR'
  ;

calenderFunctionName
  :
  'td_weekday_of_month'
  | 'td_day_of_week'
  | 'td_day_of_year'
  | 'td_day_of_month'
  | 'td_day_of_calendar'
  | 'td_week_of_month'
  | 'td_week_of_year'
  | 'td_week_of_calendar'
  | 'td_month_of_quarter'
  | 'td_month_of_year'
  | 'td_month_of_calendar'
  | 'td_quarter_of_year'
  | 'td_quarter_of_calendar'
  | 'td_year_of_calendar'
  | 'TD_WEEKDAY_OF_MONTH'
  | 'TD_DAY_OF_WEEK'
  | 'TD_DAY_OF_YEAR'
  | 'TD_DAY_OF_MONTH'
  | 'TD_DAY_OF_CALENDAR'
  | 'TD_WEEK_OF_MONTH'
  | 'TD_WEEK_OF_YEAR'
  | 'TD_WEEK_OF_CALENDAR'
  | 'TD_MONTH_OF_QUARTER'
  | 'TD_MONTH_OF_YEAR'
  | 'TD_MONTH_OF_CALENDAR'
  | 'TD_QUARTER_OF_YEAR'
  | 'TD_QUARTER_OF_CALENDAR'
  | 'TD_YEAR_OF_CALENDAR'
  ;

positionFunction
  :
  position delim LPAREN delim catExpression delim IN delim catExpression delim RPAREN delim
    ->
      ^(POSITION_FUNCTION catExpression catExpression)
  ;

addMonthsFunction
  :
  add_months delim LPAREN delim subExpression delim (COMMA delim catExpression delim)? RPAREN delim
    ->
      ^(
        ADD_MONTHS_FUNCTION subExpression (catExpression)?
       )
  ;

toCharFunction
  :
  to_char delim LPAREN delim subExpression delim (COMMA delim catExpression delim)? RPAREN delim
    ->
      ^(
        TO_CHAR_FUNCTION subExpression (catExpression)?
       )
  ;

minFunction
  :
  MIN delim LPAREN delim (countOperator delim)? value delim RPAREN delim
    ->
      ^(
        MIN_FUNCTION (countOperator)? value
       )
  ;

maxFunction
  :
  MAX delim LPAREN delim (countOperator delim)? value delim RPAREN delim
    ->
      ^(
        MAX_FUNCTION (countOperator)? value
       )
  ;

sumFunction
  :
  SUM delim LPAREN delim (countOperator delim)? value delim RPAREN delim
    ->
      ^(
        SUM_FUNCTION (countOperator)? value
       )
  ;

avgFunction
  :
  AVG delim LPAREN delim (countOperator delim)? value delim RPAREN delim
    ->
      ^(
        AVG_FUNCTION (countOperator)? value
       )
  ;

countFunction
  :
  COUNT delim LPAREN delim STAR delim delim RPAREN delim
    ->
      ^(COUNT_FUNCTION STAR)
  | COUNT delim LPAREN delim (countOperator delim)? value delim delim RPAREN delim
    ->
      ^(
        COUNT_FUNCTION (countOperator)? value
       )
  ;

functionCall
  :
  aggregateFunctionCall delim
    ->
      ^(AGGREGATE_FUNCTION_CALL aggregateFunctionCall)
  | functionName delim LPAREN delim functionArguments delim RPAREN delim
    ->
      ^(FUNCTION_CALL functionName functionArguments)
  ;

functionName
  :
  sqlid
    ->
      ^(FUNCTION_NAME sqlid)
  | END
    ->
      ^(FUNCTION_NAME END)
  ;

functionArguments
  :
  arguList delim
    ->
      ^(FUNCTION_ARGUMENTS arguList)
  ;

arguList
  :
  (
    (value delim (COMMA delim value delim)*)?
      ->
        ^(
          ARGU_LIST (value (value)*)?
         )
  )
  ;

alias
  :
  sqlid
    ->
      ^(ALIAS sqlid)
  | stringLiteral
    ->
      ^(ALIAS stringLiteral)
  ;

formatAliasExpression
  :
  (dataTypeExpression delim)? (ftmExpressions delim)? aliasExpression1 delim
    ->
      ^(
        FORMAT_ALIAS_EXPRESSION (dataTypeExpression)? (ftmExpressions)? aliasExpression1
       )
  ;

ftmExpressions
  :
  ftmExpression ftmExpression*
  ;

ftmExpressions2
  :
  ftmExpression (COMMA delim ftmExpression)*
  ;

ftmExpression
  :
  (
    formatExpression
    | titleExpression
    | namedExpression
  )
  ;

namedExpression
  :
  LPAREN delim named delim sqlid delim RPAREN delim
    ->
      ^(NAMED_EXPRESSION named sqlid)
  | named delim sqlid delim
    ->
      ^(NAMED_EXPRESSION named sqlid)
  ;

titleExpression
  :
  LPAREN delim title delim stringLiteral delim RPAREN delim
    ->
      ^(TITLE_EXPRESSION title stringLiteral)
  | title delim stringLiteral delim
    ->
      ^(TITLE_EXPRESSION title stringLiteral)
  ;

formatExpression
  :
  LPAREN delim format delim stringLiteral delim RPAREN delim
    ->
      ^(FORMAT_EXPRESSION format stringLiteral)
  | format delim stringLiteral delim
    ->
      ^(FORMAT_EXPRESSION format stringLiteral)
  ;

aliasExpression1
  :
  (AS)? delim (alias)? delim
    ->
      ^(
        ALIAS_EXPRESSION1 (AS)? (alias)?
       )
  ;

aliasExpression2
  :
  (AS)? delim alias delim
    ->
      ^(
        ALIAS_EXPRESSION2 (AS)? alias
       )
  ;

dataTypeExpression
  :
  LPAREN delim dataType delim (COMMA delim (ftmExpressions2 delim)?)? RPAREN delim
    ->
      ^(
        DATA_TYPE_EXPRESSION dataType (ftmExpressions2)?
       )
  ;

MOD
  :
  '%'
  | 'MOD'
  | 'mod'
  ;

dataType
  :
  dateDateType
  | integerDataType
  | decimalDataType
  | charDataType
  ;

dateDateType
  :
  time
    ->
      ^(DATE_DATATYPE time)
  | date
    ->
      ^(DATE_DATATYPE date)
  | timestamp
    ->
      ^(DATE_DATATYPE timestamp)
  ;

integerDataType
  :
  INT
    ->
      ^(INT_DATATYPE INT)
  ;

decimalDataType
  :
  DECIMAL delim (LPAREN delim NUMBER delim COMMA delim NUMBER delim RPAREN delim)?
    ->
      ^(
        DECIMAL_DATATYPE DECIMAL (NUMBER NUMBER)?
       )
  ;

charDataType
  :
  CHAR delim (LPAREN delim NUMBER delim RPAREN delim)?
    ->
      ^(
        CHAR_DATATYPE CHAR (NUMBER)?
       )
  ;

table
  :
  sqlid
    ->
      ^(TABLE sqlid)
  | stringLiteral
    ->
      ^(TABLE stringLiteral)
  ;

database
  :
  sqlid
    ->
      ^(DATABASE sqlid)
  | stringLiteral
    ->
      ^(DATABASE stringLiteral)
  ;

tableColumns
  :
  (
    stringLiteral
    | sqlid
  )
  DOT_STAR
  ;

column
  :
  sqlid
    ->
      ^(COLUMN_NAME sqlid)
  | stringLiteral
    ->
      ^(COLUMN_NAME stringLiteral)
  ;

value
  :
  (catExpression) => catExpression
  | LPAREN delim catExpression delim RPAREN delim
    ->
      ^(LPAREN catExpression RPAREN)
  // | sqlid
  // | stringLiteral
  // | NUMBER
  // | NULL
  ;

// ***************** lexer rules:
//the grammar must contain at least one lexer rule

DELIM
  :
  'delim'
  ;

INT
  :
  I N T
  | I N T E G E R
  | S M A L L I N T
  ;

DECIMAL
  :
  D E C I M A L
  | D E C
  ;

format
  :
  'format'
  | 'FORMAT'
  ;

cast
  :
  'cast'
  | 'CAST'
  ;

title
  :
  'title'
  | 'TITLE'
  ;

named
  :
  'named'
  | 'NAMED'
  ;

CHAR
  :
  C H A R
  | V A R C H A R
  ;

ALL
  :
  A L L
  ;

DISTINCT
  :
  D I S T I N C T
  ;

PERCENT
  :
  P E R C E N T
  ;

AND
  :
  A N D
  ;

ANY
  :
  A N Y
  ;

AS
  :
  A S
  ;

ASC
  :
  A S C
  ;

COUNT
  :
  C O U N T
  ;

SUM
  :
  S U M
  ;

AVG
  :
  A V G
  | A V E
  | A V E R A G E
  ;

MAX
  :
  M A X
  | M A X I M U M
  ;

TO
  :
  T O
  ;

MIN
  :
  M I N
  | M I N I M U M
  ;

BETWEEN
  :
  B E T W E E N
  ;

BY
  :
  B Y
  ;

COLUMN
  :
  'column'
  | 'COLUMN'
  ;

DESC
  :
  D E S C
  ;

EXISTS
  :
  E X I S T S
  ;

FROM
  :
  F R O M
  ;

FULL
  :
  F U L L
  ;

GROUP
  :
  G R O U P
  ;

HAVING
  :
  H A V I N G
  ;

IN
  :
  'IN'
  | 'in'
  ;

INNER
  :
  'INNER'
  | 'inner'
  ;

JOIN
  :
  J O I N
  ;

LEFT
  :
  'LEFT'
  | 'left'
  ;

LIKE
  :
  L I K E
  ;

MERGE
  :
  'MERGE'
  | 'merge'
  ;

NOT
  :
  N O T
  | '!'
  ;

NULL
  :
  N U L L
  ;

OR
  :
  O R
  ;

XOR
  :
  X O R
  ;

ORDER
  :
  O R D E R
  ;

OUTER
  :
  'OUTER'
  | 'outer'
  ;

CROSS
  :
  'CROSS'
  | 'cross'
  ;

ON
  :
  'ON'
  | 'on'
  ;

RIGHT
  :
  'RIGHT'
  | 'right'
  ;

SELECT
  :
  S E L E C T
  | S E L
  ;

INSERT
  :
  I N S E R T
  ;

UPDATE
  :
  U P D A T E
  ;

DELETE
  :
  D E L E T E
  ;

SET
  :
  S E T
  ;

VALUES
  :
  'VALUES'
  | 'values'
  ;

INTO
  :
  I N T O
  ;

WHERE
  :
  W H E R E
  ;

ESCAPE
  :
  'ESCAPE'
  | 'escape'
  ;

TOP
  :
  T O P
  ;

SOME
  :
  'SOME'
  | 'some'
  ;

UNION
  :
  'UNION'
  | 'union'
  ;

INTERSECT
  :
  'INTERSECT'
  | 'intersect'
  ;

MINUSC
  :
  'MINUS'
  | 'minus'
  ;

EXCEPT
  :
  'EXCEPT'
  | 'except'
  ;

CONTAINS
  :
  'CONTAINS'
  | 'contains'
  ;

IS
  :
  'IS'
  | 'is'
  ;

CASE
  :
  C A S E
  ;

END
  :
  E N D
  ;

WHEN
  :
  W H E N
  ;

THEN
  :
  T H E N
  ;

ELSE
  :
  E L S E
  ;

NEWLINE
  :
  '\r\n'
         {
          if (state.tokenStartCharIndex == 0) {
	$channel = HIDDEN;
} else if (input.substring(state.tokenStartCharIndex - 1,
		state.tokenStartCharIndex - 1).equals("\n")) {
	$channel = HIDDEN;
} else {
	int pos = state.tokenStartCharIndex;
	boolean textFound = false;
	// Loop from the rigth to the left
	// Set $channel to HIDDEN unless you find something usefull (non-space, non-comment, non-SEMICOLON
	while (pos-- != 0) {
		String c = input.substring(pos, pos);
		String p = input.substring(pos - 1, pos - 1);
		if (c.equals("\n"))
			break;
		if (c.equals(";"))
			break;
		if (c.equals("/") && p.equals("*"))
			break;
		if (!c.equals(" ") && !c.equals("\t")) {
			textFound = true;
			break;
		}
	}
	if (!textFound) {
		$channel = HIDDEN;
	}
}
if ($channel == HIDDEN) {
	System.out.println("Empty line at: " + input.getLine());
}
         }
  ;

delim
  :
  (
    NEWLINE
    | WS
    | DELIM
    | EOF
  )?
  ;

swallow_to_semi
  :
  ~(SEMI )+
  ;

swallow_to_newline
  :
  ~(NEWLINE )+
  ;

sqlid
  :
  ID_PARTS delim
    ->
      ^(SQLID ID_PARTS)
  ;

id2
  :
  ID_PARTS
  ;

ID_PARTS
  :
  (
    'A'..'Z'
    | 'a'..'z'
  )
  (
    'A'..'Z'
    | 'a'..'z'
    | DIGIT
    //  | '-'
    | '$'
    | '#'
    | '%'
    | '_'
  )*
  ;

COMMA
  :
  ','
  ;

SEMI
  :
  ';'
  ;

LPAREN
  :
  '('
  ;

RPAREN
  :
  ')'
  ;

LCPAREN
  :
  '{'
  ;

RCPAREN
  :
  '}'
  ;

LSQUARE
  :
  '['
  ;

RSQUARE
  :
  ']'
  ;

COLON
  :
  ':'
  ;

DIVIDE
  :
  '/'
  ;

PLUS
  :
  '+'
  ;

MINUS
  :
  '-'
  ;

STAR
  :
  '*'
  ;

ASSIGNEQUAL
  :
  '='
  ;

NOTEQUAL1
  :
  '<>'
  ;

NOTEQUAL2
  :
  '!='
  ;

LESSTHANOREQUALTO1
  :
  '<='
  ;

LESSTHANOREQUALTO2
  :
  '!>'
  ;

LESSTHAN
  :
  '<'
  ;

GREATERTHANOREQUALTO1
  :
  '>='
  ;

GREATERTHANOREQUALTO2
  :
  '!<'
  ;

EQUALVERSION1
  :
  '*='
  ;

GREATERTHAN
  :
  '>'
  ;

AMPERSAND
  :
  '&'
  ;

TILDE
  :
  '~'
  ;

BITWISEOR
  :
  '|'
  ;

BITWISEXOR
  :
  '^'
  ;

DOT_STAR
  :
  '.*'
  ;

NUMBER
  :
  (
    (NUM POINT NUM) => NUM POINT NUM
    | POINT NUM
    | NUM
  )
  (
    'E'
    (
      '+'
      | '-'
    )?
    NUM
  )?
  (
    'D'
    | 'F'
  )?
  ;

fragment
NUM
  :
  DIGIT (DIGIT)*
  ;

DOT
  :
  POINT
  | '..'
  ;

fragment
POINT
  :
  '.'
  ;

DQUOTE
  :
  '"'
  ;

SL_COMMENT
  :
  '//'
  ~(
    '\n'
    | '\r'
   )*
  d='\r\n'
           {
            int pos = state.tokenStartCharIndex;
boolean textFound = false;
while (pos-- != 0) {
	String c = input.substring(pos, pos);
	if (c.equals("\n"))
		break;
	if (c.equals(";"))
		break;
	if (c.equals("*"))
		break;
	if (!c.equals(" ") && !c.equals("\t") && !c.equals("/")) {
		textFound = true;
		break;
	}
}
if (textFound) {
	$d.setType(DELIM);
	emit($d);
}
$channel = HIDDEN;
           }
  ;

ML_COMMENT
  :
  '/*' (options {greedy=false;}: .)* '*/' //'/'* WS* //d='\r\n'
  ;

WS
  :
  (
    ' '
    | '\t'
    | '\r'
    | '\n'
  )+

  // "0x" ('0'..'9' | 'a'..'f')*
  // generated as a part of Number rule
  // Numeric Constants
  // each statement ends with a newline but we do not want empty lines to parsed
  // PB woodoo some newlines are hidden while others are not
  ;

fragment
DIGIT
  :
  '0'..'9'
  ;

constant
  :
  NULL
  | stringLiteral
  | HexLiteral
  ;

stringLiteral
  :
  UnicodeStringLiteral
  | ASCIIStringLiteral
  | QuotedIdentifier
  | NonQuotedIdentifier
  ;

NonQuotedIdentifier
  :
  (
    'a'..'z'
    | '_'
    | '#'
    | '\u0080'..'\ufffe'
  )
  (
    LETTER
    | DIGIT
  )*
  ;

QuotedIdentifier
  :
  (
    '[' (~']')* ']' (']' (~']')* ']')*
    | '"' (~'"')* '"' ('"' (~'"')* '"')*
  )
  ;

fragment
HexLiteral: ;

fragment
LETTER
  :
  'a'..'z'
  | 'A'..'Z'
  | '_'
  | '#'
  | '@'
  | '\u0080'..'\ufffe'
  ;

ASCIIStringLiteral
  :
  '\'' (~'\'')* '\'' ('\'' (~'\'')* '\'')*
  ;

UnicodeStringLiteral
  :
  'n' '\'' (~'\'')* '\'' ('\'' (~'\'')* '\'')*
  ;

unaryOperator
  :
  PLUS
  | MINUS
  | TILDE
  ;

binaryOperator
  :
  (
    arithmeticOperator
    | bitwiseOperator
  )
  ;

arithmeticOperator
  :
  (
    PLUS
    | MINUS
    | STAR
    | DIVIDE
    | MOD
  )^
  ;

bitwiseOperator
  :
  AMPERSAND
  | TILDE
  | BITWISEOR
  | BITWISEXOR
  ;

comparisonOperator
  :
  ASSIGNEQUAL
  | NOTEQUAL1
  | NOTEQUAL2
  | LESSTHANOREQUALTO1
  | LESSTHANOREQUALTO2
  | LESSTHAN
  | GREATERTHANOREQUALTO1
  | GREATERTHANOREQUALTO2
  | GREATERTHAN
  | EQUALVERSION1
  ;

logicalOperator
  :
  (
    ALL
    | AND
    | ANY
    | BETWEEN
    | EXISTS
    | IN
    | LIKE
    | NOT
    | OR
  )
  ;

likeOperator
  :
  (
    ALL
    | SOME
    | ANY
  )
  ;

unionOperator
  :
  UNION
  ;

countOperator
  :
  (
    ALL
    | DISTINCT
  )
  ;

fragment
A
  :
  (
    'a'
    | 'A'
  )
  ;

fragment
B
  :
  (
    'b'
    | 'B'
  )
  ;

fragment
C
  :
  (
    'c'
    | 'C'
  )
  ;

fragment
D
  :
  (
    'd'
    | 'D'
  )
  ;

fragment
E
  :
  (
    'e'
    | 'E'
  )
  ;

fragment
F
  :
  (
    'f'
    | 'F'
  )
  ;

fragment
G
  :
  (
    'g'
    | 'G'
  )
  ;

fragment
H
  :
  (
    'h'
    | 'H'
  )
  ;

fragment
I
  :
  (
    'i'
    | 'I'
  )
  ;

fragment
J
  :
  (
    'j'
    | 'J'
  )
  ;

fragment
K
  :
  (
    'k'
    | 'K'
  )
  ;

fragment
L
  :
  (
    'l'
    | 'L'
  )
  ;

fragment
M
  :
  (
    'm'
    | 'M'
  )
  ;

fragment
N
  :
  (
    'n'
    | 'N'
  )
  ;

fragment
O
  :
  (
    'o'
    | 'O'
  )
  ;

fragment
P
  :
  (
    'p'
    | 'P'
  )
  ;

fragment
Q
  :
  (
    'q'
    | 'Q'
  )
  ;

fragment
R
  :
  (
    'r'
    | 'R'
  )
  ;

fragment
S
  :
  (
    's'
    | 'S'
  )
  ;

fragment
T
  :
  (
    't'
    | 'T'
  )
  ;

fragment
U
  :
  (
    'u'
    | 'U'
  )
  ;

fragment
V
  :
  (
    'v'
    | 'V'
  )
  ;

fragment
W
  :
  (
    'w'
    | 'W'
  )
  ;

fragment
X
  :
  (
    'x'
    | 'X'
  )
  ;

fragment
Y
  :
  (
    'y'
    | 'Y'
  )
  ;

fragment
Z
  :
  (
    'z'
    | 'Z'
  )
  ;
