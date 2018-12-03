"Default documentation for module `test.ceylonic.jdbc`."

native ("jvm")
module test.ceylonic.jdbc "1.0.0" {
    shared import java.jdbc "8";
    shared import java.base "8";
    shared import ceylonic.jdbc "1.0.0";
    shared import maven:"mysql:mysql-connector-java" "6.0.5";
}
