"Default documentation for module `ceylonic.jdbc`."

native ("jvm")
module ceylonic.jdbc "1.0.0" {
    shared import java.jdbc "8";
    shared import java.base "8";
    shared import maven:"mysql:mysql-connector-java" "6.0.5";
}
