import ceylonic.jdbc.meta {
    ColumnValue{
        set
    }
}

import test.ceylonic.jdbc.dml.noconnection {
    TblPerson{...},
    TblOrder{...}
}

import ceylonic.jdbc {
    update
}


shared void complexAndConditionTest(){
    update.table(person).setColumnValues({set(fname, "Eva")})
    .where().not().columnEq({set(personId, 5)})
        .and().beginComplex().columnEq({set(adult, true)})
        .or().columnEq({set(email, "trisha@123.com")})
        .endComplex();
    String sql = update.toSql();
    String expected = "UPDATE person SET firstname=? WHERE  NOT id=? AND (adult=? OR email=?)";
    assert (sql == expected);
    for(v in update.getValues()){
        print(v);
    }
}

shared void complexOrConditionTest(){
    update.table(order).setColumnValues({set(customerId, 44)})
    .where()
        .not()
    .beginComplex()
    .ge(set(totalAmount, 4500))
    .or()
    .le(set(totalAmount, 6700))
    .endComplex();
    String sql = update.toSql();
    String expected = "UPDATE order SET customer_id=? WHERE  NOT (total_amount>=? OR total_amount<=?)";
    assert(sql == expected);
}

shared void complexConditionTest(){
    update.table(person).setColumnValues({set(city, "Dusseldorf")})
    .where()
    .not()
    .beginComplex()
        .columnEq({set(country, "Germany")})
    .endComplex();

    String sql = update.toSql();
    String expected = "UPDATE person SET city=? WHERE  NOT (country=?)";
    assert (sql == expected);
}