{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # database client
    dbeaver-bin

    # database drivers for common databases
    sqlite-jdbc
    postgresql_jdbc
    mysql_jdbc
  ];
}
