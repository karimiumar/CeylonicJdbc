import java.sql {
    ResultSet
}

shared interface RowMapper<out T> given T satisfies Object{
    shared formal T map(ResultSet rs);
}