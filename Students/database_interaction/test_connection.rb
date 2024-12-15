require 'pg'

connection = PG.connect(
    dbname: "Students",
    user: "flaim",
    password: "Light_47",
    host: "localhost",
    port: 5432
)

result = connection.exec("SELECT * FROM student")
result.each { |row| puts row } # Print each row (optional for debugging)
connection.close()