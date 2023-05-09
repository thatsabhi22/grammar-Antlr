grammar PBSQL;

options {
  // antlr will generate java lexer and parser
  language = Java;
  // generated parser should create abstract syntax tree
  output   = AST;
}

tokens {
  COLUMN_NAME             = 'columnName';
  USING_CLAUSE            = 'usingClause';
  UPDATE_STATEMENT        = 'updateStatement';
  INSERT_STATEMENT        = 'insertStatement';
  DELETE_STATEMENT        = 'deleteStatement';
  SELECT_STATEMENT        = 'selectStatement';
  INTO_CLAUSE             = 'intoClause';
  SET_CLAUSE              = 'setClause';
  SQL_EQUAL_EXPRESSION    = 'sqlEqualExpression';
  DELETE_CLAUSE           = 'deleteClause';
  UPDATE_CLAUSE           = 'updateClause';
  WHERE_CLAUSE            = 'whereClause';
  FROM_CLAUSE             = 'fromClause';
  SEARCH_CONDITION        = 'searchCondition';
  RELATION_EXPRESSION     = 'relationExpression';
  UNARY_EXPRESSION        = 'unaryExpression';
  LOGICAL_EXPRESSION      = 'logicalExpresion';
  TABLE_SOURCE            = 'tableSource';
  PBID                    = 'pbid';
  LOGICAL_OPERATOR        = 'logicalOperator';
  MAT_EXPRESSION          = 'matExpression';
  SQL_STATEMENTS          = 'sqlStatements';
  SQL_STATEMENT           = 'sqlStatement';
  PREDICATE               = 'predicate';
  COLUMN_LIST             = 'columnList';
  VALUE_LIST              = 'valueList';
  VALUES_CLAUSE           = 'valuesClause';
  VARIABLE                = 'variable';
  EXISTS_CLAUSE           = 'existsClause';
  PREDICATE               = 'predicate';
  PREDICATE2              = 'predicat2';
  SUBSEARCH_CONDITION     = 'subSearchCondition';
  SUB_EXPRESSION          = 'subExpression';
  LOGICAL_OPS_VALUES      = 'logicalOpsValues';
  PREDICATE_OPTIONS       = 'predicateOptions';
  LBI_VALUES              = 'lbiValues';
  FUNCTION_CALL           = 'functionCall';
  FUNCTION_NAME           = 'functionName';
  FUNCTION_ARGUMENTS      = 'functionArguments';
  ARGU_LIST               = 'arguList';
  TABLE                   = 'table';
  DATABASE                = 'database';
  ALIAS                   = 'alias';
  SUB_TABLE_SOURCE        = 'subTableSource';
  SUB_TABLE_SOURCE_VALUE  = 'subTableSourceValue';
  QUERY_EXPRESSION        = 'queryExpression';
  SUB_QUERY_EXPRESSION    = 'subQueryExpression';
  QUERY_SPECIFICATION     = 'querySpecification';
  HAVING_CLAUSE           = 'havingClause';
  MULTI_TABLES            = 'multiTables';
  JOINED_TABLES           = 'joinedTables';
  LOWER_TABLE_SOURCE      = 'lowerTableSource';
  ORDER_BY_RULE           = 'orderByRule';
  COMPUTE                 = 'compute';
  GROUP_BY_CLAUSE         = 'groupByClause';
  SELECT_INTO_CLAUSE      = 'selectIntoClause';
  SELECT_CLAUSE           = 'selectClause';
  SELECT_LIST             = 'selectList';
  SELECT_ITEM             = 'selectItem';
  SELECT_TOKEN            = 'selectToken';
  JOINED_TABLE            = 'joinedTable';
  CROSS_JOIN              = 'crossJoin';
  INNER_JOIN              = 'innerJoin';
  OUTER_JOIN              = 'outerJoin';
  ORDER_BY_CLAUSE         = 'orderByClause';
  ORDER_BY_ITEM           = 'orderByItem';
  MULTI_VALUE_LIST        = 'multiValueList';
  DYNAMIC_SQL_STATEMENT1  = 'dynamicSqlStatement1';
  DYNAMIC_SQL_STATEMENT2  = 'dynamicSqlStatement2';
  DYNAMIC_SQL_STATEMENT3  = 'dynamicSqlStatement3';
  DYNAMIC_SQL_STATEMENT4  = 'dynamicSqlStatement4';
  USING_PARAMETERS_CLAUSE = 'usingParametersClause';
  PREPARE_CLAUSE          = 'prepareClause';
  SELECT_ITEM_EXPRESSION  = 'selectItemExpression';
  PB_SELECT_STATEMENT     = 'pbSelectStatement';
  PB_SELECT_CLAUSE        = 'pbSelectClause';
  PB_TABLES_CLAUSE        = 'pbTablesClause';
  PB_COLUMNS_CLAUSE       = 'pbColumnsClause';
  PB_ORDERBY_CLAUSE       = 'pbOrderByClause';
  PB_ARGS_CLAUSE          = 'pbArgsClause';
  PB_WHERE_CLAUSE         = 'pbWhereClause';
  PB_WHERE_CONDITION      = 'pbWhereConndition';
  PB_JOINS_CLAUSE         = 'pbJoinsClause';
  PB_JOIN                 = 'pbJoin';
}

@lexer::header {
package com.ilabs.avatar.sql.lexer;
}

@parser::header {
package com.ilabs.avatar.sql.parser;
}

sqlStatements
  :
  sqlStatement delim SEMI delim (sqlStatement delim SEMI delim)*
    ->
      ^(
        SQL_STATEMENTS sqlStatement (sqlStatement)*
       )
  ;

sqlStatement
  :
  (
    insertStatement
      ->
        ^(SQL_STATEMENT insertStatement)
    | updateStatement
      ->
        ^(SQL_STATEMENT updateStatement)
    | deleteStatement
      ->
        ^(SQL_STATEMENT deleteStatement)
    | selectStatement
      ->
        ^(SQL_STATEMENT selectStatement)
    | dynamicSqlStatement
      ->
        ^(SQL_STATEMENT dynamicSqlStatement)
    | pbSelectStatement
      ->
        ^(SQL_STATEMENT pbSelectStatement)
  )^
  ;

/************************     PBSELECT SQL STATEMENT  *****************/
pbSelectStatement
  :
  pbSelectClause delim (pbOrderByClause delim)? (pbArgsClause delim)?
    ->
      ^(
        PB_SELECT_STATEMENT pbSelectClause (pbOrderByClause)? (pbArgsClause)?
       )
  ;

pbSelectClause
  :
  'PBSELECT' LPAREN delim ('VERSION(400)' delim)? pbTablesClause delim pbColumnsClause delim pbJoinsClause delim pbWhereClause delim RPAREN delim
    ->
      ^(PB_SELECT_CLAUSE pbTablesClause pbColumnsClause pbJoinsClause pbWhereClause)
  ;

pbTablesClause
  :
  ('TABLET' LPAREN 'NAMETABLET' ASSIGNEQUAL delim stringLiteral delim RPAREN delim)+
    ->
      ^(
        PB_TABLES_CLAUSE (stringLiteral)+
       )
  ;

pbColumnsClause
  :
  (
    (
      'COLUMNC'
      | 'COMPUTEC'
    )
    LPAREN
    (
      'NAMECOLUMNC'
      | 'NAMECOMPUTEC'
    )
    delim ASSIGNEQUAL delim stringLiteral delim RPAREN delim
  )+
    ->
      ^(
        PB_COLUMNS_CLAUSE (stringLiteral)+
       )
  ;

pbJoinsClause
  :
  (pbJoin)*
    ->
      ^(
        PB_JOINS_CLAUSE (pbJoin)*
       )
  ;

pbJoin
  :
  'JOIN' delim LPAREN 'LEFT' delim ASSIGNEQUAL delim stringLiteral delim 'OP ' delim ASSIGNEQUAL delim stringLiteral delim 'RIGHT' delim ASSIGNEQUAL delim stringLiteral delim ('OUTER1 ' ASSIGNEQUAL delim stringLiteral delim)? ')' delim
    ->
      ^(
        PB_JOIN stringLiteral stringLiteral stringLiteral (stringLiteral)?
       )
  ;

pbWhereClause
  :
  (pbWhereCondition)*
    ->
      ^(
        PB_WHERE_CLAUSE (pbWhereCondition)*
       )
  ;

pbWhereCondition
  :
  WHERE delim LPAREN delim 'EXP1 ' delim ASSIGNEQUAL delim stringLiteral delim 'OP ' delim ASSIGNEQUAL delim stringLiteral delim 'EXP2 ' ASSIGNEQUAL delim stringLiteral delim ('LOGIC ' ASSIGNEQUAL delim stringLiteral delim)? RPAREN delim
    ->
      ^(
        PB_WHERE_CONDITION stringLiteral stringLiteral stringLiteral (stringLiteral)?
       )
  ;

pbOrderByClause
  :
  ('ORDERO' LPAREN 'NAMEORDERO' ASSIGNEQUAL delim stringLiteral delim 'ASC' ASSIGNEQUAL delim BOOLEAN delim RPAREN delim)+
    ->
      ^(
        PB_ORDERBY_CLAUSE (stringLiteral BOOLEAN)+
       )
  ;

pbArgsClause
  :
  ('ARGA' LPAREN 'NAMEARGA' delim ASSIGNEQUAL delim stringLiteral delim 'TYPE' delim ASSIGNEQUAL delim pbid delim RPAREN delim)+
    ->
      ^(
        PB_ARGS_CLAUSE (stringLiteral pbid)+
       )
  ;

BOOLEAN
  :
  'YES'
  | 'yes'
  | 'NO'
  | 'no'
  ;

WHERE
  :
  'where'
  | 'WHERE'
  ;

/************************     DYNAMIC SQL STATEMENT  *****************/
dynamicSqlStatement
  :
  dynamicSqlStatement1
  | dynamicSqlStatement2
  | dynamicSqlStatement3
  | dynamicSqlStatement4
  ;

/************************     DYNAMIC SQL STATEMENT  4  *****************/
dynamicSqlStatement4
  :
  'hell04'
    ->
      ^(DYNAMIC_SQL_STATEMENT4 'hell04')
  ;

/************************     DYNAMIC SQL STATEMENT  3  *****************/
dynamicSqlStatement3
  :
  'hell03'
    ->
      ^(DYNAMIC_SQL_STATEMENT3 'hell03')
  ;

/************************     DYNAMIC SQL STATEMENT  2  *****************/
dynamicSqlStatement2
  :
  prepareClause delim SEMI delim EXECUTE delim pbid delim (usingParametersClause)?
    ->
      ^(
        DYNAMIC_SQL_STATEMENT2 prepareClause SEMI EXECUTE pbid (usingParametersClause)?
       )
  ;

prepareClause
  :
  PREPARE delim pbid delim FROM delim sqlQuery delim (usingClause)? delim
    ->
      ^(
        PREPARE_CLAUSE PREPARE pbid FROM sqlQuery (usingClause)?
       )
  ;

PREPARE
  :
  'prepare'
  | 'PREPARE'
  ;

EXECUTE
  :
  'EXECUTE'
  | 'execute'
  ;

IMMEDIATE
  :
  'IMMEDIATE'
  | 'immediate'
  ;

/************************     DYNAMIC SQL STATEMENT  1  *****************/
dynamicSqlStatement1
  :
  EXECUTE delim IMMEDIATE delim sqlQuery delim (usingClause)?
    ->
      ^(
        DYNAMIC_SQL_STATEMENT1 EXECUTE IMMEDIATE sqlQuery (usingClause)?
       )
  ;

sqlQuery
  :
  variable
  | QuotedIdentifier
  ;

/************************     SQL SELECT STATEMENT   *****************/
selectStatement
  :
  queryExpression delim (usingClause)? delim
    ->
      ^(
        SELECT_STATEMENT queryExpression (usingClause)?
       )
  ;

queryExpression
  :
  subQueryExpression delim (unionOperator delim (ALL)? delim subQueryExpression delim)* (orderByClause)? delim
    ->
      ^(
        QUERY_EXPRESSION subQueryExpression (unionOperator (ALL)? subQueryExpression)* (orderByClause)?
       )
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
  selectClause delim (selectIntoClause)? delim (fromClause)? delim (whereClause)? delim groupByClause? delim havingClause? delim delim
    ->
      ^(
        QUERY_SPECIFICATION selectClause (selectIntoClause)? (fromClause)? (whereClause)? groupByClause? havingClause?
       )
  ;

selectIntoClause
  :
  INTO delim variable delim (COMMA delim variable delim)*
    ->
      ^(
        SELECT_INTO_CLAUSE variable (variable)*
       )
  ;

selectClause
  :
  SELECT delim (DISTINCT delim)? selectList delim
    ->
      ^(
        SELECT_CLAUSE (DISTINCT)? selectList
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
  GROUP delim BY delim (ALL)? delim selectItemExpression delim (COMMA delim selectItemExpression delim)* delim
    ->
      ^(
        GROUP_BY_CLAUSE (ALL)? selectItemExpression (selectItemExpression)*
       )
  ;

havingClause
  :
  HAVING delim searchCondition delim
    ->
      ^(HAVING_CLAUSE searchCondition)
  ;

selectList
  :
  selectItem delim (COMMA delim selectItem delim)* delim
    ->
      ^(
        SELECT_LIST selectItem (selectItem)*
       )
  ;

selectItem
  :
  selectItemExpression delim (AS)? delim (alias)?
    ->
      ^(
        SELECT_ITEM selectItemExpression (AS)? (alias)?
       )
  ;

selectItemExpression
  :
  selectToken delim (arithmeticOperator delim selectToken delim)*
    ->
      ^(
        SELECT_ITEM_EXPRESSION selectToken (arithmeticOperator selectToken)*
       )
  | LPAREN delim selectToken delim (arithmeticOperator delim selectToken delim)* RPAREN delim
    ->
      ^(
        SELECT_ITEM_EXPRESSION LPAREN selectToken (arithmeticOperator selectToken)* RPAREN
       )
  | LPAREN delim querySpecification delim RPAREN delim
    ->
      ^(SELECT_ITEM_EXPRESSION LPAREN querySpecification RPAREN)
  ;

selectToken
  :
  STAR delim
    ->
      ^(SELECT_TOKEN STAR)
  | column delim
    ->
      ^(SELECT_TOKEN column)
  | table DOT_STAR delim
    ->
      ^(SELECT_TOKEN table DOT_STAR)
  | table DOT column delim
    ->
      ^(SELECT_TOKEN table DOT column)
  | database DOT table DOT column delim
    ->
      ^(SELECT_TOKEN database DOT table DOT column)
  | functionCall delim
    ->
      ^(SELECT_TOKEN functionCall)
  | NUMBER delim
    ->
      ^(SELECT_TOKEN NUMBER)
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
    | LCPAREN delim pbid delim subTableSourceValue delim (joinedTable delim)* RCPAREN delim
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
  (database DOT)? table delim (AS)? delim (alias)? delim (WITH delim LPAREN delim pbid delim RPAREN delim)?
    ->
      ^(
        SUB_TABLE_SOURCE_VALUE (database DOT)? table (AS)? (alias)?
       )
  | LPAREN delim querySpecification delim RPAREN delim (AS)? delim alias delim
    ->
      ^(SUB_TABLE_SOURCE_VALUE LPAREN querySpecification RPAREN alias)
  ;

/***********************      SQL UPDATE STATEMENT   *****************/
updateStatement
  :
  updateClause delim (setClause)? delim (fromClause)? delim (whereClause)? delim (usingClause)?
    ->
      ^(
        UPDATE_STATEMENT updateClause (setClause)? (fromClause)? (whereClause)? (usingClause)?
       )
  ;

updateClause
  :
  UPDATE tableSource
    ->
      ^(UPDATE_CLAUSE tableSource)
  ;

setClause
  :
  SET sqlEqualExpression (delim COMMA sqlEqualExpression)*
    ->
      ^(
        SET_CLAUSE sqlEqualExpression (sqlEqualExpression)*
       )
  ;

sqlEqualExpression
  :
  column delim ASSIGNEQUAL delim matExpression
    ->
      ^(SQL_EQUAL_EXPRESSION column matExpression)
  ;

/*************************     SQL DELETE STATEMENT   **********************/
deleteStatement
  :
  deleteClause delim (fromClause)? delim (whereClause)? delim (usingClause)? delim
    ->
      ^(
        DELETE_STATEMENT (fromClause)? (whereClause)? (usingClause)?
       )
  ;

deleteClause
  :
  DELETE
  ;

/***************** insert statement **********************/
insertStatement
  :
  insertClause delim (intoClause)? delim (valuesClause)? delim (usingClause)?
    ->
      ^(
        INSERT_STATEMENT (intoClause)? (valuesClause)? (usingClause)?
       )
  ;

insertClause
  :
  INSERT
  ;

intoClause
  :
  INTO tableSource delim (columnList)?
    ->
      ^(
        INTO_CLAUSE tableSource (columnList)?
       )
  ;

valuesClause
  :
  VALUES delim multiValueList
    ->
      ^(VALUES_CLAUSE multiValueList)
  //| selectStatement delim
  //  ->
  //    ^(VALUES_CLAUSE selectStatement)
  ;

usingClause
  :
  USING delim (database DOT)? table delim
    ->
      ^(
        USING_CLAUSE (database DOT)? table
       )
  ;

usingParametersClause
  :
  USING delim variable delim (COMMA delim variable)*
    ->
      ^(
        USING_PARAMETERS_CLAUSE variable (COMMA variable)*
       )
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

logicalOp
  :
  (
    OR
    | AND
    | XOR
  )
  ;

subSearchCondition
  :
  (NOT)? delim LPAREN delim searchCondition delim RPAREN delim
    ->
      ^(
        SUBSEARCH_CONDITION (NOT)? LPAREN searchCondition RPAREN
       )
  | (NOT)? delim predicate delim
    ->
      ^(
        SUBSEARCH_CONDITION (NOT)? predicate
       )
  ;

predicate
  :
  (matExpression delim predicate2 delim
      ->
        ^(PREDICATE matExpression predicate2))
  | existsClause delim
    ->
      ^(PREDICATE existsClause)
  ;

predicate2
  :
  (
    comparisonOperator delim matExpression delim
      ->
        ^(PREDICATE2 comparisonOperator matExpression)
    | predicateOptions delim
      ->
        ^(PREDICATE2 predicateOptions)
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
    logicalOpsValues delim
      ->
        ^(PREDICATE_OPTIONS logicalOpsValues)
    | IS delim (NOT)? delim NULL
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
    (NOT)? delim LIKE delim subExpression delim (ESCAPE delim subExpression delim)? // only single char
      ->
        ^(
          LBI_VALUES (NOT)? LIKE subExpression (ESCAPE subExpression)?
         )
    | (NOT)? delim BETWEEN delim subExpression AND delim subExpression delim
      ->
        ^(
          LBI_VALUES (NOT)? BETWEEN subExpression AND subExpression
         )
    | (NOT)? delim IN delim valueList delim
      ->
        ^(
          LBI_VALUES (NOT)? IN valueList
         )
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
  (LPAREN delim matExpression (delim COMMA delim matExpression)* delim RPAREN delim)
    ->
      ^(
        VALUE_LIST matExpression (matExpression)*
       )
  | matExpression delim
    ->
      ^(VALUE_LIST matExpression)
  ;

subExpression
  :
  (unaryOperator delim)? constant delim (AS)? delim (alias)? delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? constant (AS)? (alias)?
       )
  | (unaryOperator delim)? NUMBER delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? NUMBER
       )
  | (unaryOperator delim)? functionCall delim (AS)? delim (alias)? delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? functionCall (AS)? (alias)?
       )
  | (unaryOperator delim)? column delim (AS)? delim (alias)? delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? column
       )
  | (unaryOperator delim)? variable delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? variable
       )
  | (unaryOperator delim)? table DOT column delim (AS)? delim (alias)? delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? table DOT column (AS)? (alias)?
       )
  | (unaryOperator delim)? database DOT table DOT column delim (AS)? delim (alias)? delim
    ->
      ^(
        SUB_EXPRESSION (unaryOperator)? database DOT table DOT column (AS)? (alias)?
       )
  ;

columnList
  :
  (LPAREN delim column (delim COMMA delim column delim)* RPAREN delim)
    ->
      ^(
        COLUMN_LIST column (column)*
       )
  ;

functionCall
  :
  functionName LPAREN delim functionArguments delim RPAREN delim
    ->
      ^(FUNCTION_CALL functionName LPAREN functionArguments RPAREN)
  ;

functionName
  :
  pbid
    ->
      ^(FUNCTION_NAME pbid)
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
  pbid
    ->
      ^(ALIAS pbid)
  | stringLiteral
    ->
      ^(ALIAS stringLiteral)
  ;

table
  :
  pbid
    ->
      ^(TABLE pbid)
  | variable
    ->
      ^(TABLE variable)
  | stringLiteral
    ->
      ^(TABLE stringLiteral)
  ;

database
  :
  pbid
    ->
      ^(DATABASE pbid)
  | stringLiteral
    ->
      ^(DATABASE stringLiteral)
  ;

tableColumns
  :
  (
    stringLiteral
    | variable
    | pbid
  )
  DOT_STAR
  ;

column
  :
  pbid
    ->
      ^(COLUMN_NAME pbid)
  | stringLiteral
    ->
      ^(COLUMN_NAME stringLiteral)
  ;

value
  :
  variable
  | matExpression
  | LPAREN delim matExpression delim RPAREN delim
    ->
      ^(LPAREN matExpression RPAREN)
  // | pbid
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

ALL
  :
  'ALL'
  | 'all'
  ;

DISTINCT
  :
  'DISTINCT'
  | 'distinct'
  ;

AND
  :
  (
    'a'
    | 'A'
  )
  (
    'n'
    | 'N'
  )
  (
    'd'
    | 'D'
  )
  ;

ANY
  :
  'any'
  | 'ANY'
  ;

AS
  :
  (
    'a'
    | 'A'
  )
  (
    's'
    | 'S'
  )
  ;

ASC
  :
  'asc'
  | 'ASC'
  ;

BETWEEN
  :
  'between'
  | 'BETWEEN'
  ;

BINARY
  :
  'binary'
  | 'BINARY'
  ;

BY
  :
  (
    'b'
    | 'B'
  )
  (
    'y'
    | 'Y'
  )
  ;

CASCADE
  :
  'cascade'
  | 'CASCADE'
  ;

CLOSE
  :
  'close'
  | 'CLOSE'
  ;

COLUMN
  :
  'column'
  | 'COLUMN'
  ;

COMMIT
  :
  'commit'
  | 'COMMIT'
  ;

CREATE
  :
  'create'
  | 'CREATE'
  ;

DELETE
  :
  'delete'
  | 'DELETE'
  ;

DESC
  :
  'desc'
  | 'DESC'
  ;

DOUBLE
  :
  'double'
  | 'DOUBLE'
  ;

ELSE
  :
  'else'
  | 'ELSE'
  ;

END
  :
  'end'
  | 'END'
  ;

EXISTS
  :
  'exists'
  | 'EXISTS'
  ;

EXIT
  :
  'exit'
  | 'EXIT'
  ;

FOR
  :
  'for'
  | 'FOR'
  ;

FROM
  :
  'from'
  | 'FROM'
  ;

FULL
  :
  'FULL'
  | 'full'
  ;

GROUP
  :
  'GROUP'
  | 'group'
  ;

HASH
  :
  'HASH'
  | 'hash'
  ;

HAVING
  :
  'HAVING'
  | 'having'
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

INSERT
  :
  'INSERT'
  | 'insert'
  ;

INTO
  :
  'INTO'
  | 'into'
  ;

JOIN
  :
  (
    'j'
    | 'J'
  )
  (
    'o'
    | 'O'
  )
  (
    'i'
    | 'I'
  )
  (
    'n'
    | 'N'
  )
  ;

LEFT
  :
  'LEFT'
  | 'left'
  ;

LIKE
  :
  'LIKE'
  | 'like'
  ;

MERGE
  :
  'MERGE'
  | 'merge'
  ;

NOT
  :
  'NOT'
  | 'not'
  | '!'
  ;

NULL
  :
  'NULL'
  | 'null'
  ;

OR
  :
  'OR'
  | 'or'
  ;

XOR
  :
  'XOR'
  | 'xor'
  ;

ORDER
  :
  (
    'o'
    | 'O'
  )
  (
    'r'
    | 'R'
  )
  (
    'd'
    | 'D'
  )
  (
    'e'
    | 'E'
  )
  (
    'r'
    | 'R'
  )
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
  'SELECT'
  | 'select'
  | 'selectblob'
  | 'SELECTBLOB'
  ;

SET
  :
  'SET'
  | 'set'
  ;

THEN
  :
  'THEN'
  | 'then'
  ;

ESCAPE
  :
  'ESCAPE'
  | 'escape'
  ;

TO
  :
  'TO'
  | 'to'
  ;

TOP
  :
  'TOP'
  | 'top'
  ;

UPDATE
  :
  'UPDATE'
  | 'update'
  | 'UPDATEBLOB'
  | 'updateblob'
  ;

USING
  :
  'USING'
  | 'using'
  ;

VALUES
  :
  'VALUES'
  | 'values'
  ;

WHEN
  :
  'WHEN'
  | 'when'
  ;

WITH
  :
  'WITH'
  | 'with'
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

pbid
  :
  delim ID_PARTS
    ->
      ^(PBID ID_PARTS)
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
    | '-'
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

MOD
  :
  '%'
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

variable
  :
  COLON pbid
    ->
      ^(VARIABLE pbid)
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

unionOperator
  :
  UNION
  ;
