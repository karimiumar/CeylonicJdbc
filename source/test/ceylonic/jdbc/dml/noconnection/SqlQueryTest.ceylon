import ceylonic.jdbc {
    select,
    SelectOp
}

import java.util{
    JList = List
}

import test.ceylonic.jdbc.dml.noconnection {
    TblSupplier {
        ...
    },
    TblPerson{
        ...
    },
    TblProduct{ ... },
    TblOrder{...}

}
import ceylonic.jdbc.meta {
    ColumnValue{
        setVal
    },
    Value
}

shared void selectDistinctColumn() {
    select.select()
        .distinct(supplierName)
        .from(supplier)
        .orderBy(country)
        .asc();
    String result = select.toSql();
    String expected = "SELECT DISTINCT supplier_name FROM supplier ORDER BY country ASC";
    assert (result == expected);
    print(result);
}

shared void selectCountDistinctColumn() {
    SelectOp distinctCol = SelectOp().distinct(country);
    select.select().count(distinctCol).from(supplier);
    String result = select.toSql();
    String expected = "SELECT COUNT(DISTINCT country) FROM supplier";
    print(result);
    assert(result==expected);
}

shared void selectMySQLTop10() {
    select.select().columns({p1_country, p1_city}).from(p1).limit(10);
    String result = select.toSql();
    String expected = "SELECT p1.country,p1.city FROM person p1 LIMIT ?";
    print(result);
    assert(result == expected);
}

shared void selectMySQLOffset6To10() {
    select.select().columns({p1_country, p1_city}).from(p1).limit(5).offset(5);
    String result = select.toSql();
    String expected = "SELECT p1.country,p1.city FROM person p1 LIMIT ? OFFSET ?";
    print(result);
    assert(result == expected);
}

shared void selectUsingAlias() {
    select.select().columns({p1_id, p1_country, p1_city}).from(p1);
    String result = select.toSql();
    String expected = "SELECT p1.id,p1.country,p1.city FROM person p1";
    print(result);
    assert(result == expected);
}

shared void selectAll() {
    select.select().all().from(p1);
    String result = select.toSql();
    String expected = "SELECT * FROM person p1";
    print(result);
    assert(result == expected);
}

shared void test_in() {
    select.select().all().from(p1).where().column(p1_country)
        .in_(SelectOp().values ({setVal("Germany"), setVal("US")}));
    String result = select.toSql();
    //"SELECT * FROM person p1 WHERE p1.country IN ('Germany','US')";
    String expected = "SELECT * FROM person p1 WHERE p1.country IN (?,?)";
    print(result);
    assert(result == expected);
    JList<Value> values = select.getValues();
    for(v in values){
        print(v);
    }
}

shared void notIn() {
    select.select().all().from(p1)
        .where().column(p1_country).not().in_(SelectOp().values({setVal("Germany"), setVal("US")}));
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.country NOT  IN (?,?)";
    print(result);
    assert(result == expected);
}

shared void notInSubQuery() {
    select.select().all().from(p2)
        .where().column(p2_fname).not().in_(SelectOp().select().column(p1_fname).from(p1));
    String result = select.toSql();
    String expected = "SELECT * FROM person p2 WHERE p2.firstname NOT  IN (SELECT p1.firstname FROM person p1)";
    print(result);
    assert(result == expected);
}

shared void avg() {
    select.select().avg(unitprice).from(product);
    String result = select.toSql();
    String expected = "SELECT AVG(unit_price) FROM product";
    print(result);
    assert(result == expected);
}

shared void max() {
    select.select().max(unitprice).from(prd1);
    String result = select.toSql();
    String expected = "SELECT MAX(unit_price) FROM product prd1";
    print(result);
    assert(result == expected);
}

shared void min() {
    select.select().min(unitprice).from(product);
    String result = select.toSql();
    String expected = "SELECT MIN(unitprice) FROM product";
    print(result);
    assert(result == expected);
}

shared void sum() {
    select.select().sum(unitprice).from(product);
    String result = select.toSql();
    String expected = "SELECT SUM(unit_price) FROM product";
    print(result);
    assert(result == expected);
}

shared void asTest() {
    select.select().column(p1_fname).as("NAME").from(p1);
    String result = select.toSql();
    String expected = "SELECT p1.firstname AS NAME  FROM person p1";
    print(result);
    assert(result == expected);
}

shared void likeStartingWith_a() {
    select.select().all().from(p1).where().column(p1_fname).like("a%");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname LIKE ?";
    print(result);
    assert(result == expected);
}

shared void likeEndingWith_a() {
    select.select().all().from(p1).where().column(p1_fname).like("%a");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname LIKE ?";
    print(result);
    assert(result == expected);
}

shared void nameHaving_or() {
    select.select().all().from(p1).where().column(p1_fname).like("%or%");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname LIKE ?";
    print(result);
    assert(result == expected);
}

shared void nameHaving_r_InSecondPos() {
    select.select().all().from(p1).where().column({p1_fname}.first).like("_r%");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname LIKE ?";
    print(result);
    assert(result == expected);
}

shared void nameStartingWith_a_AndAtleast3Chars() {
    select.select().all().from(p1).where().column({p1_fname}.first).like("a_%_%");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname LIKE ?";
    print(result);
    assert(result == expected);
}

shared void nameStartsWith_a_AndEndsWith_o() {
    select.select().all().from(p1).where().column({p1_fname}.first).like("a%o");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname LIKE ?";
    print(result);
    assert(result == expected);
}

shared void notStartWith_a() {
    select.select().all().from(p1).where().column(p1_fname).not().like("a%");
    String result = select.toSql();
    String expected = "SELECT * FROM person p1 WHERE p1.firstname NOT  LIKE ?";
    print(result);
    assert(result == expected);
}

shared void betweenTextValues() {
    select.select().all().from(product).where().column(prd_name)
        .between({setVal("Carnarvon Tigers"), setVal("Mozzarella di Giovanni")});
    String result = select.toSql();
    //SELECT * FROM product WHERE product_name BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
    String expected = "SELECT * FROM product WHERE product_name BETWEEN ? AND ?";
    print(result);
    assert(result == expected);
}

shared void betweenWithIn() {
    select.select().all().from(product).where()
        .beginComplex().column(unitprice).between({setVal(10), setVal(20)}).endComplex()
        .and().not().column(cat_id).in_(SelectOp().values({setVal(1), setVal(2), setVal(3)}));
    String result = select.toSql();
    //"SELECT * FROM product WHERE (unit_price BETWEEN '10' AND '20') AND  NOT category_id IN ('1','2','3')"
    String expected = "SELECT * FROM product WHERE (unit_price BETWEEN ? AND ?) AND  NOT category_id IN (?,?,?)";
    print(result);
    assert(result == expected);
}

shared void betweenVariant() {
    select.select().all().from(product).where()
        .beginComplex().column(unitprice).between({setVal(10), setVal(20), setVal(30)}).endComplex()
        .and().not().column(cat_id).in_(SelectOp().values({setVal(1), setVal(2), setVal(3)}));
    String result = select.toSql();
    //"SELECT * FROM product WHERE (unit_price BETWEEN 10 AND 20 AND 30) AND  NOT category_id IN (1,2,3)";
    String expected = "SELECT * FROM product WHERE (unit_price BETWEEN ? AND ? AND ?) AND  NOT category_id IN (?,?,?)";
    print(result);
    assert(result == expected);
}

shared void notBetween() {
    select.select().all().from(product)
        .where().column(unitprice).not().between({setVal(10), setVal(20)});
    String result = select.toSql();
    String expected = "SELECT * FROM product WHERE unit_price NOT  BETWEEN ? AND ?";
    print(result);
    assert(result == expected);
}

shared void isNull() {
    select.select().all().from(product)
        .where().column(prd_name).is_().values({setVal(null)});
    String result = select.toSql();
    String expected = "SELECT * FROM product WHERE product_name IS ?";
    print(result);
    assert(result == expected);
}

shared void orderBy() {
    select.select().columns({productId, prd_name, unitprice})
        .from(product).where().column(unitprice).eq().values({setVal(20)})
        .orderBy(prd_name);
    String result = select.toSql();
    String expected = "SELECT id,product_name,unit_price FROM product WHERE unit_price=? ORDER BY product_name";
    print(result);
    assert(result == expected);
}

shared void groupBy() {
    select.select().count(p1_id)
        .with({p1_country})
        .from(p1).groupBy({p1_country});
    String result = select.toSql();
    String expected = "SELECT COUNT(p1.id), p1.country FROM person p1 GROUP BY p1.country";
    print(result);
    assert(result == expected);
}

shared void groupByOrderByDesc() {
    select.select().count(p1_id)
        .with({p1_country})
        .from(p1)
        .groupBy({p1_country})
        .orderBy(SelectOp().count(p1_id).toSql()).desc();
    String result = select.toSql();
    String expected = "SELECT COUNT(p1.id), p1.country FROM person p1 GROUP BY p1.country ORDER BY COUNT(p1.id) DESC";
    print(result);
    assert(result == expected);
}

shared void totalAmtOrderedForEachCustomer() {
    select.select().sum(o1_totalAmount).with({p1_fname, p1_lname})
        .from(o1)
        .join().table(p1)
        .on().column(o1_customerId).eq().column(p1_id)
        .groupBy({p1_fname, p1_lname})
        .orderBy(SelectOp().sum(o1_totalAmount).toSql()).desc();
    String result = select.toSql();
    String expected = "SELECT SUM(o1.total_amount),p1.firstname,p1.lastname FROM order o1 JOIN person p1 ON o1.customer_id=p1.id GROUP BY p1.firstname,p1.lastname ORDER BY SUM(o1.total_amount) DESC";
    print(result);
    assert(result == expected);
}

shared void havingCount() {
        select.select().count(p1_id).with({p1_country})
        .from(p1)
        .groupBy({p1_country})
        .having().count(p1_id).gt(10);
    String result = select.toSql();
    String expected = "SELECT COUNT(p1.id), p1.country FROM person p1 GROUP BY p1.country HAVING COUNT(p1.id)>?";
    print(result);
    assert(result == expected);
    assert(select.getValues().size() == 1);
    value it = select.getValues().get(0);
    if(exists it) {
        assert (it == 10);
    }
}

shared void listAllProductsStartingWithCha_or_Chan(){
    select.select().columns({productId, prd_name, unitprice})
        .from(product).where().column(prd_name).like("Cha_").or().column(prd_name).like("Chan_");
    String result = select.toSql();
    String expected = "SELECT id,product_name,unit_price FROM product WHERE product_name LIKE ? OR product_name LIKE ?";
    print(result);
    assert(result == expected);
}

shared void selfJoin(){
    /**Match customers that are from the same city and country*/

    select.select()
        .columns({p1_fname, p1_lname,
        p2_fname, p2_lname,
        p2_city, p2_country}).from({p1,p2})
        .where(p1_id).ne(p2_id).and(p1_city).eq(p2_city)
        .and(p1_country).eq(p2_country).orderBy(p1_country);
    String result = select.toSql();
    String expected = "SELECT p1.first_name,p1.last_name,p2.first_name,p2.last_name,"
    +"p2.city,p2.country FROM(person p1,person p2) WHERE p1.id<>p2.id AND p1.city=p2.city AND p1.country=p2.country ORDER BY p1.country";
    print(result);
    assert(result == expected);
}

shared void union() {
    /*List all suppliers and customers*/
    select.select().column("p1.*").from(p1)
        .union()
        .select().column("s1.*").from(s1_supplier);
    String result = select.toSql();
    String expected = "SELECT p1.* FROM person p1 UNION SELECT s1.* FROM supplier s1";
    print(result);
    assert(result == expected);
}

shared void intersectUsingInnerJoin() {
    /*Simulate INTERSECT operator in MySQL using DISTINCT and INNER JOIN*/
    select.select().distinct().column(s1_Id).from(s1_supplier).innerJoin().table(prd1).using(prd1_suppid);
    String result = select.toSql();
    String expected = "SELECT DISTINCT s1.id FROM supplier s1 INNER JOIN product prd1 USING(prd1.supplier_id)";
    print(result);
    assert(result == expected);
}

shared void insetsectUsingInAndSubQuery() {
    /*Simulate INTERSECT operator in MySQL using IN and Subquery*/
    select.select().distinct().column(s1_Id).from(s1_supplier).where()
        .column(s1_Id).in_(SelectOp().select().column(prd1_suppid).from(prd1));
    String result = select.toSql();
    String expected = "SELECT DISTINCT s1.id FROM supplier s1 WHERE s1.id IN (SELECT prd1.supplier_id FROM product prd1)";
    print(result);
    assert(result == expected);
}

shared void minus() {
    select.select().column(s1_Id).from(s1_supplier).minus().select().column(prd1_suppid).from(prd1);
    String result = select.toSql();
    String expected = "SELECT s1.id FROM supplier s1 MINUS SELECT prd1.supplier_id FROM product prd1";
    print(result);
    assert(result == expected);
}

shared void minusSimulationUsingJoin() {
    select.select().column(s1_Id).from(s1_supplier).leftJoin().table(prd1).using(prd1_suppid)
        .where().column(prd1_suppid).is_().null();
    String result = select.toSql();
    String expected = "SELECT s1.id FROM supplier s1 LEFT JOIN product prd1 USING(prd1.supplier_id) WHERE prd1.supplier_id IS  NULL";
    print(result);
    assert(result == expected);
}

shared void findDuplicates() {
    select.select().count(email).with({email})
        .from(person).groupBy({email}).having().count(email).gt().values({setVal(1)});
    String result = select.toSql();
    String expected = "SELECT COUNT(email), email FROM person GROUP BY email HAVING COUNT(email)>?";
    print(result);
    assert(result == expected);
}

shared void crossJoin() {
    select.select().all().from({prd1, o1});
    String result = select.toSql();
    String expected = "SELECT * FROM(product prd1,order o1)";
    print(result);
    assert(result == expected);
}

shared void testExists(){
    select.select().all().from(s1_supplier).where()
        .exists_(SelectOp().select({prd1_productname}).from(prd1)
        .where(prd1_suppid).eq(s1_Id).and(prd1_unitprice).lt().values({setVal(20)})
    );
    String result = select.toSql();
    String expected = "SELECT * FROM supplier s1 WHERE EXISTS (SELECT prd1.product_name FROM product prd1 WHERE prd1.supplier_id=s1.id AND prd1.unit_price<? )";
    print(result);
    assert(result == expected);
}

shared void testNotExists() {
    select.select().all().from(s1_supplier).where().not()
        .exists_(SelectOp().select({prd1_productname}).from(prd1)
        .where(prd1_suppid).eq(s1_Id).and(prd1_unitprice).lt().values({setVal(20)}));
    String result = select.toSql();
    String expected = "SELECT * FROM supplier s1 WHERE  NOT EXISTS (SELECT prd1.product_name FROM product prd1 WHERE prd1.supplier_id=s1.id AND prd1.unit_price<? )";
    print(result);
    assert(result == expected);
}

